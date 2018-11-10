Return-Path: <SRS0=nRr/=NV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD0BC43441
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Nov 2018 14:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F4D20817
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Nov 2018 14:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjTZV/o7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F4D20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeKKAUM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:20:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33520 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeKKAUL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 10 Nov 2018 19:20:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id u9-v6so4780055wrr.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Nov 2018 06:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=U5Fh4bbZ/lHGqUg5GnVgsSQaT6fP5BD2D6o0aaialGs=;
        b=jjTZV/o7+lesa4QPnF2jum/6Ea/kvovRJ3doFxWbRJIEy8xiMKCQ+VdCVwVflNd9jb
         LnK8dBhSUN7M/Sp/+kXTqM0TOL5H9QtuNUyo0zN7U2XrhVBxPEHSZLUGnE6HCWlLhec/
         BJ3OHyNG2cyPWQ9yUfSKbHNJiyOS+dPdjfI+dKIilCqj61baxyeqWOP7Oj6QePhXlnvR
         XOyTxj43jQthRVLCGsr3SuHf8NSmksS4cDX7Bbu9pNic6JRIkxZITZV+QuqEDFXKMsKE
         vdMmG06XwnCsk2s1n4OvcOaoVWpA3iufUEH14l2Hm/4+IkE1cQiBoU25KOZpwUY4QTQq
         AU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=U5Fh4bbZ/lHGqUg5GnVgsSQaT6fP5BD2D6o0aaialGs=;
        b=LWoaICcQ7o3bK1D0ViDezVx55eqxMmqL+a7Oisysa5fVTZcqyxU5g9K2skHeo0KL7C
         lgz1btWocOmlrZn105fpescNaNrD2dugf2kou6jpCF7YitkAwcvlrLPSW+Pr22OG3M1F
         hlfdUYjkerZe8uJtTivjLY9IDo6l8kyyQ/1L7lWvCe0U/DiduK/vUy1m3DQjDp9vfPNw
         CNDOLiXQb/rWx4bfiRsJM5RBAP/T4FILO/MacplBKbkhQaz3XIFTYi6uQyaw++iMKwKL
         6xD/d+u0Xc+NU6yh4Vrw+vZKrIQv4n8iNZDjFekWNp4TM2br4xwaulYlLqXKBjXbhgZc
         3BDA==
X-Gm-Message-State: AGRZ1gKQIyHSp+KQdxqonZ+qLl7yxLMU39TiXsPgVXYrIV83zo6Mg3bh
        UVXb/+84b+zOuP3eeFoP27tnzYT7
X-Google-Smtp-Source: AJdET5d3NnMNlODTbJYVg9SiopAry0t45eI7qvRs0CHP5zNG/ROsFPCD7uGwjzWjlx47r6UfP5b8yA==
X-Received: by 2002:a05:6000:1048:: with SMTP id c8mr11745057wrx.171.1541860494638;
        Sat, 10 Nov 2018 06:34:54 -0800 (PST)
Received: from ?IPv6:2003:d3:83e5:9c00:7506:51ae:24c8:2d09? (p200300D383E59C00750651AE24C82D09.dip0.t-ipconnect.de. [2003:d3:83e5:9c00:7506:51ae:24c8:2d09])
        by smtp.gmail.com with ESMTPSA id u4-v6sm12210273wrt.89.2018.11.10.06.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 06:34:53 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH BlueZ] src/adapter: Removed obsolete conversion functions for persistant settings
From:   Christian Zimmermann <zimmermach@gmail.com>
X-Mailer: iPad Mail (16B92)
In-Reply-To: <CABBYNZ+A+iU4wAw6LVy6toi+Qb7=2trkbx+HJmQYtdYyTHwSEA@mail.gmail.com>
Date:   Sat, 10 Nov 2018 15:34:52 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <447CAA92-87E8-4E79-B850-EA22A682E5C5@gmail.com>
References: <20181105160342.29434-1-zimmermach@gmail.com> <CABBYNZ+A+iU4wAw6LVy6toi+Qb7=2trkbx+HJmQYtdYyTHwSEA@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

thank you for your response.
How about having a shell or python script which does the necessary conversio=
n during bluez install? Would this be sufficient?

Regards,
Christian

> Am 07.11.2018 um 12:37 schrieb Luiz Augusto von Dentz <luiz.dentz@gmail.co=
m>:
>=20
> Hi Christian,
>=20
> On Mon, Nov 5, 2018 at 6:10 PM Christian Zimmermann
> <zimmermach@gmail.com> wrote:
>>=20
>> According to TODO file:
>> Removal of conversion functions for persistant settings
>> since they're obsolete with Bluez5 after certain time of it's first relea=
se
>=20
> We probably need to consider if there are still platforms using BlueZ
> 4 then removing this code would make the transition, perhaps we could
> have a tool to do that so we can remove this from the daemon.
>=20
>> ---
>> TODO          |   6 -
>> src/adapter.c | 832 -----------------------------------------------------=
-----
>> 2 files changed, 838 deletions(-)
>>=20
>> diff --git a/TODO b/TODO
>> index d88349e06..ae2d69dfa 100644
>> --- a/TODO
>> +++ b/TODO
>> @@ -37,12 +37,6 @@ General
>>   Priority: Medium
>>   Complexity: C2
>>=20
>> -- Function in src/adapter.c to convert old storage files to new ini-file=
 format
>> -  should be removed 6-8 months after first BlueZ 5 release.
>> -
>> -  Priority: Low
>> -  Complexity: C1
>> -
>> - Remove usage of symlinks for drivers, such as profiles/input/suspend.c a=
nd
>>   profiles/sap/sap.c. Instead, select drivers at runtime by using config
>>   options or probing for running D-Bus services (using e.g.
>> diff --git a/src/adapter.c b/src/adapter.c
>> index c24432125..5709ee956 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -423,18 +423,6 @@ void btd_adapter_set_class(struct btd_adapter *adapt=
er, uint8_t major,
>>        set_dev_class(adapter);
>> }
>>=20
>> -static uint8_t get_mode(const char *mode)
>> -{
>> -       if (strcasecmp("off", mode) =3D=3D 0)
>> -               return MODE_OFF;
>> -       else if (strcasecmp("connectable", mode) =3D=3D 0)
>> -               return MODE_CONNECTABLE;
>> -       else if (strcasecmp("discoverable", mode) =3D=3D 0)
>> -               return MODE_DISCOVERABLE;
>> -       else
>> -               return MODE_UNKNOWN;
>> -}
>> -
>> const char *btd_adapter_get_storage_dir(struct btd_adapter *adapter)
>> {
>>        static char dir[25];
>> @@ -4927,824 +4915,10 @@ void btd_adapter_unref(struct btd_adapter *adapt=
er)
>>                                                ADAPTER_INTERFACE);
>> }
>>=20
>> -static void convert_names_entry(char *key, char *value, void *user_data)=

>> -{
>> -       char *address =3D user_data;
>> -       char *str =3D key;
>> -       char filename[PATH_MAX];
>> -       GKeyFile *key_file;
>> -       char *data;
>> -       gsize length =3D 0;
>> -
>> -       if (strchr(key, '#'))
>> -               str[17] =3D '\0';
>> -
>> -       if (bachk(str) !=3D 0)
>> -               return;
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", address, s=
tr);
>> -       create_file(filename, S_IRUSR | S_IWUSR);
>> -
>> -       key_file =3D g_key_file_new();
>> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
>> -       g_key_file_set_string(key_file, "General", "Name", value);
>> -
>> -       data =3D g_key_file_to_data(key_file, &length, NULL);
>> -       g_file_set_contents(filename, data, length, NULL);
>> -       g_free(data);
>> -
>> -       g_key_file_free(key_file);
>> -}
>> -
>> -struct device_converter {
>> -       char *address;
>> -       void (*cb)(GKeyFile *key_file, void *value);
>> -       gboolean force;
>> -};
>> -
>> -static void set_device_type(GKeyFile *key_file, char type)
>> -{
>> -       char *techno;
>> -       char *addr_type =3D NULL;
>> -       char *str;
>> -
>> -       switch (type) {
>> -       case BDADDR_BREDR:
>> -               techno =3D "BR/EDR";
>> -               break;
>> -       case BDADDR_LE_PUBLIC:
>> -               techno =3D "LE";
>> -               addr_type =3D "public";
>> -               break;
>> -       case BDADDR_LE_RANDOM:
>> -               techno =3D "LE";
>> -               addr_type =3D "static";
>> -               break;
>> -       default:
>> -               return;
>> -       }
>> -
>> -       str =3D g_key_file_get_string(key_file, "General",
>> -                                       "SupportedTechnologies", NULL);
>> -       if (!str)
>> -               g_key_file_set_string(key_file, "General",
>> -                                       "SupportedTechnologies", techno);=

>> -       else if (!strstr(str, techno))
>> -               g_key_file_set_string(key_file, "General",
>> -                                       "SupportedTechnologies", "BR/EDR;=
LE");
>> -
>> -       g_free(str);
>> -
>> -       if (addr_type)
>> -               g_key_file_set_string(key_file, "General", "AddressType",=

>> -                                       addr_type);
>> -}
>> -
>> -static void convert_aliases_entry(GKeyFile *key_file, void *value)
>> -{
>> -       g_key_file_set_string(key_file, "General", "Alias", value);
>> -}
>> -
>> -static void convert_trusts_entry(GKeyFile *key_file, void *value)
>> -{
>> -       g_key_file_set_boolean(key_file, "General", "Trusted", TRUE);
>> -}
>> -
>> -static void convert_classes_entry(GKeyFile *key_file, void *value)
>> -{
>> -       g_key_file_set_string(key_file, "General", "Class", value);
>> -}
>> -
>> -static void convert_blocked_entry(GKeyFile *key_file, void *value)
>> -{
>> -       g_key_file_set_boolean(key_file, "General", "Blocked", TRUE);
>> -}
>> -
>> -static void convert_did_entry(GKeyFile *key_file, void *value)
>> -{
>> -       char *vendor_str, *product_str, *version_str;
>> -       uint16_t val;
>> -
>> -       vendor_str =3D strchr(value, ' ');
>> -       if (!vendor_str)
>> -               return;
>> -
>> -       *(vendor_str++) =3D 0;
>> -
>> -       if (g_str_equal(value, "FFFF"))
>> -               return;
>> -
>> -       product_str =3D strchr(vendor_str, ' ');
>> -       if (!product_str)
>> -               return;
>> -
>> -       *(product_str++) =3D 0;
>> -
>> -       version_str =3D strchr(product_str, ' ');
>> -       if (!version_str)
>> -               return;
>> -
>> -       *(version_str++) =3D 0;
>> -
>> -       val =3D (uint16_t) strtol(value, NULL, 16);
>> -       g_key_file_set_integer(key_file, "DeviceID", "Source", val);
>> -
>> -       val =3D (uint16_t) strtol(vendor_str, NULL, 16);
>> -       g_key_file_set_integer(key_file, "DeviceID", "Vendor", val);
>> -
>> -       val =3D (uint16_t) strtol(product_str, NULL, 16);
>> -       g_key_file_set_integer(key_file, "DeviceID", "Product", val);
>> -
>> -       val =3D (uint16_t) strtol(version_str, NULL, 16);
>> -       g_key_file_set_integer(key_file, "DeviceID", "Version", val);
>> -}
>> -
>> -static void convert_linkkey_entry(GKeyFile *key_file, void *value)
>> -{
>> -       char *type_str, *length_str, *str;
>> -       int val;
>> -
>> -       type_str =3D strchr(value, ' ');
>> -       if (!type_str)
>> -               return;
>> -
>> -       *(type_str++) =3D 0;
>> -
>> -       length_str =3D strchr(type_str, ' ');
>> -       if (!length_str)
>> -               return;
>> -
>> -       *(length_str++) =3D 0;
>> -
>> -       str =3D g_strconcat("0x", value, NULL);
>> -       g_key_file_set_string(key_file, "LinkKey", "Key", str);
>> -       g_free(str);
>> -
>> -       val =3D strtol(type_str, NULL, 16);
>> -       g_key_file_set_integer(key_file, "LinkKey", "Type", val);
>> -
>> -       val =3D strtol(length_str, NULL, 16);
>> -       g_key_file_set_integer(key_file, "LinkKey", "PINLength", val);
>> -}
>> -
>> -static void convert_ltk_entry(GKeyFile *key_file, void *value)
>> -{
>> -       char *auth_str, *rand_str, *str;
>> -       int i, ret;
>> -       unsigned char auth, master, enc_size;
>> -       unsigned short ediv;
>> -
>> -       auth_str =3D strchr(value, ' ');
>> -       if (!auth_str)
>> -               return;
>> -
>> -       *(auth_str++) =3D 0;
>> -
>> -       for (i =3D 0, rand_str =3D auth_str; i < 4; i++) {
>> -               rand_str =3D strchr(rand_str, ' ');
>> -               if (!rand_str || rand_str[1] =3D=3D '\0')
>> -                       return;
>> -
>> -               rand_str++;
>> -       }
>> -
>> -       ret =3D sscanf(auth_str, " %hhd %hhd %hhd %hd", &auth, &master,
>> -                                                       &enc_size, &ediv)=
;
>> -       if (ret < 4)
>> -               return;
>> -
>> -       str =3D g_strconcat("0x", value, NULL);
>> -       g_key_file_set_string(key_file, "LongTermKey", "Key", str);
>> -       g_free(str);
>> -
>> -       g_key_file_set_integer(key_file, "LongTermKey", "Authenticated", a=
uth);
>> -       g_key_file_set_integer(key_file, "LongTermKey", "Master", master)=
;
>> -       g_key_file_set_integer(key_file, "LongTermKey", "EncSize", enc_si=
ze);
>> -       g_key_file_set_integer(key_file, "LongTermKey", "EDiv", ediv);
>> -
>> -       str =3D g_strconcat("0x", rand_str, NULL);
>> -       g_key_file_set_string(key_file, "LongTermKey", "Rand", str);
>> -       g_free(str);
>> -}
>> -
>> -static void convert_profiles_entry(GKeyFile *key_file, void *value)
>> -{
>> -       g_strdelimit(value, " ", ';');
>> -       g_key_file_set_string(key_file, "General", "Services", value);
>> -}
>> -
>> -static void convert_appearances_entry(GKeyFile *key_file, void *value)
>> -{
>> -       g_key_file_set_string(key_file, "General", "Appearance", value);
>> -}
>> -
>> -static void convert_entry(char *key, char *value, void *user_data)
>> -{
>> -       struct device_converter *converter =3D user_data;
>> -       char type =3D BDADDR_BREDR;
>> -       char filename[PATH_MAX];
>> -       GKeyFile *key_file;
>> -       char *data;
>> -       gsize length =3D 0;
>> -
>> -       if (strchr(key, '#')) {
>> -               key[17] =3D '\0';
>> -               type =3D key[18] - '0';
>> -       }
>> -
>> -       if (bachk(key) !=3D 0)
>> -               return;
>> -
>> -       if (converter->force =3D=3D FALSE) {
>> -               struct stat st;
>> -               int err;
>> -
>> -               snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s",
>> -                               converter->address, key);
>> -
>> -               err =3D stat(filename, &st);
>> -               if (err || !S_ISDIR(st.st_mode))
>> -                       return;
>> -       }
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
>> -                       converter->address, key);
>> -
>> -       key_file =3D g_key_file_new();
>> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
>> -
>> -       set_device_type(key_file, type);
>> -
>> -       converter->cb(key_file, value);
>> -
>> -       data =3D g_key_file_to_data(key_file, &length, NULL);
>> -       if (length > 0) {
>> -               create_file(filename, S_IRUSR | S_IWUSR);
>> -               g_file_set_contents(filename, data, length, NULL);
>> -       }
>> -
>> -       g_free(data);
>> -
>> -       g_key_file_free(key_file);
>> -}
>> -
>> -static void convert_file(char *file, char *address,
>> -                               void (*cb)(GKeyFile *key_file, void *valu=
e),
>> -                               gboolean force)
>> -{
>> -       char filename[PATH_MAX];
>> -       struct device_converter converter;
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", address, file);=

>> -
>> -       converter.address =3D address;
>> -       converter.cb =3D cb;
>> -       converter.force =3D force;
>> -
>> -       textfile_foreach(filename, convert_entry, &converter);
>> -}
>> -
>> -static gboolean record_has_uuid(const sdp_record_t *rec,
>> -                               const char *profile_uuid)
>> -{
>> -       sdp_list_t *pat;
>> -
>> -       for (pat =3D rec->pattern; pat !=3D NULL; pat =3D pat->next) {
>> -               char *uuid;
>> -               int ret;
>> -
>> -               uuid =3D bt_uuid2string(pat->data);
>> -               if (!uuid)
>> -                       continue;
>> -
>> -               ret =3D strcasecmp(uuid, profile_uuid);
>> -
>> -               free(uuid);
>> -
>> -               if (ret =3D=3D 0)
>> -                       return TRUE;
>> -       }
>> -
>> -       return FALSE;
>> -}
>> -
>> -static void store_attribute_uuid(GKeyFile *key_file, uint16_t start,
>> -                                       uint16_t end, char *att_uuid,
>> -                                       uuid_t uuid)
>> -{
>> -       char handle[6], uuid_str[33];
>> -       int i;
>> -
>> -       switch (uuid.type) {
>> -       case SDP_UUID16:
>> -               sprintf(uuid_str, "%4.4X", uuid.value.uuid16);
>> -               break;
>> -       case SDP_UUID32:
>> -               sprintf(uuid_str, "%8.8X", uuid.value.uuid32);
>> -               break;
>> -       case SDP_UUID128:
>> -               for (i =3D 0; i < 16; i++)
>> -                       sprintf(uuid_str + (i * 2), "%2.2X",
>> -                                       uuid.value.uuid128.data[i]);
>> -               break;
>> -       default:
>> -               uuid_str[0] =3D '\0';
>> -       }
>> -
>> -       sprintf(handle, "%hu", start);
>> -       g_key_file_set_string(key_file, handle, "UUID", att_uuid);
>> -       g_key_file_set_string(key_file, handle, "Value", uuid_str);
>> -       g_key_file_set_integer(key_file, handle, "EndGroupHandle", end);
>> -}
>> -
>> -static void store_sdp_record(char *local, char *peer, int handle, char *=
value)
>> -{
>> -       char filename[PATH_MAX];
>> -       GKeyFile *key_file;
>> -       char handle_str[11];
>> -       char *data;
>> -       gsize length =3D 0;
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, pe=
er);
>> -
>> -       key_file =3D g_key_file_new();
>> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
>> -
>> -       sprintf(handle_str, "0x%8.8X", handle);
>> -       g_key_file_set_string(key_file, "ServiceRecords", handle_str, val=
ue);
>> -
>> -       data =3D g_key_file_to_data(key_file, &length, NULL);
>> -       if (length > 0) {
>> -               create_file(filename, S_IRUSR | S_IWUSR);
>> -               g_file_set_contents(filename, data, length, NULL);
>> -       }
>> -
>> -       g_free(data);
>> -
>> -       g_key_file_free(key_file);
>> -}
>> -
>> -static void convert_sdp_entry(char *key, char *value, void *user_data)
>> -{
>> -       char *src_addr =3D user_data;
>> -       char dst_addr[18];
>> -       char type =3D BDADDR_BREDR;
>> -       int handle, ret;
>> -       char filename[PATH_MAX];
>> -       GKeyFile *key_file;
>> -       struct stat st;
>> -       sdp_record_t *rec;
>> -       uuid_t uuid;
>> -       char *att_uuid, *prim_uuid;
>> -       uint16_t start =3D 0, end =3D 0, psm =3D 0;
>> -       int err;
>> -       char *data;
>> -       gsize length =3D 0;
>> -
>> -       ret =3D sscanf(key, "%17s#%hhu#%08X", dst_addr, &type, &handle);
>> -       if (ret < 3) {
>> -               ret =3D sscanf(key, "%17s#%08X", dst_addr, &handle);
>> -               if (ret < 2)
>> -                       return;
>> -       }
>> -
>> -       if (bachk(dst_addr) !=3D 0)
>> -               return;
>> -
>> -       /* Check if the device directory has been created as records shou=
ld
>> -        * only be converted for known devices */
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, dst_a=
ddr);
>> -
>> -       err =3D stat(filename, &st);
>> -       if (err || !S_ISDIR(st.st_mode))
>> -               return;
>> -
>> -       /* store device records in cache */
>> -       store_sdp_record(src_addr, dst_addr, handle, value);
>> -
>> -       /* Retrieve device record and check if there is an
>> -        * attribute entry in it */
>> -       sdp_uuid16_create(&uuid, ATT_UUID);
>> -       att_uuid =3D bt_uuid2string(&uuid);
>> -
>> -       sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
>> -       prim_uuid =3D bt_uuid2string(&uuid);
>> -
>> -       rec =3D record_from_string(value);
>> -
>> -       if (record_has_uuid(rec, att_uuid))
>> -               goto failed;
>> -
>> -       /* TODO: Do this through btd_gatt_database */
>> -       if (!gatt_parse_record(rec, &uuid, &psm, &start, &end))
>> -               goto failed;
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", src_=
addr,
>> -                                                               dst_addr)=
;
>> -
>> -       key_file =3D g_key_file_new();
>> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
>> -
>> -       store_attribute_uuid(key_file, start, end, prim_uuid, uuid);
>> -
>> -       data =3D g_key_file_to_data(key_file, &length, NULL);
>> -       if (length > 0) {
>> -               create_file(filename, S_IRUSR | S_IWUSR);
>> -               g_file_set_contents(filename, data, length, NULL);
>> -       }
>> -
>> -       g_free(data);
>> -       g_key_file_free(key_file);
>> -
>> -failed:
>> -       sdp_record_free(rec);
>> -       free(prim_uuid);
>> -       free(att_uuid);
>> -}
>> -
>> -static void convert_primaries_entry(char *key, char *value, void *user_d=
ata)
>> -{
>> -       char *address =3D user_data;
>> -       int device_type =3D -1;
>> -       uuid_t uuid;
>> -       char **services, **service, *prim_uuid;
>> -       char filename[PATH_MAX];
>> -       GKeyFile *key_file;
>> -       int ret;
>> -       uint16_t start, end;
>> -       char uuid_str[MAX_LEN_UUID_STR + 1];
>> -       char *data;
>> -       gsize length =3D 0;
>> -
>> -       if (strchr(key, '#')) {
>> -               key[17] =3D '\0';
>> -               device_type =3D key[18] - '0';
>> -       }
>> -
>> -       if (bachk(key) !=3D 0)
>> -               return;
>> -
>> -       services =3D g_strsplit(value, " ", 0);
>> -       if (services =3D=3D NULL)
>> -               return;
>> -
>> -       sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
>> -       prim_uuid =3D bt_uuid2string(&uuid);
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", addr=
ess,
>> -                                                                       k=
ey);
>> -       key_file =3D g_key_file_new();
>> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
>> -
>> -       for (service =3D services; *service; service++) {
>> -               ret =3D sscanf(*service, "%04hX#%04hX#%s", &start, &end,
>> -                                                               uuid_str)=
;
>> -               if (ret < 3)
>> -                       continue;
>> -
>> -               bt_string2uuid(&uuid, uuid_str);
>> -               sdp_uuid128_to_uuid(&uuid);
>> -
>> -               store_attribute_uuid(key_file, start, end, prim_uuid, uui=
d);
>> -       }
>> -
>> -       g_strfreev(services);
>> -
>> -       data =3D g_key_file_to_data(key_file, &length, NULL);
>> -       if (length =3D=3D 0)
>> -               goto end;
>> -
>> -       create_file(filename, S_IRUSR | S_IWUSR);
>> -       g_file_set_contents(filename, data, length, NULL);
>> -
>> -       if (device_type < 0)
>> -               goto end;
>> -
>> -       g_free(data);
>> -       g_key_file_free(key_file);
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", address, k=
ey);
>> -
>> -       key_file =3D g_key_file_new();
>> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
>> -       set_device_type(key_file, device_type);
>> -
>> -       data =3D g_key_file_to_data(key_file, &length, NULL);
>> -       if (length > 0) {
>> -               create_file(filename, S_IRUSR | S_IWUSR);
>> -               g_file_set_contents(filename, data, length, NULL);
>> -       }
>> -
>> -end:
>> -       g_free(data);
>> -       free(prim_uuid);
>> -       g_key_file_free(key_file);
>> -}
>> -
>> -static void convert_ccc_entry(char *key, char *value, void *user_data)
>> -{
>> -       char *src_addr =3D user_data;
>> -       char dst_addr[18];
>> -       char type =3D BDADDR_BREDR;
>> -       uint16_t handle;
>> -       int ret, err;
>> -       char filename[PATH_MAX];
>> -       GKeyFile *key_file;
>> -       struct stat st;
>> -       char group[6];
>> -       char *data;
>> -       gsize length =3D 0;
>> -
>> -       ret =3D sscanf(key, "%17s#%hhu#%04hX", dst_addr, &type, &handle);=

>> -       if (ret < 3)
>> -               return;
>> -
>> -       if (bachk(dst_addr) !=3D 0)
>> -               return;
>> -
>> -       /* Check if the device directory has been created as records shou=
ld
>> -        * only be converted for known devices */
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, dst_a=
ddr);
>> -
>> -       err =3D stat(filename, &st);
>> -       if (err || !S_ISDIR(st.st_mode))
>> -               return;
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/ccc", src_addr,
>> -                                                               dst_addr)=
;
>> -       key_file =3D g_key_file_new();
>> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
>> -
>> -       sprintf(group, "%hu", handle);
>> -       g_key_file_set_string(key_file, group, "Value", value);
>> -
>> -       data =3D g_key_file_to_data(key_file, &length, NULL);
>> -       if (length > 0) {
>> -               create_file(filename, S_IRUSR | S_IWUSR);
>> -               g_file_set_contents(filename, data, length, NULL);
>> -       }
>> -
>> -       g_free(data);
>> -       g_key_file_free(key_file);
>> -}
>> -
>> -static void convert_gatt_entry(char *key, char *value, void *user_data)
>> -{
>> -       char *src_addr =3D user_data;
>> -       char dst_addr[18];
>> -       char type =3D BDADDR_BREDR;
>> -       uint16_t handle;
>> -       int ret, err;
>> -       char filename[PATH_MAX];
>> -       GKeyFile *key_file;
>> -       struct stat st;
>> -       char group[6];
>> -       char *data;
>> -       gsize length =3D 0;
>> -
>> -       ret =3D sscanf(key, "%17s#%hhu#%04hX", dst_addr, &type, &handle);=

>> -       if (ret < 3)
>> -               return;
>> -
>> -       if (bachk(dst_addr) !=3D 0)
>> -               return;
>> -
>> -       /* Check if the device directory has been created as records shou=
ld
>> -        * only be converted for known devices */
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, dst_a=
ddr);
>> -
>> -       err =3D stat(filename, &st);
>> -       if (err || !S_ISDIR(st.st_mode))
>> -               return;
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/gatt", src_addr,
>> -                                                               dst_addr)=
;
>> -       key_file =3D g_key_file_new();
>> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
>> -
>> -       sprintf(group, "%hu", handle);
>> -       g_key_file_set_string(key_file, group, "Value", value);
>> -
>> -       data =3D g_key_file_to_data(key_file, &length, NULL);
>> -       if (length > 0) {
>> -               create_file(filename, S_IRUSR | S_IWUSR);
>> -               g_file_set_contents(filename, data, length, NULL);
>> -       }
>> -
>> -       g_free(data);
>> -       g_key_file_free(key_file);
>> -}
>> -
>> -static void convert_proximity_entry(char *key, char *value, void *user_d=
ata)
>> -{
>> -       char *src_addr =3D user_data;
>> -       char *alert;
>> -       char filename[PATH_MAX];
>> -       GKeyFile *key_file;
>> -       struct stat st;
>> -       int err;
>> -       char *data;
>> -       gsize length =3D 0;
>> -
>> -       if (!strchr(key, '#'))
>> -               return;
>> -
>> -       key[17] =3D '\0';
>> -       alert =3D &key[18];
>> -
>> -       if (bachk(key) !=3D 0)
>> -               return;
>> -
>> -       /* Check if the device directory has been created as records shou=
ld
>> -        * only be converted for known devices */
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, key);=

>> -
>> -       err =3D stat(filename, &st);
>> -       if (err || !S_ISDIR(st.st_mode))
>> -               return;
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/proximity", src_a=
ddr,
>> -                                                                       k=
ey);
>> -       key_file =3D g_key_file_new();
>> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
>> -
>> -       g_key_file_set_string(key_file, alert, "Level", value);
>> -
>> -       data =3D g_key_file_to_data(key_file, &length, NULL);
>> -       if (length > 0) {
>> -               create_file(filename, S_IRUSR | S_IWUSR);
>> -               g_file_set_contents(filename, data, length, NULL);
>> -       }
>> -
>> -       g_free(data);
>> -       g_key_file_free(key_file);
>> -}
>> -
>> -static void convert_device_storage(struct btd_adapter *adapter)
>> -{
>> -       char filename[PATH_MAX];
>> -       char address[18];
>> -
>> -       ba2str(&adapter->bdaddr, address);
>> -
>> -       /* Convert device's name cache */
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/names", address);
>> -       textfile_foreach(filename, convert_names_entry, address);
>> -
>> -       /* Convert aliases */
>> -       convert_file("aliases", address, convert_aliases_entry, TRUE);
>> -
>> -       /* Convert trusts */
>> -       convert_file("trusts", address, convert_trusts_entry, TRUE);
>> -
>> -       /* Convert blocked */
>> -       convert_file("blocked", address, convert_blocked_entry, TRUE);
>> -
>> -       /* Convert profiles */
>> -       convert_file("profiles", address, convert_profiles_entry, TRUE);
>> -
>> -       /* Convert primaries */
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/primaries", address)=
;
>> -       textfile_foreach(filename, convert_primaries_entry, address);
>> -
>> -       /* Convert linkkeys */
>> -       convert_file("linkkeys", address, convert_linkkey_entry, TRUE);
>> -
>> -       /* Convert longtermkeys */
>> -       convert_file("longtermkeys", address, convert_ltk_entry, TRUE);
>> -
>> -       /* Convert classes */
>> -       convert_file("classes", address, convert_classes_entry, FALSE);
>> -
>> -       /* Convert device ids */
>> -       convert_file("did", address, convert_did_entry, FALSE);
>> -
>> -       /* Convert sdp */
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/sdp", address);
>> -       textfile_foreach(filename, convert_sdp_entry, address);
>> -
>> -       /* Convert ccc */
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/ccc", address);
>> -       textfile_foreach(filename, convert_ccc_entry, address);
>> -
>> -       /* Convert appearances */
>> -       convert_file("appearances", address, convert_appearances_entry, FA=
LSE);
>> -
>> -       /* Convert gatt */
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/gatt", address);
>> -       textfile_foreach(filename, convert_gatt_entry, address);
>> -
>> -       /* Convert proximity */
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/proximity", address)=
;
>> -       textfile_foreach(filename, convert_proximity_entry, address);
>> -}
>> -
>> -static void convert_config(struct btd_adapter *adapter, const char *file=
name,
>> -                                                       GKeyFile *key_fil=
e)
>> -{
>> -       char address[18];
>> -       char str[MAX_NAME_LENGTH + 1];
>> -       char config_path[PATH_MAX];
>> -       int timeout;
>> -       uint8_t mode;
>> -       char *data;
>> -       gsize length =3D 0;
>> -
>> -       ba2str(&adapter->bdaddr, address);
>> -       snprintf(config_path, PATH_MAX, STORAGEDIR "/%s/config", address)=
;
>> -
>> -       if (read_pairable_timeout(address, &timeout) =3D=3D 0)
>> -               g_key_file_set_integer(key_file, "General",
>> -                                               "PairableTimeout", timeou=
t);
>> -
>> -       if (read_discoverable_timeout(address, &timeout) =3D=3D 0)
>> -               g_key_file_set_integer(key_file, "General",
>> -                                               "DiscoverableTimeout", ti=
meout);
>> -
>> -       if (read_on_mode(address, str, sizeof(str)) =3D=3D 0) {
>> -               mode =3D get_mode(str);
>> -               g_key_file_set_boolean(key_file, "General", "Discoverable=
",
>> -                                       mode =3D=3D MODE_DISCOVERABLE);
>> -       }
>> -
>> -       if (read_local_name(&adapter->bdaddr, str) =3D=3D 0)
>> -               g_key_file_set_string(key_file, "General", "Alias", str);=

>> -
>> -       create_file(filename, S_IRUSR | S_IWUSR);
>> -
>> -       data =3D g_key_file_to_data(key_file, &length, NULL);
>> -       g_file_set_contents(filename, data, length, NULL);
>> -       g_free(data);
>> -}
>> -
>> -static void fix_storage(struct btd_adapter *adapter)
>> -{
>> -       char filename[PATH_MAX];
>> -       char address[18];
>> -       char *converted;
>> -
>> -       ba2str(&adapter->bdaddr, address);
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/config", address);
>> -       converted =3D textfile_get(filename, "converted");
>> -       if (!converted)
>> -               return;
>> -
>> -       free(converted);
>> -
>> -       textfile_del(filename, "converted");
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/names", address);
>> -       textfile_del(filename, "converted");
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/aliases", address);
>> -       textfile_del(filename, "converted");
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/trusts", address);
>> -       textfile_del(filename, "converted");
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/blocked", address);
>> -       textfile_del(filename, "converted");
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/profiles", address);=

>> -       textfile_del(filename, "converted");
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/primaries", address)=
;
>> -       textfile_del(filename, "converted");
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/linkkeys", address);=

>> -       textfile_del(filename, "converted");
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/longtermkeys", addre=
ss);
>> -       textfile_del(filename, "converted");
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/classes", address);
>> -       textfile_del(filename, "converted");
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/did", address);
>> -       textfile_del(filename, "converted");
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/sdp", address);
>> -       textfile_del(filename, "converted");
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/ccc", address);
>> -       textfile_del(filename, "converted");
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/appearances", addres=
s);
>> -       textfile_del(filename, "converted");
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/gatt", address);
>> -       textfile_del(filename, "converted");
>> -
>> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/proximity", address)=
;
>> -       textfile_del(filename, "converted");
>> -}
>> -
>> static void load_config(struct btd_adapter *adapter)
>> {
>>        GKeyFile *key_file;
>>        char filename[PATH_MAX];
>> -       struct stat st;
>>        GError *gerr =3D NULL;
>>=20
>>        key_file =3D g_key_file_new();
>> @@ -5752,11 +4926,6 @@ static void load_config(struct btd_adapter *adapte=
r)
>>        snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings",
>>                                        btd_adapter_get_storage_dir(adapte=
r));
>>=20
>> -       if (stat(filename, &st) < 0) {
>> -               convert_config(adapter, filename, key_file);
>> -               convert_device_storage(adapter);
>> -       }
>> -
>>        g_key_file_load_from_file(key_file, filename, 0, NULL);
>>=20
>>        /* Get alias */
>> @@ -8124,7 +7293,6 @@ static int adapter_register(struct btd_adapter *ada=
pter)
>>=20
>> load:
>>        load_config(adapter);
>> -       fix_storage(adapter);
>>        load_drivers(adapter);
>>        btd_profile_foreach(probe_profile, adapter);
>>        clear_blocked(adapter);
>> --
>> 2.11.0
>>=20
>=20
>=20
> --=20
> Luiz Augusto von Dentz
