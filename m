Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122E11B3927
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740845873; cv=pass; b=C4CzrJ0cciCyU2Si1ORkZXfhyYQA8ueOFsVbpyo2D/+Nsx6TnKd3KPajTcrjrgSv76V0yx3ZtqnnO2GP7AMyMtEREdAFO55DuK4UrKXF5nxHzqTfKIBGpdFLSps+Osh/cRQYzrqYFqsiiDJTO9ri42YUpXhPNW71S9x3FqkWCe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740845873; c=relaxed/simple;
	bh=y/KwRNYHOahr394MluZJV5IElnaX1fLB6SZ67hxytms=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nbaxWFoiXoyBftRNzpRro+TW/RGaxqa95UhCNhgtMbPZ1IBTy2F7gIUFnd+JYoKKZbTFrb/Qr/oPc2r/3NolQZo3CxYlpcEZOTSVsT3xGWve/p1pHKc53nkdb2G1mMxF1eLP2TNelitm0TPr4zO4pMegoCOGtyD3GKK0u7brxas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=k9Ms9VAk; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="k9Ms9VAk"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z4qx91twGz4BKH9;
	Sat,  1 Mar 2025 18:17:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740845870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q3HzP4BPDVhmp5lc7DJnYtRVcQxGdcHx9zJZq7wlGqs=;
	b=k9Ms9VAkJ26apOSK+EGeNTkbFgdtk9g2e3FK80UstpEQPASw1KBSu1ks4EObU25xtjbcJ3
	NlpgxaZnwvayduINUMUeXlwYQT9RdICLqXiHa4n5PY/fgQJNlqXV9L6oIQKjuBjz4d8GPi
	jsXwh+x+Z8S2u/PSnJbv97766a654oYxmE6Pu0f2+HhfweLRbO67p/FlNWsz4znKHGJDCA
	A1A3IZ2A0jjHNKaffwwWmS5I62XCmJhJb39rjhGQ57aMBxTd1jx+DQXTtr/ppB8GaIKdsb
	SK6yfEDGPeJTmbiYOiGC2oy6S/b26C+zsqKA0GnlC7VfAsV6KE2mZxrRCeGRwg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740845870; a=rsa-sha256;
	cv=none;
	b=OsI7fsDJA8Fj8eokg5Ir7w38zGwkgJYkBOlLWzuehSNAy/mS/1EqgN5doYsLtou84nrg4P
	l3yq4qD1jGi2LYGnGxxLTI/RKj5G1mAgx0eUgen7ylw/V0+Wkg6aMbDb05S6kNYEsz0n/V
	GD3jTP3SXNDrPA8Z1mUo2EQPqHEhPSQH9nYYw1CaSnANVnMHb5PpFX7ps2zMENlATY0Cey
	oQ8T20bT7WMvWPnd/7KZlw3N242aAniUq47glK4C9mI3A3P+zZncpmdM/q7hAQhYov89ir
	CdeGzpREqI5zWwTJn+ikXToM65DUf0wkyAhxOut9W+ncrgacM3qQReutD9USxw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740845870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q3HzP4BPDVhmp5lc7DJnYtRVcQxGdcHx9zJZq7wlGqs=;
	b=CR0QJ3B045vroP7Gierbp2GmjdMMcIlAHg0LcaCvb5goayjCYa5mJQqGP1Y+jfSv3JQKAK
	zA0QG4R34luMFE7kK0fSD9jTFt5JheSoS3zq3lIYWqiftKoHbOILIUGEFqKZAgcfXQlKKE
	xZDQrJ7rOb1RfrggFHMwJik26g/Xir85Un1rSMDlkX69uyLh5NEYZou9BlYDJ1sRTI2uFf
	8F4wWkpn2KxpGDfvm31AA9N3HEFk4pPbpKBJjx4VASH/emsFdkh9U0Gx+G4MzRMfu+mGgD
	LUlcl+GhKET+x1bMi10DkAcYOchySNfHS3isvo0Icc5vgsCJqOXFRE6SEFlz7w==
Message-ID: <24709b9c28161f1bc300b6117de63975ae92c00c.camel@iki.fi>
Subject: Re: [PATCH BlueZ v2 3/3] client: Add support get/set PreferredBearer
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Date: Sat, 01 Mar 2025 18:17:47 +0200
In-Reply-To: <CABBYNZLwaqD8X8X0vzBR99bJ9uOScufxpOZfgCQDCYYe6FqJHw@mail.gmail.com>
References: <20250225220059.2821394-1-luiz.dentz@gmail.com>
	 <20250225220059.2821394-3-luiz.dentz@gmail.com>
	 <CABBYNZ+32tuRH+T7M=1aeDJJOqHz9qt4ThsuMF4sVpiEeC380A@mail.gmail.com>
	 <CABBYNZLwaqD8X8X0vzBR99bJ9uOScufxpOZfgCQDCYYe6FqJHw@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ti, 2025-02-25 kello 17:12 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Tue, Feb 25, 2025 at 5:10=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >=20
> > Hi Pauli, Bastien,
> >=20
> > On Tue, Feb 25, 2025 at 5:01=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >=20
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >=20
> > > This adds support for PreferredBearer which is printed with the likes=
 of
> > > info command:
> > >=20
> > > bluetoothctl> info <addr>
> > > ...
> > >         PreferredBearer: last-seen
> > >=20
> > > It also introduces a new command to get/set the PreferredBearer:
> > >=20
> > > [bluetoothctl]> bearer --help
> > > Get/Set preferred bearer
> > > Usage:
> > >          bearer <dev> [last-seen/bredr/le]
> > >=20
> > > [bluetoothctl]> bearer <addr>
> > >         PreferredBearer: last-seen
> > > [bluetoothctl]> bearer <addr> le
> > > bluetoothd: @ MGMT Command: Add Device (0x0033) plen 8
> > >         LE Address: <addr>
> > >         Action: Auto-connect remote device (0x02)
> > > [CHG] Device <addr> PreferredBearer: le
> > > Changing le succeeded
> > > [bluetoothctl]> bearer <addr>
> > >         PreferredBearer: le
> > > [bluetoothctl]> bearer <addr> bredr
> > > bluetoothd: @ MGMT Command: Remove Device (0x0034) plen 7
> > >         LE Address: <addr>
> > > [CHG] Device <addr> PreferredBearer: bredr
> > > Changing bredr succeeded
> > > ---
> > >  client/main.c | 27 +++++++++++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > >=20
> > > diff --git a/client/main.c b/client/main.c
> > > index feb21a1163d2..76c9bc329c96 100644
> > > --- a/client/main.c
> > > +++ b/client/main.c
> > > @@ -1714,6 +1714,7 @@ static void cmd_info(int argc, char *argv[])
> > >         print_property(proxy, "AdvertisingFlags");
> > >         print_property(proxy, "AdvertisingData");
> > >         print_property(proxy, "Sets");
> > > +       print_property(proxy, "PreferredBearer");
> > >=20
> > >         battery_proxy =3D find_proxies_by_path(battery_proxies,
> > >                                         g_dbus_proxy_get_path(proxy))=
;
> > > @@ -2086,6 +2087,30 @@ static void cmd_wake(int argc, char *argv[])
> > >         return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > >  }
> > >=20
> > > +static void cmd_bearer(int argc, char *argv[])
> > > +{
> > > +       GDBusProxy *proxy;
> > > +       char *str;
> > > +
> > > +       proxy =3D find_device(argc, argv);
> > > +       if (!proxy)
> > > +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > > +
> > > +       if (argc <=3D 2) {
> > > +               print_property(proxy, "PreferredBearer");
> > > +               return;
> > > +       }
> > > +
> > > +       str =3D strdup(argv[2]);
> > > +
> > > +       if (g_dbus_proxy_set_property_basic(proxy, "PreferredBearer",
> > > +                                       DBUS_TYPE_STRING, &str,
> > > +                                       generic_callback, str, free))
> > > +               return;
> > > +
> > > +       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > > +}
> > > +
> > >  static void cmd_list_attributes(int argc, char *argv[])
> > >  {
> > >         GDBusProxy *proxy;
> > > @@ -3247,6 +3272,8 @@ static const struct bt_shell_menu main_menu =3D=
 {
> > >                                                         dev_generator=
 },
> > >         { "wake",         "[dev] [on/off]",    cmd_wake, "Get/Set wak=
e support",
> > >                                                         dev_generator=
 },
> > > +       { "bearer",       "<dev> [last-seen/bredr/le]", cmd_bearer,
> > > +                               "Get/Set preferred bearer", dev_gener=
ator },
> > >         { } },
> > >  };
> > >=20
> > > --
> > > 2.48.1
> >=20
> > So I went ahead and implemented the idea of having PreferredBearer,
> > this works great when setting bredr it really stops from connecting to
> > LE, the said the other way around when setting to le seems to confuse
> > some headsets like EarFun and it ends up connecting both bearers:
> >=20
> > [EarFun Air Pro 3]> transport.show
> > Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0/fd1
> >     UUID: Sink PAC                  (00002bc9-0000-1000-8000-00805f9b34=
fb)
> >     Codec: 0x06 (6)
> >     Configuration.#0: len 0x02 type 0x01
> >     Configuration.Sampling Frequency: 16 Khz (0x03)
> >     Configuration.#1: len 0x02 type 0x02
> >     Configuration.Frame Duration: 7.5 ms (0x00)
> >     Configuration.#2: len 0x05 type 0x03
> >     Configuration.Location: 0x00000001
> >     Configuration.Location: Front Left (0x00000001)
> >     Configuration.#3: len 0x03 type 0x04
> >     Configuration.Frame Length: 30 (0x001e)
> >     Configuration.#4: len 0x02 type 0x05
> >     Configuration.Frame Blocks per SDU: 1 (0x01)
> >     Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
> >     State: idle
> >     Volume: 0x00c8 (200)
> >     Endpoint: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0
> >     QoS.CIG: 0x00 (0)
> >     QoS.CIS: 0x00 (0)
> >     QoS.Framing: 0x00 (0)
> >     QoS.PresentationDelay: 0x00009c40 (40000)
> >     QoS.Interval: 0x00001d4c (7500)
> >     QoS.Latency: 0x0008 (8)
> >     QoS.SDU: 0x001e (30)
> >     QoS.PHY: 0x02 (2)
> >     QoS.Retransmissions: 0x02 (2)
> >     Location: 0x00000003 (3)
> >     Links: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0/fd3
> > Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0/fd2
> >     UUID: Sink PAC                  (00002bc9-0000-1000-8000-00805f9b34=
fb)
> >     Codec: 0x06 (6)
> >     Configuration.#0: len 0x02 type 0x01
> >     Configuration.Sampling Frequency: 16 Khz (0x03)
> >     Configuration.#1: len 0x02 type 0x02
> >     Configuration.Frame Duration: 7.5 ms (0x00)
> >     Configuration.#2: len 0x05 type 0x03
> >     Configuration.Location: 0x00000002
> >     Configuration.Location: Front Right (0x00000002)
> >     Configuration.#3: len 0x03 type 0x04
> >     Configuration.Frame Length: 30 (0x001e)
> >     Configuration.#4: len 0x02 type 0x05
> >     Configuration.Frame Blocks per SDU: 1 (0x01)
> >     Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
> >     State: idle
> >     Volume: 0x00c8 (200)
> >     Endpoint: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0
> >     QoS.CIG: 0x00 (0)
> >     QoS.CIS: 0x01 (1)
> >     QoS.Framing: 0x00 (0)
> >     QoS.PresentationDelay: 0x00009c40 (40000)
> >     QoS.Interval: 0x00001d4c (7500)
> >     QoS.Latency: 0x0008 (8)
> >     QoS.SDU: 0x001e (30)
> >     QoS.PHY: 0x02 (2)
> >     QoS.Retransmissions: 0x02 (2)
> >     Location: 0x00000003 (3)
> >     Links: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0/fd4
> > Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0/fd3
> >     UUID: Source PAC                (00002bcb-0000-1000-8000-00805f9b34=
fb)
> >     Codec: 0x06 (6)
> >     Configuration.#0: len 0x02 type 0x01
> >     Configuration.Sampling Frequency: 48 Khz (0x08)
> >     Configuration.#1: len 0x02 type 0x02
> >     Configuration.Frame Duration: 7.5 ms (0x00)
> >     Configuration.#2: len 0x05 type 0x03
> >     Configuration.Location: 0x00000001
> >     Configuration.Location: Front Left (0x00000001)
> >     Configuration.#3: len 0x03 type 0x04
> >     Configuration.Frame Length: 90 (0x005a)
> >     Configuration.#4: len 0x02 type 0x05
> >     Configuration.Frame Blocks per SDU: 1 (0x01)
> >     Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
> >     State: idle
> >     Volume: 0x00c8 (200)
> >     Endpoint: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0
> >     QoS.CIG: 0x00 (0)
> >     QoS.CIS: 0x00 (0)
> >     QoS.Framing: 0x00 (0)
> >     QoS.PresentationDelay: 0x00009c40 (40000)
> >     QoS.Interval: 0x00001d4c (7500)
> >     QoS.Latency: 0x000f (15)
> >     QoS.SDU: 0x005a (90)
> >     QoS.PHY: 0x02 (2)
> >     QoS.Retransmissions: 0x05 (5)
> >     Location: 0x00000003 (3)
> >     Links: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0/fd1
> > Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0/fd4
> >     UUID: Source PAC                (00002bcb-0000-1000-8000-00805f9b34=
fb)
> >     Codec: 0x06 (6)
> >     Configuration.#0: len 0x02 type 0x01
> >     Configuration.Sampling Frequency: 48 Khz (0x08)
> >     Configuration.#1: len 0x02 type 0x02
> >     Configuration.Frame Duration: 7.5 ms (0x00)
> >     Configuration.#2: len 0x05 type 0x03
> >     Configuration.Location: 0x00000002
> >     Configuration.Location: Front Right (0x00000002)
> >     Configuration.#3: len 0x03 type 0x04
> >     Configuration.Frame Length: 90 (0x005a)
> >     Configuration.#4: len 0x02 type 0x05
> >     Configuration.Frame Blocks per SDU: 1 (0x01)
> >     Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
> >     State: idle
> >     Volume: 0x00c8 (200)
> >     Endpoint: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0
> >     QoS.CIG: 0x00 (0)
> >     QoS.CIS: 0x01 (1)
> >     QoS.Framing: 0x00 (0)
> >     QoS.PresentationDelay: 0x00009c40 (40000)
> >     QoS.Interval: 0x00001d4c (7500)
> >     QoS.Latency: 0x000f (15)
> >     QoS.SDU: 0x005a (90)
> >     QoS.PHY: 0x02 (2)
> >     QoS.Retransmissions: 0x05 (5)
> >     Location: 0x00000003 (3)
> >     Links: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0/fd2
> > Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/fd5
> >     UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34=
fb)
> >     Codec: 0x02 (2)
> >     Media Codec: MPEG24
> >     Object Types: MPEG-4 AAC LC
> >     Frequencies: 48kHz
> >     Channels: 2
> >     Bitrate: 320000
> >     VBR: Yes
> >     Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
> >     State: idle
> >     Delay: 0x0960 (2400)
> >     Volume: 0x0064 (100)
>=20
> Forgot to mention, but with the above transports it seems to confuse
> the gnome audio output selection, it doesn't seem to be able to mix
> A2DP and BAP transports for some reason, so when I select the device
> it enables BAP but A2DP is not shown as an option.

I'll have to see if I can reproduce that on current PW master branch.

The visibility of profiles in theory should only cares about whether
the UUIDs appear in both device properties and transport.


--=20
Pauli Virtanen
