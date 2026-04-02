Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BE5339870
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143995; cv=pass; b=Odbbo+uTBZmIPL+ZgF/oOqzQNAAVwGHBt4FHZh1tBD9jB7IQzKMpjks0lLVjprFkJr3C1Z3tiuWVzmz1tTYAWOpfrKxfqoSOfEicJmot1dAlfRG3N/lApuE1QVo1YwkLrlWwqs5QGYvtlXcDudo/LV/6ieNLWGPqCjITX87XBpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143995; c=relaxed/simple;
	bh=YqtAAGIEsssmwLp7C8wn71w8U/GxGD7b7INHpfD5OHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUa5k2X7Gz34BeoHsCEOHbqhGBEEz1XC/dPM0WeiMzc9dUjcYMQLenW+Inq7Dp0zT6S7lek6YqIIv/RTMZFsAPNGpa3aLc6DBr7uTh1iBZkPpLG7Ct40bkNTnLeItrBni43mkAkmgqper7VnwatH/fGsVjp9LPo/O06N7L4UIHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McXEmFBe; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McXEmFBe"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6500040f128so968276d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 08:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775143993; cv=none;
        d=google.com; s=arc-20240605;
        b=YM4rZoP1ZEg7YJpkoz8Ma/+EJ6rk058ZxkHM8k8T6Ps7gxUxAvBTnzWOHPmQK8ok11
         +vU3TvRVXlqeOJT5MaUH8zAXFYEDJnOHa7bpFKaXBobO1zgHpTJGgOuyIoRLZTB0kaRO
         SM54evUz4JewUPD495KACFceIBjRep06bcEPOiF/KJQU5fBpcX7gk8D9IgwPudCj+Ckh
         tC3gr9Yqp8kTaDpLR2W+k4LmpaGrxBkIBPPkL/4V0ncI+2CBFaXhCa+M5vWho1y9xWGE
         ujcBcR3PFpPRPESVnPOE+dqkwjanDEhpjEo0rRymg080MTPbfwduLcwuajw7QMT/rBGk
         LlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6inW2ZePR1MLa/hz3I1WoX3Yn7rZzVPK8ozzCEJSPkA=;
        fh=8vmOwSm9QheBlSAtzpU2h+vPN6vqZAy+khabkFtSFIk=;
        b=ZHFCpdf4vSQF1OcTSe3KL+77zoXquutrPCoeTWtsipgDaVCBvi1JCGVvMEG4zErPmn
         MujSBuQNexwj/aKAkf2XOcNBCELIx1d5oGmv1prWtauLDRXrGREuKyTMGWJDmgbb8/eM
         n3mgZhRgKPipZBVhAaEzsIQ7MVmTTbGPnVRWYkwFQ4aSsXOez5IugEMZ1qb8q+/AuZDO
         34o1KzJROSWr1GfrfOlVG/BzjfamT6WHXVqHynYKQoD3ad+ta43csGUOBg4Nic6PEL+L
         TIJN6I24ei6/ZjJAwuU26NttlDEjdekdNIOYekOMW9Zt50wAT06GVzvEU2w7NR8xkxEY
         xJZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775143993; x=1775748793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6inW2ZePR1MLa/hz3I1WoX3Yn7rZzVPK8ozzCEJSPkA=;
        b=McXEmFBeNrQXu9v/C7Q0gKelyQ6XOcZIcdiVu8N8NzGiyt9sLdZxzIBip2IucAYotN
         791gGluriqNAFfKjKYdHY0kNHwENUrVqKsU7JPXnaMHmMH1KhI62GVM9RvhlisTxlsuh
         HzeME90MBqycqqmHsp2tGOQfFtc1uYJOWMrHjmh6IKVIqVVVprw9lOX99e/W9HuAW7Kr
         jr4kkYYddvZ/6U53VAqj+xRxXv1FSEuOkiSXXXX2ijb1vzK7pRRbvfIf8mQZcVRxjH8R
         a0A5ANF98tfqlsY+eCufXqB5YRxhGfJy72nfbfOQWAvGxnEjaJIOJIi28sTf+Y/RuPoF
         xTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775143993; x=1775748793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6inW2ZePR1MLa/hz3I1WoX3Yn7rZzVPK8ozzCEJSPkA=;
        b=bX0AC2f3YUBaSnWba0bFd35IHhtmRgc6+7ZICfRLu7kgajqFkgFSXHjjuOKMq3QLyD
         +0joCe/q2tM9ShNXhfG3xN0zXxZNyZ0235hy5s5aMuqtdV658HpXZ/8V8hwxT1s//3tO
         6Y/y1uIV58F7A82w1S1uUHW3flM7GIuXtwyNAP7pxsRcFtAeU5pjPxCftiw49mFGRdRY
         bGrf2szsi0If3DaKJPJXCdv6uMSoa2AswQmR+z+ZqIjThbpN98shQt4cI9VvsKbDp+F2
         2vNS6lzJ4M5EyhybYUMCfpjZTlK4zRzXe5piytucMGkyxV3GpIqj4gdByo9Hz4xdw73s
         ZweQ==
X-Gm-Message-State: AOJu0Yy/R5NKPJe/ZrYpLgNh5Ab6eNDG8urh7GUVCFBWK0v4CwQlmhTd
	n1wOYKK6C1xmoXAgp9BVJG2LQjTCHV69f5+hMn/pbJMSD1mItejJAIV12qXPXHYyVX3I1k+lvIr
	s77wZO8aTmzD0ChXnQ0L7CsnDhFOlt7o=
X-Gm-Gg: AeBDieuYmWAZtx23Zbc4v2PqLhpI+C5aNSyD9OOlAtJQ00F3SXuT5Cnv8iLhH8ZtjgQ
	OLyyY7eztvDwewnVaLLWCipvgAsxNKvvTevGdntNd2m4LmGF9Fk/8mw5THikDlVvUfIuQ4/Rufj
	GOFZLqiMCHseT4vMr8WQ5Uh71JM/n9i+4KT4PI8NaMdkAV8zcAva7HMxPbWxXXQdhHJVXJ82nbp
	EkfjeOppeyNJ4f5HCFH6N4+LNw9VONlNJjxtP2bjtrJ3QIJ29e29phMEa3YhfImzI5z8z7R9zOi
	mWjdMlfIipfrqolva+67FUZAk/Ob5Rqg4m2wnPVCNf7FhGTPlpYEbt5eYnKAnUc/5IwRdsLLHAQ
	LyhMl
X-Received: by 2002:a05:690e:4805:b0:650:136e:4248 with SMTP id
 956f58d0204a3-6502fd8a8f1mr6179830d50.4.1775143992685; Thu, 02 Apr 2026
 08:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402103900.310778-1-naga.akella@oss.qualcomm.com> <20260402103900.310778-3-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260402103900.310778-3-naga.akella@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 2 Apr 2026 11:33:01 -0400
X-Gm-Features: AQROBzAIrpqyleKkyVEoOhoVrdr9ekEDdQwn4OQgRvE50EjspciH02P0e5xKfys
Message-ID: <CABBYNZK04Bvx=+RZZx5UrkSrY9HQK_2ZMBkyd5BDD+=ER9MzsQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 2/3] bluetooth: Add Channel Sounding config
 parsing support
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	prathibha.madugonde@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naga,

On Thu, Apr 2, 2026 at 6:39=E2=80=AFAM Naga Bhavani Akella
<naga.akella@oss.qualcomm.com> wrote:
>
> Add support for parsing Channel Sounding (CS) configuration options
> from the configuration file.
>
> Add CAP_NET_RAW to CapabilityBoundingSet in bluetooth.service.
> bluetoothd requires CAP_NET_RAW to receive and process HCI LE events
> when running under a constrained systemd capability bounding set
> ---
>  src/bluetooth.service.in |   2 +-
>  src/btd.h                |   7 +++
>  src/main.c               | 129 +++++++++++++++++++++++++++++++++++++++
>  src/main.conf            |  24 ++++++++
>  4 files changed, 161 insertions(+), 1 deletion(-)
>
> diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
> index 8ebe89bec..8dcbde236 100644
> --- a/src/bluetooth.service.in
> +++ b/src/bluetooth.service.in
> @@ -10,7 +10,7 @@ ExecStart=3D@PKGLIBEXECDIR@/bluetoothd
>  NotifyAccess=3Dmain
>  #WatchdogSec=3D10
>  #Restart=3Don-failure
> -CapabilityBoundingSet=3DCAP_NET_ADMIN CAP_NET_BIND_SERVICE
> +CapabilityBoundingSet=3DCAP_NET_RAW CAP_NET_ADMIN CAP_NET_BIND_SERVICE
>  LimitNPROC=3D1
>
>  # Filesystem lockdown
> diff --git a/src/btd.h b/src/btd.h
> index 1b521706d..0ec08d622 100644
> --- a/src/btd.h
> +++ b/src/btd.h
> @@ -94,11 +94,18 @@ struct btd_le_defaults {
>         uint8_t         enable_advmon_interleave_scan;
>  };
>
> +struct btd_le_bcs {
> +       uint8_t role;
> +       uint8_t cs_sync_ant_sel;
> +       int8_t max_tx_power;
> +};
> +
>  struct btd_defaults {
>         uint16_t        num_entries;
>
>         struct btd_br_defaults br;
>         struct btd_le_defaults le;
> +       struct btd_le_bcs bcs;
>  };
>
>  struct btd_csis {
> diff --git a/src/main.c b/src/main.c
> index 59df0ad4c..92734edd3 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -155,6 +155,13 @@ static const char *gatt_options[] =3D {
>         NULL
>  };
>
> +static const char *bcs_options[] =3D {
> +       "Role",
> +       "CcSyncAntennaSel",
> +       "MaxTxPower",
> +       NULL
> +};
> +
>  static const char *csip_options[] =3D {
>         "SIRK",
>         "Encryption",
> @@ -192,6 +199,7 @@ static const struct group_table {
>         { "CSIS",       csip_options },
>         { "AVDTP",      avdtp_options },
>         { "AVRCP",      avrcp_options },
> +       { "ChannelSounding",    bcs_options },
>         { "AdvMon",     advmon_options },
>         { }
>  };
> @@ -491,6 +499,46 @@ static bool parse_config_int(GKeyFile *config, const=
 char *group,
>         return true;
>  }
>
> +static bool parse_config_signed_int(GKeyFile *config, const char *group,
> +                                       const char *key, int8_t *val,
> +                                       size_t min, size_t max)
> +{
> +       char *str =3D NULL;
> +       char *endptr =3D NULL;
> +       long tmp;
> +       bool result =3D false;
> +
> +       str =3D g_key_file_get_string(config, group, key, NULL);
> +       if (!str)
> +               return false;
> +
> +       tmp =3D strtol(str, &endptr, 0);
> +       if (!endptr || *endptr !=3D '\0') {
> +               warn("%s.%s =3D %s is not integer", group, key, str);
> +               goto cleanup;
> +       }
> +
> +       if (tmp < (long)min) {
> +               warn("%s.%s =3D %ld is out of range (< %zu)", group, key,=
 tmp,
> +                       min);
> +               goto cleanup;
> +       }
> +
> +       if (tmp > (long)max) {
> +               warn("%s.%s =3D %ld is out of range (> %zu)", group, key,=
 tmp,
> +                                                                       m=
ax);
> +               goto cleanup;
> +       }
> +
> +       if (val)
> +               *val =3D (int8_t)tmp;
> +       result =3D true;
> +
> +cleanup:
> +       g_free(str);
> +       return result;
> +}
> +
>  struct config_param {
>         const char * const val_name;
>         void * const val;
> @@ -1150,6 +1198,82 @@ static void parse_csis(GKeyFile *config)
>                                         0, UINT8_MAX);
>  }
>
> +static bool parse_cs_role(GKeyFile *config, const char *group,
> +                                       const char *key, uint8_t *val)
> +{
> +       GError *err =3D NULL;
> +       char *str =3D NULL;
> +       int numeric_val;
> +
> +       /* Try to read as string first */
> +       str =3D g_key_file_get_string(config, group, key, &err);
> +       if (err) {
> +               if (err->code !=3D G_KEY_FILE_ERROR_KEY_NOT_FOUND)
> +                       DBG("%s", err->message);
> +               g_error_free(err);
> +               return false;
> +       }
> +
> +       DBG("%s.%s =3D %s", group, key, str);
> +
> +       /* Check if it's a string value */
> +       if (!strcmp(str, "Initiator") || !strcmp(str, "initiator")) {
> +               if (val)
> +                       *val =3D 1;
> +               g_free(str);
> +               return true;
> +       } else if (!strcmp(str, "Reflector") || !strcmp(str, "reflector")=
) {
> +               if (val)
> +                       *val =3D 2;
> +               g_free(str);
> +               return true;
> +       } else if (!strcmp(str, "Both") || !strcmp(str, "both")) {
> +               if (val)
> +                       *val =3D 3;
> +               g_free(str);
> +               return true;
> +       }
> +
> +       /* Try to parse as numeric value */
> +       char *endptr =3D NULL;
> +
> +       numeric_val =3D strtol(str, &endptr, 0);
> +
> +       if (!endptr || *endptr !=3D '\0') {
> +               error("%s.%s =3D %s is not a valid value. "
> +                       "Expected: 1/Initiator, 2/Reflector, or 3/Both",
> +                       group, key, str);
> +               g_free(str);
> +               return false;
> +       }
> +
> +       if (numeric_val < 1 || numeric_val > 3) {
> +               warn("%s.%s =3D %d is out of range. "
> +                       "Valid values: 1 (Initiator), 2 (Reflector), 3 (B=
oth)",
> +                       group, key, numeric_val);
> +               g_free(str);
> +               return false;
> +       }
> +
> +       if (val)
> +               *val =3D numeric_val;
> +
> +       g_free(str);
> +       return true;
> +}
> +
> +static void parse_le_cs_config(GKeyFile *config)
> +{
> +       parse_cs_role(config, "ChannelSounding", "Role",
> +                       &btd_opts.defaults.bcs.role);
> +       parse_config_u8(config, "ChannelSounding", "CcSyncAntennaSel",
> +                       &btd_opts.defaults.bcs.cs_sync_ant_sel,
> +                       0x01, 0xFF);
> +       parse_config_signed_int(config, "ChannelSounding",
> +                       "MaxTxPower", &btd_opts.defaults.bcs.max_tx_power=
,
> +                       INT8_MIN, INT8_MAX);
> +}
> +
>  static void parse_avdtp_session_mode(GKeyFile *config)
>  {
>         char *str =3D NULL;
> @@ -1228,6 +1352,7 @@ static void parse_config(GKeyFile *config)
>         parse_csis(config);
>         parse_avdtp(config);
>         parse_avrcp(config);
> +       parse_le_cs_config(config);
>         parse_advmon(config);
>  }
>
> @@ -1278,6 +1403,10 @@ static void init_defaults(void)
>
>         btd_opts.advmon.rssi_sampling_period =3D 0xFF;
>         btd_opts.csis.encrypt =3D true;
> +
> +       btd_opts.defaults.bcs.role =3D 0x03;
> +       btd_opts.defaults.bcs.cs_sync_ant_sel =3D 0xFF;
> +       btd_opts.defaults.bcs.max_tx_power =3D 0x14;
>  }
>
>  static void log_handler(const gchar *log_domain, GLogLevelFlags log_leve=
l,
> diff --git a/src/main.conf b/src/main.conf
> index 724c4b44f..84fd28f5b 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -291,6 +291,30 @@
>  # Default: read-only
>  #ExportClaimedServices =3D read-only
>
> +[ChannelSounding]
> +# Current role of the device
> +# Possible values:
> +#   1 or "Initiator" - CS Initiator role,
> +#   Generally, CS Initiator acts as Client (Gatt role) and Central (Gap =
role)
> +#   2 or "Reflector" - CS Reflector role,
> +#   Generally, CS Reflector acts as Server (Gatt role) and Peripheral (G=
ap role)
> +#   3 or "Both"      - Both Initiator and Reflector roles
> +# Default: 3 (Both)
> +#Role =3D 3
> +
> +# Antenna Identifier to be used
> +# Possible values:
> +# 0x01-0x04 (antenna identifier to be used),
> +# 0xFE - Antennas to be used in repetetive order,
> +# 0xFF - Host doen't have recommendation
> +# Default: 0xFF (Host doesn't have recommendation)
> +#CcSyncAntennaSel =3D 0xFF
> +
> +# Maximum Transmit power
> +# Possible values: 0x7F-0x14 (-127dBm to 20dBm)
> +# Default: 0x14 (Max Power possible)
> +#MaxTxPower =3D 0x14

Don't we need the last 2 to be configurable at runtime? Don't those
end up influencing results, etc, and therefore need tuning depending
on the use case?

>  [CSIS]
>  # SIRK - Set Identification Resolution Key which is common for all the
>  # sets. They SIRK key is used to identify its sets. This can be any
> --
>


--=20
Luiz Augusto von Dentz
