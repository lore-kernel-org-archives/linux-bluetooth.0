Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296056;
	b=Y5SkpZYeCZbK9RxKtZkxKIZ2P+AIIKSB8MN8W5EjHktKR2L7/2jTNGdr1JKpcsMMWjx6
	 PG2G6j96bD7xdG0b7y0sv830UsFHPpLOOO4ti4vh2LkXVBcdFegYDFJMluGzcys+ybHzs
	 ekIsBHTaCYL9EhI8FbrbxN3ctaOsOgV82JCc4OWGHhNcx3gHYECk8+K4lZmhjEcNcFhv7
	 N3wSnw9vFXHww/4zbE073Svloea8ADfKGO8PfRMkvA1ZxwTsdgllCygOM8Tsnb9OIp8QA
	 FvlALHI8RYAhK2NQi0iJKE6HZbUMm/1vfmvi6H6wBEsDGjfpUbP583cFs++gtfEK8Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296056;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=0aFcIB/jrZG4PJtKTMjUVIlMJgMhzPwZAJQ8rlFZh7g=;
	b=rCaWD9BRbBHtP9nyYEqom84DQUwYzB0krsW05wKHRQpMpbYjt8P4Q33Wtc3Pke8SvHps
	 HllJC20VpVvFmugXAYToRlQqBMResO2HJIr5jOGNCxsxpIwFD53AfIKmCx+JYgvh5EmpR
	 ZJMDkMpqChWlmlHM5Qc76aoCN7P8qCjEguDECwNAZAc7++ktStEzNb8ZMPKshdNuuRkvt
	 ig6EuMK7Mr5QkMjYfD41RXaY9nauvZ9EuCZCPwJb1ZvxsBbRuG7O1RzRkN9x6VvWxCFdA
	 EcTTDVnBiiTX4KSY3HwK3pgbkh5awNWjZNos2sjuv+XMZjo66TSX4pJKPJ8OBaOjhig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=MCBmO4Wm;
	arc=none smtp.remote-ip=79.135.106.31
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB66606A32A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 17:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DB66606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=MCBmO4Wm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793296053; x=1793555253;
	bh=0aFcIB/jrZG4PJtKTMjUVIlMJgMhzPwZAJQ8rlFZh7g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MCBmO4Wm1lflT+vfxMTyAFv/8IwVC8Y/vJtYI3MMA/uK/4t3eUaOLV04J5Qrhzpob
	 VtO74f1C4FCHKFr2Le8YiMkIfhMUenA1M9IYch24bm8JM+ARe4LnJ01TfbDrtNf/X8
	 5oP8545NuiWm5PaGreNGIMuQ7SU8BFwTAh3SR0CfOYAeRUqpFe/CTiCT3rRGCH8uMb
	 65Q1zgst8ScKp+Ynb/QhMatSD9QiQmzn+DmzKX8uL2rwW7ec2GLUjtx4CoV/VXGdZ5
	 4GpEjTbi+uSBcgHuGwbH29kF6n+8iJB6T0J85Tc/qnQKE9Y2nHcTvEwI4e0Cqtabuh
	 qxqicS+8XKe4A==
Date: Thu, 29 Oct 2026 17:47:28 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [PATCH v4 1/1] Bluetooth: btusb: support larger LE packets on TP-Link UB500
Message-ID: <7136cfd8f427b90d6d931a836e93dad5ea6164a0.1793296023.git.cochcoder@proton.me>
In-Reply-To: <20261029023235.1280321-2-cochcoder@proton.me>
References: <20261013032742.497402-1-cochcoder@proton.me> <20261029023235.1280321-1-cochcoder@proton.me> <20261029023235.1280321-2-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 725a1136e45d2a014807a00699112420998fa9f3
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

The TP-Link UB500 (2357:0604) with RTL8761BU firmware 0xdfc6d922
reports an LE HCI packet length of 27 bytes and eight packets. It
separately reports a maximum Link Layer TX data length of 251 bytes.
Direct HCI user-channel transfers verified intact reception and
completion of sixteen 251-byte packets, with one outstanding at a time.

Use 251-byte LE HCI packets automatically on this device when its
reported values match. Limit both the initial LE credits and their
refill ceiling to one, matching the verified number of outstanding
enlarged packets. Leave BR/EDR buffer fields unchanged.

Skip the override when the reported values differ instead of failing
controller initialization. A different firmware revision can continue
using its reported HCI buffers.

Assisted-by: LLM
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
v4:
- Skip mismatched buffer reports without failing controller bring-up.
- Limit enlarged LE packets to one initial and refill credit.
- Submit as PATCH v4 and shorten the source wording.

The first two changes address Sashiko review 219856:
https://sashiko.dev/#/patchset/20261029023235.1280321-1-cochcoder%40proton.=
me

Validation: baseline and revised btusb_main.o compile with W=3D1; strict
checkpatch and compiled callback regression controls pass. The earlier
raw-radio capture verifies 48 intact payloads and completions: sixteen
each at 27, 167 and 251 bytes, with one outstanding packet at a time.

The Link Layer maximum is not a measurement of HCI storage capacity.
The revised callback has not been exercised on hardware. Sustained audio,
mixed BR/EDR traffic, other firmware and exceptional congestion remain
unverified. The override applies automatically only to the matching UB500
device and the observed buffer reports.

 drivers/bluetooth/btusb_main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.=
c
index 92a78a7e6..b32d3acc6 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -2972,6 +2972,21 @@ static int btusb_setup_realtek(struct hci_dev *hdev)
 =09return ret;
 }
=20
+static int btusb_ub500_post_init(struct hci_dev *hdev)
+{
+=09if (hdev->le_mtu !=3D 27 ||
+=09    hdev->le_pkts !=3D 8 || hdev->le_cnt !=3D 8 ||
+=09    hdev->le_max_tx_len !=3D 251)
+=09=09return 0;
+
+=09bt_dev_info(hdev, "LE ACL MTU 27 -> %u; LE packets 8 -> 1",
+=09=09    hdev->le_max_tx_len);
+=09hdev->le_mtu =3D hdev->le_max_tx_len;
+=09hdev->le_pkts =3D 1;
+=09hdev->le_cnt =3D 1;
+=09return 0;
+}
+
 static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *=
skb)
 {
 =09if (skb->len >=3D HCI_EVENT_HDR_SIZE + 1 &&
@@ -4715,6 +4730,9 @@ static int btusb_probe(struct usb_interface *intf,
 =09    (id->driver_info & BTUSB_REALTEK)) {
 =09=09btrtl_set_driver_name(hdev, btusb_driver.name);
 =09=09hdev->setup =3D btusb_setup_realtek;
+=09=09if (le16_to_cpu(data->udev->descriptor.idVendor) =3D=3D 0x2357 &&
+=09=09    le16_to_cpu(data->udev->descriptor.idProduct) =3D=3D 0x0604)
+=09=09=09hdev->post_init =3D btusb_ub500_post_init;
 =09=09hdev->shutdown =3D btrtl_shutdown_realtek;
 =09=09hdev->reset =3D btusb_rtl_reset;
 =09=09hdev->hw_error =3D btusb_rtl_hw_error;

base-commit: 1081a6ef8f1e0661fd52eb3f878691b0b96cdff9
--=20
2.56.0


