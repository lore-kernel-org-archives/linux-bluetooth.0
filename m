Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB38633F
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752608982; cv=pass; b=geLeee0aadikwjmfMe6D8Xv89ZbzZmNpUV8Mmzu1yPE2it07UxMfsGWgBiwMOx2Gl1JKtWFIZYgv/rIHbY9oGcehzbeSQ6PzbdXLb2+eX2sXT422VQcP/bVkVJDxF5P77wST0zqWRXyPg7meWvVhj5K25uiIfARvQf1LEKXGLJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752608982; c=relaxed/simple;
	bh=Gy18ll0753o/FM5YGCjr4YPqiRQzUD8SQA07sO/2Kts=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kRpZOXYYEnZL1bD8jZTMIHmaYFFvfSwxNKY/8JmMQi1QPELCz+1A0n2levWf6w0KLHB+CymGQMzfyKZmbBz2tJaWj+5/8pN1rVJk+PTC3d8RpTCZ879m//KO0llESRj+FTKnnPBhpuKDMoYTs0aJVZMi/RaEZyueXoeIl9Q5zm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=c/7lQ8oB; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="c/7lQ8oB"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bhVBW2HMyz49QJY;
	Tue, 15 Jul 2025 22:49:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1752608963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+pB0GVTaeJ4MkI2sIvhi0pUR0LnJs9p6imNUtZ7Qh1Q=;
	b=c/7lQ8oBiBmfXYEK4JcwdLws2Jy/+3QDIhpG3VzjPqm9tRzocsR46TasTqh8Az5jPEWNAN
	SHwMKBF7sTeA61UH1p5qGymB2SisamIL9t/SRE2iH4uoi3CnLYR8LIshFSfS4nUaljfUwM
	oQ72j2cDMhYGmpH46BDH51JtxUyzZImXnR3o0z0HtcQBEQrk/k7hw94YNIJtNCxYS9xNUy
	zNuLBdNmVZuwXKGzyKcM6yzP9lPyTzkrFExt6Tmg+qA7p5/Bax5f1vO6/bHCTraFImvL/B
	6ZM3WZnbLGC3IsO7tozYEK0Mp6jiTQzZA6yRu4unlV0B87S/1aZoNW7ABlKnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1752608963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+pB0GVTaeJ4MkI2sIvhi0pUR0LnJs9p6imNUtZ7Qh1Q=;
	b=t5tu1j7WB3yMtyCjAw8kO717+j4ahEAJVNeB7ZTcp1CgRNmIHT1+yoWs8KjNzJbiRToVIW
	ynbRL++k2aOjI4y7D8QX5pxlMxtzx60mWOHVL3vAb/s7nwOxsq9ObZAh430fwMa0ichhZ9
	21DfqGWSi1n10i2DWN7CduNCTNnOEq2FuMrk5IJES6kaT0wRtj1bJ3/Qd21qMuVPX0nCrV
	ZmbXP6JYTq8jcwCHlqmcEMt8oRfVNgtqX4VIugQITcGQiHfZY6OSk6KBA7LWzI8hjCe+BF
	/2cp3vpj7+qxcH8lIoLLOqGiCAE94XqPBgBSN+6q2kYuRGuHBUeK7QJB+lQ8yA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1752608963; a=rsa-sha256;
	cv=none;
	b=LJgE/x99wpuYbenCq2BLdVkIzWGMTZvOY/hJo9mb/ZgnH8umKCAfS+YzcpsAO6cvXTpuTE
	99J3Spsvh236t2L+IFrxv6ubFHtq8dz0VUdzA3CwjyymiWg/Wup9AdA+25ETX0wm+Q4efF
	ePimBg4C35OUZ/DVEUWsiopox8JqFgGDOdc1SVsx8nkY7Ml2L9FAPDgi+hTEXsO4sXLho8
	kuxDXRBZhJMzq37aNCFUj0crXQ2QrSCHx1mQK5RZfRIWCQlNgIbSZ86JQpFamWra4rYBpp
	cfPP9kr96AITEykm7JCaN4DSBQDfG0y466KiV69cD2ku4v6zb4bZ8kI1euW3Sg==
Message-ID: <a27c264f3b5e8122f508c7a5a110bfc214658d71.camel@iki.fi>
Subject: Re: [PATCH BlueZ v1] doc: Add initial ISO(7) documentation
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 15 Jul 2025 22:49:22 +0300
In-Reply-To: <CABBYNZJUKs5bdVa0xYqKsfa7EOs=UXrCZD-QKigfu_Lpf72i+g@mail.gmail.com>
References: <20250715180747.670323-1-luiz.dentz@gmail.com>
	 <CABBYNZJUKs5bdVa0xYqKsfa7EOs=UXrCZD-QKigfu_Lpf72i+g@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ti, 2025-07-15 kello 14:17 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Tue, Jul 15, 2025 at 2:07=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >=20
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >=20
> > This adds initial documentation for ISO sockets.
> > ---
> >  Makefile.am |   8 +-
> >  doc/iso.rst | 436 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 441 insertions(+), 3 deletions(-)
> >  create mode 100644 doc/iso.rst
> >=20
> > diff --git a/Makefile.am b/Makefile.am
> > index c4b88d83c962..8319373409cd 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -356,7 +356,7 @@ CLEANFILES +=3D $(builtin_files)
> >=20
> >  if MANPAGES
> >  man_MANS +=3D src/bluetoothd.8
> > -man_MANS +=3D doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7
> > +man_MANS +=3D doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 =
doc/iso.7
> >  man_MANS +=3D doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
> >                 doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 =
\
> >                 doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
> > @@ -390,7 +390,8 @@ man_MANS +=3D doc/org.bluez.obex.Client.5 doc/org.b=
luez.obex.Session.5 \
> >                 doc/org.bluez.obex.Image.5
> >  endif
> >  manual_pages +=3D src/bluetoothd.8
> > -manual_pages +=3D doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sc=
o.7
> > +manual_pages +=3D doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sc=
o.7 \
> > +               doc/iso.7
> >  manual_pages +=3D doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
> >                 doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 =
\
> >                 doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
> > @@ -467,7 +468,8 @@ EXTRA_DIST +=3D doc/assigned-numbers.txt doc/suppor=
ted-features.txt \
> >  EXTRA_DIST +=3D doc/health-api.txt \
> >                 doc/sap-api.txt
> >=20
> > -EXTRA_DIST +=3D doc/hci.rst doc/mgmt.rst doc/l2cap.rst doc/rfcomm.rst =
doc/sco.rst
> > +EXTRA_DIST +=3D doc/hci.rst doc/mgmt.rst doc/l2cap.rst doc/rfcomm.rst =
\
> > +             doc/sco.rst doc/iso.rst
> >=20
> >  EXTRA_DIST +=3D doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
> >                 doc/org.bluez.DeviceSet.rst doc/org.bluez.AgentManager.=
rst \
> > diff --git a/doc/iso.rst b/doc/iso.rst
> > new file mode 100644
> > index 000000000000..d08b60d20865
> > --- /dev/null
> > +++ b/doc/iso.rst
> > @@ -0,0 +1,436 @@
> > +=3D=3D=3D
> > +iso
> > +=3D=3D=3D
> > +-------------
> > +ISO transport
> > +-------------
> > +
> > +:Version: BlueZ
> > +:Copyright: Free use of this software is granted under the terms of th=
e GNU
> > +            Lesser General Public Licenses (LGPL).
> > +:Date: July 2025
> > +:Manual section: 7
> > +:Manual group: Linux System Administration
> > +
> > +SYNOPSIS (since Linux 6.0 [experimental])
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +.. code-block::
> > +
> > +    #include <sys/socket.h>
> > +    #include <bluetooth/bluetooth.h>
> > +    #include <bluetooth/iso.h>
> > +
> > +    iso_socket =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO);
> > +
> > +DESCRIPTION
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Bluetooth Isochronous Channels is a feature introduced in Bluetooth 5.=
2 that
> > +allow for the transmission of multiple, synchronized audio streams bet=
ween
> > +devices.
> > +
> > +For unicast/multi-stream audio, connected isochronous group (CIG), and
> > +connected isochronous stream (CIS) are used. A CIG is created by the c=
entral and
> > +it can include one or more CISs. A CIS is a point-to-point data transp=
ortation
> > +stream between a central and a certain peripheral, and is a bidirectio=
nal
> > +communication protocol with acknowledgment.
> > +
> > +For broadcast audio, broadcast isochronous group (BIG) and broadcast i=
sochronous
> > +stream (BIS) are used. There are two types of devices: isochronous bro=
adcaster
> > +and synchronized receiver. A BIG is created by an isochronous broadcas=
ter, and
> > +it can include one or more BISs. A BIS is a one-to-many data transport=
ation
> > +stream.
> > +
> > +SOCKET ADDRESS
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +.. code-block::
> > +
> > +    struct sockaddr_iso_bc {
> > +        bdaddr_t       bc_bdaddr;
> > +        uint8_t                bc_bdaddr_type;
> > +        uint8_t                bc_sid;
> > +        uint8_t                bc_num_bis;
> > +        uint8_t                bc_bis[ISO_MAX_NUM_BIS];
> > +    };
> > +
> > +    struct sockaddr_iso {
> > +        sa_family_t     iso_family;
> > +        bdaddr_t        iso_bdaddr;
> > +        uint8_t                iso_bdaddr_type;
> > +        struct sockaddr_iso_bc iso_bc[];
> > +    };
> > +
> > +Unicast example:
> > +
> > +.. code-block::
> > +
> > +    struct sockaddr_iso addr;
> > +
> > +    memset(&addr, 0, sizeof(addr));
> > +    addr.iso_family =3D AF_BLUETOOTH;
> > +    bacpy(&addr.iso_bdaddr, bdaddr);
> > +    addr.iso_bdaddr_type =3D BDADDR_LE_PUBLIC;
> > +
> > +Broadcast example:
> > +
> > +.. code-block::
> > +
> > +    struct sockaddr_iso *addr;
> > +    size_t addr_len;
> > +
> > +    addr_len =3D sizeof(*addr) + sizeof(*addr->iso_bc);
> > +
> > +    memset(addr, 0, addr_len);
> > +    addr->iso_family =3D AF_BLUETOOTH;
> > +    bacpy(&addr->iso_bdaddr, bdaddr);
> > +    addr->iso_bdaddr_type =3D BDADDR_LE_PUBLIC;
> > +
> > +Broadcast Source (Broadcaster) example:
> > +
> > +.. code-block::
> > +
> > +    struct sockaddr_iso *addr;
> > +    size_t addr_len;
> > +
> > +    addr_len =3D sizeof(*addr) + sizeof(*addr->iso_bc);
> > +
> > +    memset(addr, 0, addr_len);
> > +    addr->iso_family =3D AF_BLUETOOTH;
> > +
> > +    /* Set address to BDADR_ANY(00:00:00:00:00:00) */
> > +    bacpy(&addr->iso_bdaddr, BADDR_ANY);
> > +    addr->iso_bdaddr_type =3D BDADDR_LE_PUBLIC;
> > +
> > +    /* Connect to Broadcast address */
> > +    connect(iso_socket, (struct sockaddr *)addr, addr_len);
> > +
> > +Broadcast Sink (Receiver) example:
> > +
> > +.. code-block::
> > +
> > +    struct sockaddr_iso *addr;
> > +    size_t addr_len;
> > +
> > +    addr_len =3D sizeof(*addr) + sizeof(*addr->iso_bc);
> > +
> > +    memset(addr, 0, addr_len);
> > +    addr->iso_family =3D AF_BLUETOOTH;
> > +
> > +    /* Set destination to Broadcaster address */
> > +    bacpy(&addr->iso_bdaddr, bdaddr);
> > +    addr->iso_bdaddr_type =3D BDADDR_LE_PUBLIC;
> > +
> > +    /* Bind to Broadcaster address */
> > +    bind(iso_socket, (struct sockaddr *)addr, addr_len);
> > +
> > +SOCKET OPTIONS (SOL_BLUETOOTH)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The socket options listed below can be set by using **setsockopt(2)** =
and read
> > +with **getsockopt(2)** with the socket level set to SOL_BLUETOOTH.
> > +
> > +BT_SECURITY
> > +-----------
> > +
> > +Channel security level, possible values:
> > +
> > +.. csv-table::
> > +    :header: "Value", "Security Level", "Link Key Type", "Encryption"
> > +    :widths: auto
> > +
> > +    **BT_SECURITY_SDP**, 0 (SDP Only), None, Not required
> > +    **BT_SECURITY_LOW**, 1 (Low), Unauthenticated, Not required
> > +    **BT_SECURITY_MEDIUM**, 2 (Medium - default), Unauthenticated, Des=
ired
> > +    **BT_SECURITY_HIGH**, 3 (High), Authenticated, Required
> > +    **BT_SECURITY_FIPS** (since Linux 3.15), 4 (Secure Only), Authenti=
cated (P-256 based Secure Simple Pairing and Secure Authentication), Requir=
ed
> > +
> > +Example:
> > +
> > +.. code-block::
> > +
> > +    int level =3D BT_SECURITY_HIGH;
> > +    int err =3D setsockopt(iso_socket, SOL_BLUETOOTH, BT_SECURITY, &le=
vel,
> > +                         sizeof(level));
> > +    if (err =3D=3D -1) {
> > +        perror("setsockopt");
> > +        return 1;
> > +    }
> > +
> > +BT_DEFER_SETUP
> > +--------------
> > +
> > +Channel defer connection setup, this control if the connection procedu=
re
> > +needs to be authorized by userspace before responding which allows
> > +authorization at profile level, possible values:
> > +
> > +.. csv-table::
> > +    :header: "Value", "Description", "Authorization"
> > +    :widths: auto
> > +
> > +    **0**, Disable (default), Not required
> > +    **1**, Enable, Required
> > +
> > +Example:
> > +
> > +.. code-block::
> > +
> > +    int defer_setup =3D 1;
> > +    int err =3D setsockopt(iso_socket, SOL_BLUETOOTH, BT_DEFER_SETUP,
> > +                         &defer_setup, sizeof(defer_setup));
> > +    if (err =3D=3D -1) {
> > +        perror("setsockopt");
> > +        return err;
> > +    }
> > +
> > +    err =3D listen(iso_socket, 5);
> > +    if (err) {
> > +        perror("listen");
> > +        return err;
> > +    }
> > +
> > +    struct sockaddr_iso remote_addr =3D {0};
> > +    socklen_t addr_len =3D sizeof(remote_addr);
> > +    int new_socket =3D accept(iso_socket, (struct sockaddr*)&remote_ad=
dr,
> > +                            &addr_len);
> > +    if (new_socket < 0) {
> > +        perror("accept");
> > +        return new_socket;
> > +    }
> > +
> > +    /* To complete the connection setup of new_socket read 1 byte */
> > +    char c;
> > +    struct pollfd pfd;
> > +
> > +    memset(&pfd, 0, sizeof(pfd));
> > +    pfd.fd =3D new_socket;
> > +    pfd.events =3D POLLOUT;
> > +
> > +    err =3D poll(&pfd, 1, 0);
> > +    if (err) {
> > +        perror("poll");
> > +        return err;
> > +    }
> > +
> > +    if (!(pfd.revents & POLLOUT)) {
> > +        err =3D read(sk, &c, 1);
> > +        if (err < 0) {
> > +            perror("read");
> > +            return err;
> > +        }
> > +    }
> > +
> > +BT_PKT_STATUS
> > +-------------
> > +
> > +Enable reporting packet status via `BT_SCM_PKT_STATUS` CMSG on
> > +received packets.  Possible values:
> > +
> > +.. csv-table::
> > +    :header: "Value", "Description"
> > +    :widths: auto
> > +
> > +    **0**, Disable (default)
> > +    **1**, Enable
> > +
> > +
> > +:BT_SCM_PKT_STATUS:
> > +
> > +    Level ``SOL_BLUETOOTH`` CMSG with data::
> > +
> > +        uint8_t pkt_status;
> > +
> > +    The values are equal to the "Packet_Status_Flag" defined in
> > +    Core Specification v6.1, 5.4.5. HCI ISO Data packets:
> > +
> > +    https://www.bluetooth.com/wp-content/uploads/Files/Specification/H=
TML/Core-61/out/en/host-controller-interface/host-controller-interface-func=
tional-specification.html#UUID-9b5fb085-278b-5084-ac33-bee2839abe6b
> > +
> > +    .. csv-table::
> > +        :header: "pkt_status", "Description"
> > +        :widths: auto
> > +
> > +        **0x0**, Valid data. The complete SDU was received correctly.
> > +        **0x1**, Possibly invalid data. The contents of the ISO_SDU_Fr=
agment
> > +       , may contain errors or part of the SDU may be missing.
> > +       , This is reported as "data with possible errors".
> > +        **0x2**, Part(s) of the SDU were not received correctly.
> > +       , This is reported as "lost data".
> > +
> > +SOCKET OPTIONS (SOL_SOCKET)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +
> > +``SOL_SOCKET`` level socket options that modify generic socket
> > +features (``SO_SNDBUF``, ``SO_RCVBUF``, etc.) have their usual
> > +meaning, see **socket(7)**.
> > +
> > +The ``SOL_SOCKET`` level ISO socket options that have
> > +Bluetooth-specific handling in kernel are listed below.
> > +
> > +SO_TIMESTAMPING, SO_TIMESTAMP, SO_TIMESTAMPNS
> > +---------------------------------------------
> > +
> > +See https://docs.kernel.org/networking/timestamping.html
> > +
> > +For ISO sockets, software RX timestamps are supported.  Software TX
> > +timestamps (SOF_TIMESTAMPING_TX_SOFTWARE) are supported since
> > +Linux 6.15.
> > +
> > +The software RX timestamp is the time when the kernel received the
> > +packet from the controller driver.
> > +
> > +The ``SCM_TSTAMP_SND`` timestamp is emitted when packet is sent to the
> > +controller driver.
> > +
> > +The ``SCM_TSTAMP_COMPLETION`` timestamp is emitted when controller
> > +reports the packet completed.  Completion timestamps are only
> > +supported on controllers that have ISO flow control.
> >=20

Completion timestamps are always available for ISO, as currently kernel
only does flow-controlled ISO.

> >   Other TX
> > +timestamp types are not supported.
> > +
> > +You can use ``SIOCETHTOOL`` to query supported flags.
> > +
> > +The timestamps are in ``CLOCK_REALTIME`` time.
> > +
> > +Example (Enable RX timestamping):
> > +
> > +.. code-block::
> > +
> > +   int flags =3D SOF_TIMESTAMPING_SOFTWARE |
> > +       SOF_TIMESTAMPING_RX_SOFTWARE;
> > +   setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));
> > +
> > +Example (Read packet and its RX timestamp):
> > +
> > +.. code-block::
> > +
> > +   char data_buf[256];
> > +   union {
> > +       char buf[CMSG_SPACE(sizeof(struct scm_timestamping))];
> > +       struct cmsghdr align;
> > +   } control;
> > +   struct iovec data =3D {
> > +       .iov_base =3D data_buf,
> > +       .iov_len =3D sizeof(data_buf),
> > +   };
> > +   struct msghdr msg =3D {
> > +       .msg_iov =3D &data,
> > +       .msg_iovlen =3D 1,
> > +       .msg_control =3D control.buf,
> > +       .msg_controllen =3D sizeof(control.buf),
> > +   };
> > +   struct scm_timestamping tss;
> > +
> > +   res =3D recvmsg(fd, &msg, MSG_ERRQUEUE | MSG_DONTWAIT);
> > +   if (res < 0)
> > +       goto error;
> > +
> > +   for (cmsg =3D CMSG_FIRSTHDR(&msg); cmsg; cmsg =3D CMSG_NXTHDR(&msg,=
 cmsg)) {
> > +       if (cmsg->cmsg_level =3D=3D SOL_SOCKET && cmsg->cmsg_type =3D=
=3D SCM_TIMESTAMPING)
> > +           memcpy(&tss, CMSG_DATA(cmsg), sizeof(tss));
> > +   }
> > +
> > +   tstamp_clock_realtime =3D tss.ts[0];
> > +
> > +Example (Enable TX timestamping):
> > +
> > +.. code-block::
> > +
> > +   int flags =3D SOF_TIMESTAMPING_SOFTWARE |
> > +       SOF_TIMESTAMPING_TX_SOFTWARE |
> > +       SOF_TIMESTAMPING_OPT_ID;
> > +   setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));
> > +
> > +Example (Read TX timestamps):
> > +
> > +.. code-block::
> > +
> > +   union {
> > +       char buf[CMSG_SPACE(sizeof(struct scm_timestamping))];
> > +       struct cmsghdr align;
> > +   } control;
> > +   struct iovec data =3D {
> > +       .iov_base =3D NULL,
> > +       .iov_len =3D 0
> > +   };
> > +   struct msghdr msg =3D {
> > +       .msg_iov =3D &data,
> > +       .msg_iovlen =3D 1,
> > +       .msg_control =3D control.buf,
> > +       .msg_controllen =3D sizeof(control.buf),
> > +   };
> > +   struct cmsghdr *cmsg;
> > +   struct scm_timestamping tss;
> > +   struct sock_extended_err serr;
> > +   int res;
> > +
> > +   res =3D recvmsg(fd, &msg, MSG_ERRQUEUE | MSG_DONTWAIT);
> > +   if (res < 0)
> > +       goto error;
> > +
> > +   for (cmsg =3D CMSG_FIRSTHDR(&msg); cmsg; cmsg =3D CMSG_NXTHDR(&msg,=
 cmsg)) {
> > +       if (cmsg->cmsg_level =3D=3D SOL_SOCKET && cmsg->cmsg_type =3D=
=3D SCM_TIMESTAMPING)
> > +           memcpy(&tss, CMSG_DATA(cmsg), sizeof(tss));
> > +       else if (cmsg->cmsg_level =3D=3D SOL_BLUETOOTH && cmsg->cmsg_ty=
pe =3D=3D BT_SCM_ERROR)
> > +           memcpy(&serr, CMSG_DATA(cmsg), sizeof(serr));
> > +   }
> > +
> > +   tstamp_clock_realtime =3D tss.ts[0];
> > +   tstamp_type =3D serr->ee_info;      /* SCM_TSTAMP_SND or SCM_TSTAMP=
_COMPLETION */
> > +   tstamp_seqnum =3D serr->ee_data;
> > +
> > +
> > +IOCTLS
> > +=3D=3D=3D=3D=3D=3D
> > +
> > +The following ioctls with operation specific for ISO sockets are
> > +available.
> > +
> > +SIOCETHTOOL (since Linux 6.16-rc1)
> > +----------------------------------
> > +
> > +Supports only command `ETHTOOL_GET_TS_INFO`, which may be used to
> > +query supported `SOF_TIMESTAMPING_*` flags.  The
> > +`SOF_TIMESTAMPING_OPT_*` flags are always available as applicable.
> > +
> > +Example:
> > +
> > +.. code-block::
> > +
> > +   #include <linux/ethtool.h>
> > +   #include <linux/sockios.h>
> > +   #include <net/if.h>
> > +   #include <sys/socket.h>
> > +   #include <sys/ioctl.h>
> > +
> > +   ...
> > +
> > +   struct ifreq ifr =3D {};
> > +   struct ethtool_ts_info cmd =3D {};
> > +   int sk;
> > +
> > +   snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "hci0");
> > +   ifr.ifr_data =3D (void *)&cmd;
> > +   cmd.cmd =3D ETHTOOL_GET_TS_INFO;
> > +
> > +   sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO);
> > +   if (sk < 0)
> > +       goto error;
> > +   if (ioctl(sk, SIOCETHTOOL, &ifr))
> > +       goto error;
> > +
> > +   sof_available =3D cmd.so_timestamping;
> > +
> > +RESOURCES
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +http://www.bluez.org
> > +
> > +REPORTING BUGS
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +linux-bluetooth@vger.kernel.org
> > +
> > +SEE ALSO
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +socket(7), isotest(1)
> > --
> > 2.50.0
> >=20
>=20
> Have a look if the above makes sense, I didn't include BT_PKT_SEQNUM
> since that is sort of new, but if you feel that should be included
> from the start I just need an example to go with it.

Looks right to me. BT_PKT_SEQNUM if added would be like

BT_PKT_SEQNUM
-------------

Enable reporting packet ISO sequence number via `BT_SCM_PKT_SEQNUM`
CMSG on received packets.  Possible values:

.. csv-table::
    :header: "Value", "Description"
    :widths: auto

    **0**, Disable (default)
    **1**, Enable


:BT_SCM_PKT_SEQNUM:

    Level ``SOL_BLUETOOTH`` CMSG with data::

        uint16_t pkt_seqnum;

    The values are equal to the "Packet_Sequence_Number" defined in
    Core Specification v6.1, 5.4.5. HCI ISO Data packets:

    https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/C=
ore-61/out/en/host-controller-interface/host-controller-interface-functiona=
l-specification.html#UUID-9b5fb085-278b-5084-ac33-bee2839abe6b

Example (Enable sequence numbers):

.. code-block::

    uint32_t opt =3D 1;
    if (setsockopt(fd, SOL_BLUETOOTH, BT_PKT_SEQNUM, &opt, sizeof(opt)) < 0=
)
        goto error;

Example (Read packet and its sequence number):

.. code-block::

   char data_buf[256];
   uint16_t seqnum;
   union {
       char buf[CMSG_SPACE(sizeof(uint16_t))];
       struct cmsghdr align;
   } control;
   struct iovec data =3D {
       .iov_base =3D data_buf,
       .iov_len =3D sizeof(data_buf),
   };
   struct msghdr msg =3D {
       .msg_iov =3D &data,
       .msg_iovlen =3D 1,
       .msg_control =3D control.buf,
       .msg_controllen =3D sizeof(control.buf),
   };
   struct scm_timestamping tss;

   res =3D recvmsg(fd, &msg, 0);
   if (res < 0)
       goto error;

   for (cmsg =3D CMSG_FIRSTHDR(&msg); cmsg; cmsg =3D CMSG_NXTHDR(&msg, cmsg=
)) {
       if (cmsg->cmsg_level =3D=3D SOL_BLUETOOTH && cmsg->cmsg_type =3D=3D =
BT_PKT_SEQNUM)
           memcpy(&seqnum, CMSG_DATA(cmsg), sizeof(seqnum));
   }


--=20
Pauli Virtanen
