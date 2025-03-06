Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6E6212D82
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279296; cv=none; b=CrHjGscBbHDEEV8QK2B48jVlotY3oTRp2AWd1VRiWwX6n288CFxQc+U7E7ca64wMFJc+RAAeal7F4Vk1uw3AzTKJJNRriD2lNu8MF8/Yls1eMFZ2bXkfWk+YnZOzCD+Nnw6RjM+3YRdRH3RMDwK1wv/filKd3fRDWOfU7xh7mIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279296; c=relaxed/simple;
	bh=x+GMzucCssV/hGF0PbOXa4X2aIttMAAk3Dy3Ci4Jv+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3HiMpOIDYIrG1TVvY75Yv/+9zxISi+u9g+c47495fyVmrGWC+Le4nb8YmEjVxq8Bl/FzNUyXVEeyXPo8MTQrutzonKbOLxQVk0kiPCN9g6jtvbm4ktB+We14x3qLKrCnU25/NIuob9ZKkpEQDH2bYdvxR6qrp1SITMLKw9urfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWgARhEe; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWgARhEe"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bb2fdbb09so8575311fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Mar 2025 08:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741279293; x=1741884093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGUEy1Xiby138CPz4Qc7TKHYO8Y2hJxGi5yQwP2lbYg=;
        b=AWgARhEeMpyg+MMqxmEmkl9pz8jx6E/nogqOdd198gdNtlSeM036obWZRD0XLRmrGj
         d33LpLr3v6eCpPR47MLOoqzAGz+DM2ZwPqIpg2xi+vQg6QDT3SKSvyD53Ftoz3fTev4v
         Ao/0SyKL7f1DZmZt5S/jwnFM/7gUXaZVJ4ilsAKYHKywn4xhCUXx7FqZVXTK+aY34vIp
         H33scsMe+g2zQQl+7UJosFNGsMmgLryD2Lx0Hl8KHFLixRofmtMe6w+gOcQ13klmGtrw
         uBNHPLsCPZjEiEz3iykFoSmDDLjGzpuiF963gN8lhlDPU/FL/BCCdCKkgUB3G5xBb8Mj
         aElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741279293; x=1741884093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGUEy1Xiby138CPz4Qc7TKHYO8Y2hJxGi5yQwP2lbYg=;
        b=CjTUo/uQ/J4TKhL5Ha44SqhfJvZtSHc4GCCjJk9ZABnhRV5aOLAWK25R+Dr2uu9Fnp
         PQi6cpT2S5WPpdpqRcblj+QJZoMeMV5MDmJV3e1Jd5kZ3nFg/4BwOMCwrcyzmDwH1JTw
         uafrLloLJTIcCJSOS7ZrappwrQE4wuJqLcTyYZ/379IiNDEqxJGWeclZ6kC3oIkh2BZR
         DzbS19B9Xapn33yfXhtcv4qi9ReuasM9H1mHYJ6bC+KL6LI/u0sNklZM0d6eHO0vM2XC
         Xw0f/i0htJSFk4wqOCt9g1/4FbdJ8JQWPanoVNKePrxpE4+a1H1/QN3uIfJtcxGV5S2c
         K1gA==
X-Gm-Message-State: AOJu0YyEuWdolumMgm1O3fgdfXwI0CrUKjOz/SbTIlYrgl8PRPIC7RTa
	DqPg7jyZ93euMnep5WUA1n8JdDfHGHnffw8mRo5HIAlRHxo5qHGZ6PjlSzl3VCYifHi5NprdtaF
	Ck/eQ39B+Gx8059W+me+NLoPcamc=
X-Gm-Gg: ASbGnctBC0lnOW1Lx3tX8fZsHTmxgbY5yBv5EMJiF4xp8958HNb2pJC4y/oI09kvzNO
	BCLvJSXj9lMw0fpazifx7BFJYAamCV/50mdBk//AgMvWdpZnbouO/IG+qDoP+ePyt1Rcsyu67sR
	a200FOihKTgjURwboteYw+e/on
X-Google-Smtp-Source: AGHT+IH9mOZPglPL3BhGZRHkgih+XKWfNhjbJloZXz8TmyNZJq6KhJFeKtKR/8uf43ESFO+WxMLkBXiXKqIOY8oLqnc=
X-Received: by 2002:a2e:a9a3:0:b0:30b:c6fe:4529 with SMTP id
 38308e7fff4ca-30bd7a1c5d0mr31245141fa.8.1741279292235; Thu, 06 Mar 2025
 08:41:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225220059.2821394-1-luiz.dentz@gmail.com>
 <20250225220059.2821394-3-luiz.dentz@gmail.com> <CABBYNZ+32tuRH+T7M=1aeDJJOqHz9qt4ThsuMF4sVpiEeC380A@mail.gmail.com>
 <CABBYNZLwaqD8X8X0vzBR99bJ9uOScufxpOZfgCQDCYYe6FqJHw@mail.gmail.com> <24709b9c28161f1bc300b6117de63975ae92c00c.camel@iki.fi>
In-Reply-To: <24709b9c28161f1bc300b6117de63975ae92c00c.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 6 Mar 2025 11:41:19 -0500
X-Gm-Features: AQ5f1JpGQS2xgNKTH3Lw5UGsBM0-P_lheW_Wp3ph0AjmczNoWyZOIdwRMGDazPo
Message-ID: <CABBYNZJFsJs3U5XpHvHyDit1SuuFiBfcn+sjAn=tyhHV3ZsKFA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 3/3] client: Add support get/set PreferredBearer
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Mar 1, 2025 at 11:17=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> ti, 2025-02-25 kello 17:12 -0500, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Tue, Feb 25, 2025 at 5:10=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Pauli, Bastien,
> > >
> > > On Tue, Feb 25, 2025 at 5:01=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >
> > > > This adds support for PreferredBearer which is printed with the lik=
es of
> > > > info command:
> > > >
> > > > bluetoothctl> info <addr>
> > > > ...
> > > >         PreferredBearer: last-seen
> > > >
> > > > It also introduces a new command to get/set the PreferredBearer:
> > > >
> > > > [bluetoothctl]> bearer --help
> > > > Get/Set preferred bearer
> > > > Usage:
> > > >          bearer <dev> [last-seen/bredr/le]
> > > >
> > > > [bluetoothctl]> bearer <addr>
> > > >         PreferredBearer: last-seen
> > > > [bluetoothctl]> bearer <addr> le
> > > > bluetoothd: @ MGMT Command: Add Device (0x0033) plen 8
> > > >         LE Address: <addr>
> > > >         Action: Auto-connect remote device (0x02)
> > > > [CHG] Device <addr> PreferredBearer: le
> > > > Changing le succeeded
> > > > [bluetoothctl]> bearer <addr>
> > > >         PreferredBearer: le
> > > > [bluetoothctl]> bearer <addr> bredr
> > > > bluetoothd: @ MGMT Command: Remove Device (0x0034) plen 7
> > > >         LE Address: <addr>
> > > > [CHG] Device <addr> PreferredBearer: bredr
> > > > Changing bredr succeeded
> > > > ---
> > > >  client/main.c | 27 +++++++++++++++++++++++++++
> > > >  1 file changed, 27 insertions(+)
> > > >
> > > > diff --git a/client/main.c b/client/main.c
> > > > index feb21a1163d2..76c9bc329c96 100644
> > > > --- a/client/main.c
> > > > +++ b/client/main.c
> > > > @@ -1714,6 +1714,7 @@ static void cmd_info(int argc, char *argv[])
> > > >         print_property(proxy, "AdvertisingFlags");
> > > >         print_property(proxy, "AdvertisingData");
> > > >         print_property(proxy, "Sets");
> > > > +       print_property(proxy, "PreferredBearer");
> > > >
> > > >         battery_proxy =3D find_proxies_by_path(battery_proxies,
> > > >                                         g_dbus_proxy_get_path(proxy=
));
> > > > @@ -2086,6 +2087,30 @@ static void cmd_wake(int argc, char *argv[])
> > > >         return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > > >  }
> > > >
> > > > +static void cmd_bearer(int argc, char *argv[])
> > > > +{
> > > > +       GDBusProxy *proxy;
> > > > +       char *str;
> > > > +
> > > > +       proxy =3D find_device(argc, argv);
> > > > +       if (!proxy)
> > > > +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > > > +
> > > > +       if (argc <=3D 2) {
> > > > +               print_property(proxy, "PreferredBearer");
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       str =3D strdup(argv[2]);
> > > > +
> > > > +       if (g_dbus_proxy_set_property_basic(proxy, "PreferredBearer=
",
> > > > +                                       DBUS_TYPE_STRING, &str,
> > > > +                                       generic_callback, str, free=
))
> > > > +               return;
> > > > +
> > > > +       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > > > +}
> > > > +
> > > >  static void cmd_list_attributes(int argc, char *argv[])
> > > >  {
> > > >         GDBusProxy *proxy;
> > > > @@ -3247,6 +3272,8 @@ static const struct bt_shell_menu main_menu =
=3D {
> > > >                                                         dev_generat=
or },
> > > >         { "wake",         "[dev] [on/off]",    cmd_wake, "Get/Set w=
ake support",
> > > >                                                         dev_generat=
or },
> > > > +       { "bearer",       "<dev> [last-seen/bredr/le]", cmd_bearer,
> > > > +                               "Get/Set preferred bearer", dev_gen=
erator },
> > > >         { } },
> > > >  };
> > > >
> > > > --
> > > > 2.48.1
> > >
> > > So I went ahead and implemented the idea of having PreferredBearer,
> > > this works great when setting bredr it really stops from connecting t=
o
> > > LE, the said the other way around when setting to le seems to confuse
> > > some headsets like EarFun and it ends up connecting both bearers:
> > >
> > > [EarFun Air Pro 3]> transport.show
> > > Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0/fd1
> > >     UUID: Sink PAC                  (00002bc9-0000-1000-8000-00805f9b=
34fb)
> > >     Codec: 0x06 (6)
> > >     Configuration.#0: len 0x02 type 0x01
> > >     Configuration.Sampling Frequency: 16 Khz (0x03)
> > >     Configuration.#1: len 0x02 type 0x02
> > >     Configuration.Frame Duration: 7.5 ms (0x00)
> > >     Configuration.#2: len 0x05 type 0x03
> > >     Configuration.Location: 0x00000001
> > >     Configuration.Location: Front Left (0x00000001)
> > >     Configuration.#3: len 0x03 type 0x04
> > >     Configuration.Frame Length: 30 (0x001e)
> > >     Configuration.#4: len 0x02 type 0x05
> > >     Configuration.Frame Blocks per SDU: 1 (0x01)
> > >     Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
> > >     State: idle
> > >     Volume: 0x00c8 (200)
> > >     Endpoint: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0
> > >     QoS.CIG: 0x00 (0)
> > >     QoS.CIS: 0x00 (0)
> > >     QoS.Framing: 0x00 (0)
> > >     QoS.PresentationDelay: 0x00009c40 (40000)
> > >     QoS.Interval: 0x00001d4c (7500)
> > >     QoS.Latency: 0x0008 (8)
> > >     QoS.SDU: 0x001e (30)
> > >     QoS.PHY: 0x02 (2)
> > >     QoS.Retransmissions: 0x02 (2)
> > >     Location: 0x00000003 (3)
> > >     Links: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0/fd3
> > > Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0/fd2
> > >     UUID: Sink PAC                  (00002bc9-0000-1000-8000-00805f9b=
34fb)
> > >     Codec: 0x06 (6)
> > >     Configuration.#0: len 0x02 type 0x01
> > >     Configuration.Sampling Frequency: 16 Khz (0x03)
> > >     Configuration.#1: len 0x02 type 0x02
> > >     Configuration.Frame Duration: 7.5 ms (0x00)
> > >     Configuration.#2: len 0x05 type 0x03
> > >     Configuration.Location: 0x00000002
> > >     Configuration.Location: Front Right (0x00000002)
> > >     Configuration.#3: len 0x03 type 0x04
> > >     Configuration.Frame Length: 30 (0x001e)
> > >     Configuration.#4: len 0x02 type 0x05
> > >     Configuration.Frame Blocks per SDU: 1 (0x01)
> > >     Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
> > >     State: idle
> > >     Volume: 0x00c8 (200)
> > >     Endpoint: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0
> > >     QoS.CIG: 0x00 (0)
> > >     QoS.CIS: 0x01 (1)
> > >     QoS.Framing: 0x00 (0)
> > >     QoS.PresentationDelay: 0x00009c40 (40000)
> > >     QoS.Interval: 0x00001d4c (7500)
> > >     QoS.Latency: 0x0008 (8)
> > >     QoS.SDU: 0x001e (30)
> > >     QoS.PHY: 0x02 (2)
> > >     QoS.Retransmissions: 0x02 (2)
> > >     Location: 0x00000003 (3)
> > >     Links: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0/fd4
> > > Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0/fd3
> > >     UUID: Source PAC                (00002bcb-0000-1000-8000-00805f9b=
34fb)
> > >     Codec: 0x06 (6)
> > >     Configuration.#0: len 0x02 type 0x01
> > >     Configuration.Sampling Frequency: 48 Khz (0x08)
> > >     Configuration.#1: len 0x02 type 0x02
> > >     Configuration.Frame Duration: 7.5 ms (0x00)
> > >     Configuration.#2: len 0x05 type 0x03
> > >     Configuration.Location: 0x00000001
> > >     Configuration.Location: Front Left (0x00000001)
> > >     Configuration.#3: len 0x03 type 0x04
> > >     Configuration.Frame Length: 90 (0x005a)
> > >     Configuration.#4: len 0x02 type 0x05
> > >     Configuration.Frame Blocks per SDU: 1 (0x01)
> > >     Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
> > >     State: idle
> > >     Volume: 0x00c8 (200)
> > >     Endpoint: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0
> > >     QoS.CIG: 0x00 (0)
> > >     QoS.CIS: 0x00 (0)
> > >     QoS.Framing: 0x00 (0)
> > >     QoS.PresentationDelay: 0x00009c40 (40000)
> > >     QoS.Interval: 0x00001d4c (7500)
> > >     QoS.Latency: 0x000f (15)
> > >     QoS.SDU: 0x005a (90)
> > >     QoS.PHY: 0x02 (2)
> > >     QoS.Retransmissions: 0x05 (5)
> > >     Location: 0x00000003 (3)
> > >     Links: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0/fd1
> > > Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0/fd4
> > >     UUID: Source PAC                (00002bcb-0000-1000-8000-00805f9b=
34fb)
> > >     Codec: 0x06 (6)
> > >     Configuration.#0: len 0x02 type 0x01
> > >     Configuration.Sampling Frequency: 48 Khz (0x08)
> > >     Configuration.#1: len 0x02 type 0x02
> > >     Configuration.Frame Duration: 7.5 ms (0x00)
> > >     Configuration.#2: len 0x05 type 0x03
> > >     Configuration.Location: 0x00000002
> > >     Configuration.Location: Front Right (0x00000002)
> > >     Configuration.#3: len 0x03 type 0x04
> > >     Configuration.Frame Length: 90 (0x005a)
> > >     Configuration.#4: len 0x02 type 0x05
> > >     Configuration.Frame Blocks per SDU: 1 (0x01)
> > >     Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
> > >     State: idle
> > >     Volume: 0x00c8 (200)
> > >     Endpoint: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0
> > >     QoS.CIG: 0x00 (0)
> > >     QoS.CIS: 0x01 (1)
> > >     QoS.Framing: 0x00 (0)
> > >     QoS.PresentationDelay: 0x00009c40 (40000)
> > >     QoS.Interval: 0x00001d4c (7500)
> > >     QoS.Latency: 0x000f (15)
> > >     QoS.SDU: 0x005a (90)
> > >     QoS.PHY: 0x02 (2)
> > >     QoS.Retransmissions: 0x05 (5)
> > >     Location: 0x00000003 (3)
> > >     Links: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0/fd2
> > > Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/fd5
> > >     UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b=
34fb)
> > >     Codec: 0x02 (2)
> > >     Media Codec: MPEG24
> > >     Object Types: MPEG-4 AAC LC
> > >     Frequencies: 48kHz
> > >     Channels: 2
> > >     Bitrate: 320000
> > >     VBR: Yes
> > >     Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
> > >     State: idle
> > >     Delay: 0x0960 (2400)
> > >     Volume: 0x0064 (100)
> >
> > Forgot to mention, but with the above transports it seems to confuse
> > the gnome audio output selection, it doesn't seem to be able to mix
> > A2DP and BAP transports for some reason, so when I select the device
> > it enables BAP but A2DP is not shown as an option.
>
> I'll have to see if I can reproduce that on current PW master branch.
>
> The visibility of profiles in theory should only cares about whether
> the UUIDs appear in both device properties and transport.

I think I will merge these changes since the property is marked as
experimental; we can always change it or revert later.

--=20
Luiz Augusto von Dentz
