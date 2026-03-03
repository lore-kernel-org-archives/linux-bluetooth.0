Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DDA37266C
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564245; cv=pass; b=qsVeYF3RRcO0ijxKuNdx1jLAMDMq6NR7gidP41Anh74Q15ly7LXQmzWZBR6JS+USxVd5WT3/oUKsfRciBAhbpdG2RYWezCQhdFlpGwGbgJemMmJj8ycXlM9a9SHMbteZJYk66qhbMgQDA0TDFdLCPssI277KYkaQJiBtus1W7ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564245; c=relaxed/simple;
	bh=/WXT5dnxMYLT4/IQ7PWiaWCqXKrXAGqvEM0Oy29DyMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWUuiPfGWq1UbY9aNhCviz4fHILFuuYxt8cTBfk8WVQUZgSd82L4CLFtmma4nVBSiJ2CiSUq6RFvwF7ugtsup2XmYxFAYbuJw//Yg9wGrWXWUue+h5jh7Fl1KIar9BYPpeeLsS/o2tRQ7yrmIonp9dUy+ROJZP1JNtrpkGQZnHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVZOKM2z; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVZOKM2z"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40ef10ec84cso874740fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Mar 2026 10:57:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772564242; cv=none;
        d=google.com; s=arc-20240605;
        b=UoD7MNz7d7v0XiyqQZj6rh8G6NCZdKhQESC4TMlqwGc1iq5KEc9MSHGcF+SkhHNI+y
         wiLQqHUDSYIIIBEKsMNzHf3AcsFAzXK6nvnvKi77GqbuOU3Lg6UCvRUdEe3SlRDIU/4e
         NbcBFBrOjfyM3HUSN+eaFnnZJy3vQvlAgwQgJZTs8EWIwh/FIRkyVBysnx0+aBLV/ZnI
         4QC4CpI67inudEk3fhJuQKttaala863Tb1VwpN75PIJc7hDz1NoXEBAStiNcJkO5ejNS
         T0kfsxqVbe7Lh3IIkHBCSvcSOxdUjK+hJtxXauf71+PQM9n3YXSIgWJvR1C1YTvj7Kd8
         9OCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c2oV0OWoEzFahMT6BqlMk05uHSS5J6Jj/xgcjEoOIsQ=;
        fh=qUOyp7TJ0ob0ZhVsCpKWFNuOSLzsvyI5QvlJKxWqiUo=;
        b=D7BcfZt11tMvnx2Q8Coc6Ppkom+xZb6AF711N5Q1U2kpnRKbzUos/HsLjKf+zCm2kp
         G75yQL3Z87KJdnXXj48DVlu0xBPREQj0mi4SqExqA/k1W9Y4pwA2s6Q/BYkdh6mvx7GB
         TtsaFZnwwz7tZZcXJJyyP3cDdbj5Q91Mz3ms+JX9V7ld2xlm0ngDZ+59HQJdD4lhaqLq
         pwFC8I0YmwlREfGhwsWwdTIsNVCCuO966zoQKZ2Rog66LdFEvnzhLM9lR1HG1HnCCYIu
         jyO5IFpdS+E4VveBUc7vYYGGjtAK2s9nMOVbnwYm6zmxvW90XqRVLKUUsFIB12X0xSP4
         dgdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772564242; x=1773169042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2oV0OWoEzFahMT6BqlMk05uHSS5J6Jj/xgcjEoOIsQ=;
        b=RVZOKM2zojTQU3DP5hYAGjTSqPEEFsrxC2cazq1fDCWvF1xmKKQZw4iwZOlCpP0V//
         3QONexUEMWhlzhV0hELfZAQD6GILWLP3mEghgTodDaXXaXdFvi+b1GV3aZ7+g2zxQdqS
         IFoIT7WmsfGgcAMSnL5KGOd22Ytyoyd/DYWzEn5OJiViJId4FFqK7MlJOowO2naTFABL
         /ioJYO4wYb7oZnEXoXBxcSqJDutGnMSoApr9JZldZnuYbShSVShZ19elli6ecvATKZ/u
         3UqeXEPhvB1ifh7OAUUXaMxxmyiRdjob4GHmhdqL+6U4ITc8He+4bg142V0AlsKAynpL
         C3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772564242; x=1773169042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2oV0OWoEzFahMT6BqlMk05uHSS5J6Jj/xgcjEoOIsQ=;
        b=GVeTWQD4dgK9/gbm6FUWAtHW9lqsegbRjYF5Bz8l4t8mywhR9FcWn5bXk1lc1zqeZh
         BGinHqigJcTZszCtXDxjf4kDEIU8Xu+v4cX4vinLrWhXr/ELf5zZFqsRK0MsWkeKfVH6
         l9CF94VRlCy6rhdL/PQSPpPb/llwxDug8w1ZxjwWKfvnotMQnTc2XRnlLD1BmYqZA+gF
         VjW/+CQaP0TS9MvaM6eO8soywFZ+xVDL17NPJAdrIqwJ9zJP4MgFAEMBFXJ9n03MRpQC
         E9+wMr/Mqn5etbBWV5Dj+3V1wBi5rOA6b8s5ELbNG0qP5C6MYXrpcdxaxKqgAWhM1jO/
         Gv5A==
X-Gm-Message-State: AOJu0YwrAUln9hIRqO8ss7CsIoK4MpLUfu213VfpdDMX+tlIOZ13fbVx
	9kwbLxfU2fVcX0xhGe8+bK9cE2Kr4jpdLK7s0ruFlTwbONUkHlgIWqPqti49KpY7i0kF1Gb3qnF
	DlZ/rxV5W2rhik4AsSqLEGWkRmai6V2QT5avQ
X-Gm-Gg: ATEYQzwdJ3tyY1mLlcC3mDgje64Ekp2k+/e8lF5W7i2tU1V7mHjzmAeq9H/glrupdwP
	BR4jvxzOe9dxnBueurrEKcF2rN1kgsdzNxZgVvsFm6C9VdnmLKB5NPDNIUUysJMZbhm5tY3A29+
	0hUO0j5opNcpLA6zwRszU9xiRW6yojrKySx1/hzdcO0GHZy+urbInFSRr0DMpMZFm1CbBwGOgMw
	vWu6KD5zjKH/gY4AybWW5LncM0MkjUgYyE5ktGaaDgJkoiKwlM7n59rClNyHN6HufO/cGEzMAq0
	H7zgFOFNJZgVNdkzT4zZa2O6mn48/4Osi2wVlIRGw37oSIoHqhNB+Q6L+w==
X-Received: by 2002:a05:6870:55d0:b0:3e8:9bbb:36b7 with SMTP id
 586e51a60fabf-41626e284demr9298460fac.22.1772564242258; Tue, 03 Mar 2026
 10:57:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302233756.910702-1-dajid.morel@volvo.com> <CABBYNZJtZZ7mHJinJY9ZfhfHbYUC9aEmoRx9ACz5R4HSwepyFg@mail.gmail.com>
In-Reply-To: <CABBYNZJtZZ7mHJinJY9ZfhfHbYUC9aEmoRx9ACz5R4HSwepyFg@mail.gmail.com>
From: Dajid Morel <dajidp.morel@gmail.com>
Date: Tue, 3 Mar 2026 19:57:11 +0100
X-Gm-Features: AaiRm50VUEkbj89EXqV0OnbyOgT9a18SRnbABUHa9bcH9KX_rnY58xE51GBvsRE
Message-ID: <CAM8DPm26RVUJbgA+Lutqshu+ZqkVtNaVrKdG-k1WdE0rcSe0dQ@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Dajid MOREL <dajid.morel@volvo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 6:24 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Dajid,
> Well except if you can point us where the 2 second timeout is coming
> from I don't see how this proves that there is a strict 2-second
> timeout, in fact I already point you that in the previous thread, it
> seems there is something programming the SO_SNDTIMEO to be 2 seconds
> which is why you could only overcome it by hardcoding a 20 sec fixed
> timeout, so you are actually introduce a strict timeout yourself with
> this change, so application wouldn't be able to set their own timeout
> when needed.

Hi Luiz,

Thank you for your response. Following your suggestion that something
in userspace might be programming SO_SNDTIMEO to 2 seconds, I dug into
the entire stack to verify this.

I completely agree that my v4 patch (hardcoding 20s globally in the
kernel) is architecturally flawed because it breaks SO_SNDTIMEO for
testing tools that legitimately rely on shorter timeouts. I formally
withdraw the v4 patch.

However, regarding the origin of the 2-second timeout in standard use
cases, a deep dive into the stack reveals a gap between the API and
the socket creation:

1. Python/Bleak layer: When an application sets a 45s timeout, it only
sets an internal asyncio timer. The actual command sent via D-Bus
(org.bluez.Device1.Connect) takes no timeout parameter.
2. BlueZ (bluetoothd) layer: A `grep -rn "setsockopt" btio/` in the
BlueZ tree shows that while btio.c configures many socket options
(like L2CAP_LM, BT_SECURITY), it never sets SO_SNDTIMEO for standard
D-Bus clients. A global search confirms SO_SNDTIMEO is only used
within the tools/ directory (e.g., l2cap-tester.c).

This means that when an application requests a connection via D-Bus,
bluetoothd passes the request down and creates the L2CAP socket
without configuring SO_SNDTIMEO.

Because the socket is created "naked" regarding timeouts, it falls
entirely back to the kernel's default behavior, which is governed by
the hardcoded 2-second conn_timeout in hci_conn.c. Userspace is
bypassed and blindly waits for its own 45s timer to expire.

(Note: I have systematically reproduced this exact 2-second abort
issue across different hardware platforms and Bluetooth controllers,
including Raspberry Pi 4, BeagleY-AI, and Rock 4 C+, confirming it is
a core stack limitation, not a vendor-specific firmware quirk).

To fix this properly without touching the kernel, would you accept a
patch to BlueZ (bluetoothd / btio) instead? We could make bluetoothd
explicitly call setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, ...) when
establishing LE connections via D-Bus, drawing the value from a new
configurable parameter in main.conf (e.g., LEConnectionTimeout).

I would be happy to draft this BlueZ userspace patch if you agree this
is the correct architectural approach to unblock industrial D-Bus
clients.

Best regards,

Dajid Morel
Volvo Group


Le mar. 3 mars 2026 =C3=A0 18:24, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> a =C3=A9crit :
>
> Hi Dajid,
>
> On Mon, Mar 2, 2026 at 6:43=E2=80=AFPM Dajid MOREL <dajidp.morel@gmail.co=
m> wrote:
> >
> > In an industrial IoT context at Volvo Group, we use TE Connectivity
> > BLE pressure sensors. These sensors exhibit high latency during
> > the initial LE connection handshake in noisy RF environments. The
> > connection systematically fails on Ubuntu Core 22 (BlueZ) because the
> > connection attempt is aborted too early.
> >
> > In the v2 thread, it was suggested that userspace (via setsockopt
> > SO_SNDTIMEO) dictates the connection timeout (defaulting to 40s),
> > suspecting that userspace was cutting the connection at 2 seconds,
> > not the kernel.
> >
> > To verify this, an empirical test was conducted using the following
> > Python/Bleak script to force the application timeout to 45.0 seconds:
> >
> >   import asyncio
> >   from bleak import BleakClient, BleakScanner
> >   import time
> >
> >   ADDRESS =3D "E8:C0:B1:D4:A3:3C"
> >
> >   async def test_connection():
> >       device =3D await BleakScanner.find_device_by_address(ADDRESS, tim=
eout=3D15.0)
> >       start_time =3D time.time()
> >       try:
> >           # Forcing 45s timeout in userspace
> >           async with BleakClient(device, timeout=3D45.0) as client:
> >               print(f"Connected in {time.time() - start_time:.2f}s")
> >       except Exception as e:
> >           print(f"Failed after {time.time() - start_time:.2f}s: {e}")
> >
> >   asyncio.run(test_connection())
> >
> > 1. Result on UNMODIFIED Kernel: The userspace script patiently waited
> >    for the full 45 seconds before raising a TimeoutError. If the kernel
> >    had actually kept the radio connection attempt alive for those
> >    45 seconds, the connection would have succeeded around the
> >    12.5-second mark (as proven by the patched kernel test below).
> >    The fact that it did not proves that the underlying HCI connection
> >    attempt was aborted early by the kernel. Userspace was blind to this
> >    abort and kept waiting in a vacuum.
> >
> > 2. Result on MODIFIED Kernel (with this patch): Using the exact same
> >    userspace script (45.0s timeout), the connection successfully
> >    established at the 12.51-second mark.
> >
> > Conclusion:
> > This proves that the underlying HCI LE Connection creation is bound by
> > a strict 2-second timeout derived from `conn_timeout` in `hci_conn.c`,
> > and that userspace socket options do not override this hardcoded HCI
> > abort in our stack. The sensor physically takes 12.5 seconds to
> > handshake, making the 2-second kernel limit a hard blocker.
>
> Well except if you can point us where the 2 second timeout is coming
> from I don't see how this proves that there is a strict 2-second
> timeout, in fact I already point you that in the previous thread, it
> seems there is something programming the SO_SNDTIMEO to be 2 seconds
> which is why you could only overcome it by hardcoding a 20 sec fixed
> timeout, so you are actually introduce a strict timeout yourself with
> this change, so application wouldn't be able to set their own timeout
> when needed.
>
> > This patch increases the hardcoded LE connection timeout to 20 seconds
> > to provide a comfortable margin for handshake retries.
> >
> > Note: If the upstream preference is to not hardcode 20 seconds globally=
,
> > I would be happy to submit a v5 that exposes this as a configurable
> > module parameter (e.g., `le_conn_timeout`).
> > ---
> >  net/bluetooth/hci_conn.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index a47f5daffdbf..7edce4126900 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1436,7 +1436,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *h=
dev, bdaddr_t *dst,
> >         }
> >
> >         conn->sec_level =3D BT_SECURITY_LOW;
> > -       conn->conn_timeout =3D conn_timeout;
> > +       conn->conn_timeout =3D msecs_to_jiffies(20000);
> >         conn->le_adv_phy =3D phy;
> >         conn->le_adv_sec_phy =3D sec_phy;
> >
> > @@ -1664,7 +1664,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_d=
ev *hdev, bdaddr_t *dst,
> >         set_bit(HCI_CONN_SCANNING, &conn->flags);
> >         conn->sec_level =3D BT_SECURITY_LOW;
> >         conn->pending_sec_level =3D sec_level;
> > -       conn->conn_timeout =3D conn_timeout;
> > +       conn->conn_timeout =3D msecs_to_jiffies(20000);
> >         conn->conn_reason =3D conn_reason;
> >
> >         hci_update_passive_scan(hdev);
> > --
> > 2.34.1
> >
>
>
> --
> Luiz Augusto von Dentz
