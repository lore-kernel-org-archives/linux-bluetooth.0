Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8BD39658E
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565998; cv=pass; b=MFJSxR18i6hDpfORw2WUk8ymei2+KVPak4OGln6gZEob0TvHG4Kwg+kSfucuJeK1jpCgabO5ofy5uzcRDNGfUoxSQh1kSAMU9M2mgfDz63OwhuRtZKcxTGPNbwnOm3fMEJAdAXz2GfbA5j6VOrcvzGD8wLXQsB9Ng1lOIjPx7Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565998; c=relaxed/simple;
	bh=dlyhOrhoMhUWuxWQlaolYiObZOZn+m2kMIyHC1zkzbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sG4/L/F2tnAVbwy+6PNP15mqUHJI1HLq0l5gjBi1QNq2loYm8OpmTSv+7DK6SeAs96o34haT4Wx0DPZtobo/0fUQt2DHctouFrrPHLzOm+RnVP0Mj008q3WVwnX3ow/WdZxiKyIRrNJMPWOyNrXtOPObmXzZ/xMIejejjPjdAeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea+JTY0e; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea+JTY0e"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64c9fcc24b3so4489291d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Mar 2026 11:26:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772565996; cv=none;
        d=google.com; s=arc-20240605;
        b=YOlQz4zQXt4O3yV5O5xeCnGRNmm7LIpNtvEhjAzYEAYrKVlthf0HG1zX3C2THsj2dI
         X+/fCFwvX+SK59fzAzggvt/4lRtiCJ5jq6BVeo+uTLeuLqWCaPJq+Rn+6edEU3Ec3RFH
         hyrKMsbs98GbJCq61s0eMZtmplzCZ7ybJF/HThFVqADWRpK2UBQ4cp5bGhrGwypqqsF2
         ySCdPq7NwUDPdh2Q0dKRZySRDREa90m1w8wmaCF53MpMxUe6rSLZl7ZoyOcJDFOgqBag
         k3ZdTxbH7Ja3JDD8ABdthc2YRbY3+kUaPGpHBpKyj5zNrETmFbo23SUbYvcgLb2wm3/9
         EVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UA3B2uAeZiluecbKQmdKwN1UA0hw/h6epxyf+0CDc4U=;
        fh=KXcOb5vphlZLN1D9IwLcOrc/UM2jVmDyJWWf/pmWc4g=;
        b=QC7x12Oyyj5S5Ty//4MffHqO67zuBe+awBSwc7STVXgvX2d5HwIT+qAV7WkOd4DM1w
         1DI4OmoGLzrEX+Q72jVBJsQ9E34kTDR2+esNrSG4wS8o4wvJUM6VAtXyT2KyFwBEDKjp
         0IDJ3EdAC31pqleD0Cfxgzdr+4g0yKSSOXK1pa9JKoZbPt4o27sAYUK/MnQ0iIUJMrZ6
         upyKu7pSu5xPXKgw6UgdewsiDwjV1XsEfiim17aB+Az7Cfb+k0sgN5z9+6hV8Xh/p5qT
         XryQhyIP250kyVDSHLEPNm4Cn0SIvoyou0a+p21ETWj8WQbrW8T17Eg5bhZHmK68C6Aj
         J8xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772565996; x=1773170796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UA3B2uAeZiluecbKQmdKwN1UA0hw/h6epxyf+0CDc4U=;
        b=Ea+JTY0eydbFuua/Y+lEzaKk3SseBLc5K6HwsrmpO2TuHnKLN/lUmfPXyKR00rrebe
         da9KY0kdUlsAkq845lH85sBso26QNGboIY7pWBvogNTiOH1PxstLiGYXS9HHheqB+LP9
         BplkpQ1DNQZFViBXeGZpiskyZZqGugK36BrO+CmUWIJK4kUwE6pLkR/bS7QWCPuW0Mag
         XwuNhe1N2Vjr9p72/JBikDq4UOVjVCXOQcqhiNJLf+82jLw4RRLFumBHIU6X/jpPeqk9
         VHhjS3+p844ziZIQRBOUDkfdf7GVRnhhc4FoiEu8b/py8Q0oK/JbMlhjrqF4EbQpMzBJ
         6N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772565996; x=1773170796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UA3B2uAeZiluecbKQmdKwN1UA0hw/h6epxyf+0CDc4U=;
        b=EgPjo3iJnVp2sQTFMq7t5I1Ki/fA5OGSC1Gsq/39Tpq8SyvFjzF+cVVpYV0/s3o6f6
         aiiUiJUnxNXJYyoM2PWiUxu1oObMfBkb9jpXorjXnG5fJA75M/Zza3lFe6yMMEzQmDSs
         UlrlQ01MfcdaJ9qCZxSSGmYcM4A+f8F18bVh2SsfxpU9xHFh03BrH8bqfHY7o9OYRjnE
         F3xS/yyrtWzTLgwJnnooub8qagUas1G29d/0JzfUKDTGKcoH7GEpGDw9ouvhVQF4T6xg
         aNtv1Fr+Xr1CrF4n8H91RohVd3DiMU78uH6/WhGHRygekL/MC2tfoY3QIzMWqNNdqJqa
         CIiw==
X-Gm-Message-State: AOJu0YxVw/XLfkK7+pC731G0TQIxi9JvZOW9lw8R+zF5gwIqBUGbcUXt
	alGcN0qGGXtH+xUKBoBPA8IgzaN48xXrFpdnoligU2TWZf+8oAsGhJyR2zavYU+jyw9JZcFiZ/B
	CbgCMr4RD+p7qUdQJ2QrVTYDcKS3pbek=
X-Gm-Gg: ATEYQzxNAZSNrXVVpr6ReiO2pqvJqgdX+WNIT5XCIH23gJdePk4Jw3mYPnjucKyohXo
	2rED3FLyEDm6KSoe6LRyd7G3eqI56qb6jp1b4vttY/vLUXsSDJI1A9/BeDLvA/HoJFBlicml0px
	YgomQMLTcrXEhP/oW1LTdKmxLRM5yATQaCI90x4lhd8SCkV7cclKQu3hP3JyjTQfwTXedCnJ5q1
	52sR85SlixjmAVEDl4xUDJRfuYJ7XgO/voA2ebUrjdfHBtJbth0BOeIWqLyFODOH8UUsiw70jmd
	I/fXQHYZhWwSWY/Gtzc4VIX1N17Um8W5EcPvUKkSaduSZ19iRTRJtX6ph3uWrY32Gu++Ng==
X-Received: by 2002:a53:d206:0:b0:64c:a81e:c229 with SMTP id
 956f58d0204a3-64cc22c3e23mr10552431d50.71.1772565995849; Tue, 03 Mar 2026
 11:26:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302233756.910702-1-dajid.morel@volvo.com>
 <CABBYNZJtZZ7mHJinJY9ZfhfHbYUC9aEmoRx9ACz5R4HSwepyFg@mail.gmail.com> <CAM8DPm26RVUJbgA+Lutqshu+ZqkVtNaVrKdG-k1WdE0rcSe0dQ@mail.gmail.com>
In-Reply-To: <CAM8DPm26RVUJbgA+Lutqshu+ZqkVtNaVrKdG-k1WdE0rcSe0dQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Mar 2026 14:26:24 -0500
X-Gm-Features: AaiRm51_T10N-j3t0SSg6FR2YPAStuwAhQuK-tY8CMkSSBnuAoKb2cMrIrNmVsE
Message-ID: <CABBYNZKxUJUtZTNe0+ot1JmNDyLzf3x-TyN+TqPz-o5xMmx=6A@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Dajid Morel <dajidp.morel@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Dajid MOREL <dajid.morel@volvo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dajid,

On Tue, Mar 3, 2026 at 1:57=E2=80=AFPM Dajid Morel <dajidp.morel@gmail.com>=
 wrote:
>
> On Tue, Mar 3, 2026 at 6:24 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Dajid,
> > Well except if you can point us where the 2 second timeout is coming
> > from I don't see how this proves that there is a strict 2-second
> > timeout, in fact I already point you that in the previous thread, it
> > seems there is something programming the SO_SNDTIMEO to be 2 seconds
> > which is why you could only overcome it by hardcoding a 20 sec fixed
> > timeout, so you are actually introduce a strict timeout yourself with
> > this change, so application wouldn't be able to set their own timeout
> > when needed.
>
> Hi Luiz,
>
> Thank you for your response. Following your suggestion that something
> in userspace might be programming SO_SNDTIMEO to 2 seconds, I dug into
> the entire stack to verify this.
>
> I completely agree that my v4 patch (hardcoding 20s globally in the
> kernel) is architecturally flawed because it breaks SO_SNDTIMEO for
> testing tools that legitimately rely on shorter timeouts. I formally
> withdraw the v4 patch.
>
> However, regarding the origin of the 2-second timeout in standard use
> cases, a deep dive into the stack reveals a gap between the API and
> the socket creation:
>
> 1. Python/Bleak layer: When an application sets a 45s timeout, it only
> sets an internal asyncio timer. The actual command sent via D-Bus
> (org.bluez.Device1.Connect) takes no timeout parameter.
> 2. BlueZ (bluetoothd) layer: A `grep -rn "setsockopt" btio/` in the
> BlueZ tree shows that while btio.c configures many socket options
> (like L2CAP_LM, BT_SECURITY), it never sets SO_SNDTIMEO for standard
> D-Bus clients. A global search confirms SO_SNDTIMEO is only used
> within the tools/ directory (e.g., l2cap-tester.c).
>
> This means that when an application requests a connection via D-Bus,
> bluetoothd passes the request down and creates the L2CAP socket
> without configuring SO_SNDTIMEO.
>
> Because the socket is created "naked" regarding timeouts, it falls
> entirely back to the kernel's default behavior, which is governed by
> the hardcoded 2-second conn_timeout in hci_conn.c. Userspace is
> bypassed and blindly waits for its own 45s timer to expire.
>
> (Note: I have systematically reproduced this exact 2-second abort
> issue across different hardware platforms and Bluetooth controllers,
> including Raspberry Pi 4, BeagleY-AI, and Rock 4 C+, confirming it is
> a core stack limitation, not a vendor-specific firmware quirk).
>
> To fix this properly without touching the kernel, would you accept a
> patch to BlueZ (bluetoothd / btio) instead? We could make bluetoothd
> explicitly call setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, ...) when
> establishing LE connections via D-Bus, drawing the value from a new
> configurable parameter in main.conf (e.g., LEConnectionTimeout).
>
> I would be happy to draft this BlueZ userspace patch if you agree this
> is the correct architectural approach to unblock industrial D-Bus
> clients.


memcheck-amd64-[97587]: =3D src/device.c:device_connect_le() Connection
attempt to: 70:5A:6F:63:B6:41


14:18:45.430382
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6


                                               #1 [hci0]
14:18:45.432666
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                           =
                                                                           =
                                   #2 [hci0] 14:18:45.533046
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Address Resolution Enable (0x08|0x002d) plen 1


                                               #3 [hci0]
14:18:45.533072
        Address resolution: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                           =
                                                                           =
                                   #4 [hci0] 14:18:45.534056
      LE Set Address Resolution Enable (0x08|0x002d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Add Device To Accept List (0x08|0x0011) plen 7


                                               #5 [hci0]
14:18:45.534065
        Address type: Public (0x00)
        Address: 70:5A:6F:63:B6:41 (OUI 70-5A-6F)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                           =
                                                                           =
                                   #6 [hci0] 14:18:45.535023
      LE Add Device To Accept List (0x08|0x0011) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Address Resolution Enable (0x08|0x002d) plen 1


                                               #7 [hci0]
14:18:45.535030
        Address resolution: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                           =
                                                                           =
                                   #8 [hci0] 14:18:45.536031
      LE Set Address Resolution Enable (0x08|0x002d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13


                                               #9 [hci0]
14:18:45.536039
        Own address type: Public (0x00)
        Filter policy: Ignore not in accept list (0x01)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Passive (0x00)
          Interval: 60.000 msec (0x0060)
          Window: 60.000 msec (0x0060)
        Entry 1: LE Coded
          Type: Passive (0x00)
          Interval: 180.000 msec (0x0120)
          Window: 180.000 msec (0x0120)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                           =
                                                                           =
                                  #10 [hci0] 14:18:45.537026
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6


                                              #11 [hci0]
14:18:45.537040
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                           =
                                                                           =
                                  #12 [hci0] 14:18:45.537969
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Connect Failed (0x000d) plen 8


                                         {0x0001} [hci0]
14:19:25.941624
        LE Address: 70:5A:6F:63:B6:41 (OUI 70-5A-6F)
        Status: Disconnected (0x0e)
memcheck-amd64-[97587]: =3D src/device.c:att_connect_cb() connect to
70:5A:6F:63:B6:41: Connection refused (111)


14:19:25.943909

That is waiting 40 seconds as expected, so I'm not sure what is
causing it to time out in 2 seconds but that is definitely the
expected behavior.

> Best regards,
>
> Dajid Morel
> Volvo Group
>
>
> Le mar. 3 mars 2026 =C3=A0 18:24, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> a =C3=A9crit :
> >
> > Hi Dajid,
> >
> > On Mon, Mar 2, 2026 at 6:43=E2=80=AFPM Dajid MOREL <dajidp.morel@gmail.=
com> wrote:
> > >
> > > In an industrial IoT context at Volvo Group, we use TE Connectivity
> > > BLE pressure sensors. These sensors exhibit high latency during
> > > the initial LE connection handshake in noisy RF environments. The
> > > connection systematically fails on Ubuntu Core 22 (BlueZ) because the
> > > connection attempt is aborted too early.
> > >
> > > In the v2 thread, it was suggested that userspace (via setsockopt
> > > SO_SNDTIMEO) dictates the connection timeout (defaulting to 40s),
> > > suspecting that userspace was cutting the connection at 2 seconds,
> > > not the kernel.
> > >
> > > To verify this, an empirical test was conducted using the following
> > > Python/Bleak script to force the application timeout to 45.0 seconds:
> > >
> > >   import asyncio
> > >   from bleak import BleakClient, BleakScanner
> > >   import time
> > >
> > >   ADDRESS =3D "E8:C0:B1:D4:A3:3C"
> > >
> > >   async def test_connection():
> > >       device =3D await BleakScanner.find_device_by_address(ADDRESS, t=
imeout=3D15.0)
> > >       start_time =3D time.time()
> > >       try:
> > >           # Forcing 45s timeout in userspace
> > >           async with BleakClient(device, timeout=3D45.0) as client:
> > >               print(f"Connected in {time.time() - start_time:.2f}s")
> > >       except Exception as e:
> > >           print(f"Failed after {time.time() - start_time:.2f}s: {e}")
> > >
> > >   asyncio.run(test_connection())
> > >
> > > 1. Result on UNMODIFIED Kernel: The userspace script patiently waited
> > >    for the full 45 seconds before raising a TimeoutError. If the kern=
el
> > >    had actually kept the radio connection attempt alive for those
> > >    45 seconds, the connection would have succeeded around the
> > >    12.5-second mark (as proven by the patched kernel test below).
> > >    The fact that it did not proves that the underlying HCI connection
> > >    attempt was aborted early by the kernel. Userspace was blind to th=
is
> > >    abort and kept waiting in a vacuum.
> > >
> > > 2. Result on MODIFIED Kernel (with this patch): Using the exact same
> > >    userspace script (45.0s timeout), the connection successfully
> > >    established at the 12.51-second mark.
> > >
> > > Conclusion:
> > > This proves that the underlying HCI LE Connection creation is bound b=
y
> > > a strict 2-second timeout derived from `conn_timeout` in `hci_conn.c`=
,
> > > and that userspace socket options do not override this hardcoded HCI
> > > abort in our stack. The sensor physically takes 12.5 seconds to
> > > handshake, making the 2-second kernel limit a hard blocker.
> >
> > Well except if you can point us where the 2 second timeout is coming
> > from I don't see how this proves that there is a strict 2-second
> > timeout, in fact I already point you that in the previous thread, it
> > seems there is something programming the SO_SNDTIMEO to be 2 seconds
> > which is why you could only overcome it by hardcoding a 20 sec fixed
> > timeout, so you are actually introduce a strict timeout yourself with
> > this change, so application wouldn't be able to set their own timeout
> > when needed.
> >
> > > This patch increases the hardcoded LE connection timeout to 20 second=
s
> > > to provide a comfortable margin for handshake retries.
> > >
> > > Note: If the upstream preference is to not hardcode 20 seconds global=
ly,
> > > I would be happy to submit a v5 that exposes this as a configurable
> > > module parameter (e.g., `le_conn_timeout`).
> > > ---
> > >  net/bluetooth/hci_conn.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > index a47f5daffdbf..7edce4126900 100644
> > > --- a/net/bluetooth/hci_conn.c
> > > +++ b/net/bluetooth/hci_conn.c
> > > @@ -1436,7 +1436,7 @@ struct hci_conn *hci_connect_le(struct hci_dev =
*hdev, bdaddr_t *dst,
> > >         }
> > >
> > >         conn->sec_level =3D BT_SECURITY_LOW;
> > > -       conn->conn_timeout =3D conn_timeout;
> > > +       conn->conn_timeout =3D msecs_to_jiffies(20000);
> > >         conn->le_adv_phy =3D phy;
> > >         conn->le_adv_sec_phy =3D sec_phy;
> > >
> > > @@ -1664,7 +1664,7 @@ struct hci_conn *hci_connect_le_scan(struct hci=
_dev *hdev, bdaddr_t *dst,
> > >         set_bit(HCI_CONN_SCANNING, &conn->flags);
> > >         conn->sec_level =3D BT_SECURITY_LOW;
> > >         conn->pending_sec_level =3D sec_level;
> > > -       conn->conn_timeout =3D conn_timeout;
> > > +       conn->conn_timeout =3D msecs_to_jiffies(20000);
> > >         conn->conn_reason =3D conn_reason;
> > >
> > >         hci_update_passive_scan(hdev);
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
