Return-Path: <SRS0=bfEF=6B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D35C3815B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 17:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B97F208E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 17:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccSwLOj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgDQRQx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:16:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45374 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729710AbgDQRQx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Apr 2020 13:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587143811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HwMhgNUQiCkIMdW07uPbS1uP55IP65k0HuUDpGRwChs=;
        b=ccSwLOj6ILce5JffdWVWxvRoxoJIpUzjXvruQc53SUSLiMoIhm5BFpwM5WfJv4lts5H0sY
        WAEUMCFT5zQpRvw19XKZvftYRIza10q5krHPQE5ErQsl4EQOYwX7d/tVZrkp0mtS/adp8p
        g2jy8BGVxC28t5Gm88m8qFagc55DLj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-gjRw5rbFPkGFghlByDoWDw-1; Fri, 17 Apr 2020 13:15:43 -0400
X-MC-Unique: gjRw5rbFPkGFghlByDoWDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCC3D104FB69;
        Fri, 17 Apr 2020 17:15:42 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E078160BE0;
        Fri, 17 Apr 2020 17:15:41 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] Bluetooth: btbcm: Try multiple Patch filenames when loading the Patch firmware
Date:   Fri, 17 Apr 2020 19:15:31 +0200
Message-Id: <20200417171532.448053-7-hdegoede@redhat.com>
In-Reply-To: <20200417171532.448053-1-hdegoede@redhat.com>
References: <20200417171532.448053-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently the bcm_uart_subver_ and bcm_usb_subver_table-s lack entries
for various newer chipsets. This makes the code use just "BCM" as prefix
for the filename to pass to request-firmware, making it harder for users
to figure out which firmware they need. This especially a problem with
UART attached devices where this leads to the filename being "BCM.hcd".

If we add new entries to the subver-tables now, then this will change
what firmware file the kernel looks for, e.g. currently linux-firmware
contains a brcm/BCM-0bb4-0306.hcd file. If we add the info for the
BCM20703A1 to the subver table, then this will change to
brcm/BCM20703A1-0bb4-0306.hcd. This will cause the file to no longer
get loaded breaking Bluetooth for existing users, going against the
no regressions policy.

To avoid this regression make the btbcm code try multiple filenames,
first try the fullname, e.g. BCM20703A1-0bb4-0306.hcd and if that is
not found, then fallback to the name with just BCM as prefix.

This commit also adds an info message which filename was used,
this makes the output look like this for example:

[   57.387867] Bluetooth: hci0: BCM20703A1
[   57.387870] Bluetooth: hci0: BCM20703A1 (001.001.005) build 0000
[   57.389438] Bluetooth: hci0: BCM20703A1 'brcm/BCM20703A1-0a5c-6410.hcd=
' Patch
[   58.681769] Bluetooth: hci0: BCM20703A1 Generic USB 20Mhz fcbga_BU
[   58.681772] Bluetooth: hci0: BCM20703A1 (001.001.005) build 0481

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btbcm.c | 59 ++++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 9fa153b35825..739ba1200f5d 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -28,6 +28,9 @@
 #define BDADDR_BCM43341B (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0x1b, 0x34, 0x=
43}})
=20
 #define BCM_FW_NAME_LEN			64
+#define BCM_FW_NAME_COUNT_MAX		2
+/* For kmalloc-ing the fw-name array instead of putting it on the stack =
*/
+typedef char bcm_fw_name[BCM_FW_NAME_LEN];
=20
 int btbcm_check_bdaddr(struct hci_dev *hdev)
 {
@@ -420,11 +423,13 @@ static const struct bcm_subver_table bcm_usb_subver=
_table[] =3D {
 int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done)
 {
 	u16 subver, rev, pid, vid;
-	const char *hw_name =3D "BCM";
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *ver;
 	const struct bcm_subver_table *bcm_subver_table;
-	char fw_name[BCM_FW_NAME_LEN];
+	const char *hw_name =3D NULL;
+	char postfix[16] =3D "";
+	int fw_name_count =3D 0;
+	bcm_fw_name *fw_name;
 	const struct firmware *fw;
 	int i, err;
=20
@@ -464,7 +469,7 @@ int btbcm_initialize(struct hci_dev *hdev, bool *fw_l=
oad_done)
 	}
=20
 	bt_dev_info(hdev, "%s (%3.3u.%3.3u.%3.3u) build %4.4u",
-		    hw_name, (subver & 0xe000) >> 13,
+		    hw_name ? hw_name : "BCM", (subver & 0xe000) >> 13,
 		    (subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
=20
 	if (*fw_load_done)
@@ -480,24 +485,46 @@ int btbcm_initialize(struct hci_dev *hdev, bool *fw=
_load_done)
 		pid =3D get_unaligned_le16(skb->data + 3);
 		kfree_skb(skb);
=20
-		snprintf(fw_name, BCM_FW_NAME_LEN, "brcm/%s-%4.4x-%4.4x.hcd",
-			 hw_name, vid, pid);
-	} else {
-		snprintf(fw_name, BCM_FW_NAME_LEN, "brcm/%s.hcd", hw_name);
+		snprintf(postfix, sizeof(postfix), "-%4.4x-%4.4x", vid, pid);
 	}
=20
-	err =3D request_firmware(&fw, fw_name, &hdev->dev);
-	if (err) {
-		bt_dev_info(hdev, "BCM: Patch %s not found", fw_name);
-		return 0;
+	fw_name =3D kmalloc(BCM_FW_NAME_COUNT_MAX * BCM_FW_NAME_LEN, GFP_KERNEL=
);
+	if (!fw_name)
+		return -ENOMEM;
+
+	if (hw_name) {
+		snprintf(fw_name[fw_name_count], BCM_FW_NAME_LEN,
+			 "brcm/%s%s.hcd", hw_name, postfix);
+		fw_name_count++;
 	}
=20
-	err =3D btbcm_patchram(hdev, fw);
-	if (err)
-		bt_dev_info(hdev, "BCM: Patch failed (%d)", err);
+	snprintf(fw_name[fw_name_count], BCM_FW_NAME_LEN,
+		 "brcm/BCM%s.hcd", postfix);
+	fw_name_count++;
+
+	for (i =3D 0; i < fw_name_count; i++) {
+		err =3D firmware_request_nowarn(&fw, fw_name[i], &hdev->dev);
+		if (err =3D=3D 0) {
+			bt_dev_info(hdev, "%s '%s' Patch",
+				    hw_name ? hw_name : "BCM", fw_name[i]);
+			*fw_load_done =3D true;
+			break;
+		}
+	}
+
+	if (*fw_load_done) {
+		err =3D btbcm_patchram(hdev, fw);
+		if (err)
+			bt_dev_info(hdev, "BCM: Patch failed (%d)", err);
+
+		release_firmware(fw);
+	} else {
+		bt_dev_err(hdev, "BCM: firmware Patch file not found, tried:");
+		for (i =3D 0; i < fw_name_count; i++)
+			bt_dev_err(hdev, "BCM: '%s'", fw_name[i]);
+	}
=20
-	release_firmware(fw);
-	*fw_load_done =3D true;
+	kfree(fw_name);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btbcm_initialize);
--=20
2.26.0

