Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87245C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 20:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiKVUOO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 15:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiKVUON (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 15:14:13 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F6B63BB
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 12:14:11 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b3so25205950lfv.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 12:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KvEMZWpkHF/oaaNqqf1C/r2qvX2v+8+UxPulJXnWsd8=;
        b=a3SiAGL0webkbPR4U+9I1z2bVcW1RxOle66RW8tbxdqIlCoUgPHwxgH6qeoDgqK3Xy
         SiLlz5LhZstQt/vlT5R9OkRGODVpBrwU5hsfXjgQZ+YzxyZ0GGqZygI5a5GNd3MBy/ys
         CXp7nXpS0ceE16ir/Idz0KntFuAjM4IZma7TnfEIlgofONqmSQDkSZ4/AqzXwOt4dESR
         DfKCAIytOdosYw1BRenfmBYYsqa78lGGG3Jbpk06khOomUo1mxSXLokoNDI8q7JTJ68k
         KyOnJ8Nn5FeDCO8+5VBBHUFU9ug+jKucUof7/NyO1umUGdRxnW3BYWba9pD5yTvbU5U5
         B4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KvEMZWpkHF/oaaNqqf1C/r2qvX2v+8+UxPulJXnWsd8=;
        b=rWNhsDQ3VXfscGI7bH5hhes8dLzpXCoJFbPRN9vRblSspM/aP1hOv2nN+vL9jtUbfp
         P5GdBLX5Ej9Xk8ezVpPXVXcRGv5K7wphf/MlM8ncfqkht53iIQd97fMMM4i87V42TbZq
         8n1M3159+0duEmWiSv4l1nAVE1qPHQlYbgFbct72GepoDef6A7UkGUbFdaGdchPfLv2w
         KK+Fr5/KMAg+TMKTHPIqcBRuHdLxPCtdSmar4W6x9/gvITdJyT/I7Y5sgEjwdk+lu5hq
         qhC1P2xAddFxxpIoQs38SDjgt0x/S/SrF8Zv//68BAIAWLjIvBJtVk4pT5RP686IUx19
         LdbQ==
X-Gm-Message-State: ANoB5pmURR08zmb1dRfrrvkZUpmRLTKsNyvrLHdeFMLiJN6SfRe9ZBV6
        T6e2mgObEwXoZKrTpQg2ufxfBbw+96k6Y8qPi5opUMhl
X-Google-Smtp-Source: AA0mqf7HYw3B4aF4P3YDKP+WltBENqbEMA3btSEvnj8lNVUNecUnHv7QN/XmxpA6/031Fx/dA1yeYHEQYoFrrmM8E2A=
X-Received: by 2002:ac2:5a59:0:b0:494:70b2:26bb with SMTP id
 r25-20020ac25a59000000b0049470b226bbmr2033319lfn.26.1669148049404; Tue, 22
 Nov 2022 12:14:09 -0800 (PST)
MIME-Version: 1.0
References: <20221122101232.45320-1-sathish.narasimman@intel.com> <20221122101232.45320-4-sathish.narasimman@intel.com>
In-Reply-To: <20221122101232.45320-4-sathish.narasimman@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 22 Nov 2022 12:13:57 -0800
Message-ID: <CABBYNZKsRV4W63KRrsJ7Ay8Er0NBV1DGEWqtgceoTaaA2VowQA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 3/7] main.conf: Add CSIP profile configurable options
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,


On Tue, Nov 22, 2022 at 2:17 AM Sathish Narasimman
<sathish.narasimman@intel.com> wrote:
>
> This introduces option to configure main.conf that can be used to
> configure co-ordinated set identification profile.
> ---
>  src/btd.h     |   9 ++++
>  src/main.c    | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/main.conf |  24 +++++++++++
>  3 files changed, 146 insertions(+)
>
> diff --git a/src/btd.h b/src/btd.h
> index 42cffcde43ca..a3683a098689 100644
> --- a/src/btd.h
> +++ b/src/btd.h
> @@ -92,6 +92,13 @@ struct btd_defaults {
>         struct btd_le_defaults le;
>  };
>
> +struct btd_csis {
> +       uint8_t sirk_type;
> +       uint8_t sirk_val[16];
> +       uint8_t cs_size;
> +       uint8_t cs_rank;
> +};
> +
>  struct btd_avdtp_opts {
>         uint8_t  session_mode;
>         uint8_t  stream_mode;
> @@ -142,6 +149,8 @@ struct btd_opts {
>         enum jw_repairing_t jw_repairing;
>
>         struct btd_advmon_opts  advmon;
> +
> +       struct btd_csis csis_defaults;
>  };
>
>  extern struct btd_opts btd_opts;
> diff --git a/src/main.c b/src/main.c
> index 99d9c508ff91..abb422961f78 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -60,6 +60,9 @@
>  #define DEFAULT_TEMPORARY_TIMEOUT         30 /* 30 seconds */
>  #define DEFAULT_NAME_REQUEST_RETRY_DELAY 300 /* 5 minutes */
>
> +/*CSIP Profile - Server */
> +#define DEFAULT_SIRK "761FAE703ED681F0C50B34155B6434FB"
> +
>  #define SHUTDOWN_GRACE_SECONDS 10
>
>  struct btd_opts btd_opts;
> @@ -146,6 +149,14 @@ static const char *gatt_options[] = {
>         NULL
>  };
>
> +static const char *csip_options[] = {
> +       "CsisSirkType",
> +       "CsisSirkValue",
> +       "CsisSize",
> +       "CsisRank",
> +       NULL
> +};
> +
>  static const char *avdtp_options[] = {
>         "SessionMode",
>         "StreamMode",
> @@ -166,11 +177,55 @@ static const struct group_table {
>         { "LE",         le_options },
>         { "Policy",     policy_options },
>         { "GATT",       gatt_options },
> +       { "CSIP",       csip_options },
>         { "AVDTP",      avdtp_options },
>         { "AdvMon",     advmon_options },
>         { }
>  };
>
> +#ifndef MIN
> +#define MIN(x, y) ((x) < (y) ? (x) : (y))
> +#endif
> +
> +static int8_t check_sirk_alpha_numeric(char *str)
> +{
> +       int8_t val = 0;
> +       char *s = str;
> +
> +       if (strlen(s) != 32) /* 32 Bytes of Alpha numeric string */
> +               return 0;
> +
> +       for ( ; *s; s++) {
> +               if (((*s >= '0') & (*s <= '9'))
> +                       || ((*s >= 'a') && (*s <= 'z'))
> +                       || ((*s >= 'A') && (*s <= 'Z'))) {
> +                       val = 1;
> +               } else {
> +                       val = 0;
> +                       break;
> +               }
> +       }
> +
> +       return val;
> +}
> +
> +static size_t hex2bin(const char *hexstr, uint8_t *buf, size_t buflen)
> +{
> +       size_t i, len;
> +
> +       if (!hexstr)
> +               return 0;
> +
> +       len = MIN((strlen(hexstr) / 2), buflen);
> +       memset(buf, 0, len);
> +
> +       for (i = 0; i < len; i++) {
> +               if (sscanf(hexstr + (i * 2), "%02hhX", &buf[i]) != 1)
> +                       continue;
> +       }
> +
> +       return len;
> +}
>
>  GKeyFile *btd_get_main_conf(void)
>  {
> @@ -939,6 +994,58 @@ static void parse_config(GKeyFile *config)
>                 btd_opts.gatt_channels = val;
>         }
>
> +       val = g_key_file_get_integer(config, "CSIP", "CsisSirkType", &err);
> +       if (err) {
> +               DBG("%s", err->message);
> +               g_clear_error(&err);
> +       } else {
> +               val = MIN(val, 2);
> +               val = MAX(val, 1);
> +               DBG("Csis Type: %u", val);
> +               btd_opts.csis_defaults.cs_size = val;
> +       }
> +
> +       str = g_key_file_get_string(config, "CSIP", "CsisSirkValue", &err);
> +       if (err) {
> +               DBG("%s", err->message);
> +               g_clear_error(&err);
> +       } else {
> +               DBG("Csis Sirk: %s", str);
> +
> +               if (!check_sirk_alpha_numeric(str)) {
> +                       DBG("SIRK is not apha numeric Value");
> +                       return;
> +               }
> +
> +               btd_opts.csis_defaults.sirk_type = 1; /* Plain Text - Type*/
> +               hex2bin(str, btd_opts.csis_defaults.sirk_val,
> +                       sizeof(btd_opts.csis_defaults.sirk_val));
> +
> +               g_free(str);
> +       }
> +
> +       val = g_key_file_get_integer(config, "CSIP", "CsisSize", &err);
> +       if (err) {
> +               DBG("%s", err->message);
> +               g_clear_error(&err);
> +       } else {
> +               val = MIN(val, 0xFF);
> +               val = MAX(val, 0);
> +               DBG("Csis Size: %u", val);
> +               btd_opts.csis_defaults.cs_size = val;
> +       }
> +
> +       val = g_key_file_get_integer(config, "CSIP", "CsisRank", &err);
> +       if (err) {
> +               DBG("%s", err->message);
> +               g_clear_error(&err);
> +       } else {
> +               val = MIN(val, 0xFF);
> +               val = MAX(val, 0);
> +               DBG("Csis Rank: %u", val);
> +               btd_opts.csis_defaults.cs_rank = val;
> +       }
> +
>         str = g_key_file_get_string(config, "AVDTP", "SessionMode", &err);
>         if (err) {
>                 DBG("%s", err->message);
> @@ -1014,6 +1121,12 @@ static void init_defaults(void)
>         btd_opts.defaults.br.scan_type = 0xFFFF;
>         btd_opts.defaults.le.enable_advmon_interleave_scan = 0xFF;
>
> +       btd_opts.csis_defaults.sirk_type = 1;
> +       hex2bin(DEFAULT_SIRK, btd_opts.csis_defaults.sirk_val,
> +                       sizeof(btd_opts.csis_defaults.sirk_val));
> +       btd_opts.csis_defaults.cs_size = 1;
> +       btd_opts.csis_defaults.cs_rank = 1;
> +
>         if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
>                 return;
>
> diff --git a/src/main.conf b/src/main.conf
> index f187c9aaa482..5378472ef0d4 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -258,6 +258,30 @@
>  # Default to 3
>  #Channels = 3
>
> +[CSIP]

Let's use Set as a group name.

> +# CSIP - Co-ordinated Set Identification Profile
> +# SIRK Types which determines the value type for CsisSirkValue
> +# Possible values:
> +# 1 - Plain text
> +# 2 - encrypted
> +#CsisSirkType = 1

Let's not use the type directly here so perhaps something like
KeyType=plaintext,encrypted, etc, and it is important to say what is
the default value.

> +
> +# CSIP - Co-ordinated Set Identification Profile
> +# SIRK - Set Identification resolution key which is common for all the
> +# sets. They SIRK key is used to identify its sets. This can be any
> +# 128 bit value.
> +# Possible Values:
> +# 16 byte hexadecimal value
> +#CsisSirkValue = 861FAE703ED681F0C50B34155B6434FB

Let's use Key instead, since this would belong to [Set] group that is
enough to disambiguate.

> +
> +#CSIP - Size
> +#Total no of sets belongs to this Profile
> +#CsisSize = 1

Size

> +#CSIP - Rank
> +#Rank for the device
> +#CsisRank = 1

Rank

>  [AVDTP]
>  # AVDTP L2CAP Signalling Channel Mode.
>  # Possible values:
> --
> 2.25.1
>


--
Luiz Augusto von Dentz
