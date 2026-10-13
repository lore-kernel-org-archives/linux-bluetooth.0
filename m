Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B353943B3F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862093; cv=none; b=kcv8pdaqD9NSCcEiUuNMn6Y77OjNOGh7Dr5kTeM6D4MSQlpXWAUbbFgAf2MVMnAgwqRP1trKTE1T9uNNRX/EV1aZryFOI7j1b2kQWxawhHvw2aXAjTnCRkRt/VItpMcuoOIT+BNLtuQkIl7+Zw+MuOTOAmrGV6arqFBCN5zREtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862093; c=relaxed/simple;
	bh=7RN8mIF9+3ZiXBhlQRQ96VCEUVdJOcsnfs8hEN8IK38=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=G98odt1K/cCXmAMd2nET+/4SRY7pPCwO1LZ+MKLuS/4hhSH5Idp6mkkhaOvF1c+QgXgUKW3auQdhdavX2C2g3TK7hNG2DlbIF9Wa+yY/l0XcjtXnm6T0/auePM6SSOmrbMBRFUSHBvprwKxJsFMkJxsE64yU0dLPhaNFZRqGF8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Bnhc4LWA; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Bnhc4LWA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791862083; x=1792121283;
	bh=wvvUNjp2S5XzNtVjblnlh1LNVgGbj1fhF/hrb1ogxa4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Bnhc4LWAoPQ7YEfj80GQIPA1RNSwQf4mQxT3RlCpwRN5vV8Wi7UA9e1ECRnUV/2WC
	 8MFZcgdIM635tTJdZhW6lFlOAC7xNFI6q33KxaWPKa7tUFu12aKdmZg3GyZOhTMR9q
	 rwK/Y7Bmtb7j3890JdZaSwRDDXiTXrPEGd2vLp9erxKUz+ZBlUvKSha4rUNppIvUu3
	 hxqadQcuZBWIKaImQlV1Cl8NFc3+ZDfG+at7plG2x/h8VZatWpDnU4Gj+TPlltBi19
	 wlitsU3DT2N3igoFfQaO+HSPKv8qbmeoLCnhx2zQoE3UixbEFeUM1uhxVTCxdfJ1yb
	 RINY7HGEDPH9g==
Date: Tue, 13 Oct 2026 03:28:00 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] Bluetooth: btusb: use shared ACL buffers for TP-Link UB500
Message-ID: <20261013032742.497402-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 7d5873288f39511801fb99da561f79dbe4ce2234
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The TP-Link UB500 (2357:0604) reports a dedicated LE ACL pool of 27
bytes by eight packets and a BR/EDR ACL pool of 1021 bytes by six
packets. Sustained large-SDU LE CoC traffic exhausts the small pool,
although this controller accepts LE traffic through the larger ACL pool.

Add an explicit HCI quirk and enable it only for the tested USB ID. When
set, treat the LE buffer as shared so the existing HCI scheduler uses
the ACL pool. Avoid inferring this from buffer sizes globally because
other controllers may have legitimate separate pools.

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Submission review notes (not part of the commit message):
October 12 N8/UB500 no-quirk trial opens CoC, completes START, DLE
and 2M, but sends no audio frames and logs two watchdog stalls. The
host advertises MPS 23 instead of the baseline 512; peer MPS remains
168. Firmware pool semantics and simultaneous BR/EDR/LE accounting are
not established. Keep the quirk device-specific and this proposal RFC.

 drivers/bluetooth/btusb_main.c |  7 ++++++-
 include/net/bluetooth/hci.h    |  7 +++++++
 net/bluetooth/hci_event.c      | 22 ++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.=
c
index 71d8dccb2..5e1fb26ab 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -70,6 +70,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_NO_WBS_SUPPORT=09BIT(26)
 #define BTUSB_ACTIONS_SEMI=09=09BIT(27)
 #define BTUSB_BARROT=09=09=09BIT(28)
+#define BTUSB_USE_BREDR_ACL_BUFFERS_FOR_LE BIT(29)
 #define BTUSB_QUALCOMM=09=09=09BIT(30)
=20
 static const struct usb_device_id btusb_table[] =3D {
@@ -872,7 +873,8 @@ static const struct usb_device_id quirks_table[] =3D {
 =09{ USB_DEVICE(0x2c4e, 0x0115), .driver_info =3D BTUSB_REALTEK |
 =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
 =09{ USB_DEVICE(0x2357, 0x0604), .driver_info =3D BTUSB_REALTEK |
-=09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
+=09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH |
+=09=09=09=09=09=09     BTUSB_USE_BREDR_ACL_BUFFERS_FOR_LE },
 =09{ USB_DEVICE(0x2357, 0x0607), .driver_info =3D BTUSB_REALTEK |
 =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
 =09{ USB_DEVICE(0x0b05, 0x190e), .driver_info =3D BTUSB_REALTEK |
@@ -4748,6 +4750,9 @@ static int btusb_probe(struct usb_interface *intf,
 =09if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
 =09=09hci_set_quirk(hdev, HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED);
=20
+=09if (id->driver_info & BTUSB_USE_BREDR_ACL_BUFFERS_FOR_LE)
+=09=09hci_set_quirk(hdev, HCI_QUIRK_USE_BREDR_ACL_BUFFERS_FOR_LE);
+
 =09if (id->driver_info & BTUSB_INVALID_LE_STATES)
 =09=09hci_set_quirk(hdev, HCI_QUIRK_BROKEN_LE_STATES);
=20
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1641d879d..d39a64663 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -375,6 +375,13 @@ enum {
 =09 */
 =09HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
=20
+=09/* When this quirk is set, LE connections use the BR/EDR ACL buffer
+=09 * pool instead of the dedicated LE pool reported by the controller.
+=09 * This is required for controllers that expose an unusably small LE
+=09 * pool while accepting LE traffic through their shared ACL pool.
+=09 */
+=09HCI_QUIRK_USE_BREDR_ACL_BUFFERS_FOR_LE,
+
 =09__HCI_NUM_QUIRKS,
 };
=20
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c055d16cf..9936f6365 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1227,6 +1227,24 @@ static u8 hci_cc_pin_code_neg_reply(struct hci_dev *=
hdev, void *data,
 =09return rp->status;
 }
=20
+/* Use the shared ACL pool for controllers whose dedicated LE pool is know=
n to
+ * be unusable for sustained large-SDU traffic.
+ */
+static void hci_le_use_shared_acl_buffer(struct hci_dev *hdev)
+{
+=09if (hci_test_quirk(hdev, HCI_QUIRK_USE_BREDR_ACL_BUFFERS_FOR_LE) &&
+=09    hdev->le_mtu =3D=3D HCI_MIN_LE_MTU &&
+=09    hdev->acl_mtu > hdev->le_mtu && hdev->acl_pkts) {
+=09=09bt_dev_dbg(hdev,
+=09=09=09   "LE buffer at minimum (%u:%u), sharing ACL buffer %u:%u",
+=09=09=09   hdev->le_mtu, hdev->le_pkts,
+=09=09=09   hdev->acl_mtu, hdev->acl_pkts);
+=09=09hdev->le_mtu =3D 0;
+=09=09hdev->le_pkts =3D 0;
+=09=09hdev->le_cnt =3D 0;
+=09}
+}
+
 static u8 hci_cc_le_read_buffer_size(struct hci_dev *hdev, void *data,
 =09=09=09=09     struct sk_buff *skb)
 {
@@ -1247,6 +1265,8 @@ static u8 hci_cc_le_read_buffer_size(struct hci_dev *=
hdev, void *data,
 =09if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)
 =09=09return HCI_ERROR_INVALID_PARAMETERS;
=20
+=09hci_le_use_shared_acl_buffer(hdev);
+
 =09return rp->status;
 }
=20
@@ -3939,6 +3959,8 @@ static u8 hci_cc_le_read_buffer_size_v2(struct hci_de=
v *hdev, void *data,
 =09if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)
 =09=09return HCI_ERROR_INVALID_PARAMETERS;
=20
+=09hci_le_use_shared_acl_buffer(hdev);
+
 =09return rp->status;
 }
=20

base-commit: 964430c038967fd06643e866f68115664e1a1bd1

