PGDMP     "        	            z         	   ehospital    14.5    14.5 P    Y           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            Z           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            [           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            \           1262    16394 	   ehospital    DATABASE     m   CREATE DATABASE ehospital WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE ehospital;
                postgres    false            ?            1255    16617    generate_cl_id(integer)    FUNCTION     ?   CREATE FUNCTION public.generate_cl_id(id integer) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT TO_CHAR(now(), 'DDMMYY')|| '_' || TO_CHAR (id,'0000');
$$;
 1   DROP FUNCTION public.generate_cl_id(id integer);
       public          postgres    false            ?            1255    16529    generate_custom_id(integer)    FUNCTION     ?   CREATE FUNCTION public.generate_custom_id(id integer) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT TO_CHAR(now(), 'DDMMYY')|| '_' || TO_CHAR(id,'000000');
$$;
 5   DROP FUNCTION public.generate_custom_id(id integer);
       public          postgres    false            ?            1255    16603    generate_ho_id(integer)    FUNCTION     ?   CREATE FUNCTION public.generate_ho_id(id integer) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
  SELECT TO_CHAR(now(), 'DDMMYY')|| '_' || TO_CHAR(id,'FM0000');
$$;
 1   DROP FUNCTION public.generate_ho_id(id integer);
       public          postgres    false            ?            1255    16540    generate_hp_id(integer)    FUNCTION     ?   CREATE FUNCTION public.generate_hp_id(id integer) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT TO_CHAR(now(), 'DDMMYY')|| '_' || TO_CHAR(id,'0000');
$$;
 1   DROP FUNCTION public.generate_hp_id(id integer);
       public          postgres    false            ?            1255    16422    generate_p_id(integer)    FUNCTION     ?   CREATE FUNCTION public.generate_p_id(id integer) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT TO_CHAR(now(), 'DDMMYY')|| '_' || TO_CHAR(id, 'P0000');
$$;
 0   DROP FUNCTION public.generate_p_id(id integer);
       public          postgres    false            ?            1255    16572    generate_pr_id(integer)    FUNCTION     ?   CREATE FUNCTION public.generate_pr_id(id integer) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT TO_CHAR(now(),'DDMMYY')|| '_'|| TO_CHAR(id,'0000');
$$;
 1   DROP FUNCTION public.generate_pr_id(id integer);
       public          postgres    false            ?            1255    16491    trigger_set_timestamp()    FUNCTION     ?   CREATE FUNCTION public.trigger_set_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
NEW.updated_at = NOW();
RETURN NEW;
END;
$$;
 .   DROP FUNCTION public.trigger_set_timestamp();
       public          postgres    false            ?            1259    16461    clinics    TABLE     ?  CREATE TABLE public.clinics (
    clinic_name character varying NOT NULL,
    insurance character varying,
    email character varying NOT NULL,
    phone character varying NOT NULL,
    country character varying,
    province character varying NOT NULL,
    city character varying,
    address character varying,
    specialty character varying(60),
    proof_id bytea,
    registeration_num character varying(30),
    verified boolean,
    verified_by character varying(40),
    departments character varying,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    fax character varying(15),
    id integer NOT NULL,
    clinic_id text GENERATED ALWAYS AS (((((('CL-'::text || ((clinic_name)::character(4))::text) || '_'::text) || ((province)::character(2))::text) || '_'::text) || public.generate_cl_id(id))) STORED NOT NULL
);
    DROP TABLE public.clinics;
       public         heap    postgres    false    227            ?            1259    16618    clinics_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.clinics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.clinics_id_seq;
       public          postgres    false    216            ]           0    0    clinics_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.clinics_id_seq OWNED BY public.clinics.id;
          public          postgres    false    220            ?            1259    16456 	   hospitals    TABLE     ?  CREATE TABLE public.hospitals (
    hospital_name character varying NOT NULL,
    sections character varying,
    insurance character varying,
    num_of_beds integer,
    email character varying NOT NULL,
    phone character varying NOT NULL,
    country character varying,
    province character varying NOT NULL,
    city character varying,
    address character varying,
    specialty character varying(60),
    licensed_with character varying,
    proof_id bytea,
    registeration_num character varying(30),
    verified boolean,
    verified_by character varying(40),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    fax character varying(15),
    id integer NOT NULL,
    ho_id text GENERATED ALWAYS AS (((('HO-'::text || ((hospital_name)::character(4))::text) || '-'::text) || public.generate_ho_id(id))) STORED NOT NULL
);
    DROP TABLE public.hospitals;
       public         heap    postgres    false    226            ?            1259    16604    hospitals_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.hospitals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.hospitals_id_seq;
       public          postgres    false    215            ^           0    0    hospitals_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.hospitals_id_seq OWNED BY public.hospitals.id;
          public          postgres    false    219            ?            1259    16446    hp    TABLE     S  CREATE TABLE public.hp (
    city text,
    email character varying(30) NOT NULL,
    fname character varying(30) NOT NULL,
    h_address character varying,
    licensed_with character varying,
    limitation character varying,
    lname character varying(30) NOT NULL,
    middle_name character varying(30),
    phone character varying(20),
    photo bytea,
    provincial_bill_num character varying(20),
    province character varying(30),
    registeration_num character varying(30),
    specialty character varying NOT NULL,
    proof_id bytea,
    verified boolean,
    verified_by character varying,
    dob date NOT NULL,
    country character varying,
    id integer NOT NULL,
    hp_id text GENERATED ALWAYS AS (((((('H-'::text || ((EXTRACT(year FROM dob))::character(4))::text) || '-'::text) || ((specialty)::character(2))::text) || '-'::text) || public.generate_hp_id(id))) STORED NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    college_num character varying(20),
    clinic_id text,
    ho_id text
);
    DROP TABLE public.hp;
       public         heap    postgres    false    224            ?            1259    16541 	   hp_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.hp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.hp_id_seq;
       public          postgres    false    213            _           0    0 	   hp_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE public.hp_id_seq OWNED BY public.hp.id;
          public          postgres    false    217            ?            1259    16404    patient    TABLE     c  CREATE TABLE public.patient (
    care_take character varying(60),
    care_contact character varying(30),
    date_of_birth date NOT NULL,
    family_doctor_name character varying(60),
    lname character varying(40) NOT NULL,
    middle_name character varying(40),
    medical_concern character varying,
    longterm_health_problem character varying,
    insurance boolean,
    health_issue character varying,
    health_card_type character varying(40),
    health_card_num character varying(30),
    gender character varying(30),
    family_doctor_phone character varying(20),
    family_doctor_email character varying(40),
    exercise character varying,
    emergency_contact character varying(20),
    email character varying(30) NOT NULL,
    drug character varying,
    card_exp_date date,
    breastfeeding character varying(20),
    blood_group character varying(10),
    armed_forces boolean,
    allergies character varying,
    alcohol character varying(20),
    verified boolean,
    verified_by character varying(40),
    id integer NOT NULL,
    province character varying(30) NOT NULL,
    proof_id bytea,
    "username_Fky" character varying,
    guardian_name character varying(40),
    guardian_relation character varying(30),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    phone character varying(20),
    country character varying,
    documents bytea,
    surgery character varying,
    medication character varying,
    pregnant boolean,
    smoke character varying,
    serious_illness character varying,
    patient_id text GENERATED ALWAYS AS (((((('P-'::text || ((EXTRACT(year FROM date_of_birth))::character(4))::text) || '-'::text) || ((province)::character(2))::text) || '-'::text) || public.generate_custom_id(id))) STORED NOT NULL,
    hp_id text,
    pr_id text,
    preferred_pharmacy character varying,
    preferred_pharmacy_email character varying(20),
    preferred_pharmacy_fax character varying(15),
    fname character varying(30) NOT NULL
);
ALTER TABLE ONLY public.patient ALTER COLUMN care_contact SET STORAGE PLAIN;
    DROP TABLE public.patient;
       public         heap    postgres    false    223            ?            1259    16423    patient_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.patient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.patient_id_seq;
       public          postgres    false    209            `           0    0    patient_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.patient_id_seq OWNED BY public.patient.id;
          public          postgres    false    212            ?            1259    16451    practitioner    TABLE     '  CREATE TABLE public.practitioner (
    city text,
    email character varying(30) NOT NULL,
    fname character varying(30) NOT NULL,
    address character varying,
    licensed_with character varying,
    limitation character varying,
    lname character varying(30) NOT NULL,
    middle_name character varying(30),
    phone character varying(20),
    photo bytea,
    province character varying(30) NOT NULL,
    registeration_num character varying(30),
    specialty character varying NOT NULL,
    proof_id bytea,
    verified boolean,
    verified_by character varying,
    date_of_birth date NOT NULL,
    country character varying(30),
    clinic_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    pr_id text GENERATED ALWAYS AS (((((('PR-'::text || ((EXTRACT(year FROM date_of_birth))::character(4))::text) || '-'::text) || ((specialty)::character(2))::text) || '-'::text) || public.generate_pr_id(id))) STORED NOT NULL,
    ho_id text
);
     DROP TABLE public.practitioner;
       public         heap    postgres    false    225            ?            1259    16573    practitioner_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.practitioner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.practitioner_id_seq;
       public          postgres    false    214            a           0    0    practitioner_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.practitioner_id_seq OWNED BY public.practitioner.id;
          public          postgres    false    218            ?            1259    16412    users    TABLE     2  CREATE TABLE public.users (
    email character varying(40) NOT NULL,
    password character varying,
    user_id bigint NOT NULL,
    username character varying(30) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            ?            1259    16411    users_user_id_seq    SEQUENCE     z   CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    211            b           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    210            ?           2604    16619 
   clinics id    DEFAULT     h   ALTER TABLE ONLY public.clinics ALTER COLUMN id SET DEFAULT nextval('public.clinics_id_seq'::regclass);
 9   ALTER TABLE public.clinics ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    216            ?           2604    16605    hospitals id    DEFAULT     l   ALTER TABLE ONLY public.hospitals ALTER COLUMN id SET DEFAULT nextval('public.hospitals_id_seq'::regclass);
 ;   ALTER TABLE public.hospitals ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    215            ?           2604    16542    hp id    DEFAULT     ^   ALTER TABLE ONLY public.hp ALTER COLUMN id SET DEFAULT nextval('public.hp_id_seq'::regclass);
 4   ALTER TABLE public.hp ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    213            |           2604    16424 
   patient id    DEFAULT     h   ALTER TABLE ONLY public.patient ALTER COLUMN id SET DEFAULT nextval('public.patient_id_seq'::regclass);
 9   ALTER TABLE public.patient ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    209            ?           2604    16574    practitioner id    DEFAULT     r   ALTER TABLE ONLY public.practitioner ALTER COLUMN id SET DEFAULT nextval('public.practitioner_id_seq'::regclass);
 >   ALTER TABLE public.practitioner ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    214            ?           2604    16415    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    211    210    211            R          0    16461    clinics 
   TABLE DATA           ?   COPY public.clinics (clinic_name, insurance, email, phone, country, province, city, address, specialty, proof_id, registeration_num, verified, verified_by, departments, updated_at, created_at, fax, id) FROM stdin;
    public          postgres    false    216   )v       Q          0    16456 	   hospitals 
   TABLE DATA           ?   COPY public.hospitals (hospital_name, sections, insurance, num_of_beds, email, phone, country, province, city, address, specialty, licensed_with, proof_id, registeration_num, verified, verified_by, created_at, updated_at, fax, id) FROM stdin;
    public          postgres    false    215   Fv       O          0    16446    hp 
   TABLE DATA             COPY public.hp (city, email, fname, h_address, licensed_with, limitation, lname, middle_name, phone, photo, provincial_bill_num, province, registeration_num, specialty, proof_id, verified, verified_by, dob, country, id, created_at, updated_at, college_num, clinic_id, ho_id) FROM stdin;
    public          postgres    false    213   cv       K          0    16404    patient 
   TABLE DATA           ?  COPY public.patient (care_take, care_contact, date_of_birth, family_doctor_name, lname, middle_name, medical_concern, longterm_health_problem, insurance, health_issue, health_card_type, health_card_num, gender, family_doctor_phone, family_doctor_email, exercise, emergency_contact, email, drug, card_exp_date, breastfeeding, blood_group, armed_forces, allergies, alcohol, verified, verified_by, id, province, proof_id, "username_Fky", guardian_name, guardian_relation, created_at, updated_at, phone, country, documents, surgery, medication, pregnant, smoke, serious_illness, hp_id, pr_id, preferred_pharmacy, preferred_pharmacy_email, preferred_pharmacy_fax, fname) FROM stdin;
    public          postgres    false    209   ?v       P          0    16451    practitioner 
   TABLE DATA             COPY public.practitioner (city, email, fname, address, licensed_with, limitation, lname, middle_name, phone, photo, province, registeration_num, specialty, proof_id, verified, verified_by, date_of_birth, country, clinic_id, created_at, updated_at, id, ho_id) FROM stdin;
    public          postgres    false    214   ?y       M          0    16412    users 
   TABLE DATA           [   COPY public.users (email, password, user_id, username, created_at, updated_at) FROM stdin;
    public          postgres    false    211   ?y       c           0    0    clinics_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.clinics_id_seq', 1, false);
          public          postgres    false    220            d           0    0    hospitals_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.hospitals_id_seq', 1, false);
          public          postgres    false    219            e           0    0 	   hp_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('public.hp_id_seq', 1, false);
          public          postgres    false    217            f           0    0    patient_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.patient_id_seq', 9, true);
          public          postgres    false    212            g           0    0    practitioner_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.practitioner_id_seq', 1, false);
          public          postgres    false    218            h           0    0    users_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_user_id_seq', 8, true);
          public          postgres    false    210            ?           2606    16496    users Unq_email 
   CONSTRAINT     k   ALTER TABLE ONLY public.users
    ADD CONSTRAINT "Unq_email" UNIQUE (email) DEFERRABLE INITIALLY DEFERRED;
 ;   ALTER TABLE ONLY public.users DROP CONSTRAINT "Unq_email";
       public            postgres    false    211            ?           2606    16637    clinics cl_id_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.clinics
    ADD CONSTRAINT cl_id_pkey PRIMARY KEY (clinic_id);
 <   ALTER TABLE ONLY public.clinics DROP CONSTRAINT cl_id_pkey;
       public            postgres    false    216            ?           2606    16663    clinics clinic_unq_email 
   CONSTRAINT     r   ALTER TABLE ONLY public.clinics
    ADD CONSTRAINT clinic_unq_email UNIQUE (email) DEFERRABLE INITIALLY DEFERRED;
 B   ALTER TABLE ONLY public.clinics DROP CONSTRAINT clinic_unq_email;
       public            postgres    false    216            ?           2606    16635    hospitals ho_id_pKey 
   CONSTRAINT     W   ALTER TABLE ONLY public.hospitals
    ADD CONSTRAINT "ho_id_pKey" PRIMARY KEY (ho_id);
 @   ALTER TABLE ONLY public.hospitals DROP CONSTRAINT "ho_id_pKey";
       public            postgres    false    215            ?           2606    16666    hospitals hos_unq_email 
   CONSTRAINT     q   ALTER TABLE ONLY public.hospitals
    ADD CONSTRAINT hos_unq_email UNIQUE (email) DEFERRABLE INITIALLY DEFERRED;
 A   ALTER TABLE ONLY public.hospitals DROP CONSTRAINT hos_unq_email;
       public            postgres    false    215            ?           2606    16558    hp hp-id-pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.hp
    ADD CONSTRAINT "hp-id-pkey" PRIMARY KEY (hp_id);
 9   ALTER TABLE ONLY public.hp DROP CONSTRAINT "hp-id-pkey";
       public            postgres    false    213            ?           2606    16562    patient p_id_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.patient
    ADD CONSTRAINT p_id_pkey PRIMARY KEY (patient_id);
 ;   ALTER TABLE ONLY public.patient DROP CONSTRAINT p_id_pkey;
       public            postgres    false    209            ?           2606    16410    patient patient_email_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_email_key UNIQUE (email);
 C   ALTER TABLE ONLY public.patient DROP CONSTRAINT patient_email_key;
       public            postgres    false    209            ?           2606    16590 #   practitioner practitioner_email_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.practitioner
    ADD CONSTRAINT practitioner_email_key UNIQUE (email);
 M   ALTER TABLE ONLY public.practitioner DROP CONSTRAINT practitioner_email_key;
       public            postgres    false    214            ?           2606    16588    practitioner practitioner_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.practitioner
    ADD CONSTRAINT practitioner_pkey PRIMARY KEY (pr_id);
 H   ALTER TABLE ONLY public.practitioner DROP CONSTRAINT practitioner_pkey;
       public            postgres    false    214            ?           2606    16560    hp unq-email 
   CONSTRAINT     J   ALTER TABLE ONLY public.hp
    ADD CONSTRAINT "unq-email" UNIQUE (email);
 8   ALTER TABLE ONLY public.hp DROP CONSTRAINT "unq-email";
       public            postgres    false    213            ?           2606    16419    users users_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    211            ?           1259    16643    fki_cl_id_pkey    INDEX     B   CREATE INDEX fki_cl_id_pkey ON public.hp USING btree (clinic_id);
 "   DROP INDEX public.fki_cl_id_pkey;
       public            postgres    false    213            ?           1259    16655    fki_cli-id-FKey    INDEX     O   CREATE INDEX "fki_cli-id-FKey" ON public.practitioner USING btree (clinic_id);
 %   DROP INDEX public."fki_cli-id-FKey";
       public            postgres    false    214            ?           1259    16512    fki_fkey-user    INDEX     M   CREATE INDEX "fki_fkey-user" ON public.patient USING btree ("username_Fky");
 #   DROP INDEX public."fki_fkey-user";
       public            postgres    false    209            ?           1259    16649    fki_hos-FKey    INDEX     H   CREATE INDEX "fki_hos-FKey" ON public.practitioner USING btree (ho_id);
 "   DROP INDEX public."fki_hos-FKey";
       public            postgres    false    214            ?           1259    16661    fki_hos-ID-FKey    INDEX     A   CREATE INDEX "fki_hos-ID-FKey" ON public.hp USING btree (ho_id);
 %   DROP INDEX public."fki_hos-ID-FKey";
       public            postgres    false    213            ?           1259    16568    fki_hp-id-fkey    INDEX     E   CREATE INDEX "fki_hp-id-fkey" ON public.patient USING btree (hp_id);
 $   DROP INDEX public."fki_hp-id-fkey";
       public            postgres    false    209            ?           1259    16596    fki_pr-id-Pkey    INDEX     E   CREATE INDEX "fki_pr-id-Pkey" ON public.patient USING btree (pr_id);
 $   DROP INDEX public."fki_pr-id-Pkey";
       public            postgres    false    209            ?           1259    16506    fki_username_Fky    INDEX     P   CREATE INDEX "fki_username_Fky" ON public.patient USING btree ("username_Fky");
 &   DROP INDEX public."fki_username_Fky";
       public            postgres    false    209            ?           2620    16602    clinics set_timestamp    TRIGGER     {   CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.clinics FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();
 .   DROP TRIGGER set_timestamp ON public.clinics;
       public          postgres    false    216    222            ?           2620    16599    hospitals set_timestamp    TRIGGER     }   CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.hospitals FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();
 0   DROP TRIGGER set_timestamp ON public.hospitals;
       public          postgres    false    222    215            ?           2620    16556    hp set_timestamp    TRIGGER     v   CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.hp FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();
 )   DROP TRIGGER set_timestamp ON public.hp;
       public          postgres    false    213    222            ?           2620    16498    patient set_timestamp    TRIGGER     {   CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.patient FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();
 .   DROP TRIGGER set_timestamp ON public.patient;
       public          postgres    false    209    222            ?           2620    16571    practitioner set_timestamp    TRIGGER     ?   CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.practitioner FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();
 3   DROP TRIGGER set_timestamp ON public.practitioner;
       public          postgres    false    222    214            ?           2620    16494    users set_timestamp    TRIGGER     y   CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();
 ,   DROP TRIGGER set_timestamp ON public.users;
       public          postgres    false    211    222            ?           2606    16638    hp cl_id_pkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.hp
    ADD CONSTRAINT cl_id_pkey FOREIGN KEY (clinic_id) REFERENCES public.clinics(clinic_id) NOT VALID;
 7   ALTER TABLE ONLY public.hp DROP CONSTRAINT cl_id_pkey;
       public          postgres    false    213    216    3248            ?           2606    16650    practitioner cli-id-FKey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.practitioner
    ADD CONSTRAINT "cli-id-FKey" FOREIGN KEY (clinic_id) REFERENCES public.clinics(clinic_id) DEFERRABLE INITIALLY DEFERRED NOT VALID;
 D   ALTER TABLE ONLY public.practitioner DROP CONSTRAINT "cli-id-FKey";
       public          postgres    false    214    216    3248            ?           2606    16644    practitioner hos-FKey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.practitioner
    ADD CONSTRAINT "hos-FKey" FOREIGN KEY (ho_id) REFERENCES public.hospitals(ho_id) DEFERRABLE INITIALLY DEFERRED NOT VALID;
 A   ALTER TABLE ONLY public.practitioner DROP CONSTRAINT "hos-FKey";
       public          postgres    false    215    214    3244            ?           2606    16656    hp hos-ID-FKey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.hp
    ADD CONSTRAINT "hos-ID-FKey" FOREIGN KEY (ho_id) REFERENCES public.hospitals(ho_id) DEFERRABLE INITIALLY DEFERRED NOT VALID;
 :   ALTER TABLE ONLY public.hp DROP CONSTRAINT "hos-ID-FKey";
       public          postgres    false    3244    213    215            ?           2606    16563    patient hp-id-fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.patient
    ADD CONSTRAINT "hp-id-fkey" FOREIGN KEY (hp_id) REFERENCES public.hp(hp_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED NOT VALID;
 >   ALTER TABLE ONLY public.patient DROP CONSTRAINT "hp-id-fkey";
       public          postgres    false    3234    209    213            ?           2606    16591    patient pr-id-Pkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.patient
    ADD CONSTRAINT "pr-id-Pkey" FOREIGN KEY (pr_id) REFERENCES public.practitioner(pr_id) DEFERRABLE INITIALLY DEFERRED NOT VALID;
 >   ALTER TABLE ONLY public.patient DROP CONSTRAINT "pr-id-Pkey";
       public          postgres    false    3242    214    209            ?           2606    16501    patient username_Fky    FK CONSTRAINT     ?   ALTER TABLE ONLY public.patient
    ADD CONSTRAINT "username_Fky" FOREIGN KEY ("username_Fky") REFERENCES public.users(username) MATCH FULL DEFERRABLE INITIALLY DEFERRED;
 @   ALTER TABLE ONLY public.patient DROP CONSTRAINT "username_Fky";
       public          postgres    false    3230    209    211            R      x?????? ? ?      Q      x?????? ? ?      O      x?????? ? ?      K   ?  x?mTKO?0>{?{.Ic;v'??"UUU??/?Hb?8,?_??ClXY???Ǟ???????z??]X??֪=:?f???zQv????"??Q?N??2?0?Ín{??\J]U?'??km?VY???????U39??Mo?i?x??Ӝ?(?e?<??3c?x?aBS?Ҁ?4HDAg?l?I??$"????02:??,ǚٳlK?:??͡?;?*???R?~z;}l?ѱ/(N?6?v?jZD??x?(???8y?-?}7?????????B.?8A????z?{?@q??Wu??;懡??I???'H?4?RJ}*?(z??B?rᇂ???e!???D?5?ެM????j1?{?h0J?\?g???l???eZ?j[??JI?p?;%; 5{?W?x*??J?V???)??U]?[?nYHEs?it???ŉN?]ɂ?T(?V?_PD???q!е?]????R??Q? ?@???zh?~? ??_??u;},??T???6M?G??]?G?|??Q6JC??q ?/F?`|???{?7?}Tv????B??Qm;????ʁU?3?Y???_?t?????v$s??M*??d ???͍????L_??P??ťt3?3??;t??V??ښ?V?D?d??{??.??????3?)`e??l ???y??ס???pcl/??6??H ܤ??"??$z?&?0?i@SF}?Y̒?????lA엕/????9}Q????j??J??      P      x?????? ? ?      M   ?   x?}ͽ
?0????*?????䴙??\j[I?1C'?^E?????=_?v?>?b???<? O?y??Q??o\=G???b????ռ?JFb}??)?F?,???`??Yl?O??*??E)i?v-??uZ_o??%J?"VE5?'??9Zc???@?     