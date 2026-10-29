Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793232849;
	b=DO7wKUza2fIFS1zVu+HItoWlYEP9+gdqhFxjTex2wF/Mh5QO19ROCv9u67L3JeukKf42
	 dhgBFE8vB1puS7wnQMBol5zzoENZdgt1rfhIi7wiaLC9YMsldqNEwbX3E9Td2Yg0CoeeN
	 4r9YGJGVPU2vFCIzomTucNcyzPTFDafn1fFBMDoKbR+/wX59QJVfkCvaDsQk4xJpzm5jT
	 3dYWd59yKJPsbc3dMDhRBarJUMpovYUKaK6KsEd3J5SWllJgimd1Aqcuu5V9E9UgwG443
	 trC1EvAGqcl6vmxIqV0iM6Ox3woS7aMA1nVnDxyV9bHeD2Zq0QGGI4EzhreL3UCCcUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793232849;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=fiDsM604MdQpNmemmifyOcmpDnq9oMpXyjw9xDuHIVo=;
	b=Bw62HRi/43LZfVJkcF7xlZnyABdtJkxhFJbOnWsfS7ZzyWjBKQQIZUdf/uWAwIOKBqFL
	 JLuuzHgqxr1z+oiun5DAkp0IIAy9CSk+A869tyHpaeMQbXdyq1j0D7M3BHfPVZUCMYf9s
	 VJv1XX6N9sxdyWBcaNfLaFW8aiE+Nbmv11yJ95QJeUs6N5S4ee9dKNyYR/f0IrQOsjbxw
	 f4bs4380t9yT42gLQ1olNBsuoiZoxLlgi4hbeth3QGZNNEYrYhVb8lqcmso6ojOGAGZEX
	 QB2t751QN9Pihv2Te0z1nFBgpiFpjPhpFJYmYKFrMzpegwt5wShXrE0mTS67KNSD5sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=6q57xwqbcvhnnkrwpyresjknty.protonmail2 header.b=lQlFhO4F;
	arc=none smtp.remote-ip=185.70.43.102
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296DD606A32E;
	Thu, 29 Oct 2026 00:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 296DD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=6q57xwqbcvhnnkrwpyresjknty.protonmail2 header.b=lQlFhO4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=6q57xwqbcvhnnkrwpyresjknty.protonmail2; t=1793232846;
	x=1793492046; bh=fiDsM604MdQpNmemmifyOcmpDnq9oMpXyjw9xDuHIVo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lQlFhO4F3BZh3t5fQKIEXIJL9bdqvYoO2Iw4U70PblIJQ/AqNjVbVnJ1jJ0rB8d1S
	 rwyHK2yDJhWMEixvMJ6vQJz5NWVPxthrfI2COV3fo+e4I8J+oaTcE/5JYXg+Qzyikd
	 O+SIYggbJvz418VYwMnyG/0JRZxtVIrpC0NRdpTtaKhd8FGWEzlzpUUyzfB3xKVOTx
	 rTjnBQd5ACqA4NgVpBBU86TgdJrWMl45JuhAXkQqz6n6iaVfUAnliuHpjZQshEXIEl
	 W0c5a1fCcRsaKjA7BA7pG7jpzLSvLQjK2dSl+OIOzYnJSpYvzgbAU+vcaR5ZRTHI62
	 UTDrr79IDubKw==
Date: Thu, 29 Oct 2026 00:14:03 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [RFC PATCH v2 1/1] Bluetooth: btusb: test larger LE packets on TP-Link UB500
Message-ID: <20261029001349.1031535-2-cochcoder@proton.me>
In-Reply-To: <20261029001349.1031535-1-cochcoder@proton.me>
References: <20261013032742.497402-1-cochcoder@proton.me> <20261029001349.1031535-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: a44334759a0b84d39271e8ca115edd9187e0f5d1
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

The tested TP-Link UB500 (2357:0604, RTL8761BU firmware 0xdfc6d922)
reports an LE ACL length of 27 bytes and eight packets. It accepts
167-byte LE HCI ACL packets during ASHA playback. A size-only test
streams clearly with the eight reported LE credits retained, so the
previous shared-buffer workaround does not establish shared pools.

Use post_init to test a host LE ACL length of 167 for this USB ID,
without changing LE packet/credit counts or BR/EDR fields. Refuse
unexpected initialization values rather than applying this diagnostic
to a different reported buffer configuration.

This is an experimental RFC: 167 is a demonstrated working length,
not a measured maximum. The appropriate general limit and firmware
scope still need confirmation. Mixed BR/EDR and LE capacity and
exceptional-congestion behavior have not been established.

The ASHA 7.2.9 trial completes all 3269 HCI packets, including 3243
whole audio SDUs, with a maximum of three outstanding packets. The
human listening verdict is CLEAR. PipeWire and its actual 4608-byte
socket send buffer are unchanged. Increasing only that socket buffer
to 8192 with HCI length 27 previously crackled and underfed the stream.

Prepared with AI assistance for source, evidence analysis and text;
hardware playback and listening were performed by the submitter.

Assisted-by: LLM
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
 drivers/bluetooth/btusb_main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.=
c
index 92a78a7e6..2b955ed4b 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -2972,6 +2972,18 @@ static int btusb_setup_realtek(struct hci_dev *hdev)
 =09return ret;
 }
=20
+/* Private diagnostic: test a known accepted packet size, not a pool claim=
. */
+static int btusb_ub500_test_post_init(struct hci_dev *hdev)
+{
+=09if (hdev->le_mtu !=3D 27 || hdev->le_pkts !=3D 8)
+=09=09return -EINVAL;
+
+=09bt_dev_info(hdev, "UB500 TEST ONLY: LE ACL MTU 27 -> 167; LE packets %u=
 unchanged",
+=09=09    hdev->le_pkts);
+=09hdev->le_mtu =3D 167;
+=09return 0;
+}
+
 static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *=
skb)
 {
 =09if (skb->len >=3D HCI_EVENT_HDR_SIZE + 1 &&
@@ -4715,6 +4727,9 @@ static int btusb_probe(struct usb_interface *intf,
 =09    (id->driver_info & BTUSB_REALTEK)) {
 =09=09btrtl_set_driver_name(hdev, btusb_driver.name);
 =09=09hdev->setup =3D btusb_setup_realtek;
+=09=09if (le16_to_cpu(data->udev->descriptor.idVendor) =3D=3D 0x2357 &&
+=09=09    le16_to_cpu(data->udev->descriptor.idProduct) =3D=3D 0x0604)
+=09=09=09hdev->post_init =3D btusb_ub500_test_post_init;
 =09=09hdev->shutdown =3D btrtl_shutdown_realtek;
 =09=09hdev->reset =3D btusb_rtl_reset;
 =09=09hdev->hw_error =3D btusb_rtl_hw_error;
--=20
2.56.0


