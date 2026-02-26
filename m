Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42973AE70D
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114363; cv=pass; b=st2Vxq3MGqv+Fzhe3xRxhSgm1KvW6CKXztRnEhgWAJOwRVROEiPiXy3Q881nlYQA2QGmfrjUCFi2AGfqerW5VcEaxoZmevdsSnEL68wX1FWY1SyOuneHH+RIDB/7YUpO6KShH7nD7mOnSKZycN/Ij0kmBwR+zuJrgen2C39tdww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114363; c=relaxed/simple;
	bh=zpUOr1PQ7gpMSHxUYscDE02UR+CYtxFWmkI6CjsVMxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xuz+XypnFyW8pAW1m7OrMcxOWUslmjKSLYJI+5LZiikJoiq36qxbyfQC5KoOwrJzFrPWYRXO901P9Umt8PHWbzWBWaMezu+4fVo7fM2SPTQywZPivFIA3oiY3r6aVSlksgteKWJAMQkam21/t00QxokkD4+g0qDNRPQdIyBa22Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMqMi/oB; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMqMi/oB"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ad9fabd08so989436d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 05:59:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772114353; cv=none;
        d=google.com; s=arc-20240605;
        b=Y66Oz7k2Lbpoz6saWxx6pbwoaWwTCRcbBWVC/JlL1TQHQpa4+NEFlnLHA/Qw7gp+je
         +LMZrD3hi/UM2Un2SCDPpz2VE8uvZWEEWVB0YWhEgbZEv6aR32HR0R/AUBVcjrmuuwGY
         mLrPAG39UMctxdEXsGdTi/bD7BZ+Wrd/diCLhty4IhR+C7ndIUW3Nke6H59sAVTJFmZn
         f2DxgPlNDc6AlMhaQDBeSPg4BfPTLIvS0EIadI3uOZ9SUoWxgchYDhLAPxz4AWETwWop
         zYF2OLtD+4bm3R38c8Xw+ohIm2S92BYOhzfUW/7tuznhGSeE0Sn6uqRkH098LVlJQL8L
         WARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lgs6JtxGmItyqdEAe1kN9b4TbDCX7FCA1XXQAe6EuvI=;
        fh=kQa6Wv+jZCCo0Dk13pUerCaj03ZHdzDdDvtl5YYmgPQ=;
        b=aZw5JBXcZQvPqA5y8uQaSCUCTyKTdYyHzi7v3WRQNMRd43gWmcfXKDgdclZnIbLA1J
         3TUN3m4KpS0UGh28KM6xiQgGgFNVZ0Lpr9IVUYSNWCuASHzYgYb95hZdME/eUW/YA9C/
         FmiusdyzYIsbdSSz2xQrgoGVdR4/ViPYiQIYLFg8NdwtDKrfFmYtMiOtJ1D041eLRUMr
         EDbTeSsPjtfNx7lH2TboTat07YcsEFttkKbAF6dcp7/8O+UZNXf2KRGqiG9JgSfwB55U
         0kkB8ESwjB7WIYrXLHol3SZyUnu9iPqGWbVUAjN2V3UG6+FgNXygg74E2yZMWEtL5Hdr
         z7mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772114353; x=1772719153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lgs6JtxGmItyqdEAe1kN9b4TbDCX7FCA1XXQAe6EuvI=;
        b=VMqMi/oBoVHnqowA9CPMvGop6TXeILsQ5g8woXQFe13cslIlRnb3ybdJUyMpi6onAm
         dvOCwId8yMGmybQ7xNY88F0LE5T/z9mFntLfaotyXtbDJ29u6YpBMyZv3Y0iASPSomEB
         gn0QnWuYXGey/pTw+GXc4B41NcVPZ2O6ZuScRZCVEMU9dlSvCkJ3bn5eA8ncT+bU190y
         X8W2N9QGSPhSeOyyAuglXAr0FOrU2UyNPj2DpVJypMdSW+1Ivkw+Wa/yMk1sLi2bCH1c
         3BZE4ABGCm4nXSalwRYZqX4tEwkoyYivt+tqrlonRCKU0U/nxqL52eyayUGw3AX2XxMJ
         TJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772114353; x=1772719153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lgs6JtxGmItyqdEAe1kN9b4TbDCX7FCA1XXQAe6EuvI=;
        b=IkwHdqgAanBG8gKsN/Dgo+SXRx7r6BkNlOU6BCWV9V961Gu77A/3aeg8QWPtRl0STO
         +75ZAA+JD9gIPjj/2/W5o5ATn1+NVwXGYtnZQHXmRkj1eRB7D5V6OFjpF2gm9RLYP6bB
         ZtJAdx3oJq4RfNACN8oAST28M5W/kVqppiszw4aHEBc+VNVWwmQQelIkHfZlFCzxFbK5
         Lm84Gf6Tm2q15CHi6bgz5VFXkP/gwHNt17VbNLDKDmQgI57gWimsbnaN2ePiSZFkNrpW
         TrEs4Nybt5G5ObNqY0Hv5g99F+PsJwOuB2ddY4dRck3dte7Z8masIyCK/ODIIfqr+QFE
         /NmQ==
X-Gm-Message-State: AOJu0Yx5eCQ5FIxBQeqfYndX1XEZKt8PS2HZaHLYbUvB1yeqqndh/1eq
	bZrnIAtfRzIy2GzHIOO1oUnth4OJDSDKhdg3x8d2RdNOO+DhA4GlueWL+BZoxoM6kjCBJwQO9Qg
	vz4cAqDIkrY5WHS1qhGKT2W6vQnRyZ7UnCw==
X-Gm-Gg: ATEYQzy5lo8TOzkFA8s3WpmKgzsybIwdV0lI+KYQz/oYsYjRiQ0toySfRxi+WZo1HqW
	rQgTLXvG3x6PSAmPo5ENGdKPPq1eA0lGKE+xfxpDP8HwnEzeNyxZEtHOPfPxIjBDvMiXzPLX9Oi
	kM1xthEUleKwxIO9maaN5nsAtNeVA2/Dsnwqj3SddnFEYtgbE/TLK60Vzi1gLmHG2585Up9pEG1
	i3HBvqulpbMDLV/UaKcjj+11wjKySM/pNyxUc1UI8Cq2DUInIo8zreAffC+4ZYgHz5yimrG1c01
	kq7Q2VAPSfHqToHd0rMpJeeBrj3ipZscsyRmCh1M6zYpfQps9uclG7MvaQSpB6MwT0wB9m/vlGz
	xxw==
X-Received: by 2002:a05:690e:12ca:b0:644:7933:ae8a with SMTP id
 956f58d0204a3-64c787d4d86mr16542985d50.16.1772114352724; Thu, 26 Feb 2026
 05:59:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225161715.20394-1-ceggers@arri.de> <3672959.dWV9SEqChM@n9w6sw14>
 <CABBYNZLH7b+N8wpF0-Fs1G=n4Hwz3VE1A5L6wx05Lb5-mPkAhQ@mail.gmail.com> <5771968.rdbgypaU67@n9w6sw14>
In-Reply-To: <5771968.rdbgypaU67@n9w6sw14>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Feb 2026 08:59:00 -0500
X-Gm-Features: AaiRm50tsh6u8sy0ddf9CIt-UNaPfTia7S63z03qaFPusih6OIQes_OTddYJ5yg
Message-ID: <CABBYNZK42k-fbKy21kjTxjMxc2XziwSwmt2e4bCFGsdupnxR-w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 11/12] agent: move defines and parsing for I/O
 capability to shared/mgnt
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Thu, Feb 26, 2026 at 4:36=E2=80=AFAM Christian Eggers <ceggers@arri.de> =
wrote:
>
> Hi Luiz,
>
> On Wednesday, 25 February 2026, 19:42:26 CET, Luiz Augusto von Dentz wrot=
e:
> > Hi Christian,
> >
> > On Wed, Feb 25, 2026 at 1:38=E2=80=AFPM Christian Eggers <ceggers@arri.=
de> wrote:
> > >
> > > Hi Luiz,
> > >
> > > On Wednesday, 25 February 2026, 17:38:49 CET, Luiz Augusto von Dentz =
wrote:
> > > > Hi Christian,
> > > >
> > > > On Wed, Feb 25, 2026 at 11:22=E2=80=AFAM Christian Eggers <ceggers@=
arri.de> wrote:
> > > > >
> > > > > Allow reusing in client/mgmt.c (next commit)
> > > > > ---
> > > > >  src/adapter.c     |  6 +++---
> > > > >  src/agent.c       | 24 ++++--------------------
> > > > >  src/agent.h       |  7 -------
> > > > >  src/device.c      |  7 ++++---
> > > >
> > > > Shared changed should be sent separately since its license (LGPL) i=
s
> > > > different than the daemon (GPL).
> > >
> > > done
> > >
> > > >
> > > > >  src/shared/mgmt.c | 32 ++++++++++++++++++++++++++++++++
> > > > >  src/shared/mgmt.h | 10 ++++++++++
> > > > >  6 files changed, 53 insertions(+), 33 deletions(-)
> > > > >
> > > > > diff --git a/src/adapter.c b/src/adapter.c
> > > > > index 9bb1950a9f7d..bfabdf9a62ef 100644
> > > > > --- a/src/adapter.c
> > > > > +++ b/src/adapter.c
> > > > > @@ -9156,7 +9156,7 @@ int adapter_set_io_capability(struct btd_ad=
apter *adapter, uint8_t io_cap)
> > > > >         struct mgmt_cp_set_io_capability cp;
> > > > >
> > > > >         if (!btd_opts.pairable) {
> > > > > -               if (io_cap =3D=3D IO_CAPABILITY_INVALID) {
> > > > > +               if (io_cap =3D=3D MGMT_IO_CAPABILITY_INVALID) {
> > > > >                         if (adapter->current_settings & MGMT_SETT=
ING_BONDABLE)
> > > > >                                 set_mode(adapter, MGMT_OP_SET_BON=
DABLE, 0x00);
> > > > >
> > > > > @@ -9165,8 +9165,8 @@ int adapter_set_io_capability(struct btd_ad=
apter *adapter, uint8_t io_cap)
> > > > >
> > > > >                 if (!(adapter->current_settings & MGMT_SETTING_BO=
NDABLE))
> > > > >                         set_mode(adapter, MGMT_OP_SET_BONDABLE, 0=
x01);
> > > > > -       } else if (io_cap =3D=3D IO_CAPABILITY_INVALID)
> > > > > -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > > > +       } else if (io_cap =3D=3D MGMT_IO_CAPABILITY_INVALID)
> > > > > +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > > >
> > > > >         memset(&cp, 0, sizeof(cp));
> > > > >         cp.io_capability =3D io_cap;
> > > > > diff --git a/src/agent.c b/src/agent.c
> > > > > index 3696575b83e6..794f81ebf18a 100644
> > > > > --- a/src/agent.c
> > > > > +++ b/src/agent.c
> > > > > @@ -35,6 +35,7 @@
> > > > >  #include "adapter.h"
> > > > >  #include "device.h"
> > > > >  #include "agent.h"
> > > > > +#include "shared/mgmt.h"
> > > > >  #include "shared/queue.h"
> > > > >
> > > > >  #define REQUEST_TIMEOUT (60 * 1000)            /* 60 seconds */
> > > > > @@ -131,7 +132,7 @@ static void set_io_cap(struct btd_adapter *ad=
apter, gpointer user_data)
> > > > >         if (agent)
> > > > >                 io_cap =3D agent->capability;
> > > > >         else
> > > > > -               io_cap =3D IO_CAPABILITY_INVALID;
> > > > > +               io_cap =3D MGMT_IO_CAPABILITY_INVALID;
> > > > >
> > > > >         adapter_set_io_capability(adapter, io_cap);
> > > > >  }
> > > > > @@ -944,23 +945,6 @@ static void agent_destroy(gpointer data)
> > > > >         agent_unref(agent);
> > > > >  }
> > > > >
> > > > > -static uint8_t parse_io_capability(const char *capability)
> > > > > -{
> > > > > -       if (g_str_equal(capability, ""))
> > > > > -               return IO_CAPABILITY_KEYBOARDDISPLAY;
> > > > > -       if (g_str_equal(capability, "DisplayOnly"))
> > > > > -               return IO_CAPABILITY_DISPLAYONLY;
> > > > > -       if (g_str_equal(capability, "DisplayYesNo"))
> > > > > -               return IO_CAPABILITY_DISPLAYYESNO;
> > > > > -       if (g_str_equal(capability, "KeyboardOnly"))
> > > > > -               return IO_CAPABILITY_KEYBOARDONLY;
> > > > > -       if (g_str_equal(capability, "NoInputNoOutput"))
> > > > > -               return IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > > > -       if (g_str_equal(capability, "KeyboardDisplay"))
> > > > > -               return IO_CAPABILITY_KEYBOARDDISPLAY;
> > > > > -       return IO_CAPABILITY_INVALID;
> > > > > -}
> > > > > -
> > > > >  static DBusMessage *register_agent(DBusConnection *conn,
> > > > >                                         DBusMessage *msg, void *u=
ser_data)
> > > > >  {
> > > > > @@ -979,8 +963,8 @@ static DBusMessage *register_agent(DBusConnec=
tion *conn,
> > > > >                                                 DBUS_TYPE_INVALID=
) =3D=3D FALSE)
> > > > >                 return btd_error_invalid_args(msg);
> > > > >
> > > > > -       cap =3D parse_io_capability(capability);
> > > > > -       if (cap =3D=3D IO_CAPABILITY_INVALID)
> > > > > +       cap =3D mgmt_parse_io_capability(capability);
> > > > > +       if (cap =3D=3D MGMT_IO_CAPABILITY_INVALID)
> > > > >                 return btd_error_invalid_args(msg);
> > > > >
> > > > >         agent =3D agent_create(sender, path, cap);
> > > > > diff --git a/src/agent.h b/src/agent.h
> > > > > index bd0502030fa0..03731756849c 100644
> > > > > --- a/src/agent.h
> > > > > +++ b/src/agent.h
> > > > > @@ -9,13 +9,6 @@
> > > > >   *
> > > > >   */
> > > > >
> > > > > -#define IO_CAPABILITY_DISPLAYONLY      0x00
> > > > > -#define IO_CAPABILITY_DISPLAYYESNO     0x01
> > > > > -#define IO_CAPABILITY_KEYBOARDONLY     0x02
> > > > > -#define IO_CAPABILITY_NOINPUTNOOUTPUT  0x03
> > > > > -#define IO_CAPABILITY_KEYBOARDDISPLAY  0x04
> > > > > -#define IO_CAPABILITY_INVALID          0xFF
> > > > > -
> > > > >  struct agent;
> > > > >
> > > > >  typedef void (*agent_cb) (struct agent *agent, DBusError *err,
> > > > > diff --git a/src/device.c b/src/device.c
> > > > > index 0ef7dcc244d2..f7a84b807878 100644
> > > > > --- a/src/device.c
> > > > > +++ b/src/device.c
> > > > > @@ -43,6 +43,7 @@
> > > > >  #include "src/shared/gatt-client.h"
> > > > >  #include "src/shared/gatt-server.h"
> > > > >  #include "src/shared/ad.h"
> > > > > +#include "src/shared/mgmt.h"
> > > > >  #include "src/shared/timeout.h"
> > > > >  #include "btio/btio.h"
> > > > >  #include "bluetooth/mgmt.h"
> > > > > @@ -3375,7 +3376,7 @@ static DBusMessage *pair_device(DBusConnect=
ion *conn, DBusMessage *msg,
> > > > >         if (agent)
> > > > >                 io_cap =3D agent_get_io_capability(agent);
> > > > >         else
> > > > > -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > > > +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > > >
> > > > >         bonding =3D bonding_request_new(msg, device, bdaddr_type,=
 agent);
> > > > >
> > > > > @@ -6544,7 +6545,7 @@ static void att_connect_cb(GIOChannel *io, =
GError *gerr, gpointer user_data)
> > > > >         if (device->bonding->agent)
> > > > >                 io_cap =3D agent_get_io_capability(device->bondin=
g->agent);
> > > > >         else
> > > > > -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > > > +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > > >
> > > > >         err =3D adapter_create_bonding(device->adapter, &device->=
bdaddr,
> > > > >                                         device->bdaddr_type, io_c=
ap);
> > > > > @@ -7452,7 +7453,7 @@ static gboolean device_bonding_retry(gpoint=
er data)
> > > > >         if (bonding->agent)
> > > > >                 io_cap =3D agent_get_io_capability(bonding->agent=
);
> > > > >         else
> > > > > -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > > > +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > > >
> > > > >         err =3D adapter_bonding_attempt(adapter, &device->bdaddr,
> > > > >                                 device->bdaddr_type, io_cap);
> > > > > diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> > > > > index 6a7eb5798cb8..300abbae1c50 100644
> > > > > --- a/src/shared/mgmt.c
> > > > > +++ b/src/shared/mgmt.c
> > > > > @@ -81,6 +81,20 @@ struct mgmt_tlv_list {
> > > > >         uint16_t size;
> > > > >  };
> > > > >
> > > > > +struct arg_table {
> > > > > +       const char *name;
> > > > > +       unsigned value;
> > > > > +};
> > > > > +
> > > > > +static const struct arg_table iocap_arguments[] =3D {
> > > > > +       { "DisplayOnly", MGMT_IO_CAPABILITY_DISPLAYONLY },
> > > > > +       { "DisplayYesNo", MGMT_IO_CAPABILITY_DISPLAYYESNO },
> > > > > +       { "KeyboardOnly", MGMT_IO_CAPABILITY_KEYBOARDONLY },
> > > > > +       { "NoInputNoOutput", MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT }=
,
> > > > > +       { "KeyboardDisplay", MGMT_IO_CAPABILITY_KEYBOARDDISPLAY }=
,
> > > > > +       { NULL, 0}
> > > > > +};
> > > > > +
> > > > >  static void destroy_request(void *data)
> > > > >  {
> > > > >         struct mgmt_request *request =3D data;
> > > > > @@ -1039,3 +1053,21 @@ uint16_t mgmt_get_mtu(struct mgmt *mgmt)
> > > > >
> > > > >         return mgmt->mtu;
> > > > >  }
> > > > > +
> > > > > +uint8_t mgmt_parse_io_capability(const char *capability)
> > > > > +{
> > > > > +       const char *arg;
> > > > > +       int index =3D 0;
> > > > > +
> > > > > +       if (!strcmp(capability, ""))
> > > > > +               return MGMT_IO_CAPABILITY_KEYBOARDDISPLAY;
> > > > > +
> > > > > +       while ((arg =3D iocap_arguments[index].name)) {
> > > > > +               if (!strncmp(arg, capability, strlen(capability))=
)
> > > > > +                       return iocap_arguments[index].value;
> > > > > +
> > > > > +               index++;
> > > > > +       }
> > > > > +
> > > > > +       return MGMT_IO_CAPABILITY_INVALID;
> > > > > +}
> > > > > diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
> > > > > index 2629fbd59cf6..a4c30075f7b7 100644
> > > > > --- a/src/shared/mgmt.h
> > > > > +++ b/src/shared/mgmt.h
> > > > > @@ -13,6 +13,14 @@
> > > > >
> > > > >  #define MGMT_VERSION(v, r) (((v) << 16) + (r))
> > > > >
> > > > > +#define MGMT_IO_CAPABILITY_DISPLAYONLY         0x00
> > > > > +#define MGMT_IO_CAPABILITY_DISPLAYYESNO                0x01
> > > > > +#define MGMT_IO_CAPABILITY_KEYBOARDONLY                0x02
> > > > > +#define MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT     0x03
> > > > > +#define MGMT_IO_CAPABILITY_KEYBOARDDISPLAY     0x04
> > > > > +#define MGMT_IO_CAPABILITY_INVALID             0xFF
> > > >
> > > > Perhaps this should be an enum to ensure things like switch stateme=
nts
> > > > do check for unhandled values.
> > >
> > > also done. But now using an enum in src/adapter.h requires also inclu=
ding
> > > "src/shared/mgmt.h" in every file where src/adapter.h is used. I've m=
ade
> > > all these changes, but maybe we should really think about include gua=
rds.
> >
> > Not following why would adapter.h requires it? Is adapter.h returning t=
he enum?
>
> diff --git a/src/adapter.h b/src/adapter.h
> index 7a7e5c8f9dfd..377c6a8789fb 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -207,15 +207,18 @@ int btd_adapter_passkey_reply(struct btd_adapter *a=
dapter,
>                                 uint32_t passkey);
>
>  int adapter_create_bonding(struct btd_adapter *adapter, const bdaddr_t *=
bdaddr,
> -                                       uint8_t addr_type, uint8_t io_cap=
);
> +                                               uint8_t addr_type,
> +                                               enum mgmt_io_capability i=
o_cap);
>
>  int adapter_bonding_attempt(struct btd_adapter *adapter, const bdaddr_t =
*bdaddr,
> -                                       uint8_t addr_type, uint8_t io_cap=
);
> +                                               uint8_t addr_type,
> +                                               enum mgmt_io_capability i=
o_cap);
>
>  int adapter_cancel_bonding(struct btd_adapter *adapter, const bdaddr_t *=
bdaddr,
>                                                         uint8_t addr_type=
);
>
> -int adapter_set_io_capability(struct btd_adapter *adapter, uint8_t io_ca=
p);
> +int adapter_set_io_capability(struct btd_adapter *adapter,
> +                                               enum mgmt_io_capability i=
o_cap);

I'd keep these as `uint8_t` to limit the necessary changes, as the
objective here is fixing the bluetoothctl mgmt command. We can attempt
cleanup in a different set.

>  int btd_adapter_read_local_oob_data(struct btd_adapter *adapter);
>
>
> Compiler output:
> In file included from plugins/autopair.c:28:
> ./src/adapter.h:211:54: warning: =E2=80=98enum mgmt_io_capability=E2=80=
=99 declared inside parameter list will not be visible outside of this defi=
nition or declaration
>   211 |                                                 enum mgmt_io_capa=
bility io_cap);
>       |                                                      ^~~~~~~~~~~~=
~~~~~~
> ./src/adapter.h:215:54: warning: =E2=80=98enum mgmt_io_capability=E2=80=
=99 declared inside parameter list will not be visible outside of this defi=
nition or declaration
>   215 |                                                 enum mgmt_io_capa=
bility io_cap);
>       |                                                      ^~~~~~~~~~~~=
~~~~~~
> ./src/adapter.h:221:54: warning: =E2=80=98enum mgmt_io_capability=E2=80=
=99 declared inside parameter list will not be visible outside of this defi=
nition or declaration
>   221 |                                                 enum mgmt_io_capa=
bility io_cap);
>       |                                                      ^~~~~~~~~~~~=
~~~~~~
>
>
> So, `enum mgmt_io_capability` is not used as a return value, but also usi=
ng it
> as function argument requires prior declaration.
>
> AFAIK, forward declaration of C-style enum is not possible. So if
> `enum mgmt_io_capability` is declared in shared/mgmt.h, this header must =
be
> included prior src/adapter.h
>
> Currently, src/adapter.h is included by 56 files. In nearly all of them, =
I had
> to add inclusion of src/shared/mgmt.h.
>
> regards,
> Christian
> >
> > > Shall I resubmit the whole series or do you want to pick the fine com=
mits
> > > first?
> >
> > Ive already applied the changes that I didn't have any comments, so
> > please rebase and send as a new set.
> >
> > > regards,
> > > Christian
> > >
> > > >
> > > > > +
> > > > > +
> > > > >  typedef void (*mgmt_destroy_func_t)(void *user_data);
> > > > >
> > > > >  struct mgmt;
> > > > > @@ -89,3 +97,5 @@ bool mgmt_unregister_index(struct mgmt *mgmt, u=
int16_t index);
> > > > >  bool mgmt_unregister_all(struct mgmt *mgmt);
> > > > >
> > > > >  uint16_t mgmt_get_mtu(struct mgmt *mgmt);
> > > > > +
> > > > > +uint8_t mgmt_parse_io_capability(const char *capability);
> > > > > --
> > > > > 2.51.0
> > > > >
> > > > >
> > > >
> > > >
> > > >
> > >
> > >
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
