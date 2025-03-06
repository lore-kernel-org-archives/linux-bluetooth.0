Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF8C18DB2C
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282741; cv=pass; b=TGEFX4O5iaHL/ufbh544E8Zc39Vyp7QmETFRvvz4Q2Ub7e9E1m0DEJ6xTM5oVXAPexY23Hr+ibLAKB3XAx6m3Z319SuyGx7x9tCD7hR5oUOgnXbYHCWgSofRjJ+AVBCu7AE0Ikg/FsaYBujZNeZol9Ajgl8ojkXMOOhFDPmRl5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282741; c=relaxed/simple;
	bh=jO1W6xPrgT0osYrNbZKIvSHoTatKjY1ihpLWIMG+hgc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TCKa7yJLqjxicDdrwsNA7taDI9iZzEVXpHkVHS99/F9cSGK+f6NyGcVc5t2BrtZScw8MLR1FZ5Ut1q1jS5O2SiWkG13nL9G3fZOMtACWNWQrmvDtkYzteok3XD9cb8ED8Jjrl/3/z+oDVQiqtXUChSfGIH1PXZKwyy4WtBrsf0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=n4+MQbD0; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="n4+MQbD0"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z7xVH0jyLz49Psw;
	Thu,  6 Mar 2025 19:38:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1741282727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwANoRM0Nd1GUGywtfBXgIVxbvKSVJer8KB5/tF3n8A=;
	b=n4+MQbD0k/FVSCnrPk0CI6ZS4ma+1OoviDMfHKYWHsKZYFIk9QfTCqxXSDD3L0qrHbab7C
	oAB03f05jvuLHJfmGkE6PG7rk5PsBK6H5hbcQH7r7gZqnViULn8y8wW0bS8b+gzUzXG895
	r8WHFjEkcuHG/spEekrD3F73+/VdvhkvrxCRiqoCR0Y9eZE+wnoYhHmE/3EafW3zvbsxDI
	efj7Ah9xFyPfKLqcbKRNT9Ara6shvYTC1nGXD958RtumEv6eNHBs8b5VCbIUF93MrBMwq5
	/lpG1I24Dovpb4FQNNL1abCa418MnPj8PKtG0wEo5MeACvpszWe9oUkQp9boRw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1741282727; a=rsa-sha256;
	cv=none;
	b=oH4h4YYH7vlm0v+qsJ/4a0d2N5X2fW6WE/Oa/iaZ428Bqs1G0iXB7vjlD4OXLfUK3DniKp
	hwOpI9jfUIn/7/6j/G+HrGrseEY+Sn3H5tIYBjKg8gnmlKe/pJsq08WJ9XnH2mNZ0pVXSi
	m9dj04AGpbxpZOILnVvbw8WbczpunVKaZqSsRdfVvauOyTmtjZkDg6Xokwa3vQjNamNqNx
	qQgnesgvxRlA8I4IaBE2cgbvEvSGOsTn3nFDDuJat9ogJiQ9yqFS0bAKy4vE8OEj3jhqIA
	+K3F1EKfWXBjTuRy85c7+iPiqFmdlzDqxk+Nm9EXZUti1SzrvMkawST6aAx0Ew==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1741282727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwANoRM0Nd1GUGywtfBXgIVxbvKSVJer8KB5/tF3n8A=;
	b=HCfcxG+ibznzkR1FNgAGPBhVHIcH2s4rMNIiw0VSlNU74h2Y7U0dcZEHaZCUMUlzVSvrbi
	muIs/fNXv1fLDBX2RaFFC2WFkTHBYiBTX1b208qYE5INw0iw5k/ZE1S4YWRZWEVA71NeVH
	L0LQplv9//Gu/JlXb4lH5N9K5L+i/AnckaWzGJpDXCLrhROZ80v61mDNcCmAdBwOmO2z3B
	C+XijdpkeeiEccxcuWIS+Bkcmgf3n0bCkZVngnBE6eWcsnFIOtdIg9qoCN6g4ulf+PJR1q
	McTxZcevzA20Z+3ZbxpvMYH9cgvllqCHvaADbEg67YJcS47uWc1OqzEkETobeA==
Message-ID: <f01b7cbb8326c405b1c4287add512b9a059815a8.camel@iki.fi>
Subject: Re: [PATCH BlueZ v2 3/3] client: Add support get/set PreferredBearer
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Date: Thu, 06 Mar 2025 19:38:46 +0200
In-Reply-To: <CABBYNZJFsJs3U5XpHvHyDit1SuuFiBfcn+sjAn=tyhHV3ZsKFA@mail.gmail.com>
References: <20250225220059.2821394-1-luiz.dentz@gmail.com>
	 <20250225220059.2821394-3-luiz.dentz@gmail.com>
	 <CABBYNZ+32tuRH+T7M=1aeDJJOqHz9qt4ThsuMF4sVpiEeC380A@mail.gmail.com>
	 <CABBYNZLwaqD8X8X0vzBR99bJ9uOScufxpOZfgCQDCYYe6FqJHw@mail.gmail.com>
	 <24709b9c28161f1bc300b6117de63975ae92c00c.camel@iki.fi>
	 <CABBYNZJFsJs3U5XpHvHyDit1SuuFiBfcn+sjAn=tyhHV3ZsKFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2025-03-06 kello 11:41 -0500, Luiz Augusto von Dentz kirjoitti:
> On Sat, Mar 1, 2025 at 11:17=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > ti, 2025-02-25 kello 17:12 -0500, Luiz Augusto von Dentz kirjoitti:
> > > Hi Pauli,
> > >=20
> > > On Tue, Feb 25, 2025 at 5:10=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >=20
> > > > Hi Pauli, Bastien,
> > > >=20
> > > > On Tue, Feb 25, 2025 at 5:01=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >=20
> > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > >=20
> > > > > This adds support for PreferredBearer which is printed with the l=
ikes of
> > > > > info command:
> > > > >=20
> > > > > bluetoothctl> info <addr>
> > > > > ...
> > > > >         PreferredBearer: last-seen
> > > > >=20
> > > > > It also introduces a new command to get/set the PreferredBearer:
> > > > >=20
> > > > > [bluetoothctl]> bearer --help
> > > > > Get/Set preferred bearer
> > > > > Usage:
> > > > >          bearer <dev> [last-seen/bredr/le]
> > > > >=20
> > > > > [bluetoothctl]> bearer <addr>
> > > > >         PreferredBearer: last-seen
> > > > > [bluetoothctl]> bearer <addr> le
> > > > > bluetoothd: @ MGMT Command: Add Device (0x0033) plen 8
> > > > >         LE Address: <addr>
> > > > >         Action: Auto-connect remote device (0x02)
> > > > > [CHG] Device <addr> PreferredBearer: le
> > > > > Changing le succeeded
> > > > > [bluetoothctl]> bearer <addr>
> > > > >         PreferredBearer: le
> > > > > [bluetoothctl]> bearer <addr> bredr
> > > > > bluetoothd: @ MGMT Command: Remove Device (0x0034) plen 7
> > > > >         LE Address: <addr>
> > > > > [CHG] Device <addr> PreferredBearer: bredr
> > > > > Changing bredr succeeded
> > > > > ---
> > > > >  client/main.c | 27 +++++++++++++++++++++++++++
> > > > >  1 file changed, 27 insertions(+)
> > > > >=20
> > > > > diff --git a/client/main.c b/client/main.c
> > > > > index feb21a1163d2..76c9bc329c96 100644
> > > > > --- a/client/main.c
> > > > > +++ b/client/main.c
> > > > > @@ -1714,6 +1714,7 @@ static void cmd_info(int argc, char *argv[]=
)
> > > > >         print_property(proxy, "AdvertisingFlags");
> > > > >         print_property(proxy, "AdvertisingData");
> > > > >         print_property(proxy, "Sets");
> > > > > +       print_property(proxy, "PreferredBearer");
> > > > >=20
> > > > >         battery_proxy =3D find_proxies_by_path(battery_proxies,
> > > > >                                         g_dbus_proxy_get_path(pro=
xy));
> > > > > @@ -2086,6 +2087,30 @@ static void cmd_wake(int argc, char *argv[=
])
> > > > >         return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > > > >  }
> > > > >=20
> > > > > +static void cmd_bearer(int argc, char *argv[])
> > > > > +{
> > > > > +       GDBusProxy *proxy;
> > > > > +       char *str;
> > > > > +
> > > > > +       proxy =3D find_device(argc, argv);
> > > > > +       if (!proxy)
> > > > > +               return bt_shell_noninteractive_quit(EXIT_FAILURE)=
;
> > > > > +
> > > > > +       if (argc <=3D 2) {
> > > > > +               print_property(proxy, "PreferredBearer");
> > > > > +               return;
> > > > > +       }
> > > > > +
> > > > > +       str =3D strdup(argv[2]);
> > > > > +
> > > > > +       if (g_dbus_proxy_set_property_basic(proxy, "PreferredBear=
er",
> > > > > +                                       DBUS_TYPE_STRING, &str,
> > > > > +                                       generic_callback, str, fr=
ee))
> > > > > +               return;
> > > > > +
> > > > > +       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > > > > +}
> > > > > +
> > > > >  static void cmd_list_attributes(int argc, char *argv[])
> > > > >  {
> > > > >         GDBusProxy *proxy;
> > > > > @@ -3247,6 +3272,8 @@ static const struct bt_shell_menu main_menu=
 =3D {
> > > > >                                                         dev_gener=
ator },
> > > > >         { "wake",         "[dev] [on/off]",    cmd_wake, "Get/Set=
 wake support",
> > > > >                                                         dev_gener=
ator },
> > > > > +       { "bearer",       "<dev> [last-seen/bredr/le]", cmd_beare=
r,
> > > > > +                               "Get/Set preferred bearer", dev_g=
enerator },
> > > > >         { } },
> > > > >  };
> > > > >=20
> > > > > --
> > > > > 2.48.1
> > > >=20
> > > > So I went ahead and implemented the idea of having PreferredBearer,
> > > > this works great when setting bredr it really stops from connecting=
 to
> > > > LE, the said the other way around when setting to le seems to confu=
se
> > > > some headsets like EarFun and it ends up connecting both bearers:
> > > >=20
> > > > [EarFun Air Pro 3]> transport.show
> > > > Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0/fd1
> > > >     UUID: Sink PAC                  (00002bc9-0000-1000-8000-00805f=
9b34fb)
> > > >     Codec: 0x06 (6)
> > > >     Configuration.#0: len 0x02 type 0x01
> > > >     Configuration.Sampling Frequency: 16 Khz (0x03)
> > > >     Configuration.#1: len 0x02 type 0x02
> > > >     Configuration.Frame Duration: 7.5 ms (0x00)
> > > >     Configuration.#2: len 0x05 type 0x03
> > > >     Configuration.Location: 0x00000001
> > > >     Configuration.Location: Front Left (0x00000001)
> > > >     Configuration.#3: len 0x03 type 0x04
> > > >     Configuration.Frame Length: 30 (0x001e)
> > > >     Configuration.#4: len 0x02 type 0x05
> > > >     Configuration.Frame Blocks per SDU: 1 (0x01)
> > > >     Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
> > > >     State: idle
> > > >     Volume: 0x00c8 (200)
> > > >     Endpoint: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0
> > > >     QoS.CIG: 0x00 (0)
> > > >     QoS.CIS: 0x00 (0)
> > > >     QoS.Framing: 0x00 (0)
> > > >     QoS.PresentationDelay: 0x00009c40 (40000)
> > > >     QoS.Interval: 0x00001d4c (7500)
> > > >     QoS.Latency: 0x0008 (8)
> > > >     QoS.SDU: 0x001e (30)
> > > >     QoS.PHY: 0x02 (2)
> > > >     QoS.Retransmissions: 0x02 (2)
> > > >     Location: 0x00000003 (3)
> > > >     Links: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0/fd3
> > > > Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0/fd2
> > > >     UUID: Sink PAC                  (00002bc9-0000-1000-8000-00805f=
9b34fb)
> > > >     Codec: 0x06 (6)
> > > >     Configuration.#0: len 0x02 type 0x01
> > > >     Configuration.Sampling Frequency: 16 Khz (0x03)
> > > >     Configuration.#1: len 0x02 type 0x02
> > > >     Configuration.Frame Duration: 7.5 ms (0x00)
> > > >     Configuration.#2: len 0x05 type 0x03
> > > >     Configuration.Location: 0x00000002
> > > >     Configuration.Location: Front Right (0x00000002)
> > > >     Configuration.#3: len 0x03 type 0x04
> > > >     Configuration.Frame Length: 30 (0x001e)
> > > >     Configuration.#4: len 0x02 type 0x05
> > > >     Configuration.Frame Blocks per SDU: 1 (0x01)
> > > >     Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
> > > >     State: idle
> > > >     Volume: 0x00c8 (200)
> > > >     Endpoint: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0
> > > >     QoS.CIG: 0x00 (0)
> > > >     QoS.CIS: 0x01 (1)
> > > >     QoS.Framing: 0x00 (0)
> > > >     QoS.PresentationDelay: 0x00009c40 (40000)
> > > >     QoS.Interval: 0x00001d4c (7500)
> > > >     QoS.Latency: 0x0008 (8)
> > > >     QoS.SDU: 0x001e (30)
> > > >     QoS.PHY: 0x02 (2)
> > > >     QoS.Retransmissions: 0x02 (2)
> > > >     Location: 0x00000003 (3)
> > > >     Links: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0/fd4
> > > > Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0/fd3
> > > >     UUID: Source PAC                (00002bcb-0000-1000-8000-00805f=
9b34fb)
> > > >     Codec: 0x06 (6)
> > > >     Configuration.#0: len 0x02 type 0x01
> > > >     Configuration.Sampling Frequency: 48 Khz (0x08)
> > > >     Configuration.#1: len 0x02 type 0x02
> > > >     Configuration.Frame Duration: 7.5 ms (0x00)
> > > >     Configuration.#2: len 0x05 type 0x03
> > > >     Configuration.Location: 0x00000001
> > > >     Configuration.Location: Front Left (0x00000001)
> > > >     Configuration.#3: len 0x03 type 0x04
> > > >     Configuration.Frame Length: 90 (0x005a)
> > > >     Configuration.#4: len 0x02 type 0x05
> > > >     Configuration.Frame Blocks per SDU: 1 (0x01)
> > > >     Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
> > > >     State: idle
> > > >     Volume: 0x00c8 (200)
> > > >     Endpoint: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0
> > > >     QoS.CIG: 0x00 (0)
> > > >     QoS.CIS: 0x00 (0)
> > > >     QoS.Framing: 0x00 (0)
> > > >     QoS.PresentationDelay: 0x00009c40 (40000)
> > > >     QoS.Interval: 0x00001d4c (7500)
> > > >     QoS.Latency: 0x000f (15)
> > > >     QoS.SDU: 0x005a (90)
> > > >     QoS.PHY: 0x02 (2)
> > > >     QoS.Retransmissions: 0x05 (5)
> > > >     Location: 0x00000003 (3)
> > > >     Links: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0/fd1
> > > > Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0/fd4
> > > >     UUID: Source PAC                (00002bcb-0000-1000-8000-00805f=
9b34fb)
> > > >     Codec: 0x06 (6)
> > > >     Configuration.#0: len 0x02 type 0x01
> > > >     Configuration.Sampling Frequency: 48 Khz (0x08)
> > > >     Configuration.#1: len 0x02 type 0x02
> > > >     Configuration.Frame Duration: 7.5 ms (0x00)
> > > >     Configuration.#2: len 0x05 type 0x03
> > > >     Configuration.Location: 0x00000002
> > > >     Configuration.Location: Front Right (0x00000002)
> > > >     Configuration.#3: len 0x03 type 0x04
> > > >     Configuration.Frame Length: 90 (0x005a)
> > > >     Configuration.#4: len 0x02 type 0x05
> > > >     Configuration.Frame Blocks per SDU: 1 (0x01)
> > > >     Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
> > > >     State: idle
> > > >     Volume: 0x00c8 (200)
> > > >     Endpoint: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0
> > > >     QoS.CIG: 0x00 (0)
> > > >     QoS.CIS: 0x01 (1)
> > > >     QoS.Framing: 0x00 (0)
> > > >     QoS.PresentationDelay: 0x00009c40 (40000)
> > > >     QoS.Interval: 0x00001d4c (7500)
> > > >     QoS.Latency: 0x000f (15)
> > > >     QoS.SDU: 0x005a (90)
> > > >     QoS.PHY: 0x02 (2)
> > > >     QoS.Retransmissions: 0x05 (5)
> > > >     Location: 0x00000003 (3)
> > > >     Links: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0/fd2
> > > > Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/fd5
> > > >     UUID: Audio Source              (0000110a-0000-1000-8000-00805f=
9b34fb)
> > > >     Codec: 0x02 (2)
> > > >     Media Codec: MPEG24
> > > >     Object Types: MPEG-4 AAC LC
> > > >     Frequencies: 48kHz
> > > >     Channels: 2
> > > >     Bitrate: 320000
> > > >     VBR: Yes
> > > >     Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
> > > >     State: idle
> > > >     Delay: 0x0960 (2400)
> > > >     Volume: 0x0064 (100)
> > >=20
> > > Forgot to mention, but with the above transports it seems to confuse
> > > the gnome audio output selection, it doesn't seem to be able to mix
> > > A2DP and BAP transports for some reason, so when I select the device
> > > it enables BAP but A2DP is not shown as an option.
> >=20
> > I'll have to see if I can reproduce that on current PW master branch.
> >=20
> > The visibility of profiles in theory should only cares about whether
> > the UUIDs appear in both device properties and transport.
>=20
> I think I will merge these changes since the property is marked as
> experimental; we can always change it or revert later.

Since the default value retains previous behavior, I think that's a
good idea as it makes it easier to iterate on this.

--=20
Pauli Virtanen
