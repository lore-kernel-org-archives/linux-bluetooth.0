Return-Path: <SRS0=FRXr=P4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B4FC61CE4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Jan 2019 12:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3741D21738
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Jan 2019 12:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbfATMlQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Jan 2019 07:41:16 -0500
Received: from avasout05.plus.net ([84.93.230.250]:44646 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbfATMlQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Jan 2019 07:41:16 -0500
Received: from localhost.localdomain ([84.93.100.233])
        by smtp with ESMTP
        id lCPPgmo0o0eJxlCPQgxu5H; Sun, 20 Jan 2019 12:41:14 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=LrG8NEVc c=1 sm=1 tr=0
 a=28fyDxKB7osSiHeljbD2ug==:117 a=28fyDxKB7osSiHeljbD2ug==:17
 a=smhzA7Sf4ErfeGMmOA0A:9 a=aOr9JvWsL3gBv6vA:21 a=eqEwCuVljLZylo4x:21
From:   David Summers <beagleboard@davidjohnsummers.uk>
To:     robh+dt@kernel.org, mark.rutland@arm.com, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     David Summers <beagleboard@davidjohnsummers.uk>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: dt-bindings: Realtek serial bluetooth
Date:   Sun, 20 Jan 2019 12:40:45 +0000
Message-Id: <20190120124046.6715-1-beagleboard@davidjohnsummers.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKyrV2mLSWnNfsxEPLl/MZEEWwa8VoP+yzs2Tul/9iXpvLJdlgLR72lAD5NlwKc7taBGjCkJBnpnWoXWOoLulrP8JE/r5bCCe2dXTolqjwlczH68DBvt
 MTCIZRFqjeEVn2smZR/Jk31M/r9Ka+otdjZG3oqoKOrM1unIZRxssvWJZUzCpXa9kkfg5/HLr+tl9A==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Since v2, the compatible binding names have been changed to end in
-bt, as requested by robh.

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
---
 drivers/bluetooth/hci_h5.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 8eede1197cd2..056ab2decccc 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -925,6 +925,22 @@ static struct h5_vnd rtl_vnd = {
 };
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id h5_of_match[] = {
+#ifdef CONFIG_BT_HCIUART_RTL
+       { .compatible = "realtek,rtl8723as-bt"},
+       { .compatible = "realtek,rtl8723bs-bt"},
+       { .compatible = "realtek,rtl8723ds-bt"},
+       { .compatible = "realtek,rtl8761atv"},
+       { .compatible = "realtek,rtl8821as-bt"},
+       { .compatible = "realtek,rtl8821cs-bt"},
+       { .compatible = "realtek,rtl8822bs-bt"},
+#endif
+       { }
+};
+MODULE_DEVICE_TABLE(of, h5_of_match);
+#endif
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id h5_acpi_match[] = {
 #ifdef CONFIG_BT_HCIUART_RTL
-- 
beagleboard@davidjohnsummers.uk

