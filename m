Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E3A248886
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044963; cv=pass; b=YHcp2DYsZWezw9kGfZl2elXTvJs6I7kaHlQay6xN4Rk4ND7W+Z9u65uJcLch2gKsMK03hE/FAhGcwTFdT5Fh3cHuajQ0Gq/vXhi+BhO8R8RhbTfIzdPTkGFfG4ISY6NwIJiANtH1+InxLzHYtiSMcOvV2UNd++vFjE8wKLYCtWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044963; c=relaxed/simple;
	bh=FHPP13k6SMedv1eBNBfIBREn6T/3r/7c4RS1MZgmHj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0SSiFHF4tLYZew8lzB32DZiMLPojMZBHLsEesA1oyvGB3TwML4kTr6x76j/o8HoZGWf4enqcVBZEV/HzcM46NZW/JtUlzRovK+/ms8ejkX9/E35GMGdr423woEXKlpR2KCOG0aBDsNIYmER2gsQMRbTf+I/qrv8f5GmzaePVNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ7yDmy0; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ7yDmy0"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ad79dfb6eso7153660d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 10:42:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772044959; cv=none;
        d=google.com; s=arc-20240605;
        b=lE1EFVkDEDXqyNPkj6rWfeA9i2tdNmDvXxR8AmiLydCmIfrC2G85/WkrapNqBeex33
         4PR5/8mC20qs39lomvMJBMyHjFFfS0O6x4f6BSGGwhGTffGqUDQnHqk0S98JWKW2PS1R
         jGyzRf4rxkhS5WZ99LrAxOvYwfCD5l9JiaG9ZICf7kh1IoWdtSvf6ySZHOeSAX2J6r89
         uGY+1ogFNUlKh55slHyVn0yyaABOm1TcumnoBg7cx7kK6t/IAOhWiOcKyYPXAZuNu5Gt
         5QmNIlSwN2/AgjLPL4YbuB/VKdhmhm2GgqWYczwB4i0Wrwet3vf+WL7OmX+4MYVTF2W3
         613w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JLgKiZdp0QWxY6WDZbD88wicG2ZUPJ3upRuH8A1S7jU=;
        fh=kQa6Wv+jZCCo0Dk13pUerCaj03ZHdzDdDvtl5YYmgPQ=;
        b=MhSN9ER2e4fvEpiccz7Yzmvy02juuVT7DwbKmq2hpA4Gzl9V1ZTwsOGf21QyCAkL+Q
         5/MnKguVEC/LkGR82hOXj0YH4jy/m0kafKFAGDU3Kh+fBAiEPb6CLyzLLyoWJeApJFok
         CfJxhFH+H/ZoyJqLCo+utSHySAVNAnaQzukAH64zzGEm1l82CD6AKPgn3P0A9BcUyWO+
         um7QwW9YPKW2PXa1hE/5+xoTuvJaIYqsg0TINjNUrKc+zn1AwnGWM/Hwk7XuT1ew/k92
         0dsL7A/Mf4OSTKOlGIB0cL3KA77UwkbtUHDpAMuFCglESqut78S/HGsmDqFjfTcd8L1k
         wqdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772044959; x=1772649759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLgKiZdp0QWxY6WDZbD88wicG2ZUPJ3upRuH8A1S7jU=;
        b=ZJ7yDmy02KmVAvFaGk8bIEA4TslOvHxLs/5jzFGAB21r6H9YKrltO/jZr67DUBBLfp
         48FsWLXJH5CcPO+eqwqIMKr4P1xVobO087httP8ZmFKJTjYbHzw317GkIpnmTeYuwBDb
         jgmq5nTWMSOS57opbAosCfGOy8QFuciE4ayNgjMbvq8Tqky6jDcLyDq7I6tSE9QYWJ8c
         a2w8WwxB+IwAV4IM3d/foGKxxRMFhCPpQX1ZHgiE1GRLYP2CcaHsZ9HodeFp7VGvMth1
         8ol8LBWAOjTxDM0T689rLykbq0WqAEpRq/jwTdd1NetjQmSdwCp6OJ9+D3MjWLsWB3Mg
         eUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044959; x=1772649759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JLgKiZdp0QWxY6WDZbD88wicG2ZUPJ3upRuH8A1S7jU=;
        b=j+ifK7E8cuQYQNi3ByvAgkeO8mvb0093wfvImQJt/ELx1HpKSdHCbFqTirvz/xuvjA
         F7MhLKHumJCszwV1ueBqroL+GP5nQ3F8Dh1XawsWMD18yZfIr5bzhYwl9v+NzqAj44HT
         QwwbcugMZ6TopYjudRvPVZhYJEEPS/q49+j4ClXDTERSXotGX1ClQn7VJbvmyJuPR3P8
         UrWkAs967vqMPPciz/rMwlUQs5wCbRpnMBGTBKRNk3fHjg7sR+CW62IGperUrYCphdCa
         XjU9oV8fa6L11iA9sVZUzODIiPNaoHJiRQhuw2iR0FhGFpRBE6XLevqy774NGFu/wbHQ
         3hLg==
X-Gm-Message-State: AOJu0Yw1bx06Ke4PmDm00fkbrCt+YfRibEI6e87sQgA3voXM63icoO2D
	/sp6o7zQ2+TJdYFQ5tkFIMEM0RJ4p2+Lcfz3IOBgTKDhzTP59w9RJzZ79gzy5iC8wOR1h4G95dq
	RFT6OAFuPktqHRrdGY26E+CDg1SFVcy0dH/sy
X-Gm-Gg: ATEYQzy8A9KV4ddkFbllEbsJl+6OzoC/vVSA/MBSZ690197R1B1kpzu28od4UGvZEjx
	j5ix1+87DJOgmJ+XnC8j9cmFkPs+cfB8ejn3f8eu+HNmJ/Ajf0Bv5yzUa2WBYonhveSp0ZDrPVy
	velTcDRA1f3X/Rd78QyE4XAU4pSLjWvq04Q5ZGXQZYQUajB8iFRy4sNyydiewoBJpGprKSdxAuH
	+JFml+57Hl0HndT8kzFWY0l2BgFjACllGzThyKwVi9X+7d2vgzj3Mzf0og5IMNX5l79kf2EL0fR
	AmfephGWfsjKCFkworo7Wcmaia33/aA7CGaa785y6dIuMV7jHJCaPPdSpE+lFtoBIL/WQw==
X-Received: by 2002:a05:690e:c42:b0:64c:9a08:9948 with SMTP id
 956f58d0204a3-64c9a089b09mr6301098d50.76.1772044958930; Wed, 25 Feb 2026
 10:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225161715.20394-1-ceggers@arri.de> <20260225161715.20394-11-ceggers@arri.de>
 <CABBYNZLgQWy_+gZmWXRmQx1g7P3pT3=ZLjFa7FuUnpWH4Huf3g@mail.gmail.com> <3672959.dWV9SEqChM@n9w6sw14>
In-Reply-To: <3672959.dWV9SEqChM@n9w6sw14>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Feb 2026 13:42:26 -0500
X-Gm-Features: AaiRm50dSgB7FnhyNm12u_GcqDJ9BoghOXdeD2Pwl1LD5jxjY2vRmB_iOUiAcb4
Message-ID: <CABBYNZLH7b+N8wpF0-Fs1G=n4Hwz3VE1A5L6wx05Lb5-mPkAhQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 11/12] agent: move defines and parsing for I/O
 capability to shared/mgnt
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, Feb 25, 2026 at 1:38=E2=80=AFPM Christian Eggers <ceggers@arri.de> =
wrote:
>
> Hi Luiz,
>
> On Wednesday, 25 February 2026, 17:38:49 CET, Luiz Augusto von Dentz wrot=
e:
> > Hi Christian,
> >
> > On Wed, Feb 25, 2026 at 11:22=E2=80=AFAM Christian Eggers <ceggers@arri=
.de> wrote:
> > >
> > > Allow reusing in client/mgmt.c (next commit)
> > > ---
> > >  src/adapter.c     |  6 +++---
> > >  src/agent.c       | 24 ++++--------------------
> > >  src/agent.h       |  7 -------
> > >  src/device.c      |  7 ++++---
> >
> > Shared changed should be sent separately since its license (LGPL) is
> > different than the daemon (GPL).
>
> done
>
> >
> > >  src/shared/mgmt.c | 32 ++++++++++++++++++++++++++++++++
> > >  src/shared/mgmt.h | 10 ++++++++++
> > >  6 files changed, 53 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/src/adapter.c b/src/adapter.c
> > > index 9bb1950a9f7d..bfabdf9a62ef 100644
> > > --- a/src/adapter.c
> > > +++ b/src/adapter.c
> > > @@ -9156,7 +9156,7 @@ int adapter_set_io_capability(struct btd_adapte=
r *adapter, uint8_t io_cap)
> > >         struct mgmt_cp_set_io_capability cp;
> > >
> > >         if (!btd_opts.pairable) {
> > > -               if (io_cap =3D=3D IO_CAPABILITY_INVALID) {
> > > +               if (io_cap =3D=3D MGMT_IO_CAPABILITY_INVALID) {
> > >                         if (adapter->current_settings & MGMT_SETTING_=
BONDABLE)
> > >                                 set_mode(adapter, MGMT_OP_SET_BONDABL=
E, 0x00);
> > >
> > > @@ -9165,8 +9165,8 @@ int adapter_set_io_capability(struct btd_adapte=
r *adapter, uint8_t io_cap)
> > >
> > >                 if (!(adapter->current_settings & MGMT_SETTING_BONDAB=
LE))
> > >                         set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01)=
;
> > > -       } else if (io_cap =3D=3D IO_CAPABILITY_INVALID)
> > > -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > +       } else if (io_cap =3D=3D MGMT_IO_CAPABILITY_INVALID)
> > > +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
> > >
> > >         memset(&cp, 0, sizeof(cp));
> > >         cp.io_capability =3D io_cap;
> > > diff --git a/src/agent.c b/src/agent.c
> > > index 3696575b83e6..794f81ebf18a 100644
> > > --- a/src/agent.c
> > > +++ b/src/agent.c
> > > @@ -35,6 +35,7 @@
> > >  #include "adapter.h"
> > >  #include "device.h"
> > >  #include "agent.h"
> > > +#include "shared/mgmt.h"
> > >  #include "shared/queue.h"
> > >
> > >  #define REQUEST_TIMEOUT (60 * 1000)            /* 60 seconds */
> > > @@ -131,7 +132,7 @@ static void set_io_cap(struct btd_adapter *adapte=
r, gpointer user_data)
> > >         if (agent)
> > >                 io_cap =3D agent->capability;
> > >         else
> > > -               io_cap =3D IO_CAPABILITY_INVALID;
> > > +               io_cap =3D MGMT_IO_CAPABILITY_INVALID;
> > >
> > >         adapter_set_io_capability(adapter, io_cap);
> > >  }
> > > @@ -944,23 +945,6 @@ static void agent_destroy(gpointer data)
> > >         agent_unref(agent);
> > >  }
> > >
> > > -static uint8_t parse_io_capability(const char *capability)
> > > -{
> > > -       if (g_str_equal(capability, ""))
> > > -               return IO_CAPABILITY_KEYBOARDDISPLAY;
> > > -       if (g_str_equal(capability, "DisplayOnly"))
> > > -               return IO_CAPABILITY_DISPLAYONLY;
> > > -       if (g_str_equal(capability, "DisplayYesNo"))
> > > -               return IO_CAPABILITY_DISPLAYYESNO;
> > > -       if (g_str_equal(capability, "KeyboardOnly"))
> > > -               return IO_CAPABILITY_KEYBOARDONLY;
> > > -       if (g_str_equal(capability, "NoInputNoOutput"))
> > > -               return IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > -       if (g_str_equal(capability, "KeyboardDisplay"))
> > > -               return IO_CAPABILITY_KEYBOARDDISPLAY;
> > > -       return IO_CAPABILITY_INVALID;
> > > -}
> > > -
> > >  static DBusMessage *register_agent(DBusConnection *conn,
> > >                                         DBusMessage *msg, void *user_=
data)
> > >  {
> > > @@ -979,8 +963,8 @@ static DBusMessage *register_agent(DBusConnection=
 *conn,
> > >                                                 DBUS_TYPE_INVALID) =
=3D=3D FALSE)
> > >                 return btd_error_invalid_args(msg);
> > >
> > > -       cap =3D parse_io_capability(capability);
> > > -       if (cap =3D=3D IO_CAPABILITY_INVALID)
> > > +       cap =3D mgmt_parse_io_capability(capability);
> > > +       if (cap =3D=3D MGMT_IO_CAPABILITY_INVALID)
> > >                 return btd_error_invalid_args(msg);
> > >
> > >         agent =3D agent_create(sender, path, cap);
> > > diff --git a/src/agent.h b/src/agent.h
> > > index bd0502030fa0..03731756849c 100644
> > > --- a/src/agent.h
> > > +++ b/src/agent.h
> > > @@ -9,13 +9,6 @@
> > >   *
> > >   */
> > >
> > > -#define IO_CAPABILITY_DISPLAYONLY      0x00
> > > -#define IO_CAPABILITY_DISPLAYYESNO     0x01
> > > -#define IO_CAPABILITY_KEYBOARDONLY     0x02
> > > -#define IO_CAPABILITY_NOINPUTNOOUTPUT  0x03
> > > -#define IO_CAPABILITY_KEYBOARDDISPLAY  0x04
> > > -#define IO_CAPABILITY_INVALID          0xFF
> > > -
> > >  struct agent;
> > >
> > >  typedef void (*agent_cb) (struct agent *agent, DBusError *err,
> > > diff --git a/src/device.c b/src/device.c
> > > index 0ef7dcc244d2..f7a84b807878 100644
> > > --- a/src/device.c
> > > +++ b/src/device.c
> > > @@ -43,6 +43,7 @@
> > >  #include "src/shared/gatt-client.h"
> > >  #include "src/shared/gatt-server.h"
> > >  #include "src/shared/ad.h"
> > > +#include "src/shared/mgmt.h"
> > >  #include "src/shared/timeout.h"
> > >  #include "btio/btio.h"
> > >  #include "bluetooth/mgmt.h"
> > > @@ -3375,7 +3376,7 @@ static DBusMessage *pair_device(DBusConnection =
*conn, DBusMessage *msg,
> > >         if (agent)
> > >                 io_cap =3D agent_get_io_capability(agent);
> > >         else
> > > -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
> > >
> > >         bonding =3D bonding_request_new(msg, device, bdaddr_type, age=
nt);
> > >
> > > @@ -6544,7 +6545,7 @@ static void att_connect_cb(GIOChannel *io, GErr=
or *gerr, gpointer user_data)
> > >         if (device->bonding->agent)
> > >                 io_cap =3D agent_get_io_capability(device->bonding->a=
gent);
> > >         else
> > > -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
> > >
> > >         err =3D adapter_create_bonding(device->adapter, &device->bdad=
dr,
> > >                                         device->bdaddr_type, io_cap);
> > > @@ -7452,7 +7453,7 @@ static gboolean device_bonding_retry(gpointer d=
ata)
> > >         if (bonding->agent)
> > >                 io_cap =3D agent_get_io_capability(bonding->agent);
> > >         else
> > > -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
> > >
> > >         err =3D adapter_bonding_attempt(adapter, &device->bdaddr,
> > >                                 device->bdaddr_type, io_cap);
> > > diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> > > index 6a7eb5798cb8..300abbae1c50 100644
> > > --- a/src/shared/mgmt.c
> > > +++ b/src/shared/mgmt.c
> > > @@ -81,6 +81,20 @@ struct mgmt_tlv_list {
> > >         uint16_t size;
> > >  };
> > >
> > > +struct arg_table {
> > > +       const char *name;
> > > +       unsigned value;
> > > +};
> > > +
> > > +static const struct arg_table iocap_arguments[] =3D {
> > > +       { "DisplayOnly", MGMT_IO_CAPABILITY_DISPLAYONLY },
> > > +       { "DisplayYesNo", MGMT_IO_CAPABILITY_DISPLAYYESNO },
> > > +       { "KeyboardOnly", MGMT_IO_CAPABILITY_KEYBOARDONLY },
> > > +       { "NoInputNoOutput", MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT },
> > > +       { "KeyboardDisplay", MGMT_IO_CAPABILITY_KEYBOARDDISPLAY },
> > > +       { NULL, 0}
> > > +};
> > > +
> > >  static void destroy_request(void *data)
> > >  {
> > >         struct mgmt_request *request =3D data;
> > > @@ -1039,3 +1053,21 @@ uint16_t mgmt_get_mtu(struct mgmt *mgmt)
> > >
> > >         return mgmt->mtu;
> > >  }
> > > +
> > > +uint8_t mgmt_parse_io_capability(const char *capability)
> > > +{
> > > +       const char *arg;
> > > +       int index =3D 0;
> > > +
> > > +       if (!strcmp(capability, ""))
> > > +               return MGMT_IO_CAPABILITY_KEYBOARDDISPLAY;
> > > +
> > > +       while ((arg =3D iocap_arguments[index].name)) {
> > > +               if (!strncmp(arg, capability, strlen(capability)))
> > > +                       return iocap_arguments[index].value;
> > > +
> > > +               index++;
> > > +       }
> > > +
> > > +       return MGMT_IO_CAPABILITY_INVALID;
> > > +}
> > > diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
> > > index 2629fbd59cf6..a4c30075f7b7 100644
> > > --- a/src/shared/mgmt.h
> > > +++ b/src/shared/mgmt.h
> > > @@ -13,6 +13,14 @@
> > >
> > >  #define MGMT_VERSION(v, r) (((v) << 16) + (r))
> > >
> > > +#define MGMT_IO_CAPABILITY_DISPLAYONLY         0x00
> > > +#define MGMT_IO_CAPABILITY_DISPLAYYESNO                0x01
> > > +#define MGMT_IO_CAPABILITY_KEYBOARDONLY                0x02
> > > +#define MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT     0x03
> > > +#define MGMT_IO_CAPABILITY_KEYBOARDDISPLAY     0x04
> > > +#define MGMT_IO_CAPABILITY_INVALID             0xFF
> >
> > Perhaps this should be an enum to ensure things like switch statements
> > do check for unhandled values.
>
> also done. But now using an enum in src/adapter.h requires also including
> "src/shared/mgmt.h" in every file where src/adapter.h is used. I've made
> all these changes, but maybe we should really think about include guards.

Not following why would adapter.h requires it? Is adapter.h returning the e=
num?

> Shall I resubmit the whole series or do you want to pick the fine commits
> first?

Ive already applied the changes that I didn't have any comments, so
please rebase and send as a new set.

> regards,
> Christian
>
> >
> > > +
> > > +
> > >  typedef void (*mgmt_destroy_func_t)(void *user_data);
> > >
> > >  struct mgmt;
> > > @@ -89,3 +97,5 @@ bool mgmt_unregister_index(struct mgmt *mgmt, uint1=
6_t index);
> > >  bool mgmt_unregister_all(struct mgmt *mgmt);
> > >
> > >  uint16_t mgmt_get_mtu(struct mgmt *mgmt);
> > > +
> > > +uint8_t mgmt_parse_io_capability(const char *capability);
> > > --
> > > 2.51.0
> > >
> > >
> >
> >
> >
>
>
>
>


--=20
Luiz Augusto von Dentz
