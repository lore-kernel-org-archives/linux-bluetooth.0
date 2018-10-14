Return-Path: <SRS0=msOO=M2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D4CC6787C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Oct 2018 12:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864AF2077C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Oct 2018 12:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864AF2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeJNUjS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Oct 2018 16:39:18 -0400
Received: from avasout06.plus.net ([212.159.14.18]:48267 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeJNUjS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Oct 2018 16:39:18 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Oct 2018 16:39:18 EDT
Received: from localhost.localdomain ([84.93.99.3])
        by smtp with ESMTP
        id Bfr5g4LTvP9YJBfr6gPxiz; Sun, 14 Oct 2018 13:50:50 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=erbxMLhX c=1 sm=1 tr=0
 a=GcUYRaTprh/tZG7TJEcPgw==:117 a=GcUYRaTprh/tZG7TJEcPgw==:17 a=EqdPLkY1AAAA:8
 a=asvQ-HOIURROcACv3bwA:9 a=upYyK7UR3OhLYXqx:21 a=LWjsv4FaQukhEy41:21
 a=dfeKg4RqpEhWThG6bP4-:22
From:   David Summers <beagleboard@davidjohnsummers.uk>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     David Summers <beagleboard@davidjohnsummers.uk>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Rockchip: Give nodes for registering in the device tree
Date:   Sun, 14 Oct 2018 13:50:14 +0100
Message-Id: <20181014125014.3976-1-beagleboard@davidjohnsummers.uk>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMjlwwzwcvRCnW9+fDEKkLiDqrndFWppIcsUGs54+CFhC0tHls4oiiEQZEcxgJCDN2zj/Llh2gzE/Swrzh0QIYkp6xlHMxj4xUS2LW+5LePaF3zQiu0u
 Fe4awlSf6tJvtBCWDRmV4yW1HGuAF7uI5i2HNHuNQ8k7MDpEYXJowRgEuVWaW+5N7XtiG1YpX8nImFRyk/n1D8ovjAlSKC9eoVs=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the compatbility flags, so the Rockchip Bluetooth can
be referenced in the device tree

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
---
 drivers/bluetooth/btrtl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 7f9ea8e4c1b2..4cc89c9fe371 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -20,6 +20,8 @@
 #include <asm/unaligned.h>
 #include <linux/usb.h>
 
+#include <linux/of.h>
+
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
@@ -743,6 +745,21 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
 
+static const struct of_device_id hci_rtl_of_match[] = {
+	{ .compatible = "realtek,rtl8723a" },
+	{ .compatible = "realtek,rtl8723bs" },
+	{ .compatible = "realtek,rtl8723b" },
+	{ .compatible = "realtek,rtl8723d" },
+	{ .compatible = "realtek,rtl8723ds" },
+	{ .compatible = "realtek,rtl8821a" },
+	{ .compatible = "realtek,rtl8821c" },
+	{ .compatible = "realtek,rtl8761a" },
+	{ .compatible = "realtek,rtl8822b" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hci_rtl_of_match);
+
+
 MODULE_AUTHOR("Daniel Drake <drake@endlessm.com>");
 MODULE_DESCRIPTION("Bluetooth support for Realtek devices ver " VERSION);
 MODULE_VERSION(VERSION);
-- 
beagleboard@davidjohnsummers.uk

