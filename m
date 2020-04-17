Return-Path: <SRS0=bfEF=6B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C3C38A2B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 17:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB1D2078E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 17:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVfzv17i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgDQRRG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:17:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53203 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729748AbgDQRRC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Apr 2020 13:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587143821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7fJIHksWMy5Gy3b3361nPibQbHTAIx6woqFPpXkpBU=;
        b=dVfzv17iALQj/ARgLOAmTyWw1S21CjS6LGZH8e4lgGQBLyzDsRi6ILsyfqR9770pl2/U5S
        yM/YPrlgoa+O1eRQxxVUDP0j6fJTVkoGYGKIZv+A/+OXVWV8cvtZ4y89/Z5KH8GCx4ccDW
        Q1btdHdEOugsnzgSGLxFYexUAmIoYPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-2R0baf0WNtm_loW1I3L3Kg-1; Fri, 17 Apr 2020 13:15:38 -0400
X-MC-Unique: 2R0baf0WNtm_loW1I3L3Kg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C12FA18CA247;
        Fri, 17 Apr 2020 17:15:37 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C353F60BFB;
        Fri, 17 Apr 2020 17:15:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] Bluetooth: btbcm: Fold Patch loading + applying into btbcm_initialize()
Date:   Fri, 17 Apr 2020 19:15:27 +0200
Message-Id: <20200417171532.448053-3-hdegoede@redhat.com>
In-Reply-To: <20200417171532.448053-1-hdegoede@redhat.com>
References: <20200417171532.448053-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Instead of having btbcm_initialize() fill a passed in fw_name buffer
and then have its callers use that to request the firmware + load
it into the HCI, make btbcm_initialize() do this itself the first
time it is called (its get called a second time to reset the HCI
after the firmware has been loaded).

This removes some code duplication and makes it easier for further
patches in this series to try more then 1 firmware filename.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btbcm.c   | 50 ++++++++++++++++++++++---------------
 drivers/bluetooth/btbcm.h   |  6 ++---
 drivers/bluetooth/hci_bcm.c | 19 +++-----------
 3 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 8052a0e8dbfb..c22e90a5e288 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -27,6 +27,8 @@
 #define BDADDR_BCM4345C5 (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0xc5, 0x45, 0x=
43}})
 #define BDADDR_BCM43341B (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0x1b, 0x34, 0x=
43}})
=20
+#define BCM_FW_NAME_LEN			64
+
 int btbcm_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
@@ -408,14 +410,15 @@ static const struct bcm_subver_table bcm_usb_subver=
_table[] =3D {
 	{ }
 };
=20
-int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len,
-		     bool reinit)
+int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done)
 {
 	u16 subver, rev, pid, vid;
 	const char *hw_name =3D "BCM";
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *ver;
 	const struct bcm_subver_table *bcm_subver_table;
+	char fw_name[BCM_FW_NAME_LEN];
+	const struct firmware *fw;
 	int i, err;
=20
 	/* Reset */
@@ -434,7 +437,7 @@ int btbcm_initialize(struct hci_dev *hdev, char *fw_n=
ame, size_t len,
 	kfree_skb(skb);
=20
 	/* Read controller information */
-	if (!reinit) {
+	if (!(*fw_load_done)) {
 		err =3D btbcm_read_info(hdev);
 		if (err)
 			return err;
@@ -460,27 +463,42 @@ int btbcm_initialize(struct hci_dev *hdev, char *fw=
_name, size_t len,
 		pid =3D get_unaligned_le16(skb->data + 3);
 		kfree_skb(skb);
=20
-		snprintf(fw_name, len, "brcm/%s-%4.4x-%4.4x.hcd",
+		snprintf(fw_name, BCM_FW_NAME_LEN, "brcm/%s-%4.4x-%4.4x.hcd",
 			 hw_name, vid, pid);
 	} else {
-		snprintf(fw_name, len, "brcm/%s.hcd", hw_name);
+		snprintf(fw_name, BCM_FW_NAME_LEN, "brcm/%s.hcd", hw_name);
 	}
=20
 	bt_dev_info(hdev, "%s (%3.3u.%3.3u.%3.3u) build %4.4u",
 		    hw_name, (subver & 0xe000) >> 13,
 		    (subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
=20
+	if (*fw_load_done)
+		return 0;
+
+	err =3D request_firmware(&fw, fw_name, &hdev->dev);
+	if (err) {
+		bt_dev_info(hdev, "BCM: Patch %s not found", fw_name);
+		return 0;
+	}
+
+	err =3D btbcm_patchram(hdev, fw);
+	if (err)
+		bt_dev_info(hdev, "BCM: Patch failed (%d)", err);
+
+	release_firmware(fw);
+	*fw_load_done =3D true;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btbcm_initialize);
=20
 int btbcm_finalize(struct hci_dev *hdev)
 {
-	char fw_name[64];
+	bool fw_load_done =3D true;
 	int err;
=20
 	/* Re-initialize */
-	err =3D btbcm_initialize(hdev, fw_name, sizeof(fw_name), true);
+	err =3D btbcm_initialize(hdev, &fw_load_done);
 	if (err)
 		return err;
=20
@@ -494,28 +512,20 @@ EXPORT_SYMBOL_GPL(btbcm_finalize);
=20
 int btbcm_setup_patchram(struct hci_dev *hdev)
 {
-	char fw_name[64];
-	const struct firmware *fw;
+	bool fw_load_done =3D false;
 	struct sk_buff *skb;
 	int err;
=20
 	/* Initialize */
-	err =3D btbcm_initialize(hdev, fw_name, sizeof(fw_name), false);
+	err =3D btbcm_initialize(hdev, &fw_load_done);
 	if (err)
 		return err;
=20
-	err =3D request_firmware(&fw, fw_name, &hdev->dev);
-	if (err < 0) {
-		bt_dev_info(hdev, "BCM: Patch %s not found", fw_name);
+	if (!fw_load_done)
 		goto done;
-	}
=20
-	btbcm_patchram(hdev, fw);
-
-	release_firmware(fw);
-
-	/* Re-initialize */
-	err =3D btbcm_initialize(hdev, fw_name, sizeof(fw_name), true);
+	/* Re-initialize after loading Patch */
+	err =3D btbcm_initialize(hdev, &fw_load_done);
 	if (err)
 		return err;
=20
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index 014ef847a486..8437caba421d 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -62,8 +62,7 @@ int btbcm_write_pcm_int_params(struct hci_dev *hdev,
 int btbcm_setup_patchram(struct hci_dev *hdev);
 int btbcm_setup_apple(struct hci_dev *hdev);
=20
-int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len,
-		     bool reinit);
+int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done);
 int btbcm_finalize(struct hci_dev *hdev);
=20
 #else
@@ -105,8 +104,7 @@ static inline int btbcm_setup_apple(struct hci_dev *h=
dev)
 	return 0;
 }
=20
-static inline int btbcm_initialize(struct hci_dev *hdev, char *fw_name,
-				   size_t len, bool reinit)
+static inline int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_d=
one)
 {
 	return 0;
 }
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index dcd2bdf2b4b9..6f0c3f2599c0 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -550,8 +550,7 @@ static int bcm_flush(struct hci_uart *hu)
 static int bcm_setup(struct hci_uart *hu)
 {
 	struct bcm_data *bcm =3D hu->priv;
-	char fw_name[64];
-	const struct firmware *fw;
+	bool fw_load_done =3D false;
 	unsigned int speed;
 	int err;
=20
@@ -560,21 +559,12 @@ static int bcm_setup(struct hci_uart *hu)
 	hu->hdev->set_diag =3D bcm_set_diag;
 	hu->hdev->set_bdaddr =3D btbcm_set_bdaddr;
=20
-	err =3D btbcm_initialize(hu->hdev, fw_name, sizeof(fw_name), false);
+	err =3D btbcm_initialize(hu->hdev, &fw_load_done);
 	if (err)
 		return err;
=20
-	err =3D request_firmware(&fw, fw_name, &hu->hdev->dev);
-	if (err < 0) {
-		bt_dev_info(hu->hdev, "BCM: Patch %s not found", fw_name);
+	if (!fw_load_done)
 		return 0;
-	}
-
-	err =3D btbcm_patchram(hu->hdev, fw);
-	if (err) {
-		bt_dev_info(hu->hdev, "BCM: Patch failed (%d)", err);
-		goto finalize;
-	}
=20
 	/* Init speed if any */
 	if (hu->init_speed)
@@ -613,9 +603,6 @@ static int bcm_setup(struct hci_uart *hu)
 		btbcm_write_pcm_int_params(hu->hdev, &params);
 	}
=20
-finalize:
-	release_firmware(fw);
-
 	err =3D btbcm_finalize(hu->hdev);
 	if (err)
 		return err;
--=20
2.26.0

