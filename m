Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6991263AC
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 03:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706154883; cv=none; b=f3vUt6xyH4J51bsKPI0jd61RD8Lhz6CfUt1L9rwU+5qlwKHcXli4mHKrnaXOX6w1qoO44uRw50WiyQ47u8ggWGaKmbwdCFHkMEQjN5oNS1N+UO/nW0JOnOquRdpHZifVdC5lQ7W/Bv81YuurqxcXofirZB8w4ctBpRqjNvFLg2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706154883; c=relaxed/simple;
	bh=aTMnbDS7IHKGqAV3qmrjvlYHkcAgmLzCt9Sgys1F1vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdkrofUhp7blSWhgaeyNTnKo4lVK5kyyxJfmfp0AFCMpC5r2EETR0khh0XXfIoVOozYcb643Pq9LeJ6QiLRVwNJ6Y7GOBR+R5zCb2fXT89WVr19CYxHcwB8az9eq99/H4avQz5Y7ihY93k3+3nY6ejN2mtbg8LV7AQZqU4QqQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHp/9Ryu; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHp/9Ryu"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cd0d05838fso74484801fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 19:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706154879; x=1706759679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsrH2o+uwKRCORXMm4hN4Itlr7GIZORC8ukVW7PawWM=;
        b=ZHp/9Ryu7NcsNJJesPs8lMDu5gri+aVz8pH7uXv026DPrvEPfFkhWCZVxGmuxm0KRt
         V7i2jJQtVn6P2vrtbkDH23k2Mf1XcIL3caWJledGd5fS7AFxLRw9X+CcQn/f7D8n7UKo
         qUfKlnuvOtGRLtpIl77Hx7asNaN1jofGa9UNbHM5sHpXA4yoJOsNIrwPvsyb3FQRFSRe
         kJ8CKOTPDri3t4LRPiHds+qmCwyUHAVuewU4VA3W+rcCCW7UED+X3l2+WyBLrZWwKm0+
         GCP5T58Rk2Wnos/oNdv4oj6CRue7L5/9M7ubaz0chswZc5oPUFUBiq5w2FKYfShWjflv
         iH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706154879; x=1706759679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsrH2o+uwKRCORXMm4hN4Itlr7GIZORC8ukVW7PawWM=;
        b=a8cee0RwNE+ttyIfpSpiqEiBlRCPis3rnDX1llp7urRuzOU+zhCWR820IGvFLG38nE
         BLHC1DJIQF0dEZQeF22IHlujbXEEMlTXSWzjj8H0zwWGg8sl7YiR9jYIGc7rtQxm+ANr
         DwvN/A+PcvjeR71BfRDuUM4jop3C9UOP0wYPmNWCXxw17Xq934Uh8OljfsYO8Ie46EBS
         rpw8+mK5qHUpFkBmBMB48zxH6ojQ4NOdsP24NIjo1/NTluYGsaiGvCAIHyg3Nv+q6Zvu
         DoVUJDKPZt+T7dyQva/TU/r1IfxDp0G+T3I2xaVhYc3iMBLOb+88ps1VDJYfNWk/owdc
         A0mQ==
X-Gm-Message-State: AOJu0YxUShf9Z4F7Zga6AuwWLj1GI622UDaACnG/rIlLNVLB4qDHS3v+
	LwYWHES/2R1ZdK+GSyJl4aor8Z/31+VU9NwOcUhE05/yIAK7wtkIg+SAUXIzKeWry8WHItlsAyR
	V7SYLUGqzsLEWfB4ueL1WHJ4uraH9fQJD
X-Google-Smtp-Source: AGHT+IEz99aC8TyWLHUcLYOhLCl/7TI8ANi5wUlb7BOqvyezrm2sQSW2Px3gPmlmC+HsHTC3Qjk+Q0OytrgTJlnFun0=
X-Received: by 2002:a2e:a265:0:b0:2cd:fa64:9616 with SMTP id
 k5-20020a2ea265000000b002cdfa649616mr141542ljm.18.1706154879037; Wed, 24 Jan
 2024 19:54:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-disto-patches-v1-0-97e0eb5625a3@gmail.com> <20240124-disto-patches-v1-1-97e0eb5625a3@gmail.com>
In-Reply-To: <20240124-disto-patches-v1-1-97e0eb5625a3@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 24 Jan 2024 22:54:26 -0500
Message-ID: <CABBYNZLibBw-_SJ4wpzF-r5cDPSds99kShO9C3v2FVNJ2Um9vg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/9] Enable alternate Bluetooth connection modes
To: emil.l.velikov@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Vicki Pfau <vi@endrift.com>, 
	Rachel Blackman <rachel.blackman@synapse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emil,

On Wed, Jan 24, 2024 at 6:46=E2=80=AFPM Emil Velikov via B4 Relay
<devnull+emil.l.velikov.gmail.com@kernel.org> wrote:
>
> From: Vicki Pfau <vi@endrift.com>
>
> This patch improves Bluetooth connectivity, especially with multiple
> controllers and while docked.
>
> Testing:
> $ btmgmt
> [mgmt]# phy
>
> Verify the SupportedPHYs in main.conf are listed.
> Verify that multiple controllers can connect and work well.
>
> Co-Authored-By: Rachel Blackman <rachel.blackman@synapse.com>
>
> [Emil Velikov]
> Remove unused function, add default entries into parser, keep only
> default entries in main.conf - commented out, like the other options.
> ---
>  src/adapter.c | 46 +++++++++++++++++++++++++++++++++++++++++
>  src/btd.h     |  2 ++
>  src/main.c    | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/main.conf |  5 +++++
>  4 files changed, 119 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 022390f0d..4c6b8f40f 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -86,6 +86,18 @@
>  #define DISTANCE_VAL_INVALID   0x7FFF
>  #define PATHLOSS_MAX           137
>
> +#define LE_PHY_1M 0x01
> +#define LE_PHY_2M 0x02
> +#define LE_PHY_CODED 0x04
> +
> +#define PHYVAL_REQUIRED 0x07ff
> +#define PHYVAL_1M_TX (1<<9)
> +#define PHYVAL_1M_RX (1<<10)
> +#define PHYVAL_2M_TX (1<<11)
> +#define PHYVAL_2M_RX (1<<12)
> +#define PHYVAL_CODED_TX (1<<13)
> +#define PHYVAL_CODED_RX (1<<14)
> +
>  /*
>   * These are known security keys that have been compromised.
>   * If this grows or there are needs to be platform specific, it is
> @@ -847,6 +859,36 @@ static bool set_discoverable(struct btd_adapter *ada=
pter, uint8_t mode,
>         return false;
>  }
>
> +static void set_phy_support_complete(uint8_t status, uint16_t length,
> +                                       const void *param, void *user_dat=
a)
> +{
> +       if (status !=3D 0) {
> +               struct btd_adapter *adapter =3D (struct btd_adapter *)use=
r_data;
> +
> +               btd_error(adapter->dev_id, "PHY setting rejected for %u: =
%s",
> +                                                               adapter->=
dev_id, mgmt_errstr(status));
> +       }
> +}
> +
> +static bool set_phy_support(struct btd_adapter *adapter, uint32_t phy_ma=
sk)
> +{
> +       struct mgmt_cp_set_phy_confguration cp;
> +
> +       memset(&cp, 0, sizeof(cp));
> +       cp.selected_phys =3D cpu_to_le32(phy_mask | PHYVAL_REQUIRED);
> +
> +       if (mgmt_send(adapter->mgmt, MGMT_OP_SET_PHY_CONFIGURATION,
> +                               adapter->dev_id, sizeof(cp), &cp,
> +                               set_phy_support_complete, (void*)adapter,=
 NULL) > 0)
> +               return true;
> +
> +       btd_error(adapter->dev_id, "Failed to set PHY for index %u",
> +                                                       adapter->dev_id);
> +
> +       return false;
> +
> +}
> +
>  static bool pairable_timeout_handler(gpointer user_data)
>  {
>         struct btd_adapter *adapter =3D user_data;
> @@ -10458,6 +10500,10 @@ static void read_info_complete(uint8_t status, u=
int16_t length,
>         if (btd_adapter_get_powered(adapter))
>                 adapter_start(adapter);
>
> +       // Some adapters do not want to accept this before being started/=
powered.
> +       if (btd_opts.phys > 0)
> +               set_phy_support(adapter, btd_opts.phys);
> +
>         return;
>
>  failed:
> diff --git a/src/btd.h b/src/btd.h
> index b7e7ebd61..2b84f7a51 100644
> --- a/src/btd.h
> +++ b/src/btd.h
> @@ -151,6 +151,8 @@ struct btd_opts {
>         struct btd_advmon_opts  advmon;
>
>         struct btd_csis csis;
> +
> +       uint32_t        phys;
>  };
>
>  extern struct btd_opts btd_opts;
> diff --git a/src/main.c b/src/main.c
> index b1339c230..faedb853c 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -128,6 +128,7 @@ static const char *le_options[] =3D {
>         "AdvMonAllowlistScanDuration",
>         "AdvMonNoFilterScanDuration",
>         "EnableAdvMonInterleaveScan",
> +       "SupportedPHYs",
>         NULL
>  };
>
> @@ -182,10 +183,32 @@ static const struct group_table {
>         { }
>  };
>
> +static const char *conf_phys_str[] =3D {
> +       "BR1M1SLOT",
> +       "BR1M3SLOT",
> +       "BR1M5SLOT",
> +       "EDR2M1SLOT",
> +       "EDR2M3SLOT",
> +       "EDR2M5SLOT",
> +       "EDR3M1SLOT",
> +       "EDR3M3SLOT",
> +       "EDR3M5SLOT",
> +       "LE1MTX",
> +       "LE1MRX",
> +       "LE2MTX",
> +       "LE2MRX",
> +       "LECODEDTX",
> +       "LECODEDRX",
> +};
> +
>  #ifndef MIN
>  #define MIN(x, y) ((x) < (y) ? (x) : (y))
>  #endif
>
> +#ifndef NELEM
> +#define NELEM(x) (sizeof(x) / sizeof((x)[0]))
> +#endif
> +
>  static int8_t check_sirk_alpha_numeric(char *str)
>  {
>         int8_t val =3D 0;
> @@ -226,6 +249,36 @@ static size_t hex2bin(const char *hexstr, uint8_t *b=
uf, size_t buflen)
>         return len;
>  }
>
> +static bool str2phy(const char *phy_str, uint32_t *phy_val)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < NELEM(conf_phys_str); i++) {
> +               if (strcasecmp(conf_phys_str[i], phy_str) =3D=3D 0) {
> +                       *phy_val =3D (1 << i);
> +                       return true;
> +               }
> +       }
> +
> +       return false;
> +}
> +
> +static void btd_parse_phy_list(char **list)
> +{
> +       uint32_t phys =3D 0;
> +
> +       for (int i =3D 0; list[i]; i++) {
> +               uint32_t phy_val;
> +
> +               info("Enabling PHY option: %s", list[i]);
> +
> +               if (str2phy(list[i], &phy_val))
> +                       phys |=3D phy_val;
> +       }
> +
> +       btd_opts.phys =3D phys;
> +}
> +
>  GKeyFile *btd_get_main_conf(void)
>  {
>         return main_conf;
> @@ -673,11 +726,24 @@ static void parse_le_config(GKeyFile *config)
>                   0,
>                   1},
>         };
> +       char **strlist;
> +       GError *err =3D NULL;
>
>         if (btd_opts.mode =3D=3D BT_MODE_BREDR)
>                 return;
>
>         parse_mode_config(config, "LE", params, ARRAY_SIZE(params));
> +
> +       strlist =3D g_key_file_get_string_list(config, "LE", "SupportedPH=
Ys",
> +                                               NULL, &err);
> +       if (err) {
> +               g_clear_error(&err);
> +               strlist =3D g_new0(char *, 3);
> +               strlist[0] =3D g_strdup("LE1MTX");
> +               strlist[1] =3D g_strdup("LE1MRX");
> +       }
> +       btd_parse_phy_list(strlist);
> +       g_strfreev(strlist);
>  }
>
>  static bool match_experimental(const void *data, const void *match_data)
> diff --git a/src/main.conf b/src/main.conf
> index 085c81a46..59d31e494 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -231,6 +231,11 @@
>  # Defaults to 1
>  #EnableAdvMonInterleaveScan=3D
>
> +# Which Bluetooth LE PHYs should be enabled/supported?
> +# Options are LE1MTX LE1MRX LE2MTX LE2MRX LECODEDTX LECODEDRX
> +# Defaults to LE1MTX,LE1MRX
> +#SupportedPHYs=3DLE1MTX,LE1MRX

I'm sort of surprised by this, we do only use the PHYs listed as
supported by the controller, so is there a bug or is this really a way
to disable PHYs that the controllers report as supported but in
reality don't really work properly? In case of the latter I think we
would be better off having a quirk added in the kernel so it can be
marked to the controllers we know misbehaves rather than limiting all
controllers to 1M PHY by default.

>  [GATT]
>  # GATT attribute cache.
>  # Possible values:
>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
