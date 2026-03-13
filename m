Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA01437F751
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435050; cv=pass; b=FPVFUwJeHBizwcsa1m2LfyEIxfkgRyD11KMVRAV6ChGQ4C66PKRClzzh+nEw5W1ORB6LZdiwvAyxhVrAR/5PVu8poviRPI8Qhjq8GSIyBQSza2T6DgxorX6m/3T0nWN70uk8aL3eu9gB0G+8GgIbb6YDws2WmnfkmvvNKDWwJ/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435050; c=relaxed/simple;
	bh=IgivItQaxLOMre6jhzuY6qnfTNa0XXjHWyhbG4kjzr8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=saaWCSleEbY9XAyK28pIshBMXN8rvwUv8Je8/x+gphZ1MqytlF5KAGCfD2TAJJ9noAYey3eI75f/NG1azOjLZJLJvMKvpejOX+qDFu7JRaYyy8sZ5XEahWpSJJ0waSZZtJgORIfFbLEi//ZvT1cAN7wd4ocv9jzPIfR/W/rFKOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=IG1fxZ92; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="IG1fxZ92"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:d:f011:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fXc7v2q0kz4BKLn;
	Fri, 13 Mar 2026 22:50:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1773435037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d6xea7M2m4wNmloNM/MN6Li7dE+WTTcyEbDL4mDIPLs=;
	b=IG1fxZ92GdtvajvyjYx666OBuqD3X4yjTNSiwMffT85cIjy1wZhKOzD37S6n2pGFS3Cttn
	Bi30863j/1MqR8tPctUK9fo+DxwxLuCkMDjE1RqMqEckAWGALSpGDaQjMqrtkWlsJWsHL7
	hLQYxjTK4e/g2L+m9vtIf7afOzEpUD3iZxGODhhgvMLakftPuHvXf5hLZOAfiFagnN1ejb
	0ohs5xO6EqtZqbMsDAVlgiN6zsKWXYjJW8EeQMeeGpcifNQGjle1/UV2WPkPkdKM6AXkPd
	mPoj+bqws+Y90ufpwgl4cUORnGZcQyTuMl+WDrzN1UHvB6K1XBI4fMopY5c18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1773435037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d6xea7M2m4wNmloNM/MN6Li7dE+WTTcyEbDL4mDIPLs=;
	b=cIuko+aoeqdgvsUkv0RB0H99nymv+6KnPAciZMf7H3fH1sUhW8HEKPNI4RGvxrW2KEfW/b
	2qF5btMVYLnPsZSe6Uf2jLdlZVa/UCt6WufvdYXZoTLMvyScF0xFs34SG7f3qaHCDkIrBa
	gpZkkeXaY9ZMEZEBhARGhZ/ZCFxy8i795ACV+YWikK4gU2j2XajF7Dk5k3ypOSrgvyCNN/
	dNVZJm/Sll3DWUPaz4w18GnfpFZhBb5HwI5DM/IaCJAWxbR4NydtNdj15YqN5w344LoE+U
	7CmLsxpNO9N+eEUqyipa/zA2np+YuXDp5MzPCM6vt7nQDJgVdI1Im5HpRKonsA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1773435037;
	b=By9eHuY45tpmIKxckvPysxDeZPjPIm3mq+SjF5XfRKdhxUb6hj6pj7XS+wWvnQwuKB6WKa
	HNSZb8+egIZyuTrgou+XmjmWaZMv+xYoaiwU+RZT6Hu6ar+FJHouHGhk/2BZkdr4bHuwTh
	g+iLHkO/B9/pIMuwJaR24hKsif1LJbUfO8PxZfzCf/BvgAVZqkttCfvu9MXHniLHvGM0kb
	uf8CDtO+UB8PGnNPTVAVgwnk7QDH1pRjR8xBpyqW3OPHMgqqLFzGqr1DznkuI4cNTjv7QN
	DGtuknzReEIaPRNybY3w1XyjIWyH1KPgp+T4BWLpjJDam8UW9o5IBUuTKpY5RA==
Message-ID: <1f3486f1ddb0adcccbbfcd676ed3dc9e32e5e69c.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: ISO: add timestamp for outgoing HCI ISO
 packet
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: Tailu Shi <tailu.shi@samsung.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Fri, 13 Mar 2026 22:50:33 +0200
In-Reply-To: <20260313120154.1254129-1-tailu.shi@samsung.com>
References: 
	<CGME20260313120201epcas5p3e57284d5bb295b1f9040478d96fa95b9@epcas5p3.samsung.com>
	 <20260313120154.1254129-1-tailu.shi@samsung.com>
Autocrypt: addr=pauli.virtanen@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

pe, 2026-03-13 kello 20:01 +0800, Tailu Shi kirjoitti:
[clip]
> I agree that, according to Core=E2=80=AFv6.2 Vol 6 Part=E2=80=AFG Section=
 3, the
> timestamp must be derived from the Controller's clock. However,
> Section 3.3 also defines a falllback where the controller decides the
> CIS/BIS event when the host=E2=80=91supplied timestamp is not based on th=
e
> Controller's clock. It looks contradictory.

TMAP likely assumes the controller implements the specification so that
providing correct time stamps would be possible, but when they in
practice don't, spec compliance seems dubious and not setting known-
wrong Time_Stamp on packets sounds safer.


[clip]
> I've cherry-picked your series and kept the PipeWire logic that passes th=
e
> timestamp via BT_SCM_PKT_ISO_TIMESTAMP CMSG. The implementation works on =
my
> platform (based on the Kernel 7.0.0-rc1, BlueZ 5.85 and PipeWire 1.5.84).
> The timestamp can be observed in the btmon trace.
>=20
> Partial HCI parsed by Wireshark:
>  Frame 32436: 72 bytes on wire (576 bits), 72 bytes captured (576 bits)
>  Bluetooth
>  Bluetooth Linux Monitor Transport
>  Bluetooth HCI ISO Packet
>      .... 1010 0000 0101 =3D Connection Handle: 0xa05
>      ..10 .... .... .... =3D PB Flag: Complete SDU (0x2)
>      .1.. .... .... .... =3D Timestamp present: True
>      0... .... .... .... =3D Reserved: 0x0
>      ..00 0000 0100 0100 =3D Data Length: 68
>      Data
>      [Connect in frame: 9436]
>  Bluetooth ISO Data
>      Timestamp: 469412333us
>      Sequence Number: 3595
>      .... 0000 0011 1100 =3D SDU Length: 60
>      SDU
>=20
> Please feel free to add the following Tested-by line if it helps:
> Tested-by: Tailu Shi <tailu.shi@samsung.com>
>=20
> May I know if you have any plan to merge this series? And also please fee=
l
> free to let me know if there's anything I can help to move this forward.
>=20
> > This sends timestamps in host clock domain and has no clock sync, but I
> > guess this is just for testing.
>=20
> I think it's better to have a complete implementation solution. So if pos=
sible,
> I would like to improve it and push it forward. Please feel free to let m=
e
> know if you have any other opinions.

I think we will want LE Read ISO TX Sync support at least, as this will
solve the CIS/BIS synchronization problem, as user application can then
know what ISO packets controller considers are playing at the same time
(if controller actually implements this command properly).

It would be good to have information how different manufacturers have
interpreted the specification vs. LE Read ISO TX Sync. Right now, I can
only read what Zephyr is doing, and tested some other controllers
return zeros. If you have access to controllers that implement this
command, it would be very useful to know their precise interpretation.


@Luiz: thoughts on the below?

For setting Time_Stamp, I think there should be plan how userspace
application uses the new APIs to produce working sound on different
controllers, without having to maintain a quirk list for each
controller. I think quirk lists should be in the kernel driver.

Depending on what hardware is doing, we could add driver quirks along
the lines of

HCI_QUIRK_BROKEN_LE_READ_ISO_TX_SYNC, /* always zero / dummy value */
HCI_QUIRK_LE_READ_ISO_TX_SYNC_HOST_PREV, /* most recent from host */
HCI_QUIRK_LE_READ_ISO_TX_SYNC_NOCP, /* most recent completed */
HCI_QUIRK_LE_READ_ISO_TX_SYNC_HOST_SEQ, /* uses host seqnum */

and should affect what skb is reported in hci_cc_le_read_iso_tx_sync(),
and if SOF_TIMESTAMPING_TX_HARDWARE capability is reported in ethtool.

(Eg. IIUC Zephyr HCI appears to interpret LE Read ISO TX Sync meaning
as follows:

- The sequence number is controller-assigned.
- The response corresponds to the ISO data packet that
  the controller *most recently received from host*.

This interpretation makes sense, but is different from my patch and
iiuc also different from what Luiz had in mind.)

If no quirk is set but the command is supported, probably should emit
visible error in kernel log, or something along such lines, so the
driver authors can see something is not right.

But knowing what is the precise hardware behavior for each
chip/firmware seems a bit involved, probably should have some testing
tool for this.

***

What it seems userspace can do:

Userspace application would check via ethtool
SOF_TIMESTAMPING_TX_HARDWARE capability to know whether controller
handles Time_Stamp in a non-broken way. (For testing, there could be a
switch to force it to use timestamps regardless.)

It could then rely that the HW timestamp corresponds to specific packet
it sent earlier. It could assume that in its clock domain, the HW
timestamp is after SND timestamp, before COMPLETION timestamp, and
likely close to COMPLETION.

Since it doesn't know the exact correspondence, probably it would
always have to ensure a few packets are always queued in controller.

There also needs to be a way to recover from a situation where the
application is setting timestamps that are in the past in controller
clock domain.

The controller does not necessarily send them I think, but will report
them completed immediately (after older ones get flushed from its
buffers).

In this case LE Read ISO TX Sync timestamp would not advance, as no
packets get sent. Kernel would also not send HW timestamps to user
application in this case.

If the application when it doesn't receive HW timestamps from kernel,
just increments its send timestamp by SDU interval for each packet, it
eventually catches up the controller clock, and receives HW timestamp
and can resync.

Alternatively the user application may stop setting timestamps, in
which case controller shall send it in next SDU interval, and in this
case HW timestamp is received and user application can resync.

Or, alternatively, controller will decide the clock is out of sync and
send the SDU regardless, in which case user application will receive a
new HW timestamp and can again resync.


>=20
> > I think these are not needed, they can be passed as arguments to
> > iso_send_frame().
> >=20
> > Adding them to iso_pinfo() probably causes a data race if two processes
> > sendmsg() at the same time.
>=20
> Thank you for identifying this potential data race issue. It was not cons=
idered
> in the current patch, and I will incorporate your suggestion in future de=
velopment.
>=20
> > I would put this in a separate function.
>=20
> Agreed. It will make code clear. I will keep this code style in future de=
velopment.
>=20
>=20
> Thank you again for the detailed review!
>=20
> Best regards!
>=20
> Tailu
