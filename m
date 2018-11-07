Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B1BC0044C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 11:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C76320827
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 11:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NROpo+Ys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C76320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeKGVH7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:07:59 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42792 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeKGVH7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 16:07:59 -0500
Received: by mail-oi1-f193.google.com with SMTP id x63-v6so9819080oix.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Nov 2018 03:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HMCEI4Z+rfD35qnMQ1u25eVXU4TgWMRaHr4KIj2+qEI=;
        b=NROpo+YsOEZkY0q2++TixvYkSjaA4q69TqNxMmJLghiy5bMOgFLSEGCfEhKO4MtigC
         Yiuue68HiLErZ9ijFKaStlSkhS4p4FHHOlXkdN8dvet1QerCWe/80QarF1flt8Pd+8y4
         jGppnTMv97Q2NRt92VHcREIRzY4kPKPq4UPtzNNG3Sz/D7LdSEJvSpY2pjxHXGNa+DOZ
         6y6P7hCyvOlr1IVSqmzD5efNok1atFQNGZHOVxR8l317AnOcsyuzjIVlm3LjA9YCO+mz
         B2s/DKXorx+gW10A9if4izaiyMI5WC9lFqxbVooKZr0Md7xgS36fsBa8Xem/efgLNTU8
         z2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HMCEI4Z+rfD35qnMQ1u25eVXU4TgWMRaHr4KIj2+qEI=;
        b=WkbmhXRdFvot3vbEE1Fv6V6JGsN1IqfZfUAugumuhik6jB2vlohxjJZOH/VHfJJ/B0
         ZE7su8KDKwITDGhnM5AvpjLTvzwbVG/2mwW3oiA4l+5nuAAdIWoJ2UJiL44MoomVtJyj
         CAb4EncYSngj9AOq/LrUMyvDzsIRrvuVtPO0eSlr2tObSdiorCr1icqusmX1iYdtCMg0
         TcxqaSl4V1J0X8xLSTaON9Qho8G5LYPqf9bH21xp01Fr++mZCS2RpDW1zqtHgGlmYCPo
         +qd8bVhvRc6KT5e6B4aQMav6n72om3anCpop8stiL8Hv8teFamf451wxwx5sl0qkDbqg
         cVGQ==
X-Gm-Message-State: AGRZ1gLD0Po9uF8Ojo4LlSz6wY1GxcklrCaPqle8WvehKD+vdrgIYZvt
        W3mHP5d8XeFnrBihG4qj5RaIzj++oZzlL9aKJBY=
X-Google-Smtp-Source: AJdET5c+5FDE8fbkgNdLYoR+BnEHhsw1gVhj7S2/wZ8Dr8Cj8LhHU7KPFQklRbImTjNr5MSqTwpOytFquQEUEKKIK5Y=
X-Received: by 2002:aca:aa4f:: with SMTP id t76-v6mr781814oie.273.1541590679476;
 Wed, 07 Nov 2018 03:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20181105160342.29434-1-zimmermach@gmail.com>
In-Reply-To: <20181105160342.29434-1-zimmermach@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 7 Nov 2018 13:37:47 +0200
Message-ID: <CABBYNZ+A+iU4wAw6LVy6toi+Qb7=2trkbx+HJmQYtdYyTHwSEA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] src/adapter: Removed obsolete conversion functions
 for persistant settings
To:     zimmermach@gmail.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Christian,

On Mon, Nov 5, 2018 at 6:10 PM Christian Zimmermann
<zimmermach@gmail.com> wrote:
>
> According to TODO file:
> Removal of conversion functions for persistant settings
> since they're obsolete with Bluez5 after certain time of it's first release

We probably need to consider if there are still platforms using BlueZ
4 then removing this code would make the transition, perhaps we could
have a tool to do that so we can remove this from the daemon.

> ---
>  TODO          |   6 -
>  src/adapter.c | 832 ----------------------------------------------------------
>  2 files changed, 838 deletions(-)
>
> diff --git a/TODO b/TODO
> index d88349e06..ae2d69dfa 100644
> --- a/TODO
> +++ b/TODO
> @@ -37,12 +37,6 @@ General
>    Priority: Medium
>    Complexity: C2
>
> -- Function in src/adapter.c to convert old storage files to new ini-file format
> -  should be removed 6-8 months after first BlueZ 5 release.
> -
> -  Priority: Low
> -  Complexity: C1
> -
>  - Remove usage of symlinks for drivers, such as profiles/input/suspend.c and
>    profiles/sap/sap.c. Instead, select drivers at runtime by using config
>    options or probing for running D-Bus services (using e.g.
> diff --git a/src/adapter.c b/src/adapter.c
> index c24432125..5709ee956 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -423,18 +423,6 @@ void btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
>         set_dev_class(adapter);
>  }
>
> -static uint8_t get_mode(const char *mode)
> -{
> -       if (strcasecmp("off", mode) == 0)
> -               return MODE_OFF;
> -       else if (strcasecmp("connectable", mode) == 0)
> -               return MODE_CONNECTABLE;
> -       else if (strcasecmp("discoverable", mode) == 0)
> -               return MODE_DISCOVERABLE;
> -       else
> -               return MODE_UNKNOWN;
> -}
> -
>  const char *btd_adapter_get_storage_dir(struct btd_adapter *adapter)
>  {
>         static char dir[25];
> @@ -4927,824 +4915,10 @@ void btd_adapter_unref(struct btd_adapter *adapter)
>                                                 ADAPTER_INTERFACE);
>  }
>
> -static void convert_names_entry(char *key, char *value, void *user_data)
> -{
> -       char *address = user_data;
> -       char *str = key;
> -       char filename[PATH_MAX];
> -       GKeyFile *key_file;
> -       char *data;
> -       gsize length = 0;
> -
> -       if (strchr(key, '#'))
> -               str[17] = '\0';
> -
> -       if (bachk(str) != 0)
> -               return;
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", address, str);
> -       create_file(filename, S_IRUSR | S_IWUSR);
> -
> -       key_file = g_key_file_new();
> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> -       g_key_file_set_string(key_file, "General", "Name", value);
> -
> -       data = g_key_file_to_data(key_file, &length, NULL);
> -       g_file_set_contents(filename, data, length, NULL);
> -       g_free(data);
> -
> -       g_key_file_free(key_file);
> -}
> -
> -struct device_converter {
> -       char *address;
> -       void (*cb)(GKeyFile *key_file, void *value);
> -       gboolean force;
> -};
> -
> -static void set_device_type(GKeyFile *key_file, char type)
> -{
> -       char *techno;
> -       char *addr_type = NULL;
> -       char *str;
> -
> -       switch (type) {
> -       case BDADDR_BREDR:
> -               techno = "BR/EDR";
> -               break;
> -       case BDADDR_LE_PUBLIC:
> -               techno = "LE";
> -               addr_type = "public";
> -               break;
> -       case BDADDR_LE_RANDOM:
> -               techno = "LE";
> -               addr_type = "static";
> -               break;
> -       default:
> -               return;
> -       }
> -
> -       str = g_key_file_get_string(key_file, "General",
> -                                       "SupportedTechnologies", NULL);
> -       if (!str)
> -               g_key_file_set_string(key_file, "General",
> -                                       "SupportedTechnologies", techno);
> -       else if (!strstr(str, techno))
> -               g_key_file_set_string(key_file, "General",
> -                                       "SupportedTechnologies", "BR/EDR;LE");
> -
> -       g_free(str);
> -
> -       if (addr_type)
> -               g_key_file_set_string(key_file, "General", "AddressType",
> -                                       addr_type);
> -}
> -
> -static void convert_aliases_entry(GKeyFile *key_file, void *value)
> -{
> -       g_key_file_set_string(key_file, "General", "Alias", value);
> -}
> -
> -static void convert_trusts_entry(GKeyFile *key_file, void *value)
> -{
> -       g_key_file_set_boolean(key_file, "General", "Trusted", TRUE);
> -}
> -
> -static void convert_classes_entry(GKeyFile *key_file, void *value)
> -{
> -       g_key_file_set_string(key_file, "General", "Class", value);
> -}
> -
> -static void convert_blocked_entry(GKeyFile *key_file, void *value)
> -{
> -       g_key_file_set_boolean(key_file, "General", "Blocked", TRUE);
> -}
> -
> -static void convert_did_entry(GKeyFile *key_file, void *value)
> -{
> -       char *vendor_str, *product_str, *version_str;
> -       uint16_t val;
> -
> -       vendor_str = strchr(value, ' ');
> -       if (!vendor_str)
> -               return;
> -
> -       *(vendor_str++) = 0;
> -
> -       if (g_str_equal(value, "FFFF"))
> -               return;
> -
> -       product_str = strchr(vendor_str, ' ');
> -       if (!product_str)
> -               return;
> -
> -       *(product_str++) = 0;
> -
> -       version_str = strchr(product_str, ' ');
> -       if (!version_str)
> -               return;
> -
> -       *(version_str++) = 0;
> -
> -       val = (uint16_t) strtol(value, NULL, 16);
> -       g_key_file_set_integer(key_file, "DeviceID", "Source", val);
> -
> -       val = (uint16_t) strtol(vendor_str, NULL, 16);
> -       g_key_file_set_integer(key_file, "DeviceID", "Vendor", val);
> -
> -       val = (uint16_t) strtol(product_str, NULL, 16);
> -       g_key_file_set_integer(key_file, "DeviceID", "Product", val);
> -
> -       val = (uint16_t) strtol(version_str, NULL, 16);
> -       g_key_file_set_integer(key_file, "DeviceID", "Version", val);
> -}
> -
> -static void convert_linkkey_entry(GKeyFile *key_file, void *value)
> -{
> -       char *type_str, *length_str, *str;
> -       int val;
> -
> -       type_str = strchr(value, ' ');
> -       if (!type_str)
> -               return;
> -
> -       *(type_str++) = 0;
> -
> -       length_str = strchr(type_str, ' ');
> -       if (!length_str)
> -               return;
> -
> -       *(length_str++) = 0;
> -
> -       str = g_strconcat("0x", value, NULL);
> -       g_key_file_set_string(key_file, "LinkKey", "Key", str);
> -       g_free(str);
> -
> -       val = strtol(type_str, NULL, 16);
> -       g_key_file_set_integer(key_file, "LinkKey", "Type", val);
> -
> -       val = strtol(length_str, NULL, 16);
> -       g_key_file_set_integer(key_file, "LinkKey", "PINLength", val);
> -}
> -
> -static void convert_ltk_entry(GKeyFile *key_file, void *value)
> -{
> -       char *auth_str, *rand_str, *str;
> -       int i, ret;
> -       unsigned char auth, master, enc_size;
> -       unsigned short ediv;
> -
> -       auth_str = strchr(value, ' ');
> -       if (!auth_str)
> -               return;
> -
> -       *(auth_str++) = 0;
> -
> -       for (i = 0, rand_str = auth_str; i < 4; i++) {
> -               rand_str = strchr(rand_str, ' ');
> -               if (!rand_str || rand_str[1] == '\0')
> -                       return;
> -
> -               rand_str++;
> -       }
> -
> -       ret = sscanf(auth_str, " %hhd %hhd %hhd %hd", &auth, &master,
> -                                                       &enc_size, &ediv);
> -       if (ret < 4)
> -               return;
> -
> -       str = g_strconcat("0x", value, NULL);
> -       g_key_file_set_string(key_file, "LongTermKey", "Key", str);
> -       g_free(str);
> -
> -       g_key_file_set_integer(key_file, "LongTermKey", "Authenticated", auth);
> -       g_key_file_set_integer(key_file, "LongTermKey", "Master", master);
> -       g_key_file_set_integer(key_file, "LongTermKey", "EncSize", enc_size);
> -       g_key_file_set_integer(key_file, "LongTermKey", "EDiv", ediv);
> -
> -       str = g_strconcat("0x", rand_str, NULL);
> -       g_key_file_set_string(key_file, "LongTermKey", "Rand", str);
> -       g_free(str);
> -}
> -
> -static void convert_profiles_entry(GKeyFile *key_file, void *value)
> -{
> -       g_strdelimit(value, " ", ';');
> -       g_key_file_set_string(key_file, "General", "Services", value);
> -}
> -
> -static void convert_appearances_entry(GKeyFile *key_file, void *value)
> -{
> -       g_key_file_set_string(key_file, "General", "Appearance", value);
> -}
> -
> -static void convert_entry(char *key, char *value, void *user_data)
> -{
> -       struct device_converter *converter = user_data;
> -       char type = BDADDR_BREDR;
> -       char filename[PATH_MAX];
> -       GKeyFile *key_file;
> -       char *data;
> -       gsize length = 0;
> -
> -       if (strchr(key, '#')) {
> -               key[17] = '\0';
> -               type = key[18] - '0';
> -       }
> -
> -       if (bachk(key) != 0)
> -               return;
> -
> -       if (converter->force == FALSE) {
> -               struct stat st;
> -               int err;
> -
> -               snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s",
> -                               converter->address, key);
> -
> -               err = stat(filename, &st);
> -               if (err || !S_ISDIR(st.st_mode))
> -                       return;
> -       }
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
> -                       converter->address, key);
> -
> -       key_file = g_key_file_new();
> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> -
> -       set_device_type(key_file, type);
> -
> -       converter->cb(key_file, value);
> -
> -       data = g_key_file_to_data(key_file, &length, NULL);
> -       if (length > 0) {
> -               create_file(filename, S_IRUSR | S_IWUSR);
> -               g_file_set_contents(filename, data, length, NULL);
> -       }
> -
> -       g_free(data);
> -
> -       g_key_file_free(key_file);
> -}
> -
> -static void convert_file(char *file, char *address,
> -                               void (*cb)(GKeyFile *key_file, void *value),
> -                               gboolean force)
> -{
> -       char filename[PATH_MAX];
> -       struct device_converter converter;
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", address, file);
> -
> -       converter.address = address;
> -       converter.cb = cb;
> -       converter.force = force;
> -
> -       textfile_foreach(filename, convert_entry, &converter);
> -}
> -
> -static gboolean record_has_uuid(const sdp_record_t *rec,
> -                               const char *profile_uuid)
> -{
> -       sdp_list_t *pat;
> -
> -       for (pat = rec->pattern; pat != NULL; pat = pat->next) {
> -               char *uuid;
> -               int ret;
> -
> -               uuid = bt_uuid2string(pat->data);
> -               if (!uuid)
> -                       continue;
> -
> -               ret = strcasecmp(uuid, profile_uuid);
> -
> -               free(uuid);
> -
> -               if (ret == 0)
> -                       return TRUE;
> -       }
> -
> -       return FALSE;
> -}
> -
> -static void store_attribute_uuid(GKeyFile *key_file, uint16_t start,
> -                                       uint16_t end, char *att_uuid,
> -                                       uuid_t uuid)
> -{
> -       char handle[6], uuid_str[33];
> -       int i;
> -
> -       switch (uuid.type) {
> -       case SDP_UUID16:
> -               sprintf(uuid_str, "%4.4X", uuid.value.uuid16);
> -               break;
> -       case SDP_UUID32:
> -               sprintf(uuid_str, "%8.8X", uuid.value.uuid32);
> -               break;
> -       case SDP_UUID128:
> -               for (i = 0; i < 16; i++)
> -                       sprintf(uuid_str + (i * 2), "%2.2X",
> -                                       uuid.value.uuid128.data[i]);
> -               break;
> -       default:
> -               uuid_str[0] = '\0';
> -       }
> -
> -       sprintf(handle, "%hu", start);
> -       g_key_file_set_string(key_file, handle, "UUID", att_uuid);
> -       g_key_file_set_string(key_file, handle, "Value", uuid_str);
> -       g_key_file_set_integer(key_file, handle, "EndGroupHandle", end);
> -}
> -
> -static void store_sdp_record(char *local, char *peer, int handle, char *value)
> -{
> -       char filename[PATH_MAX];
> -       GKeyFile *key_file;
> -       char handle_str[11];
> -       char *data;
> -       gsize length = 0;
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
> -
> -       key_file = g_key_file_new();
> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> -
> -       sprintf(handle_str, "0x%8.8X", handle);
> -       g_key_file_set_string(key_file, "ServiceRecords", handle_str, value);
> -
> -       data = g_key_file_to_data(key_file, &length, NULL);
> -       if (length > 0) {
> -               create_file(filename, S_IRUSR | S_IWUSR);
> -               g_file_set_contents(filename, data, length, NULL);
> -       }
> -
> -       g_free(data);
> -
> -       g_key_file_free(key_file);
> -}
> -
> -static void convert_sdp_entry(char *key, char *value, void *user_data)
> -{
> -       char *src_addr = user_data;
> -       char dst_addr[18];
> -       char type = BDADDR_BREDR;
> -       int handle, ret;
> -       char filename[PATH_MAX];
> -       GKeyFile *key_file;
> -       struct stat st;
> -       sdp_record_t *rec;
> -       uuid_t uuid;
> -       char *att_uuid, *prim_uuid;
> -       uint16_t start = 0, end = 0, psm = 0;
> -       int err;
> -       char *data;
> -       gsize length = 0;
> -
> -       ret = sscanf(key, "%17s#%hhu#%08X", dst_addr, &type, &handle);
> -       if (ret < 3) {
> -               ret = sscanf(key, "%17s#%08X", dst_addr, &handle);
> -               if (ret < 2)
> -                       return;
> -       }
> -
> -       if (bachk(dst_addr) != 0)
> -               return;
> -
> -       /* Check if the device directory has been created as records should
> -        * only be converted for known devices */
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, dst_addr);
> -
> -       err = stat(filename, &st);
> -       if (err || !S_ISDIR(st.st_mode))
> -               return;
> -
> -       /* store device records in cache */
> -       store_sdp_record(src_addr, dst_addr, handle, value);
> -
> -       /* Retrieve device record and check if there is an
> -        * attribute entry in it */
> -       sdp_uuid16_create(&uuid, ATT_UUID);
> -       att_uuid = bt_uuid2string(&uuid);
> -
> -       sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
> -       prim_uuid = bt_uuid2string(&uuid);
> -
> -       rec = record_from_string(value);
> -
> -       if (record_has_uuid(rec, att_uuid))
> -               goto failed;
> -
> -       /* TODO: Do this through btd_gatt_database */
> -       if (!gatt_parse_record(rec, &uuid, &psm, &start, &end))
> -               goto failed;
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", src_addr,
> -                                                               dst_addr);
> -
> -       key_file = g_key_file_new();
> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> -
> -       store_attribute_uuid(key_file, start, end, prim_uuid, uuid);
> -
> -       data = g_key_file_to_data(key_file, &length, NULL);
> -       if (length > 0) {
> -               create_file(filename, S_IRUSR | S_IWUSR);
> -               g_file_set_contents(filename, data, length, NULL);
> -       }
> -
> -       g_free(data);
> -       g_key_file_free(key_file);
> -
> -failed:
> -       sdp_record_free(rec);
> -       free(prim_uuid);
> -       free(att_uuid);
> -}
> -
> -static void convert_primaries_entry(char *key, char *value, void *user_data)
> -{
> -       char *address = user_data;
> -       int device_type = -1;
> -       uuid_t uuid;
> -       char **services, **service, *prim_uuid;
> -       char filename[PATH_MAX];
> -       GKeyFile *key_file;
> -       int ret;
> -       uint16_t start, end;
> -       char uuid_str[MAX_LEN_UUID_STR + 1];
> -       char *data;
> -       gsize length = 0;
> -
> -       if (strchr(key, '#')) {
> -               key[17] = '\0';
> -               device_type = key[18] - '0';
> -       }
> -
> -       if (bachk(key) != 0)
> -               return;
> -
> -       services = g_strsplit(value, " ", 0);
> -       if (services == NULL)
> -               return;
> -
> -       sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
> -       prim_uuid = bt_uuid2string(&uuid);
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", address,
> -                                                                       key);
> -       key_file = g_key_file_new();
> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> -
> -       for (service = services; *service; service++) {
> -               ret = sscanf(*service, "%04hX#%04hX#%s", &start, &end,
> -                                                               uuid_str);
> -               if (ret < 3)
> -                       continue;
> -
> -               bt_string2uuid(&uuid, uuid_str);
> -               sdp_uuid128_to_uuid(&uuid);
> -
> -               store_attribute_uuid(key_file, start, end, prim_uuid, uuid);
> -       }
> -
> -       g_strfreev(services);
> -
> -       data = g_key_file_to_data(key_file, &length, NULL);
> -       if (length == 0)
> -               goto end;
> -
> -       create_file(filename, S_IRUSR | S_IWUSR);
> -       g_file_set_contents(filename, data, length, NULL);
> -
> -       if (device_type < 0)
> -               goto end;
> -
> -       g_free(data);
> -       g_key_file_free(key_file);
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", address, key);
> -
> -       key_file = g_key_file_new();
> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> -       set_device_type(key_file, device_type);
> -
> -       data = g_key_file_to_data(key_file, &length, NULL);
> -       if (length > 0) {
> -               create_file(filename, S_IRUSR | S_IWUSR);
> -               g_file_set_contents(filename, data, length, NULL);
> -       }
> -
> -end:
> -       g_free(data);
> -       free(prim_uuid);
> -       g_key_file_free(key_file);
> -}
> -
> -static void convert_ccc_entry(char *key, char *value, void *user_data)
> -{
> -       char *src_addr = user_data;
> -       char dst_addr[18];
> -       char type = BDADDR_BREDR;
> -       uint16_t handle;
> -       int ret, err;
> -       char filename[PATH_MAX];
> -       GKeyFile *key_file;
> -       struct stat st;
> -       char group[6];
> -       char *data;
> -       gsize length = 0;
> -
> -       ret = sscanf(key, "%17s#%hhu#%04hX", dst_addr, &type, &handle);
> -       if (ret < 3)
> -               return;
> -
> -       if (bachk(dst_addr) != 0)
> -               return;
> -
> -       /* Check if the device directory has been created as records should
> -        * only be converted for known devices */
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, dst_addr);
> -
> -       err = stat(filename, &st);
> -       if (err || !S_ISDIR(st.st_mode))
> -               return;
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/ccc", src_addr,
> -                                                               dst_addr);
> -       key_file = g_key_file_new();
> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> -
> -       sprintf(group, "%hu", handle);
> -       g_key_file_set_string(key_file, group, "Value", value);
> -
> -       data = g_key_file_to_data(key_file, &length, NULL);
> -       if (length > 0) {
> -               create_file(filename, S_IRUSR | S_IWUSR);
> -               g_file_set_contents(filename, data, length, NULL);
> -       }
> -
> -       g_free(data);
> -       g_key_file_free(key_file);
> -}
> -
> -static void convert_gatt_entry(char *key, char *value, void *user_data)
> -{
> -       char *src_addr = user_data;
> -       char dst_addr[18];
> -       char type = BDADDR_BREDR;
> -       uint16_t handle;
> -       int ret, err;
> -       char filename[PATH_MAX];
> -       GKeyFile *key_file;
> -       struct stat st;
> -       char group[6];
> -       char *data;
> -       gsize length = 0;
> -
> -       ret = sscanf(key, "%17s#%hhu#%04hX", dst_addr, &type, &handle);
> -       if (ret < 3)
> -               return;
> -
> -       if (bachk(dst_addr) != 0)
> -               return;
> -
> -       /* Check if the device directory has been created as records should
> -        * only be converted for known devices */
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, dst_addr);
> -
> -       err = stat(filename, &st);
> -       if (err || !S_ISDIR(st.st_mode))
> -               return;
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/gatt", src_addr,
> -                                                               dst_addr);
> -       key_file = g_key_file_new();
> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> -
> -       sprintf(group, "%hu", handle);
> -       g_key_file_set_string(key_file, group, "Value", value);
> -
> -       data = g_key_file_to_data(key_file, &length, NULL);
> -       if (length > 0) {
> -               create_file(filename, S_IRUSR | S_IWUSR);
> -               g_file_set_contents(filename, data, length, NULL);
> -       }
> -
> -       g_free(data);
> -       g_key_file_free(key_file);
> -}
> -
> -static void convert_proximity_entry(char *key, char *value, void *user_data)
> -{
> -       char *src_addr = user_data;
> -       char *alert;
> -       char filename[PATH_MAX];
> -       GKeyFile *key_file;
> -       struct stat st;
> -       int err;
> -       char *data;
> -       gsize length = 0;
> -
> -       if (!strchr(key, '#'))
> -               return;
> -
> -       key[17] = '\0';
> -       alert = &key[18];
> -
> -       if (bachk(key) != 0)
> -               return;
> -
> -       /* Check if the device directory has been created as records should
> -        * only be converted for known devices */
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, key);
> -
> -       err = stat(filename, &st);
> -       if (err || !S_ISDIR(st.st_mode))
> -               return;
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/proximity", src_addr,
> -                                                                       key);
> -       key_file = g_key_file_new();
> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> -
> -       g_key_file_set_string(key_file, alert, "Level", value);
> -
> -       data = g_key_file_to_data(key_file, &length, NULL);
> -       if (length > 0) {
> -               create_file(filename, S_IRUSR | S_IWUSR);
> -               g_file_set_contents(filename, data, length, NULL);
> -       }
> -
> -       g_free(data);
> -       g_key_file_free(key_file);
> -}
> -
> -static void convert_device_storage(struct btd_adapter *adapter)
> -{
> -       char filename[PATH_MAX];
> -       char address[18];
> -
> -       ba2str(&adapter->bdaddr, address);
> -
> -       /* Convert device's name cache */
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/names", address);
> -       textfile_foreach(filename, convert_names_entry, address);
> -
> -       /* Convert aliases */
> -       convert_file("aliases", address, convert_aliases_entry, TRUE);
> -
> -       /* Convert trusts */
> -       convert_file("trusts", address, convert_trusts_entry, TRUE);
> -
> -       /* Convert blocked */
> -       convert_file("blocked", address, convert_blocked_entry, TRUE);
> -
> -       /* Convert profiles */
> -       convert_file("profiles", address, convert_profiles_entry, TRUE);
> -
> -       /* Convert primaries */
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/primaries", address);
> -       textfile_foreach(filename, convert_primaries_entry, address);
> -
> -       /* Convert linkkeys */
> -       convert_file("linkkeys", address, convert_linkkey_entry, TRUE);
> -
> -       /* Convert longtermkeys */
> -       convert_file("longtermkeys", address, convert_ltk_entry, TRUE);
> -
> -       /* Convert classes */
> -       convert_file("classes", address, convert_classes_entry, FALSE);
> -
> -       /* Convert device ids */
> -       convert_file("did", address, convert_did_entry, FALSE);
> -
> -       /* Convert sdp */
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/sdp", address);
> -       textfile_foreach(filename, convert_sdp_entry, address);
> -
> -       /* Convert ccc */
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/ccc", address);
> -       textfile_foreach(filename, convert_ccc_entry, address);
> -
> -       /* Convert appearances */
> -       convert_file("appearances", address, convert_appearances_entry, FALSE);
> -
> -       /* Convert gatt */
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/gatt", address);
> -       textfile_foreach(filename, convert_gatt_entry, address);
> -
> -       /* Convert proximity */
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/proximity", address);
> -       textfile_foreach(filename, convert_proximity_entry, address);
> -}
> -
> -static void convert_config(struct btd_adapter *adapter, const char *filename,
> -                                                       GKeyFile *key_file)
> -{
> -       char address[18];
> -       char str[MAX_NAME_LENGTH + 1];
> -       char config_path[PATH_MAX];
> -       int timeout;
> -       uint8_t mode;
> -       char *data;
> -       gsize length = 0;
> -
> -       ba2str(&adapter->bdaddr, address);
> -       snprintf(config_path, PATH_MAX, STORAGEDIR "/%s/config", address);
> -
> -       if (read_pairable_timeout(address, &timeout) == 0)
> -               g_key_file_set_integer(key_file, "General",
> -                                               "PairableTimeout", timeout);
> -
> -       if (read_discoverable_timeout(address, &timeout) == 0)
> -               g_key_file_set_integer(key_file, "General",
> -                                               "DiscoverableTimeout", timeout);
> -
> -       if (read_on_mode(address, str, sizeof(str)) == 0) {
> -               mode = get_mode(str);
> -               g_key_file_set_boolean(key_file, "General", "Discoverable",
> -                                       mode == MODE_DISCOVERABLE);
> -       }
> -
> -       if (read_local_name(&adapter->bdaddr, str) == 0)
> -               g_key_file_set_string(key_file, "General", "Alias", str);
> -
> -       create_file(filename, S_IRUSR | S_IWUSR);
> -
> -       data = g_key_file_to_data(key_file, &length, NULL);
> -       g_file_set_contents(filename, data, length, NULL);
> -       g_free(data);
> -}
> -
> -static void fix_storage(struct btd_adapter *adapter)
> -{
> -       char filename[PATH_MAX];
> -       char address[18];
> -       char *converted;
> -
> -       ba2str(&adapter->bdaddr, address);
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/config", address);
> -       converted = textfile_get(filename, "converted");
> -       if (!converted)
> -               return;
> -
> -       free(converted);
> -
> -       textfile_del(filename, "converted");
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/names", address);
> -       textfile_del(filename, "converted");
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/aliases", address);
> -       textfile_del(filename, "converted");
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/trusts", address);
> -       textfile_del(filename, "converted");
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/blocked", address);
> -       textfile_del(filename, "converted");
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/profiles", address);
> -       textfile_del(filename, "converted");
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/primaries", address);
> -       textfile_del(filename, "converted");
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/linkkeys", address);
> -       textfile_del(filename, "converted");
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/longtermkeys", address);
> -       textfile_del(filename, "converted");
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/classes", address);
> -       textfile_del(filename, "converted");
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/did", address);
> -       textfile_del(filename, "converted");
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/sdp", address);
> -       textfile_del(filename, "converted");
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/ccc", address);
> -       textfile_del(filename, "converted");
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/appearances", address);
> -       textfile_del(filename, "converted");
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/gatt", address);
> -       textfile_del(filename, "converted");
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/proximity", address);
> -       textfile_del(filename, "converted");
> -}
> -
>  static void load_config(struct btd_adapter *adapter)
>  {
>         GKeyFile *key_file;
>         char filename[PATH_MAX];
> -       struct stat st;
>         GError *gerr = NULL;
>
>         key_file = g_key_file_new();
> @@ -5752,11 +4926,6 @@ static void load_config(struct btd_adapter *adapter)
>         snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings",
>                                         btd_adapter_get_storage_dir(adapter));
>
> -       if (stat(filename, &st) < 0) {
> -               convert_config(adapter, filename, key_file);
> -               convert_device_storage(adapter);
> -       }
> -
>         g_key_file_load_from_file(key_file, filename, 0, NULL);
>
>         /* Get alias */
> @@ -8124,7 +7293,6 @@ static int adapter_register(struct btd_adapter *adapter)
>
>  load:
>         load_config(adapter);
> -       fix_storage(adapter);
>         load_drivers(adapter);
>         btd_profile_foreach(probe_profile, adapter);
>         clear_blocked(adapter);
> --
> 2.11.0
>


-- 
Luiz Augusto von Dentz
