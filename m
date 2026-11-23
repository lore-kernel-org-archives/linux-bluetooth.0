Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795477087;
	b=mpAWGlIyz8M5WS37s/GuARvlCmKt91yPT1YpforwTU9IEFKytir1u2xkIH/Qexb+yFJa
	 Zx7DDxz9e8oeZ6xIUMxF7cY9JumgiIYXRZA1pfJ+gli+ygVm7vqetGTscBAqYlAipTS6o
	 o9enxqE3rEQkr9cbyaOyjRC3fSTvHJ5DucsBHu+QpsyxgCCvwdT5Jfz3mqsYYUHs45QlS
	 9azL77Fkqu2mOOq9MidMQip7Ej+pe0CtQqhQJz0PMwAdP5pA1PFaGlz84lk/9qg030IVS
	 dylZkpyi9TEyu7A1WGlIZ/2SI4OLAK5TeoySivgPeHzGdROX7Bqa6+jAiPD++JK54BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477087;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=XH/awogagchCAYNUOz49w7DXegBFWyWWFw00RGQO90o=;
	b=bvS4C+w99skS2KMY+mzMOlYzNc1bYmEF4BITqIFzNGJIhh/XcY40vICXW43OZ8ki8WS4
	 l93aDfdNk3snrH4Dies90k7poVnkDiQ8WgHwodvTggQeai2AgRUam9MSaeEeW4HGHeAvs
	 yo0C7jZBTOgBbmZ7x2kiWAiXbmuKuBq6ZDKdROgvp0HpOW88igwy4wCdMurXG4XQRntCw
	 CH3g9Rkv1OGTLK1Xe8oy5dw3GG/TJll+ULgztEhO6xAUbzLJS7RNJH9YpnwpdLYgmmhOu
	 fQFIknhLUuRuRXyDK07b7PjKwbIqSEzwRSsG4Z1qrGeK8YZ/g6S2VFNy2jp32IXdSgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=CaKjXISF;
	arc=none smtp.remote-ip=79.135.106.120
Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B4606A326
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 23:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A7B4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=CaKjXISF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795477082; x=1795736282;
	bh=XH/awogagchCAYNUOz49w7DXegBFWyWWFw00RGQO90o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CaKjXISFINBXtYOPgF5wSFeWAuDbqgR3BDoU3JVin8bvGrZ2sCCN6bDQZdpt+HAYD
	 yAG5Q567CZPEz+KqG/vg9f/82ugDSDQTYm1ienMHw3Ix35+oNAU2LIMCd9wdRbee//
	 oSDwG8uwEDKM7+IrcgMbfgC5KhrJllBLUYkKCIvQ/qRUisZP8utq2L4fXxG29VPHJk
	 PBBTp+vBjb7hKBDuk20pQ5bpQF3/RZdvyYYDgg0XCotNKLirDokJ4+oYsJeMBkHU0I
	 Z5jNMiykEjolv3RdS/py05q6BO1g1IRtosX2ua4SjzGQUeclZuE5PvXSdBIDqbzSxl
	 XfCi/vvlvtpAA==
Date: Mon, 23 Nov 2026 23:37:56 +0000
To: linux-bluetooth@vger.kernel.org
From: cochcoder <cochcoder@proton.me>
Cc: linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org
Subject: Re: [PATCH v5 1/1] Bluetooth: btusb: support larger LE packets on TP-Link UB500
Message-ID: <8NaE3sxC1VT7TQZ6Q4QMDfOoJSegqGy7q7FCVjheOEzBNpefA5_eeoKnDORi-q0nNJy1ZuIfVFl1bnzcWBDvSmZGUnY8dhobOfP-yy40HpE=@proton.me>
In-Reply-To: <WioHtJe5UoBDypyj0zDKYKksSKYCyTLi_RJLX-8uaxbN9WWssCjald6Lc6_MDAaw0Owixufqc4h_JnPMwFBVGzgtMmXMfJD3jIDh_0UHxZ4=@proton.me>
References: <20261013032742.497402-1-cochcoder@proton.me> <20261029023235.1280321-1-cochcoder@proton.me> <20261029023235.1280321-2-cochcoder@proton.me> <7136cfd8f427b90d6d931a836e93dad5ea6164a0.1793296023.git.cochcoder@proton.me> <5a7311d6f4cc94931fd753e5fe0d54a2a65f631a.1793315289.git.cochcoder@proton.me> <WioHtJe5UoBDypyj0zDKYKksSKYCyTLi_RJLX-8uaxbN9WWssCjald6Lc6_MDAaw0Owixufqc4h_JnPMwFBVGzgtMmXMfJD3jIDh_0UHxZ4=@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 05637f6a4a66d1f67a30253c9ee5764478062220
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Following up on this patch, is there anything else needed to move it forwar=
d?

Thanks,
Kyle Pepper



On Friday, November 6th, 2026 at 4:34 PM, cochcoder <cochcoder@proton.me> w=
rote:

> Hi,
>=20
> I've been using this patch for the past couple of days and haven't notice=
d any issues with it in that time. I'm unsure if I've managed to use all 8 =
credits however.
>=20
> Kyle Pepper
>=20
>=20
>=20
> On Thursday, October 29th, 2026 at 7:08 PM, Kyle Pepper <cochcoder@proton=
.me> wrote:
>=20
> > The TP-Link UB500 (2357:0604) reports a 27-byte LE ACL packet length an=
d
> > eight LE packets, although its reported maximum LE TX data length is
> > 251 bytes. The small HCI packet length fragments ASHA audio packets.
> > Direct controller testing received 251-byte LE HCI packets intact.
> >
> > Set the host LE ACL MTU to the reported maximum after initialization fo=
r
> > the observed 27/eight/eight-available/251 reports. Skip other reports
> > without failing controller initialization.
> >
> > Keep the controller-reported packet count and available credits unchang=
ed
> > so transfers can use all eight credits. Leave BR/EDR accounting unchang=
ed.
> >
> > Assisted-by: LLM
> > Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> > ---
> > v5:
> > - Keep the reported eight LE packet credits instead of reducing them to
> >   one, addressing Luiz's throughput concern.
> > - Keep automatic MTU selection and nonfatal handling of mismatched repo=
rts.
> >
> > Matched 60-second single-N8 playback tests on the UB500 passed at host =
MTU
> > 167/eight and 251/eight, with CLEAR listening and verified stock restor=
ation
> > between tests. The control had 3,236 complete audio SDUs and 3,262/3,26=
2 HCI
> > completions; the 251-byte setting had 3,234 SDUs and 3,260/3,260 comple=
tions.
> > Both used whole 167-byte HCI audio packets, reached three outstanding p=
ackets,
> > returned all credits and had no socket EAGAIN or disconnection. PipeWir=
e's
> > actual SO_SNDBUF stayed 4608. Tests used the exact callback ported to t=
he
> > Arch-based ASHA 7.2.9 kernel; fresh upstream object builds run before s=
ending.
> >
> > An earlier 251/eight trial sounded clear but stalled after about 40 sec=
onds
> > of audio transmission and ended with HCI Connection Timeout (0x08), wit=
h seven
> > completions pending. Restoration succeeded. Its cause remains unexplain=
ed;
> > the successful comparison does not erase that failure.
> >
> > These are normal single-CI playback results. They do not establish eigh=
t
> > physical 251-byte slots, mixed BR/EDR+LE capacity, bilateral recovery,
> > exceptional congestion behavior, other firmware or long-duration reliab=
ility.
> >
> >  drivers/bluetooth/btusb_main.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_m=
ain.c
> > index 92a78a7e6..9cc3dd240 100644
> > --- a/drivers/bluetooth/btusb_main.c
> > +++ b/drivers/bluetooth/btusb_main.c
> > @@ -2972,6 +2972,19 @@ static int btusb_setup_realtek(struct hci_dev *h=
dev)
> >  =09return ret;
> >  }
> >
> > +static int btusb_ub500_post_init(struct hci_dev *hdev)
> > +{
> > +=09if (hdev->le_mtu !=3D 27 ||
> > +=09    hdev->le_pkts !=3D 8 || hdev->le_cnt !=3D 8 ||
> > +=09    hdev->le_max_tx_len !=3D 251)
> > +=09=09return 0;
> > +
> > +=09bt_dev_info(hdev, "LE ACL MTU 27 -> %u; LE packets 8 unchanged",
> > +=09=09    hdev->le_max_tx_len);
> > +=09hdev->le_mtu =3D hdev->le_max_tx_len;
> > +=09return 0;
> > +}
> > +
> >  static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_bu=
ff *skb)
> >  {
> >  =09if (skb->len >=3D HCI_EVENT_HDR_SIZE + 1 &&
> > @@ -4715,6 +4728,9 @@ static int btusb_probe(struct usb_interface *intf=
,
> >  =09    (id->driver_info & BTUSB_REALTEK)) {
> >  =09=09btrtl_set_driver_name(hdev, btusb_driver.name);
> >  =09=09hdev->setup =3D btusb_setup_realtek;
> > +=09=09if (le16_to_cpu(data->udev->descriptor.idVendor) =3D=3D 0x2357 &=
&
> > +=09=09    le16_to_cpu(data->udev->descriptor.idProduct) =3D=3D 0x0604)
> > +=09=09=09hdev->post_init =3D btusb_ub500_post_init;
> >  =09=09hdev->shutdown =3D btrtl_shutdown_realtek;
> >  =09=09hdev->reset =3D btusb_rtl_reset;
> >  =09=09hdev->hw_error =3D btusb_rtl_hw_error;
> >
> > base-commit: 1081a6ef8f1e0661fd52eb3f878691b0b96cdff9
> > --
> > 2.56.0
> >
> >
