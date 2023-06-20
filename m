Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4705EB64D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 14:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjFTOlD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjFTOk5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 10:40:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A621708;
        Tue, 20 Jun 2023 07:40:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 256E7612A4;
        Tue, 20 Jun 2023 14:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256D3C433C8;
        Tue, 20 Jun 2023 14:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687272055;
        bh=ESB3mfiK6QBH5mUFKpOX+efwTKUL4XJTjgbpWQzRRMc=;
        h=From:To:Cc:Subject:Date:From;
        b=AQ1kjlBk64T4zNDLF05DXcQeIMF1Azrj4JzQbk6DV3OMIBEM+H72Cd02fjbRAheDS
         ZVCUP00qc/iAFD2TW/2QuqBOfi8tOHaa2BKsuVg12gBVhyL8YUn5g/8vLjGmLiA8i+
         dX+sm6yPDe9vlBEhnCKBrwziBD2ce7N2yt9Q6LEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] Bluetooth: hci_sysfs: make bt_class a static const structure
Date:   Tue, 20 Jun 2023 16:40:52 +0200
Message-ID: <20230620144051.580683-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1970; i=gregkh@linuxfoundation.org; h=from:subject; bh=PS9eqLmRrtetpOBWHADQYLqQmcboniXU2OhUOrX6kXY=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTdxV/TnoreGNRbulcu9k9hks53jDv2mrVeu+fLctpz xVLj/mmdMSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBECqsYFrReU/xVucrw5mTr jD8vZEzDNH/rxjHMr7gurLFI7JqN7WUBgarzJXOrfhuFAQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

Now that the driver core allows for struct class to be in read-only
memory, move the bt_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_sysfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 2934d7f4d564..15b33579007c 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -6,7 +6,9 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-static struct class *bt_class;
+static const struct class bt_class = {
+	.name = "bluetooth",
+};
 
 static void bt_link_release(struct device *dev)
 {
@@ -36,7 +38,7 @@ void hci_conn_init_sysfs(struct hci_conn *conn)
 	BT_DBG("conn %p", conn);
 
 	conn->dev.type = &bt_link;
-	conn->dev.class = bt_class;
+	conn->dev.class = &bt_class;
 	conn->dev.parent = &hdev->dev;
 
 	device_initialize(&conn->dev);
@@ -104,7 +106,7 @@ void hci_init_sysfs(struct hci_dev *hdev)
 	struct device *dev = &hdev->dev;
 
 	dev->type = &bt_host;
-	dev->class = bt_class;
+	dev->class = &bt_class;
 
 	__module_get(THIS_MODULE);
 	device_initialize(dev);
@@ -112,12 +114,10 @@ void hci_init_sysfs(struct hci_dev *hdev)
 
 int __init bt_sysfs_init(void)
 {
-	bt_class = class_create("bluetooth");
-
-	return PTR_ERR_OR_ZERO(bt_class);
+	return class_register(&bt_class);
 }
 
 void bt_sysfs_cleanup(void)
 {
-	class_destroy(bt_class);
+	class_unregister(&bt_class);
 }
-- 
2.41.0

