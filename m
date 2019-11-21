Return-Path: <SRS0=kdk/=ZN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA21C432C3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 08:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6816E2089F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 08:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUI1l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:27:41 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40448 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKUI1l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Nov 2019 03:27:41 -0500
Received: from localhost.localdomain (tmo-101-191.customers.d1-online.com [80.187.101.191])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6BC55CED0F
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2019 09:36:47 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Allow combination of BDADDR_PROPERTY and INVALID_BDADDR quirks
Date:   Thu, 21 Nov 2019 08:51:30 +0100
Message-Id: <20191121075130.92705-2-marcel@holtmann.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When utilizing BDADDR_PROPERTY and INVALID_BDADDR quirks together it
results in an unconfigured controller even if the bootloader provides
a valid address. Fix this by allowing a bootloader provided address
to mark the controller as configured.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c957f0611f74..6039105c96c0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1444,6 +1444,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 
 	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
 	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
+		bool invalid_bdaddr;
+
 		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
 
 		if (hdev->setup) {
@@ -1452,25 +1454,45 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 				goto setup_failed;
 		}
 
+		/* The transport driver can set the quirk to mark the
+		 * BD_ADDR invalid before creating the HCI device or in
+		 * its setup callback.
+		 */
+		invalid_bdaddr = test_bit(HCI_QUIRK_INVALID_BDADDR,
+					  &hdev->quirks);
+
 		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
 			if (!bacmp(&hdev->public_addr, BDADDR_ANY))
 				hci_dev_get_bd_addr_from_property(hdev);
 
 			if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
-			    hdev->set_bdaddr)
+			    hdev->set_bdaddr) {
 				ret = hdev->set_bdaddr(hdev,
 						       &hdev->public_addr);
+
+				/* If setting of the BD_ADDR from the device
+				 * property succeeds, then treat the address
+				 * as valid even if the invalid BD_ADDR
+				 * quirk indicates otherwise.
+				 */
+				if (!ret)
+					invalid_bdaddr = false;
+			}
 		}
 
 setup_failed:
 		/* The transport driver can set these quirks before
 		 * creating the HCI device or in its setup callback.
 		 *
+		 * For the invalid BD_ADDR quirk it is possible that
+		 * it becomes a valid address if the bootloader does
+		 * provide it (see above).
+		 *
 		 * In case any of them is set, the controller has to
 		 * start up as unconfigured.
 		 */
 		if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
-		    test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks))
+		    invalid_bdaddr)
 			hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
 
 		/* For an unconfigured controller it is required to
-- 
2.23.0

