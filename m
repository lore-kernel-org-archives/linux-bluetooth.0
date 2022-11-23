Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C67C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Nov 2022 00:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbiKWAII (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 19:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiKWAID (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 19:08:03 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2251B4BA
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 16:08:01 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id h12so19676915ljg.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 16:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bhfnrrtu3v37RX3Xv92faYzhU6WWCi7pTyezw6yjfos=;
        b=no/9/CzwzhNOgR+T1m5VQ8DlZPiUeVia0x9fmitpAys6SEaSQXGxk70SvaAdjVW51Y
         2TShDgNPj/oJdXeU9yPvDyIGtWEFk/oJMLOFYaC3YGjquS3CigI+jXwj5jsS6L0VC4kd
         brRK9Sz2c98Ney15zJhh4XcY5hfLrB8iSw4oBkVhu03nXrFUAYSuhTqp2wvV+4ZWl0yc
         ZFgltmd+01Ck88lPTBfVQBmMQ7qCRVvPzKq3MLVxSA0RM7TQXZ+OX3KcOSfo7QECWaln
         A8IuEChEb/+TULGa+4oRPwFkwHzFxtPwpK0qw4P5U5lY5lrI9EXGQ7CaBXTWMmfD9zaK
         AnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhfnrrtu3v37RX3Xv92faYzhU6WWCi7pTyezw6yjfos=;
        b=RE9VwWrVpRD50TtpmevD3tOfOwsS1v9+a+tLHeMRJvusSW7VuW8zJASGDqn5k3q7vG
         CTz8ct9dSGAZELSXT1MsXIm7Qfj8agVEMigE9isS4xkbSLmSfmksncYZ7sniU1h9HUTj
         UGzkyZu0qWAUi5JRRlV2nxbX0h7wzPojJwhX62tZofgC3MiSgZkzJKGptkuhSRs+Z+4S
         BzG1i57uUHeHyNUPK9AereU72XMGBXK8RRjggmvTWoB5Uj/492R4GhybbTpdnBbLOjgT
         w73ZEQ5hpE8F3Wf4XERyhBfI+G9t4PWLCzDVIAkTEu5ocE0/eSETunT5jaebSDtYxSf3
         SJcA==
X-Gm-Message-State: ANoB5pmuChvEGd3CVKsOrPppCjFM9okmyUloE408PP0Tfeut39yMsCyq
        p0MhBdRzvLlUvfGyc333PMJ+Ylt70qHah946jzQunIDP
X-Google-Smtp-Source: AA0mqf5Rmo9JROwnsRobh85AgxjqMfAqpW1N8GNfLUiV7Wq5TodtkIQ9BHjW1ylMDclxQg+AQ6ABzRxET6GL23nv8Gs=
X-Received: by 2002:a05:651c:389:b0:278:f5de:8478 with SMTP id
 e9-20020a05651c038900b00278f5de8478mr4187945ljp.65.1669162079548; Tue, 22 Nov
 2022 16:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20221122101232.45320-1-sathish.narasimman@intel.com>
 <20221122101232.45320-4-sathish.narasimman@intel.com> <CABBYNZKsRV4W63KRrsJ7Ay8Er0NBV1DGEWqtgceoTaaA2VowQA@mail.gmail.com>
In-Reply-To: <CABBYNZKsRV4W63KRrsJ7Ay8Er0NBV1DGEWqtgceoTaaA2VowQA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 22 Nov 2022 16:07:47 -0800
Message-ID: <CABBYNZJ5YqJJ1wu00PCszxPdgSZOvKv1Uy9DKfgDObum+AnKWw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 3/7] main.conf: Add CSIP profile configurable options
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Tue, Nov 22, 2022 at 12:13 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sathish,
>
>
> On Tue, Nov 22, 2022 at 2:17 AM Sathish Narasimman
> <sathish.narasimman@intel.com> wrote:
> >
> > This introduces option to configure main.conf that can be used to
> > configure co-ordinated set identification profile.
> > ---
> >  src/btd.h     |   9 ++++
> >  src/main.c    | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  src/main.conf |  24 +++++++++++
> >  3 files changed, 146 insertions(+)
> >
> > diff --git a/src/btd.h b/src/btd.h
> > index 42cffcde43ca..a3683a098689 100644
> > --- a/src/btd.h
> > +++ b/src/btd.h
> > @@ -92,6 +92,13 @@ struct btd_defaults {
> >         struct btd_le_defaults le;
> >  };
> >
> > +struct btd_csis {
> > +       uint8_t sirk_type;
> > +       uint8_t sirk_val[16];
> > +       uint8_t cs_size;
> > +       uint8_t cs_rank;
> > +};
> > +
> >  struct btd_avdtp_opts {
> >         uint8_t  session_mode;
> >         uint8_t  stream_mode;
> > @@ -142,6 +149,8 @@ struct btd_opts {
> >         enum jw_repairing_t jw_repairing;
> >
> >         struct btd_advmon_opts  advmon;
> > +
> > +       struct btd_csis csis_defaults;
> >  };
> >
> >  extern struct btd_opts btd_opts;
> > diff --git a/src/main.c b/src/main.c
> > index 99d9c508ff91..abb422961f78 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -60,6 +60,9 @@
> >  #define DEFAULT_TEMPORARY_TIMEOUT         30 /* 30 seconds */
> >  #define DEFAULT_NAME_REQUEST_RETRY_DELAY 300 /* 5 minutes */
> >
> > +/*CSIP Profile - Server */
> > +#define DEFAULT_SIRK "761FAE703ED681F0C50B34155B6434FB"
> > +
> >  #define SHUTDOWN_GRACE_SECONDS 10
> >
> >  struct btd_opts btd_opts;
> > @@ -146,6 +149,14 @@ static const char *gatt_options[] = {
> >         NULL
> >  };
> >
> > +static const char *csip_options[] = {
> > +       "CsisSirkType",
> > +       "CsisSirkValue",
> > +       "CsisSize",
> > +       "CsisRank",
> > +       NULL
> > +};
> > +
> >  static const char *avdtp_options[] = {
> >         "SessionMode",
> >         "StreamMode",
> > @@ -166,11 +177,55 @@ static const struct group_table {
> >         { "LE",         le_options },
> >         { "Policy",     policy_options },
> >         { "GATT",       gatt_options },
> > +       { "CSIP",       csip_options },
> >         { "AVDTP",      avdtp_options },
> >         { "AdvMon",     advmon_options },
> >         { }
> >  };
> >
> > +#ifndef MIN
> > +#define MIN(x, y) ((x) < (y) ? (x) : (y))
> > +#endif
> > +
> > +static int8_t check_sirk_alpha_numeric(char *str)
> > +{
> > +       int8_t val = 0;
> > +       char *s = str;
> > +
> > +       if (strlen(s) != 32) /* 32 Bytes of Alpha numeric string */
> > +               return 0;
> > +
> > +       for ( ; *s; s++) {
> > +               if (((*s >= '0') & (*s <= '9'))
> > +                       || ((*s >= 'a') && (*s <= 'z'))
> > +                       || ((*s >= 'A') && (*s <= 'Z'))) {
> > +                       val = 1;
> > +               } else {
> > +                       val = 0;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       return val;
> > +}
> > +
> > +static size_t hex2bin(const char *hexstr, uint8_t *buf, size_t buflen)
> > +{
> > +       size_t i, len;
> > +
> > +       if (!hexstr)
> > +               return 0;
> > +
> > +       len = MIN((strlen(hexstr) / 2), buflen);
> > +       memset(buf, 0, len);
> > +
> > +       for (i = 0; i < len; i++) {
> > +               if (sscanf(hexstr + (i * 2), "%02hhX", &buf[i]) != 1)
> > +                       continue;
> > +       }
> > +
> > +       return len;
> > +}
> >
> >  GKeyFile *btd_get_main_conf(void)
> >  {
> > @@ -939,6 +994,58 @@ static void parse_config(GKeyFile *config)
> >                 btd_opts.gatt_channels = val;
> >         }
> >
> > +       val = g_key_file_get_integer(config, "CSIP", "CsisSirkType", &err);
> > +       if (err) {
> > +               DBG("%s", err->message);
> > +               g_clear_error(&err);
> > +       } else {
> > +               val = MIN(val, 2);
> > +               val = MAX(val, 1);
> > +               DBG("Csis Type: %u", val);
> > +               btd_opts.csis_defaults.cs_size = val;
> > +       }
> > +
> > +       str = g_key_file_get_string(config, "CSIP", "CsisSirkValue", &err);
> > +       if (err) {
> > +               DBG("%s", err->message);
> > +               g_clear_error(&err);
> > +       } else {
> > +               DBG("Csis Sirk: %s", str);
> > +
> > +               if (!check_sirk_alpha_numeric(str)) {
> > +                       DBG("SIRK is not apha numeric Value");
> > +                       return;
> > +               }
> > +
> > +               btd_opts.csis_defaults.sirk_type = 1; /* Plain Text - Type*/
> > +               hex2bin(str, btd_opts.csis_defaults.sirk_val,
> > +                       sizeof(btd_opts.csis_defaults.sirk_val));
> > +
> > +               g_free(str);
> > +       }
> > +
> > +       val = g_key_file_get_integer(config, "CSIP", "CsisSize", &err);
> > +       if (err) {
> > +               DBG("%s", err->message);
> > +               g_clear_error(&err);
> > +       } else {
> > +               val = MIN(val, 0xFF);
> > +               val = MAX(val, 0);
> > +               DBG("Csis Size: %u", val);
> > +               btd_opts.csis_defaults.cs_size = val;
> > +       }
> > +
> > +       val = g_key_file_get_integer(config, "CSIP", "CsisRank", &err);
> > +       if (err) {
> > +               DBG("%s", err->message);
> > +               g_clear_error(&err);
> > +       } else {
> > +               val = MIN(val, 0xFF);
> > +               val = MAX(val, 0);
> > +               DBG("Csis Rank: %u", val);
> > +               btd_opts.csis_defaults.cs_rank = val;
> > +       }
> > +
> >         str = g_key_file_get_string(config, "AVDTP", "SessionMode", &err);
> >         if (err) {
> >                 DBG("%s", err->message);
> > @@ -1014,6 +1121,12 @@ static void init_defaults(void)
> >         btd_opts.defaults.br.scan_type = 0xFFFF;
> >         btd_opts.defaults.le.enable_advmon_interleave_scan = 0xFF;
> >
> > +       btd_opts.csis_defaults.sirk_type = 1;
> > +       hex2bin(DEFAULT_SIRK, btd_opts.csis_defaults.sirk_val,
> > +                       sizeof(btd_opts.csis_defaults.sirk_val));
> > +       btd_opts.csis_defaults.cs_size = 1;
> > +       btd_opts.csis_defaults.cs_rank = 1;
> > +
> >         if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
> >                 return;
> >
> > diff --git a/src/main.conf b/src/main.conf
> > index f187c9aaa482..5378472ef0d4 100644
> > --- a/src/main.conf
> > +++ b/src/main.conf
> > @@ -258,6 +258,30 @@
> >  # Default to 3
> >  #Channels = 3
> >
> > +[CSIP]
>
> Let's use Set as a group name.
>
> > +# CSIP - Co-ordinated Set Identification Profile
> > +# SIRK Types which determines the value type for CsisSirkValue
> > +# Possible values:
> > +# 1 - Plain text
> > +# 2 - encrypted
> > +#CsisSirkType = 1
>
> Let's not use the type directly here so perhaps something like
> KeyType=plaintext,encrypted, etc, and it is important to say what is
> the default value.

Actually this doesn't make much sense, we can't really enter the key
in encrypt format since that has to be encrypted with device's LTK,
perhaps we should just have EncryptKey=y/n.

> > +
> > +# CSIP - Co-ordinated Set Identification Profile
> > +# SIRK - Set Identification resolution key which is common for all the
> > +# sets. They SIRK key is used to identify its sets. This can be any
> > +# 128 bit value.
> > +# Possible Values:
> > +# 16 byte hexadecimal value
> > +#CsisSirkValue = 861FAE703ED681F0C50B34155B6434FB
>
> Let's use Key instead, since this would belong to [Set] group that is
> enough to disambiguate.
>
> > +
> > +#CSIP - Size
> > +#Total no of sets belongs to this Profile
> > +#CsisSize = 1
>
> Size
>
> > +#CSIP - Rank
> > +#Rank for the device
> > +#CsisRank = 1
>
> Rank
>
> >  [AVDTP]
> >  # AVDTP L2CAP Signalling Channel Mode.
> >  # Possible values:
> > --
> > 2.25.1
> >
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
