Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793315310;
	b=lXodpl906xX8hulAIxOsvZTUfKEeZNFJbveqQpbMw74B2+L4oM87nErVDl97CjPuJjqv
	 jko+yNlT0krpqlNu9EHJBTCMJYEGPrid2+zSIhF4+r/BNE/8TB+yXp9KpZOat1wh8tb3v
	 Z9Q3jVNh5gRJFQn5hZ0qe7ZCxq5qljd6PdlUq3SYwQ5v7KXQvW+Mr7Wqq2KfE1WakSIF9
	 FDeUPYpxcxcImlD+M/GySUXCFvpP+y2y7xGtovoQMvVU9bhp0uqYFLAL7mhxQkJlKDSbq
	 GJ+YO/crxhnLi+u8v8x6YxbvIX4sb3DPusXRHglYjpyu1JtbgI9woofJ+BOOhDR1OPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793315310;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=1XdQJv7+8NFJgvlf+OSRfglYiAU1NG/C+JqoeMQnMCw=;
	b=oqO9uPVumdCKJkQfWuMhHqB9GkEQSqvc2+rn8Q0izKQAxcrJHItgu6ScIIjJemRHBWq1
	 MMaTbk9I/hV4nE+4J7+H09Fp/3wS75sLi65LUCqxHDu1kecxBQ3UAJm0UgZEZaMmitQZK
	 Qwpq0KBQz2ewT1SUef3sJqdVe3DnJndHa69mlgr8wEtPGKi/IzriOfPQPKXQk1g8beYJD
	 PO4MUEy71H5opB8UBqa/mVen0c8Pv0b7VPXvEbPx8UG0+LBVv/lVDsBUANvkQPCUgL4gb
	 eG/W9IkmpxroCgYUHJio7VmYY0N4Lzwe2H7MSDVP0f+NHi5vUJkdAlYvtW1JtVKi9Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=frnmfcnawva6nkwpdxaicizlpy.protonmail2 header.b=NzAZc4XV;
	arc=none smtp.remote-ip=79.135.106.29
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE6606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 23:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00EE6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=frnmfcnawva6nkwpdxaicizlpy.protonmail2 header.b=NzAZc4XV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=frnmfcnawva6nkwpdxaicizlpy.protonmail2; t=1793315306;
	x=1793574506; bh=1XdQJv7+8NFJgvlf+OSRfglYiAU1NG/C+JqoeMQnMCw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NzAZc4XV4mqGFAqVC9i3ki/ePbaZ9dL19jGc5ieqaqPatQV3Fujojs5PLVb6XYjME
	 FlwBcc0V4znIzn6zF1u2HaxAoLhi2AcfWEo5f/rMWTL5tybuAUt0YIwj07Nvx6T5Ni
	 QNGG9Yxy/tkwG/77rc05ZTwb18Y/9EOsYkUye/Sn/QFkusGxE5zKoX+B3maou2cd0M
	 PEbniBKkcsf6wfowQgmzVuSFOhgtbl/kMwnaelSYy8fpj5JhXb+OVzL4iOo81oey5F
	 18W5t8xiNZs0Bv7so9LBpcIzYsmzT8lXaDS9tlHmnKraBLH6j26RIdHh9NHE7UcT32
	 wY+JIJf67hfFw==
Date: Thu, 29 Oct 2026 23:08:21 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [PATCH v5 1/1] Bluetooth: btusb: support larger LE packets on TP-Link UB500
Message-ID: <5a7311d6f4cc94931fd753e5fe0d54a2a65f631a.1793315289.git.cochcoder@proton.me>
In-Reply-To: <7136cfd8f427b90d6d931a836e93dad5ea6164a0.1793296023.git.cochcoder@proton.me>
References: <20261013032742.497402-1-cochcoder@proton.me> <20261029023235.1280321-1-cochcoder@proton.me> <20261029023235.1280321-2-cochcoder@proton.me> <7136cfd8f427b90d6d931a836e93dad5ea6164a0.1793296023.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 766f5ce6850717bd5d6d92046eba13d5a9c62978
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

The TP-Link UB500 (2357:0604) reports a 27-byte LE ACL packet length and
eight LE packets, although its reported maximum LE TX data length is
251 bytes. The small HCI packet length fragments ASHA audio packets.
Direct controller testing received 251-byte LE HCI packets intact.

Set the host LE ACL MTU to the reported maximum after initialization for
the observed 27/eight/eight-available/251 reports. Skip other reports
without failing controller initialization.

Keep the controller-reported packet count and available credits unchanged
so transfers can use all eight credits. Leave BR/EDR accounting unchanged.

Assisted-by: LLM
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
v5:
- Keep the reported eight LE packet credits instead of reducing them to
  one, addressing Luiz's throughput concern.
- Keep automatic MTU selection and nonfatal handling of mismatched reports.

Matched 60-second single-N8 playback tests on the UB500 passed at host MTU
167/eight and 251/eight, with CLEAR listening and verified stock restoratio=
n
between tests. The control had 3,236 complete audio SDUs and 3,262/3,262 HC=
I
completions; the 251-byte setting had 3,234 SDUs and 3,260/3,260 completion=
s.
Both used whole 167-byte HCI audio packets, reached three outstanding packe=
ts,
returned all credits and had no socket EAGAIN or disconnection. PipeWire's
actual SO_SNDBUF stayed 4608. Tests used the exact callback ported to the
Arch-based ASHA 7.2.9 kernel; fresh upstream object builds run before sendi=
ng.

An earlier 251/eight trial sounded clear but stalled after about 40 seconds
of audio transmission and ended with HCI Connection Timeout (0x08), with se=
ven
completions pending. Restoration succeeded. Its cause remains unexplained;
the successful comparison does not erase that failure.

These are normal single-CI playback results. They do not establish eight
physical 251-byte slots, mixed BR/EDR+LE capacity, bilateral recovery,
exceptional congestion behavior, other firmware or long-duration reliabilit=
y.

 drivers/bluetooth/btusb_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.=
c
index 92a78a7e6..9cc3dd240 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -2972,6 +2972,19 @@ static int btusb_setup_realtek(struct hci_dev *hdev)
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
+=09bt_dev_info(hdev, "LE ACL MTU 27 -> %u; LE packets 8 unchanged",
+=09=09    hdev->le_max_tx_len);
+=09hdev->le_mtu =3D hdev->le_max_tx_len;
+=09return 0;
+}
+
 static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *=
skb)
 {
 =09if (skb->len >=3D HCI_EVENT_HDR_SIZE + 1 &&
@@ -4715,6 +4728,9 @@ static int btusb_probe(struct usb_interface *intf,
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


