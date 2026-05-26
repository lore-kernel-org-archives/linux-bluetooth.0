Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D812B94
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821933; cv=pass; b=TgcdrfKJktbv7Fo6wLAVZsIXWrPJdGG5HYkksyQE2BLp57b+gNQzi6K7QkCI6w7UxBI8whBvAJgUCM9K7BsBZelYSmxqvO1voHP0nklqQ3RDb8rOwgIFVMCBv1u6sAmByu/r/hrqjTx9nLq4SckFbXkmS6LjrDWzpoO+C3/Y1JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821933; c=relaxed/simple;
	bh=qPNQadfM0D7kxRso6AWDMPDoJ6GcWvDOpPrlMPIgHK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tH5qa57OCNJjALoq0WPMqjHlhir27YglTj5lkqO4E6a9WiLapfKUNgNnr9rvPne8d+qLEVCFTw5ERu9C0Rtw56X+3WuUZ9YCAFrQQsM47hXcSN1lfWlYUWih4CT7jalCG+MhSsboI42womgWJ0Ab4tiz6uCkNQhMW2XirNOHdgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XohFq5uL; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XohFq5uL"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7cff695e6b1so77968537b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 11:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779821930; cv=none;
        d=google.com; s=arc-20240605;
        b=FDBmJJ/BnEY++KloXJP0fi2v+1BZRJLUCX4hMKAK2yq5FvxM0IEXN0aRVHrZhcpKB8
         ie+NsiNAXAV1Ybojtz1ZylX4UwulcU1I50bdA0hADJUm+zvyVtIytbIjfnFSAuVbia5P
         rb0ntgAP9yJ1N8fKml5ClPnpw4Nh6AMFHw91Ta1JMp9BjuYgFAatKUQvbYPlsfA/Hv8s
         57X+DlMlorRLHt+sYluYWEuW4e49m2Nqdg3epVpJviaPP1kdS3jYyRRbuO2TgDdhCruT
         PNBuLL75w+REEKIuyvndcM60K3P9amYIx/YSlA3rqGnhj2U0BIkZ2+K0w1rC6I774R3I
         rwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cOd35e1KHX7zgHOt2UFpwjLHppJmW2KT8BAf+G9dtVU=;
        fh=v4Z3N2Htbr8NtGqMLkQjkIE/EbeUcf6lhEWEAm07n3g=;
        b=aRtwpq5m9vQ1LFsDpNviGWVnPE8JiuR2LYFKq01fgVDbjiJW4GsEOR9/vYcXcYO3/k
         9kL6NC39zchzQJBrNsJ70qjH5yndIoc8DyxItEnFscUWoy5+9zlH7DXah0n9S7VARQw3
         WpwcCA6yVqnz9MXGRJjI5g13aZN7uXdULM506uILoNXrb5OwL5kgqWm3Dxqt1HauQKFX
         aiSsjoIycISoigPCa0rUxZQStYJbkrY0VY9jU07if1QjSW3bqQ9AwMPY5GHlTF0NW+Lh
         /RiegguHPS+Q26u3Rf4huNTWE+r1vGjESM/WNudq6gzO6Lr2DUCLZEImq1w4yk5mOlZD
         bkSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779821930; x=1780426730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOd35e1KHX7zgHOt2UFpwjLHppJmW2KT8BAf+G9dtVU=;
        b=XohFq5uLLwj2XLqkPqfOQ0fcV/kZRrXtzrihFbINJrgJdzyK2M0dcQfbRn2yFO1Z0X
         br6KxVYAU7CvUwUov66zurMT/V4jM8SukgwQZXDF2NAF/TVQB6Gp5hWA9M0lFgHjV61n
         xEJ9NoDjCwvemT4Y6qFdS2CVVMiYbFfJm9HFXljUgnvA1uAMlDoXt9BhHCLWYTTY/VuN
         diN844tEm0qEcJ8aWNeEYP2AjnkOyLhoNOVJ/H3rFOzziGyoAzPtqUGIIPi7N7nbJEL7
         JMlXRLSR0zkSMEMbCpjEv+WDoUsHWNImY+4eHkO5FcFaLRso3gM9UrL3EenhtzxOt6OV
         Oz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779821930; x=1780426730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cOd35e1KHX7zgHOt2UFpwjLHppJmW2KT8BAf+G9dtVU=;
        b=ULHENoeYCx16T3SlQEsTA2ptdRdKpj/QEaMGKetE1Gow5WeRHHif4xzL/WqJb4dhgP
         okEwgyiYIFUY32zxB2ZOvkKbzfVAEUaVlBWIN4ctYaXIZ+ZQB/6Y329I0u0umpO+GWs+
         m0IPNOK7Od5xu9mwd3bL4lC0G4n7b76SBehyiHrJztPNooS9/e7ok9BSYz+uc5pILhQq
         6gzbgAFslSbE7kTf4TpSG54i6xWEhje4//iev9/t8k20s7Ic7QsV3rOgfukclXEKtCzQ
         NlFyEJ0wDwwC2SybfJp+N9MMOZsQWU+reNvxYIncR2NEBMs3eryR0b1q5RKEb1bUZsPG
         4yGQ==
X-Gm-Message-State: AOJu0YyxQOvlYUmjIdZVCLGTKxEWBevk3ED2aQCoGFy38xYNneeNVnQz
	7ypa3mI3mGPLwqsg+uiQvCkwCXokyGZutVTj7sGIdl6BDG8N2g9A1gi2PYokSxaxIVNalaI1TQW
	1BPpWZcH4N/bhXae6a+yzYs2jEZZ7UR60WgSu+G2c8Q==
X-Gm-Gg: Acq92OEqatpsVwPFgg7jSXdCnmrjZ/yhHnH9R0uON3gFiZeQ/jvFuS8uSgdaVsDCKrO
	PN9o2GhnfAbn4nhVgcNwap8rucU3F6T1/0OqSq13Oep0r4p96JgM49BtOIbyUYa5vTWQj/l4gVv
	Xg08bvqlPL+ldbJ7C5qqc5OqNbG2kHYbO4gYtj5teQFHnZABDyB69gk3Zl5KyOTrwhn6nkjxXD2
	VAiYnI/ganYajbNX6QYCVVeP3a7JLUh4S1p0cA7F5BfXD9hHIaO9fTwRPReV4PCGBtlbxbjWB1B
	KaASmpyMyXBdnyoCTc5Ti+geihk/Tezwetk+gtMeDJHDhQvVKnh/vGPxf+tm5A==
X-Received: by 2002:a05:690c:7341:b0:7b3:edc7:9b8f with SMTP id
 00721157ae682-7d3351c9f16mr229152437b3.0.1779821930248; Tue, 26 May 2026
 11:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524221421.258593-1-tarjeib@gmail.com> <20260524221421.258593-2-tarjeib@gmail.com>
 <CABBYNZLNrWP4-ZtqxL61UR8fxnp+6_Wfwdtfhq=bx2g=VeVLyg@mail.gmail.com>
In-Reply-To: <CABBYNZLNrWP4-ZtqxL61UR8fxnp+6_Wfwdtfhq=bx2g=VeVLyg@mail.gmail.com>
From: =?UTF-8?Q?Tarjei_Bitust=C3=B8yl?= <tarjeib@gmail.com>
Date: Tue, 26 May 2026 20:58:14 +0200
X-Gm-Features: AVHnY4LNXHPDsIb_Vo-LiVwoqVpi6A-gpZyny3joTnQ46PnlK95sm0r5MKJSFPw
Message-ID: <CAJQCZbArSLor2zLC2cb_-AC1bAZJcNnzX5xvhug1xr1fr7DCNg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] adapter: Add configurable default LE PHYs
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yea you're right, I assumed too much here. I have only identified it
with my Frostbay device, not any other device. I've made a GitHub
issue with btmon logs and others that should show the issue.
I do still suspect that this is an issue for other BLE devices on the
Intel AX210 though.
Issue is 2155.

Regards,
Tarjei


tir. 26. mai 2026 kl. 16:27 skrev Luiz Augusto von Dentz <luiz.dentz@gmail.=
com>:
>
> Hi Tarjei,
>
> On Sun, May 24, 2026 at 6:14=E2=80=AFPM Tarjei Bitust=C3=B8yl <tarjeib@gm=
ail.com> wrote:
> >
> > Some controllers mis-handle LE procedures on specific PHYs with
> > certain peers. On an Intel AX210-class controller, connecting to a
> > Frostbay BLE device can fail during early ATT/GATT setup unless the
> > adapter is limited to LE 1M TX/RX.
>
> Perhaps there should be a GitHub issue explaining exactly what the
> problem is with btmon logs, etc, Then we can evaluate if this needs a
> workaround like this or if we should detect that certain PHYs should
> not be used.
>
> > Add an opt-in [LE] DefaultPHYs setting to bluetoothd and apply it at
> > adapter startup using MGMT_OP_GET/SET_PHY_CONFIGURATION while
> > preserving non-configurable PHY bits.
> >
> > This provides a generic, adapter-wide workaround for controller-
> > specific LE PHY interoperability problems affecting scanning and
> > connection establishment, without adding device-specific quirks.
>
> Well it is not really controller specific though, since it applies to
> any controller on the system. Also, I believe this could be a device
> specific problem so you might be taking away 2M support entirely when
> it could actually be supported with another device.
>
> > ---
> >  src/adapter.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  src/btd.h     |  2 ++
> >  src/main.c    | 61 +++++++++++++++++++++++++++++++++++++++++
> >  src/main.conf |  8 ++++++
> >  4 files changed, 147 insertions(+)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 20f7c3e03..fcbb65e38 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -4972,6 +4972,81 @@ done:
> >         mgmt_tlv_list_free(list);
> >  }
> >
> > +static void set_default_le_phys_complete(uint8_t status, uint16_t leng=
th,
> > +                                       const void *param, void *user_d=
ata)
> > +{
> > +       struct btd_adapter *adapter =3D user_data;
> > +
> > +       if (status !=3D MGMT_STATUS_SUCCESS)
> > +               btd_error(adapter->dev_id,
> > +                               "Failed to set default LE PHYs for hci%=
u: %s (0x%02x)",
> > +                               adapter->dev_id, mgmt_errstr(status), s=
tatus);
> > +}
> > +
> > +static void get_default_le_phys_complete(uint8_t status, uint16_t leng=
th,
> > +                                       const void *param, void *user_d=
ata)
> > +{
> > +       struct btd_adapter *adapter =3D user_data;
> > +       const struct mgmt_rp_get_phy_confguration *rp =3D param;
> > +       struct mgmt_cp_set_phy_confguration cp;
> > +       uint32_t configurable_phys;
> > +       uint32_t selected_phys;
> > +       uint32_t next_phys;
> > +
> > +       if (status !=3D MGMT_STATUS_SUCCESS) {
> > +               btd_error(adapter->dev_id,
> > +                               "Failed to read PHY configuration for h=
ci%u: %s (0x%02x)",
> > +                               adapter->dev_id, mgmt_errstr(status), s=
tatus);
> > +               return;
> > +       }
> > +
> > +       if (length < sizeof(*rp)) {
> > +               btd_error(adapter->dev_id,
> > +                               "Too small get PHY configuration respon=
se for hci%u",
> > +                               adapter->dev_id);
> > +               return;
> > +       }
> > +
> > +       configurable_phys =3D btohl(rp->configurable_phys);
> > +       selected_phys =3D btohl(rp->selected_phys);
> > +
> > +       configurable_phys &=3D MGMT_PHY_LE_TX_MASK | MGMT_PHY_LE_RX_MAS=
K;
> > +       next_phys =3D selected_phys & ~configurable_phys;
> > +       next_phys |=3D btd_opts.default_le_phys & configurable_phys;
> > +
> > +       if (next_phys =3D=3D selected_phys)
> > +               return;
> > +
> > +       cp.selected_phys =3D cpu_to_le32(next_phys);
> > +
> > +       if (mgmt_send(adapter->mgmt, MGMT_OP_SET_PHY_CONFIGURATION,
> > +                       adapter->dev_id, sizeof(cp), &cp,
> > +                       set_default_le_phys_complete, adapter, NULL) > =
0)
> > +               return;
> > +
> > +       btd_error(adapter->dev_id,
> > +                       "Failed to set default LE PHYs for hci%u",
> > +                       adapter->dev_id);
> > +}
> > +
> > +static void load_default_le_phys(struct btd_adapter *adapter)
> > +{
> > +       if (!btd_opts.default_le_phys_configured)
> > +               return;
> > +
> > +       if (!(adapter->supported_settings & MGMT_SETTING_LE))
> > +               return;
> > +
> > +       if (mgmt_send(adapter->mgmt, MGMT_OP_GET_PHY_CONFIGURATION,
> > +                       adapter->dev_id, 0, NULL,
> > +                       get_default_le_phys_complete, adapter, NULL) > =
0)
> > +               return;
> > +
> > +       btd_error(adapter->dev_id,
> > +                       "Failed to read PHY configuration for hci%u",
> > +                       adapter->dev_id);
> > +}
> > +
> >  static void load_devices(struct btd_adapter *adapter)
> >  {
> >         char dirname[PATH_MAX];
> > @@ -9455,6 +9530,7 @@ load:
> >         btd_profile_foreach(probe_profile, adapter);
> >         clear_blocked(adapter);
> >         load_defaults(adapter);
> > +       load_default_le_phys(adapter);
> >         load_devices(adapter);
> >
> >         /* restore Service Changed CCC value for bonded devices */
> > diff --git a/src/btd.h b/src/btd.h
> > index db2e81239..59f44dc8c 100644
> > --- a/src/btd.h
> > +++ b/src/btd.h
> > @@ -140,6 +140,8 @@ struct btd_opts {
> >         bool            device_privacy;
> >         uint32_t        name_request_retry_delay;
> >         uint8_t         secure_conn;
> > +       uint32_t        default_le_phys;
> > +       bool            default_le_phys_configured;
> >
> >         struct btd_defaults defaults;
> >
> > diff --git a/src/main.c b/src/main.c
> > index 8aa19a3e3..97c64845b 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -32,6 +32,7 @@
> >  #include <dbus/dbus.h>
> >
> >  #include "bluetooth/bluetooth.h"
> > +#include "bluetooth/mgmt.h"
> >  #include "bluetooth/sdp.h"
> >
> >  #include "gdbus/gdbus.h"
> > @@ -132,6 +133,7 @@ static const char *le_options[] =3D {
> >         "Autoconnecttimeout",
> >         "AdvMonAllowlistScanDuration",
> >         "AdvMonNoFilterScanDuration",
> > +       "DefaultPHYs",
> >         "EnableAdvMonInterleaveScan",
> >         NULL
> >  };
> > @@ -145,6 +147,8 @@ static const char *policy_options[] =3D {
> >         NULL
> >  };
> >
> > +static void parse_default_le_phys(GKeyFile *config);
> > +
> >  static const char *gatt_options[] =3D {
> >         "Cache",
> >         "KeySize",
> > @@ -751,6 +755,7 @@ static void parse_le_config(GKeyFile *config)
> >                 return;
> >
> >         parse_mode_config(config, "LE", params, ARRAY_SIZE(params));
> > +       parse_default_le_phys(config);
> >  }
> >
> >  static bool match_experimental(const void *data, const void *match_dat=
a)
> > @@ -966,6 +971,62 @@ static void parse_repairing(GKeyFile *config)
> >         g_free(str);
> >  }
> >
> > +struct phy_config_entry {
> > +       const char *name;
> > +       uint32_t bit;
> > +};
> > +
> > +static const struct phy_config_entry le_phy_configs[] =3D {
> > +       { "LE1MTX", MGMT_PHY_LE_1M_TX },
> > +       { "LE1MRX", MGMT_PHY_LE_1M_RX },
> > +       { "LE2MTX", MGMT_PHY_LE_2M_TX },
> > +       { "LE2MRX", MGMT_PHY_LE_2M_RX },
> > +       { "LECODEDTX", MGMT_PHY_LE_CODED_TX },
> > +       { "LECODEDRX", MGMT_PHY_LE_CODED_RX },
> > +};
> > +
> > +static void parse_default_le_phys(GKeyFile *config)
> > +{
> > +       char *str =3D NULL;
> > +       char **tokens;
> > +       uint32_t phys =3D 0;
> > +       bool valid =3D false;
> > +       int i;
> > +
> > +       if (!parse_config_string(config, "LE", "DefaultPHYs", &str))
> > +               return;
> > +
> > +       tokens =3D g_strsplit_set(str, ", \t", -1);
> > +
> > +       for (i =3D 0; tokens[i]; i++) {
> > +               const char *token =3D tokens[i];
> > +               size_t j;
> > +
> > +               if (!token[0])
> > +                       continue;
> > +
> > +               for (j =3D 0; j < ARRAY_SIZE(le_phy_configs); j++) {
> > +                       if (strcasecmp(le_phy_configs[j].name, token) !=
=3D 0)
> > +                               continue;
> > +
> > +                       phys |=3D le_phy_configs[j].bit;
> > +                       valid =3D true;
> > +                       break;
> > +               }
> > +
> > +               if (j =3D=3D ARRAY_SIZE(le_phy_configs))
> > +                       warn("Invalid DefaultPHYs token: %s", token);
> > +       }
> > +
> > +       if (valid) {
> > +               btd_opts.default_le_phys =3D phys;
> > +               btd_opts.default_le_phys_configured =3D true;
> > +       }
> > +
> > +       g_strfreev(tokens);
> > +       g_free(str);
> > +}
> > +
> >  static bool parse_config_hex(GKeyFile *config, char *group,
> >                                         const char *key, uint32_t *val)
> >  {
> > diff --git a/src/main.conf b/src/main.conf
> > index 5846ef92d..ed955897e 100644
> > --- a/src/main.conf
> > +++ b/src/main.conf
> > @@ -247,6 +247,14 @@
> >  # Default: 500
> >  #AdvMonNoFilterScanDuration=3D
> >
> > +# Configure the controller's default LE PHY policy used for scanning a=
nd
> > +# connection establishment. Only configurable LE PHYs are changed; man=
datory
> > +# PHYs remain selected automatically.
> > +# Possible values: comma or space separated list of LE1MTX, LE1MRX, LE=
2MTX,
> > +# LE2MRX, LECODEDTX, LECODEDRX.
> > +# Example: keep LE on 1M only.
> > +#DefaultPHYs =3D LE1MTX LE1MRX
> > +
> >  # Enable/Disable Advertisement Monitor interleave scan for power savin=
g.
> >  # 0: disable
> >  # 1: enable
> > --
> > 2.43.0
> >
> >
>
>
> --
> Luiz Augusto von Dentz
