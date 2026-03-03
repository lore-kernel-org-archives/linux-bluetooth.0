Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEC335F160
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569864; cv=pass; b=rK3yp5P0HPX23Ofmn0z2UgDCDrzR8PVlcL4593p2q/Gv2eMtb0euqQ0/PWuLY3glDOcFyl+JHfHuRgIMbp1n+qOV1bbtZwzdUijDWc7pUAV3+lWeOPBGyogpzX+3UBz3Fam8mLp65VTtVHpatX8D3+wTjDHNWTiGHx3U6XGBPBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569864; c=relaxed/simple;
	bh=0uWayP55JYPkvyG+s/f6o+MuVr5Iu4mXX7kNtR/wJ6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dbs4eCMhdGXzMUxpss2u0asBTw0dwL+UHGNLDXVUI5y4NQ7XSh99sAvAE4sNB3mM197m46upKywa41S3WhYjQtGKwZvEyAQUbhf8qNddZ1zzVdTHh3ooKXqlDB6nF1RKVwENP81nbynUnLqJCQZNNBR5YCOX1CpT7qX/J7KekmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbS+wKfX; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbS+wKfX"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40f387a688dso964000fac.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Mar 2026 12:31:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772569861; cv=none;
        d=google.com; s=arc-20240605;
        b=kGBOwrUw4B+sOFBKO38EjTT6FdqlnOioV6rOqm2X68Jdh2r8994vo/d0sklVL2paDh
         YsZQnQQVghPndAkWeMe487kj4817adK7U/tdVv0nU3uzz6a3TzHiwSGSlbAGGd9moy/q
         UkRB5GY8AVaiiKJ6ms0ZfQx5xpbloG0n/DeNPFi0BiQwLsCaPDnRJcpup27GcRoRGGGE
         gcMXl3vXXbl3ck3rOQXlJP2yrcfalqtZGBcVv3j5UCorKUabSOoMH4dMZuzpnUjQOGgs
         Ph2Js6UQYNxBcK6XPvkcsi65XMq9xGwRa53yIJi5J583KElZkWiwXgUwKmJHNUKDN61c
         T4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sRMvf1t5OGogsINyPWvlitgEJ+xtwudyn7RluGy3UII=;
        fh=qUOyp7TJ0ob0ZhVsCpKWFNuOSLzsvyI5QvlJKxWqiUo=;
        b=ki69CF5VqCybsr7Weq/dpH5/DME95jgXPik5GxY404P9MPiIlAoW/HyBMhJiAaMg1Z
         z1SGPyGbsmHwnXW/g1LZnLnnozx0JkYw4/g7SiwBUZHkrQ54q7PHMPvUFbPSEaycC3Tc
         05AAE8CqPsRPYCyPk74AUID0r4SpAg0QtvpF7w1xKdtco8Lck6+AKu4jRYqvODzOfPFK
         n1ki8aGyQHlIkO+/n6QuOJSRT/Jc4CVhg++bys5ADm5Sm1EKKEvPXShpdKxoFLmOWJT6
         MTQTMlfE/6Yyj6QRy1ZQ62HzRzWHDvbHhB6oM7e0/qxTzgoyWPxs9z5W9YFpn+fIxLTY
         Mg+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772569861; x=1773174661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRMvf1t5OGogsINyPWvlitgEJ+xtwudyn7RluGy3UII=;
        b=mbS+wKfXfcT1CduhGWOya3qMQeZ1IbMLXn5vqKONo+HD9L4eegkOAaIejGEp4n+Y/m
         0pzhtl8JmiZ8U83+keV//onqENKgqCKpKjjvtjSyGX3wJxzJ49E3UIvo2hMFNX1PdBvt
         IQX+kSP0jcObZGzruoArYvmrHOXAYMOK6AfJ5GfrAYECBHZTl3dKX3gAU7lkezCamMYv
         jIa+J7E6x0xWFKBAeypbMaUp6O7vREfuKVVcZ4S5zmyS3Jg0OrFtTZn3TQ0+xY7TYYZU
         lmItOGdLQg+fqLfn6GNuBZV0GNrfEV8+700zN/eetDdn9lebBXeW0G7ti6vLYyDwNomG
         xp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772569861; x=1773174661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sRMvf1t5OGogsINyPWvlitgEJ+xtwudyn7RluGy3UII=;
        b=A7ta17YiNqch2mzblQaWAJDLjLxbOauhqPYBURpkz721cAJ34i8FpHxNgIv/jdiXqe
         26RDZMSowuUu4Tx24Dc1g9tKo7PznH+Yf5yrD0Z3eUzeCVevui7nEsNFOb/PHf7v6yAR
         NU7d8pM7NsnzLsou2GwPWyNuW27+HHl8qixvLXb4YooWgo8zVvJ611JfylmOqHVvVxK/
         6AJMqn2ySy/jXf+VzSF6NqWHIAznbtlbKNk4b8ijtOQ5aU+YSR1R9gZTmEyvjkGES68p
         b7/r0k7vlULG5zjCpRV8EpM/QwT3SQEVGvY7uEgPvpXa3xGZXrbvsy6/LoHTa2eRnqjf
         xq+A==
X-Gm-Message-State: AOJu0YxxGWUh2G1da1pZU/km/mEQldK9Blik6I0zmmvp4Fv+qHxeYkcS
	UyvtlhocIEbh1sffHMNbOXiVRn14f+ODpiaRAMrR8IBvuJjgQ34PXdXdHFYyYFcJQ/SKoTBcC1A
	EZF7Fed670MmPN+aCeE7j9jAQH3zkUIJNGmA9Iw1QATp7
X-Gm-Gg: ATEYQzxZuJ4zH8fcGfGOoclmA5tJUWmREjQrTNrHbEGQxfpb6UtA0iSzyBHmVRg0XEO
	cisSuAeUjeUZ2Jb2m6HNvfpVnBdjZigRdmGRwqFcyssdcOuUc47D28ePXxRUBa1uO7/4JfrnwGv
	uagvVB+iJp4QLpSX/mgA/QqolcHWJOryDQQMCIqbcXSSHsIre6NBiP3oZMRhpeM4B4asLDETSuN
	gXS9WGpVXqn+vtIcojv37J+wsGcdJUod98OaVQneY05fIXNy7rgi31lrVNqpxuonoVeYIDkDZjo
	k86cPZ0qDH/VYk+FbGN0/1PkCvdu5cXSGeo/UrH+U0ZbNwANKAxZ8i+cGw==
X-Received: by 2002:a05:6870:8275:b0:3f5:b16e:82d6 with SMTP id
 586e51a60fabf-41626eb5cefmr9542834fac.16.1772569861121; Tue, 03 Mar 2026
 12:31:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302233756.910702-1-dajid.morel@volvo.com>
 <CABBYNZJtZZ7mHJinJY9ZfhfHbYUC9aEmoRx9ACz5R4HSwepyFg@mail.gmail.com>
 <CAM8DPm26RVUJbgA+Lutqshu+ZqkVtNaVrKdG-k1WdE0rcSe0dQ@mail.gmail.com> <CABBYNZKxUJUtZTNe0+ot1JmNDyLzf3x-TyN+TqPz-o5xMmx=6A@mail.gmail.com>
In-Reply-To: <CABBYNZKxUJUtZTNe0+ot1JmNDyLzf3x-TyN+TqPz-o5xMmx=6A@mail.gmail.com>
From: Dajid Morel <dajidp.morel@gmail.com>
Date: Tue, 3 Mar 2026 21:30:50 +0100
X-Gm-Features: AaiRm53Poq3dfA-yOV_2FxuqTqS6Z9m_YZOkonOgNxjlrkk7c_6t5t0dwZZXFoA
Message-ID: <CAM8DPm24s+2raquaofgPoroTMECGdKeba7pnDz5X64wN66yjiw@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Dajid MOREL <dajid.morel@volvo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 8:26 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> That is waiting 40 seconds as expected, so I'm not sure what is
> causing it to time out in 2 seconds but that is definitely the
> expected behavior.

Hi Luiz,

Thank you for providing those logs. Seeing the 40.5-second delta in
your environment is very insightful and confirms that the standard
stack should wait much longer than what I am observing.

I have finally identified the root cause of the 2-second abort in my
setup. My environment uses industrial TE Connectivity M5600 sensors,
which are designed for ultra-low power consumption with a long
advertising interval of 5 seconds.

After auditing the kernel source, I found that HCI_CMD_TIMEOUT is
hardcoded to 2.0 seconds (#define HCI_CMD_TIMEOUT
msecs_to_jiffies(2000)).

When the kernel issues HCI_OP_LE_CREATE_CONN, the local controller
(Broadcom on RPi4 or Rockchip on Rock 4 C+) must wait for the next
advertisement from the sensor to proceed with the connection. Since
the M5600 only wakes up every 5s, the 2-second HCI_CMD_TIMEOUT
systematically triggers before the controller can receive the
advertisement and acknowledge the command completion. This leads to an
immediate abort, even if the sensor is physically next to a high-gain
antenna (9.4dBi).

This explains why my v4 patch (forcing conn_timeout to 20s) worked as
a side-effect: it kept the connection structure alive just long enough
to bypass the immediate impact of the HCI command timeout, but it was
architecturally the wrong target.

I officially withdraw this patch series.

However, this 2-second hardcoded limit for HCI_CMD_TIMEOUT seems
fundamentally incompatible with many industrial low-duty-cycle
sensors. Many developers on various forums resort to kernel hacks to
bypass this.

Would you consider a patch that either:
1. Increases HCI_CMD_TIMEOUT globally to 5 or 10 seconds?
2. Or makes the LE connection command timeout specifically
configurable via the Management API or main.conf?

I would like to work on a cleaner solution that accommodates these
low-power industrial sleep cycles without breaking existing tools.

Best regards,

Dajid Morel
Volvo Group


Le mar. 3 mars 2026 =C3=A0 20:26, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> a =C3=A9crit :
>
> Hi Dajid,
>
> On Tue, Mar 3, 2026 at 1:57=E2=80=AFPM Dajid Morel <dajidp.morel@gmail.co=
m> wrote:
> >
> > On Tue, Mar 3, 2026 at 6:24 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Dajid,
> > > Well except if you can point us where the 2 second timeout is coming
> > > from I don't see how this proves that there is a strict 2-second
> > > timeout, in fact I already point you that in the previous thread, it
> > > seems there is something programming the SO_SNDTIMEO to be 2 seconds
> > > which is why you could only overcome it by hardcoding a 20 sec fixed
> > > timeout, so you are actually introduce a strict timeout yourself with
> > > this change, so application wouldn't be able to set their own timeout
> > > when needed.
> >
> > Hi Luiz,
> >
> > Thank you for your response. Following your suggestion that something
> > in userspace might be programming SO_SNDTIMEO to 2 seconds, I dug into
> > the entire stack to verify this.
> >
> > I completely agree that my v4 patch (hardcoding 20s globally in the
> > kernel) is architecturally flawed because it breaks SO_SNDTIMEO for
> > testing tools that legitimately rely on shorter timeouts. I formally
> > withdraw the v4 patch.
> >
> > However, regarding the origin of the 2-second timeout in standard use
> > cases, a deep dive into the stack reveals a gap between the API and
> > the socket creation:
> >
> > 1. Python/Bleak layer: When an application sets a 45s timeout, it only
> > sets an internal asyncio timer. The actual command sent via D-Bus
> > (org.bluez.Device1.Connect) takes no timeout parameter.
> > 2. BlueZ (bluetoothd) layer: A `grep -rn "setsockopt" btio/` in the
> > BlueZ tree shows that while btio.c configures many socket options
> > (like L2CAP_LM, BT_SECURITY), it never sets SO_SNDTIMEO for standard
> > D-Bus clients. A global search confirms SO_SNDTIMEO is only used
> > within the tools/ directory (e.g., l2cap-tester.c).
> >
> > This means that when an application requests a connection via D-Bus,
> > bluetoothd passes the request down and creates the L2CAP socket
> > without configuring SO_SNDTIMEO.
> >
> > Because the socket is created "naked" regarding timeouts, it falls
> > entirely back to the kernel's default behavior, which is governed by
> > the hardcoded 2-second conn_timeout in hci_conn.c. Userspace is
> > bypassed and blindly waits for its own 45s timer to expire.
> >
> > (Note: I have systematically reproduced this exact 2-second abort
> > issue across different hardware platforms and Bluetooth controllers,
> > including Raspberry Pi 4, BeagleY-AI, and Rock 4 C+, confirming it is
> > a core stack limitation, not a vendor-specific firmware quirk).
> >
> > To fix this properly without touching the kernel, would you accept a
> > patch to BlueZ (bluetoothd / btio) instead? We could make bluetoothd
> > explicitly call setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, ...) when
> > establishing LE connections via D-Bus, drawing the value from a new
> > configurable parameter in main.conf (e.g., LEConnectionTimeout).
> >
> > I would be happy to draft this BlueZ userspace patch if you agree this
> > is the correct architectural approach to unblock industrial D-Bus
> > clients.
>
>
> memcheck-amd64-[97587]: =3D src/device.c:device_connect_le() Connection
> attempt to: 70:5A:6F:63:B6:41
>
>
> 14:18:45.430382
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6
>
>
>                                                #1 [hci0]
> 14:18:45.432666
>         Extended scan: Disabled (0x00)
>         Filter duplicates: Disabled (0x00)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                                           =
                                                                           =
                                     #2 [hci0] 14:18:45.533046
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 1
>         Status: Success (0x00)
> < HCI Command: LE Set Address Resolution Enable (0x08|0x002d) plen 1
>
>
>                                                #3 [hci0]
> 14:18:45.533072
>         Address resolution: Disabled (0x00)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                                           =
                                                                           =
                                     #4 [hci0] 14:18:45.534056
>       LE Set Address Resolution Enable (0x08|0x002d) ncmd 1
>         Status: Success (0x00)
> < HCI Command: LE Add Device To Accept List (0x08|0x0011) plen 7
>
>
>                                                #5 [hci0]
> 14:18:45.534065
>         Address type: Public (0x00)
>         Address: 70:5A:6F:63:B6:41 (OUI 70-5A-6F)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                                           =
                                                                           =
                                     #6 [hci0] 14:18:45.535023
>       LE Add Device To Accept List (0x08|0x0011) ncmd 1
>         Status: Success (0x00)
> < HCI Command: LE Set Address Resolution Enable (0x08|0x002d) plen 1
>
>
>                                                #7 [hci0]
> 14:18:45.535030
>         Address resolution: Enabled (0x01)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                                           =
                                                                           =
                                     #8 [hci0] 14:18:45.536031
>       LE Set Address Resolution Enable (0x08|0x002d) ncmd 1
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13
>
>
>                                                #9 [hci0]
> 14:18:45.536039
>         Own address type: Public (0x00)
>         Filter policy: Ignore not in accept list (0x01)
>         PHYs: 0x05
>         Entry 0: LE 1M
>           Type: Passive (0x00)
>           Interval: 60.000 msec (0x0060)
>           Window: 60.000 msec (0x0060)
>         Entry 1: LE Coded
>           Type: Passive (0x00)
>           Interval: 180.000 msec (0x0120)
>           Window: 180.000 msec (0x0120)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                                           =
                                                                           =
                                    #10 [hci0] 14:18:45.537026
>       LE Set Extended Scan Parameters (0x08|0x0041) ncmd 1
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6
>
>
>                                               #11 [hci0]
> 14:18:45.537040
>         Extended scan: Enabled (0x01)
>         Filter duplicates: Enabled (0x01)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                                           =
                                                                           =
                                    #12 [hci0] 14:18:45.537969
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 1
>         Status: Success (0x00)
> @ MGMT Event: Connect Failed (0x000d) plen 8
>
>
>                                          {0x0001} [hci0]
> 14:19:25.941624
>         LE Address: 70:5A:6F:63:B6:41 (OUI 70-5A-6F)
>         Status: Disconnected (0x0e)
> memcheck-amd64-[97587]: =3D src/device.c:att_connect_cb() connect to
> 70:5A:6F:63:B6:41: Connection refused (111)
>
>
> 14:19:25.943909
>
> That is waiting 40 seconds as expected, so I'm not sure what is
> causing it to time out in 2 seconds but that is definitely the
> expected behavior.
>
> > Best regards,
> >
> > Dajid Morel
> > Volvo Group
> >
> >
> > Le mar. 3 mars 2026 =C3=A0 18:24, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> a =C3=A9crit :
> > >
> > > Hi Dajid,
> > >
> > > On Mon, Mar 2, 2026 at 6:43=E2=80=AFPM Dajid MOREL <dajidp.morel@gmai=
l.com> wrote:
> > > >
> > > > In an industrial IoT context at Volvo Group, we use TE Connectivity
> > > > BLE pressure sensors. These sensors exhibit high latency during
> > > > the initial LE connection handshake in noisy RF environments. The
> > > > connection systematically fails on Ubuntu Core 22 (BlueZ) because t=
he
> > > > connection attempt is aborted too early.
> > > >
> > > > In the v2 thread, it was suggested that userspace (via setsockopt
> > > > SO_SNDTIMEO) dictates the connection timeout (defaulting to 40s),
> > > > suspecting that userspace was cutting the connection at 2 seconds,
> > > > not the kernel.
> > > >
> > > > To verify this, an empirical test was conducted using the following
> > > > Python/Bleak script to force the application timeout to 45.0 second=
s:
> > > >
> > > >   import asyncio
> > > >   from bleak import BleakClient, BleakScanner
> > > >   import time
> > > >
> > > >   ADDRESS =3D "E8:C0:B1:D4:A3:3C"
> > > >
> > > >   async def test_connection():
> > > >       device =3D await BleakScanner.find_device_by_address(ADDRESS,=
 timeout=3D15.0)
> > > >       start_time =3D time.time()
> > > >       try:
> > > >           # Forcing 45s timeout in userspace
> > > >           async with BleakClient(device, timeout=3D45.0) as client:
> > > >               print(f"Connected in {time.time() - start_time:.2f}s"=
)
> > > >       except Exception as e:
> > > >           print(f"Failed after {time.time() - start_time:.2f}s: {e}=
")
> > > >
> > > >   asyncio.run(test_connection())
> > > >
> > > > 1. Result on UNMODIFIED Kernel: The userspace script patiently wait=
ed
> > > >    for the full 45 seconds before raising a TimeoutError. If the ke=
rnel
> > > >    had actually kept the radio connection attempt alive for those
> > > >    45 seconds, the connection would have succeeded around the
> > > >    12.5-second mark (as proven by the patched kernel test below).
> > > >    The fact that it did not proves that the underlying HCI connecti=
on
> > > >    attempt was aborted early by the kernel. Userspace was blind to =
this
> > > >    abort and kept waiting in a vacuum.
> > > >
> > > > 2. Result on MODIFIED Kernel (with this patch): Using the exact sam=
e
> > > >    userspace script (45.0s timeout), the connection successfully
> > > >    established at the 12.51-second mark.
> > > >
> > > > Conclusion:
> > > > This proves that the underlying HCI LE Connection creation is bound=
 by
> > > > a strict 2-second timeout derived from `conn_timeout` in `hci_conn.=
c`,
> > > > and that userspace socket options do not override this hardcoded HC=
I
> > > > abort in our stack. The sensor physically takes 12.5 seconds to
> > > > handshake, making the 2-second kernel limit a hard blocker.
> > >
> > > Well except if you can point us where the 2 second timeout is coming
> > > from I don't see how this proves that there is a strict 2-second
> > > timeout, in fact I already point you that in the previous thread, it
> > > seems there is something programming the SO_SNDTIMEO to be 2 seconds
> > > which is why you could only overcome it by hardcoding a 20 sec fixed
> > > timeout, so you are actually introduce a strict timeout yourself with
> > > this change, so application wouldn't be able to set their own timeout
> > > when needed.
> > >
> > > > This patch increases the hardcoded LE connection timeout to 20 seco=
nds
> > > > to provide a comfortable margin for handshake retries.
> > > >
> > > > Note: If the upstream preference is to not hardcode 20 seconds glob=
ally,
> > > > I would be happy to submit a v5 that exposes this as a configurable
> > > > module parameter (e.g., `le_conn_timeout`).
> > > > ---
> > > >  net/bluetooth/hci_conn.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > > index a47f5daffdbf..7edce4126900 100644
> > > > --- a/net/bluetooth/hci_conn.c
> > > > +++ b/net/bluetooth/hci_conn.c
> > > > @@ -1436,7 +1436,7 @@ struct hci_conn *hci_connect_le(struct hci_de=
v *hdev, bdaddr_t *dst,
> > > >         }
> > > >
> > > >         conn->sec_level =3D BT_SECURITY_LOW;
> > > > -       conn->conn_timeout =3D conn_timeout;
> > > > +       conn->conn_timeout =3D msecs_to_jiffies(20000);
> > > >         conn->le_adv_phy =3D phy;
> > > >         conn->le_adv_sec_phy =3D sec_phy;
> > > >
> > > > @@ -1664,7 +1664,7 @@ struct hci_conn *hci_connect_le_scan(struct h=
ci_dev *hdev, bdaddr_t *dst,
> > > >         set_bit(HCI_CONN_SCANNING, &conn->flags);
> > > >         conn->sec_level =3D BT_SECURITY_LOW;
> > > >         conn->pending_sec_level =3D sec_level;
> > > > -       conn->conn_timeout =3D conn_timeout;
> > > > +       conn->conn_timeout =3D msecs_to_jiffies(20000);
> > > >         conn->conn_reason =3D conn_reason;
> > > >
> > > >         hci_update_passive_scan(hdev);
> > > > --
> > > > 2.34.1
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
