Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD36272E7B
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609605; cv=none; b=bbMttC4dkzDB1u7DJ9uxbB25cmYyzcwzeMYEGtUkkYBKWIZOTbYNI5hIIuemp3pkrXR+xMr4zGgTatJr5eGw2xIpE4HRZep1VqLhwY9zyCqkyzhxM4jl8lp4dCXMg+hXObmoFI8mDVlCWkfTWgpdtEc4vGXngBH0MlIrLD9o3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609605; c=relaxed/simple;
	bh=IE3jA591a5WOBsbsgm7VqxCRyHjln2k+QAqyi0WHJME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kif/7oE/IZ9ces5okVrs+mCFq1pDL1RDfgV8j8jxr3NQ3tAFGO4ZTTJx4j7OEoh/03yZgKkCMGQxeQ10r20ixn8Z++7w4zZUg4wG+O6jtdrWO1ankAk6YltWYE7I2g2nWZZnbCo2RomzHWlo2TKO3bTYGQY4Bv4K/kcvio0Rptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrNq/BTE; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrNq/BTE"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553b5165cf5so7194538e87.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752609601; x=1753214401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPi8370E9Cbumc/lIZBBntxUAB+Jozz4Dmc0n+54W0Y=;
        b=GrNq/BTEnkeduitivwuXst1xdX3ahB4AeIt5UZoXwkzaxrhW9ljPsaj+mKugjkrRgH
         eugxgPUQ7fHbv4ZcJOtpWgOp0ugNNLf7BGYHEwDNt4+D95P+ia5sBSoRHjZzohOiJ02W
         ePx6ZqHWHUf13crIAy6XLH/DAf1XQUQXH+V90rGOGHH5PkvRHBl/pn8gxe8L8trp1bjn
         Eo4MYtq+4PZN50XGGE+Ebeg3YqODm8S+Jtv4SfjA4o+i0Z+y7vJy4L2eRcp4x4xEsAy7
         z9Pe46XjnWenZ0NLSn3EqlyHKSOqY3LrxC/vbyLUVXZDYX1eYTCUwGvxklxyhdvbgDJp
         qhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752609601; x=1753214401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPi8370E9Cbumc/lIZBBntxUAB+Jozz4Dmc0n+54W0Y=;
        b=FoQQCmLGtmCuwWqo9cPQV7uS4DcPq6Gk/Do/BvZtI6mrOLZJEXVref5FCG0m4WCEnR
         TakG0gbV62O+JQTRm22knLPNvUtSOqyipEOJKp+JjCeG89iKgB3vYqNCKoy4pIHH+dir
         UoAq+BU2e8Cks2J4LoAuCCd16JAEMbqt70G4HIFD4NQddOYRT/k4eR9dYNF2gh5RZ1KS
         YYcG3Oi28DC9sp78OaAtndHmreE4GPAgw805Utv0VhtVXyYzNwNKfx5BxP6iiTCn2RXv
         gi9s8fyp22f///I7VNmh3arqcISrqJlykc7D1lBMXIdvuoKb8UE3pvCbA78ad7hojaO+
         UHkg==
X-Gm-Message-State: AOJu0Yx1ZQLWdhFztVGkMWUYkrlzB7PosJbJp7ObOCyIM0r4Dnx54SCm
	WSPLn3dQXJp1xbqdh51by/SxZ8SpzzrdEdyUHNewww8b7ELLuBxExXD99h+z5x1RcOnhVtRBMmu
	PFtcQUGj7E3LfmTmb/U1X5ohy/Smzl4CVNaVV
X-Gm-Gg: ASbGnct0NlODd0UnOqvOovcfBB6aIo7VqZjCjbF+NO1M77eh5SiSzzhNaSn4jG7nslL
	e1IwVPNdPDsAYoqOL1y9VDS3RUGCB+YM+mjwlMXgHh3nf0XiYn/BFG98nQ30Q/0DRuZ82mebU9Z
	Huci6zc/AkkSGaLGtdUIGYi9I4K36cDDUnpRkdeRn0xhBjlQOXInyjq1wxjhkqmDYqf8KA2UngS
	89VhQ==
X-Google-Smtp-Source: AGHT+IGD+9sKMh1WEorhEcctPfI6jHvRRzhkV15jnXSXCyzaqsp76Q17KUohwiop4wabKQcC4OGSSG1O/ozrTZfhR28=
X-Received: by 2002:a05:6512:23a4:b0:54f:c2ca:d33 with SMTP id
 2adb3069b0e04-55a2332fd06mr282801e87.20.1752609600094; Tue, 15 Jul 2025
 13:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715180747.670323-1-luiz.dentz@gmail.com> <CABBYNZJUKs5bdVa0xYqKsfa7EOs=UXrCZD-QKigfu_Lpf72i+g@mail.gmail.com>
 <a27c264f3b5e8122f508c7a5a110bfc214658d71.camel@iki.fi>
In-Reply-To: <a27c264f3b5e8122f508c7a5a110bfc214658d71.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 15 Jul 2025 15:59:47 -0400
X-Gm-Features: Ac12FXzUioVP3l6hiKxbL-8mQb_HE08ya0BrTpl5BiPo544CBkm-WVrrtagOmhM
Message-ID: <CABBYNZ+xq-ifPiChUJqt=qNQ5_agqQtHkfwU-toy+2yosvdGqg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1] doc: Add initial ISO(7) documentation
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Jul 15, 2025 at 3:49=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ti, 2025-07-15 kello 14:17 -0400, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Tue, Jul 15, 2025 at 2:07=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > This adds initial documentation for ISO sockets.
> > > ---
> > >  Makefile.am |   8 +-
> > >  doc/iso.rst | 436 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 441 insertions(+), 3 deletions(-)
> > >  create mode 100644 doc/iso.rst
> > >
> > > diff --git a/Makefile.am b/Makefile.am
> > > index c4b88d83c962..8319373409cd 100644
> > > --- a/Makefile.am
> > > +++ b/Makefile.am
> > > @@ -356,7 +356,7 @@ CLEANFILES +=3D $(builtin_files)
> > >
> > >  if MANPAGES
> > >  man_MANS +=3D src/bluetoothd.8
> > > -man_MANS +=3D doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.=
7
> > > +man_MANS +=3D doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.=
7 doc/iso.7
> > >  man_MANS +=3D doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
> > >                 doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.=
5 \
> > >                 doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 =
\
> > > @@ -390,7 +390,8 @@ man_MANS +=3D doc/org.bluez.obex.Client.5 doc/org=
.bluez.obex.Session.5 \
> > >                 doc/org.bluez.obex.Image.5
> > >  endif
> > >  manual_pages +=3D src/bluetoothd.8
> > > -manual_pages +=3D doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/=
sco.7
> > > +manual_pages +=3D doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/=
sco.7 \
> > > +               doc/iso.7
> > >  manual_pages +=3D doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
> > >                 doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.=
5 \
> > >                 doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 =
\
> > > @@ -467,7 +468,8 @@ EXTRA_DIST +=3D doc/assigned-numbers.txt doc/supp=
orted-features.txt \
> > >  EXTRA_DIST +=3D doc/health-api.txt \
> > >                 doc/sap-api.txt
> > >
> > > -EXTRA_DIST +=3D doc/hci.rst doc/mgmt.rst doc/l2cap.rst doc/rfcomm.rs=
t doc/sco.rst
> > > +EXTRA_DIST +=3D doc/hci.rst doc/mgmt.rst doc/l2cap.rst doc/rfcomm.rs=
t \
> > > +             doc/sco.rst doc/iso.rst
> > >
> > >  EXTRA_DIST +=3D doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
> > >                 doc/org.bluez.DeviceSet.rst doc/org.bluez.AgentManage=
r.rst \
> > > diff --git a/doc/iso.rst b/doc/iso.rst
> > > new file mode 100644
> > > index 000000000000..d08b60d20865
> > > --- /dev/null
> > > +++ b/doc/iso.rst
> > > @@ -0,0 +1,436 @@
> > > +=3D=3D=3D
> > > +iso
> > > +=3D=3D=3D
> > > +-------------
> > > +ISO transport
> > > +-------------
> > > +
> > > +:Version: BlueZ
> > > +:Copyright: Free use of this software is granted under the terms of =
the GNU
> > > +            Lesser General Public Licenses (LGPL).
> > > +:Date: July 2025
> > > +:Manual section: 7
> > > +:Manual group: Linux System Administration
> > > +
> > > +SYNOPSIS (since Linux 6.0 [experimental])
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +.. code-block::
> > > +
> > > +    #include <sys/socket.h>
> > > +    #include <bluetooth/bluetooth.h>
> > > +    #include <bluetooth/iso.h>
> > > +
> > > +    iso_socket =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO)=
;
> > > +
> > > +DESCRIPTION
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Bluetooth Isochronous Channels is a feature introduced in Bluetooth =
5.2 that
> > > +allow for the transmission of multiple, synchronized audio streams b=
etween
> > > +devices.
> > > +
> > > +For unicast/multi-stream audio, connected isochronous group (CIG), a=
nd
> > > +connected isochronous stream (CIS) are used. A CIG is created by the=
 central and
> > > +it can include one or more CISs. A CIS is a point-to-point data tran=
sportation
> > > +stream between a central and a certain peripheral, and is a bidirect=
ional
> > > +communication protocol with acknowledgment.
> > > +
> > > +For broadcast audio, broadcast isochronous group (BIG) and broadcast=
 isochronous
> > > +stream (BIS) are used. There are two types of devices: isochronous b=
roadcaster
> > > +and synchronized receiver. A BIG is created by an isochronous broadc=
aster, and
> > > +it can include one or more BISs. A BIS is a one-to-many data transpo=
rtation
> > > +stream.
> > > +
> > > +SOCKET ADDRESS
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +.. code-block::
> > > +
> > > +    struct sockaddr_iso_bc {
> > > +        bdaddr_t       bc_bdaddr;
> > > +        uint8_t                bc_bdaddr_type;
> > > +        uint8_t                bc_sid;
> > > +        uint8_t                bc_num_bis;
> > > +        uint8_t                bc_bis[ISO_MAX_NUM_BIS];
> > > +    };
> > > +
> > > +    struct sockaddr_iso {
> > > +        sa_family_t     iso_family;
> > > +        bdaddr_t        iso_bdaddr;
> > > +        uint8_t                iso_bdaddr_type;
> > > +        struct sockaddr_iso_bc iso_bc[];
> > > +    };
> > > +
> > > +Unicast example:
> > > +
> > > +.. code-block::
> > > +
> > > +    struct sockaddr_iso addr;
> > > +
> > > +    memset(&addr, 0, sizeof(addr));
> > > +    addr.iso_family =3D AF_BLUETOOTH;
> > > +    bacpy(&addr.iso_bdaddr, bdaddr);
> > > +    addr.iso_bdaddr_type =3D BDADDR_LE_PUBLIC;
> > > +
> > > +Broadcast example:
> > > +
> > > +.. code-block::
> > > +
> > > +    struct sockaddr_iso *addr;
> > > +    size_t addr_len;
> > > +
> > > +    addr_len =3D sizeof(*addr) + sizeof(*addr->iso_bc);
> > > +
> > > +    memset(addr, 0, addr_len);
> > > +    addr->iso_family =3D AF_BLUETOOTH;
> > > +    bacpy(&addr->iso_bdaddr, bdaddr);
> > > +    addr->iso_bdaddr_type =3D BDADDR_LE_PUBLIC;
> > > +
> > > +Broadcast Source (Broadcaster) example:
> > > +
> > > +.. code-block::
> > > +
> > > +    struct sockaddr_iso *addr;
> > > +    size_t addr_len;
> > > +
> > > +    addr_len =3D sizeof(*addr) + sizeof(*addr->iso_bc);
> > > +
> > > +    memset(addr, 0, addr_len);
> > > +    addr->iso_family =3D AF_BLUETOOTH;
> > > +
> > > +    /* Set address to BDADR_ANY(00:00:00:00:00:00) */
> > > +    bacpy(&addr->iso_bdaddr, BADDR_ANY);
> > > +    addr->iso_bdaddr_type =3D BDADDR_LE_PUBLIC;
> > > +
> > > +    /* Connect to Broadcast address */
> > > +    connect(iso_socket, (struct sockaddr *)addr, addr_len);
> > > +
> > > +Broadcast Sink (Receiver) example:
> > > +
> > > +.. code-block::
> > > +
> > > +    struct sockaddr_iso *addr;
> > > +    size_t addr_len;
> > > +
> > > +    addr_len =3D sizeof(*addr) + sizeof(*addr->iso_bc);
> > > +
> > > +    memset(addr, 0, addr_len);
> > > +    addr->iso_family =3D AF_BLUETOOTH;
> > > +
> > > +    /* Set destination to Broadcaster address */
> > > +    bacpy(&addr->iso_bdaddr, bdaddr);
> > > +    addr->iso_bdaddr_type =3D BDADDR_LE_PUBLIC;
> > > +
> > > +    /* Bind to Broadcaster address */
> > > +    bind(iso_socket, (struct sockaddr *)addr, addr_len);
> > > +
> > > +SOCKET OPTIONS (SOL_BLUETOOTH)
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +The socket options listed below can be set by using **setsockopt(2)*=
* and read
> > > +with **getsockopt(2)** with the socket level set to SOL_BLUETOOTH.
> > > +
> > > +BT_SECURITY
> > > +-----------
> > > +
> > > +Channel security level, possible values:
> > > +
> > > +.. csv-table::
> > > +    :header: "Value", "Security Level", "Link Key Type", "Encryption=
"
> > > +    :widths: auto
> > > +
> > > +    **BT_SECURITY_SDP**, 0 (SDP Only), None, Not required
> > > +    **BT_SECURITY_LOW**, 1 (Low), Unauthenticated, Not required
> > > +    **BT_SECURITY_MEDIUM**, 2 (Medium - default), Unauthenticated, D=
esired
> > > +    **BT_SECURITY_HIGH**, 3 (High), Authenticated, Required
> > > +    **BT_SECURITY_FIPS** (since Linux 3.15), 4 (Secure Only), Authen=
ticated (P-256 based Secure Simple Pairing and Secure Authentication), Requ=
ired
> > > +
> > > +Example:
> > > +
> > > +.. code-block::
> > > +
> > > +    int level =3D BT_SECURITY_HIGH;
> > > +    int err =3D setsockopt(iso_socket, SOL_BLUETOOTH, BT_SECURITY, &=
level,
> > > +                         sizeof(level));
> > > +    if (err =3D=3D -1) {
> > > +        perror("setsockopt");
> > > +        return 1;
> > > +    }
> > > +
> > > +BT_DEFER_SETUP
> > > +--------------
> > > +
> > > +Channel defer connection setup, this control if the connection proce=
dure
> > > +needs to be authorized by userspace before responding which allows
> > > +authorization at profile level, possible values:
> > > +
> > > +.. csv-table::
> > > +    :header: "Value", "Description", "Authorization"
> > > +    :widths: auto
> > > +
> > > +    **0**, Disable (default), Not required
> > > +    **1**, Enable, Required
> > > +
> > > +Example:
> > > +
> > > +.. code-block::
> > > +
> > > +    int defer_setup =3D 1;
> > > +    int err =3D setsockopt(iso_socket, SOL_BLUETOOTH, BT_DEFER_SETUP=
,
> > > +                         &defer_setup, sizeof(defer_setup));
> > > +    if (err =3D=3D -1) {
> > > +        perror("setsockopt");
> > > +        return err;
> > > +    }
> > > +
> > > +    err =3D listen(iso_socket, 5);
> > > +    if (err) {
> > > +        perror("listen");
> > > +        return err;
> > > +    }
> > > +
> > > +    struct sockaddr_iso remote_addr =3D {0};
> > > +    socklen_t addr_len =3D sizeof(remote_addr);
> > > +    int new_socket =3D accept(iso_socket, (struct sockaddr*)&remote_=
addr,
> > > +                            &addr_len);
> > > +    if (new_socket < 0) {
> > > +        perror("accept");
> > > +        return new_socket;
> > > +    }
> > > +
> > > +    /* To complete the connection setup of new_socket read 1 byte */
> > > +    char c;
> > > +    struct pollfd pfd;
> > > +
> > > +    memset(&pfd, 0, sizeof(pfd));
> > > +    pfd.fd =3D new_socket;
> > > +    pfd.events =3D POLLOUT;
> > > +
> > > +    err =3D poll(&pfd, 1, 0);
> > > +    if (err) {
> > > +        perror("poll");
> > > +        return err;
> > > +    }
> > > +
> > > +    if (!(pfd.revents & POLLOUT)) {
> > > +        err =3D read(sk, &c, 1);
> > > +        if (err < 0) {
> > > +            perror("read");
> > > +            return err;
> > > +        }
> > > +    }
> > > +
> > > +BT_PKT_STATUS
> > > +-------------
> > > +
> > > +Enable reporting packet status via `BT_SCM_PKT_STATUS` CMSG on
> > > +received packets.  Possible values:
> > > +
> > > +.. csv-table::
> > > +    :header: "Value", "Description"
> > > +    :widths: auto
> > > +
> > > +    **0**, Disable (default)
> > > +    **1**, Enable
> > > +
> > > +
> > > +:BT_SCM_PKT_STATUS:
> > > +
> > > +    Level ``SOL_BLUETOOTH`` CMSG with data::
> > > +
> > > +        uint8_t pkt_status;
> > > +
> > > +    The values are equal to the "Packet_Status_Flag" defined in
> > > +    Core Specification v6.1, 5.4.5. HCI ISO Data packets:
> > > +
> > > +    https://www.bluetooth.com/wp-content/uploads/Files/Specification=
/HTML/Core-61/out/en/host-controller-interface/host-controller-interface-fu=
nctional-specification.html#UUID-9b5fb085-278b-5084-ac33-bee2839abe6b
> > > +
> > > +    .. csv-table::
> > > +        :header: "pkt_status", "Description"
> > > +        :widths: auto
> > > +
> > > +        **0x0**, Valid data. The complete SDU was received correctly=
.
> > > +        **0x1**, Possibly invalid data. The contents of the ISO_SDU_=
Fragment
> > > +       , may contain errors or part of the SDU may be missing.
> > > +       , This is reported as "data with possible errors".
> > > +        **0x2**, Part(s) of the SDU were not received correctly.
> > > +       , This is reported as "lost data".
> > > +
> > > +SOCKET OPTIONS (SOL_SOCKET)
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > +
> > > +``SOL_SOCKET`` level socket options that modify generic socket
> > > +features (``SO_SNDBUF``, ``SO_RCVBUF``, etc.) have their usual
> > > +meaning, see **socket(7)**.
> > > +
> > > +The ``SOL_SOCKET`` level ISO socket options that have
> > > +Bluetooth-specific handling in kernel are listed below.
> > > +
> > > +SO_TIMESTAMPING, SO_TIMESTAMP, SO_TIMESTAMPNS
> > > +---------------------------------------------
> > > +
> > > +See https://docs.kernel.org/networking/timestamping.html
> > > +
> > > +For ISO sockets, software RX timestamps are supported.  Software TX
> > > +timestamps (SOF_TIMESTAMPING_TX_SOFTWARE) are supported since
> > > +Linux 6.15.
> > > +
> > > +The software RX timestamp is the time when the kernel received the
> > > +packet from the controller driver.
> > > +
> > > +The ``SCM_TSTAMP_SND`` timestamp is emitted when packet is sent to t=
he
> > > +controller driver.
> > > +
> > > +The ``SCM_TSTAMP_COMPLETION`` timestamp is emitted when controller
> > > +reports the packet completed.  Completion timestamps are only
> > > +supported on controllers that have ISO flow control.
> > >
>
> Completion timestamps are always available for ISO, as currently kernel
> only does flow-controlled ISO.
>
> > >   Other TX
> > > +timestamp types are not supported.
> > > +
> > > +You can use ``SIOCETHTOOL`` to query supported flags.
> > > +
> > > +The timestamps are in ``CLOCK_REALTIME`` time.
> > > +
> > > +Example (Enable RX timestamping):
> > > +
> > > +.. code-block::
> > > +
> > > +   int flags =3D SOF_TIMESTAMPING_SOFTWARE |
> > > +       SOF_TIMESTAMPING_RX_SOFTWARE;
> > > +   setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags)=
);
> > > +
> > > +Example (Read packet and its RX timestamp):
> > > +
> > > +.. code-block::
> > > +
> > > +   char data_buf[256];
> > > +   union {
> > > +       char buf[CMSG_SPACE(sizeof(struct scm_timestamping))];
> > > +       struct cmsghdr align;
> > > +   } control;
> > > +   struct iovec data =3D {
> > > +       .iov_base =3D data_buf,
> > > +       .iov_len =3D sizeof(data_buf),
> > > +   };
> > > +   struct msghdr msg =3D {
> > > +       .msg_iov =3D &data,
> > > +       .msg_iovlen =3D 1,
> > > +       .msg_control =3D control.buf,
> > > +       .msg_controllen =3D sizeof(control.buf),
> > > +   };
> > > +   struct scm_timestamping tss;
> > > +
> > > +   res =3D recvmsg(fd, &msg, MSG_ERRQUEUE | MSG_DONTWAIT);
> > > +   if (res < 0)
> > > +       goto error;
> > > +
> > > +   for (cmsg =3D CMSG_FIRSTHDR(&msg); cmsg; cmsg =3D CMSG_NXTHDR(&ms=
g, cmsg)) {
> > > +       if (cmsg->cmsg_level =3D=3D SOL_SOCKET && cmsg->cmsg_type =3D=
=3D SCM_TIMESTAMPING)
> > > +           memcpy(&tss, CMSG_DATA(cmsg), sizeof(tss));
> > > +   }
> > > +
> > > +   tstamp_clock_realtime =3D tss.ts[0];
> > > +
> > > +Example (Enable TX timestamping):
> > > +
> > > +.. code-block::
> > > +
> > > +   int flags =3D SOF_TIMESTAMPING_SOFTWARE |
> > > +       SOF_TIMESTAMPING_TX_SOFTWARE |
> > > +       SOF_TIMESTAMPING_OPT_ID;
> > > +   setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags)=
);
> > > +
> > > +Example (Read TX timestamps):
> > > +
> > > +.. code-block::
> > > +
> > > +   union {
> > > +       char buf[CMSG_SPACE(sizeof(struct scm_timestamping))];
> > > +       struct cmsghdr align;
> > > +   } control;
> > > +   struct iovec data =3D {
> > > +       .iov_base =3D NULL,
> > > +       .iov_len =3D 0
> > > +   };
> > > +   struct msghdr msg =3D {
> > > +       .msg_iov =3D &data,
> > > +       .msg_iovlen =3D 1,
> > > +       .msg_control =3D control.buf,
> > > +       .msg_controllen =3D sizeof(control.buf),
> > > +   };
> > > +   struct cmsghdr *cmsg;
> > > +   struct scm_timestamping tss;
> > > +   struct sock_extended_err serr;
> > > +   int res;
> > > +
> > > +   res =3D recvmsg(fd, &msg, MSG_ERRQUEUE | MSG_DONTWAIT);
> > > +   if (res < 0)
> > > +       goto error;
> > > +
> > > +   for (cmsg =3D CMSG_FIRSTHDR(&msg); cmsg; cmsg =3D CMSG_NXTHDR(&ms=
g, cmsg)) {
> > > +       if (cmsg->cmsg_level =3D=3D SOL_SOCKET && cmsg->cmsg_type =3D=
=3D SCM_TIMESTAMPING)
> > > +           memcpy(&tss, CMSG_DATA(cmsg), sizeof(tss));
> > > +       else if (cmsg->cmsg_level =3D=3D SOL_BLUETOOTH && cmsg->cmsg_=
type =3D=3D BT_SCM_ERROR)
> > > +           memcpy(&serr, CMSG_DATA(cmsg), sizeof(serr));
> > > +   }
> > > +
> > > +   tstamp_clock_realtime =3D tss.ts[0];
> > > +   tstamp_type =3D serr->ee_info;      /* SCM_TSTAMP_SND or SCM_TSTA=
MP_COMPLETION */
> > > +   tstamp_seqnum =3D serr->ee_data;
> > > +
> > > +
> > > +IOCTLS
> > > +=3D=3D=3D=3D=3D=3D
> > > +
> > > +The following ioctls with operation specific for ISO sockets are
> > > +available.
> > > +
> > > +SIOCETHTOOL (since Linux 6.16-rc1)
> > > +----------------------------------
> > > +
> > > +Supports only command `ETHTOOL_GET_TS_INFO`, which may be used to
> > > +query supported `SOF_TIMESTAMPING_*` flags.  The
> > > +`SOF_TIMESTAMPING_OPT_*` flags are always available as applicable.
> > > +
> > > +Example:
> > > +
> > > +.. code-block::
> > > +
> > > +   #include <linux/ethtool.h>
> > > +   #include <linux/sockios.h>
> > > +   #include <net/if.h>
> > > +   #include <sys/socket.h>
> > > +   #include <sys/ioctl.h>
> > > +
> > > +   ...
> > > +
> > > +   struct ifreq ifr =3D {};
> > > +   struct ethtool_ts_info cmd =3D {};
> > > +   int sk;
> > > +
> > > +   snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "hci0");
> > > +   ifr.ifr_data =3D (void *)&cmd;
> > > +   cmd.cmd =3D ETHTOOL_GET_TS_INFO;
> > > +
> > > +   sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO);
> > > +   if (sk < 0)
> > > +       goto error;
> > > +   if (ioctl(sk, SIOCETHTOOL, &ifr))
> > > +       goto error;
> > > +
> > > +   sof_available =3D cmd.so_timestamping;
> > > +
> > > +RESOURCES
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +http://www.bluez.org
> > > +
> > > +REPORTING BUGS
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +linux-bluetooth@vger.kernel.org
> > > +
> > > +SEE ALSO
> > > +=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +socket(7), isotest(1)
> > > --
> > > 2.50.0
> > >
> >
> > Have a look if the above makes sense, I didn't include BT_PKT_SEQNUM
> > since that is sort of new, but if you feel that should be included
> > from the start I just need an example to go with it.
>
> Looks right to me. BT_PKT_SEQNUM if added would be like

Thanks for looking into it.

> BT_PKT_SEQNUM
> -------------
>
> Enable reporting packet ISO sequence number via `BT_SCM_PKT_SEQNUM`
> CMSG on received packets.  Possible values:
>
> .. csv-table::
>     :header: "Value", "Description"
>     :widths: auto
>
>     **0**, Disable (default)
>     **1**, Enable
>
>
> :BT_SCM_PKT_SEQNUM:
>
>     Level ``SOL_BLUETOOTH`` CMSG with data::
>
>         uint16_t pkt_seqnum;
>
>     The values are equal to the "Packet_Sequence_Number" defined in
>     Core Specification v6.1, 5.4.5. HCI ISO Data packets:
>
>     https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML=
/Core-61/out/en/host-controller-interface/host-controller-interface-functio=
nal-specification.html#UUID-9b5fb085-278b-5084-ac33-bee2839abe6b
>
> Example (Enable sequence numbers):
>
> .. code-block::
>
>     uint32_t opt =3D 1;
>     if (setsockopt(fd, SOL_BLUETOOTH, BT_PKT_SEQNUM, &opt, sizeof(opt)) <=
 0)
>         goto error;
>
> Example (Read packet and its sequence number):
>
> .. code-block::
>
>    char data_buf[256];
>    uint16_t seqnum;
>    union {
>        char buf[CMSG_SPACE(sizeof(uint16_t))];
>        struct cmsghdr align;
>    } control;
>    struct iovec data =3D {
>        .iov_base =3D data_buf,
>        .iov_len =3D sizeof(data_buf),
>    };
>    struct msghdr msg =3D {
>        .msg_iov =3D &data,
>        .msg_iovlen =3D 1,
>        .msg_control =3D control.buf,
>        .msg_controllen =3D sizeof(control.buf),
>    };
>    struct scm_timestamping tss;
>
>    res =3D recvmsg(fd, &msg, 0);
>    if (res < 0)
>        goto error;
>
>    for (cmsg =3D CMSG_FIRSTHDR(&msg); cmsg; cmsg =3D CMSG_NXTHDR(&msg, cm=
sg)) {
>        if (cmsg->cmsg_level =3D=3D SOL_BLUETOOTH && cmsg->cmsg_type =3D=
=3D BT_PKT_SEQNUM)
>            memcpy(&seqnum, CMSG_DATA(cmsg), sizeof(seqnum));
>    }

I think I will wait until it has made it into Linus tree in the next
merge window, so we avoid having to remove it later if there is
something that blocks it for some reason since we already experienced
something like that before.

> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
