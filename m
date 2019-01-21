Return-Path: <SRS0=Rr1U=P5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A59EC37120
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 20:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C9720989
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 20:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfAUUju (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:39:50 -0500
Received: from avasout04.plus.net ([212.159.14.19]:56403 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfAUUju (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 15:39:50 -0500
Received: from localhost.localdomain ([87.112.42.170])
        by smtp with ESMTP
        id lgMBgPXkRAOoylgMCgBlki; Mon, 21 Jan 2019 20:39:48 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=mWDk6ZswF0UwtwIMZFE8gw==:117 a=mWDk6ZswF0UwtwIMZFE8gw==:17
 a=smhzA7Sf4ErfeGMmOA0A:9 a=np1FOK99Wu_VW2yF:21 a=8ZKh2xixNCT-zY7d:21
From:   David Summers <beagleboard@davidjohnsummers.uk>
To:     robh+dt@kernel.org, mark.rutland@arm.com, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     David Summers <beagleboard@davidjohnsummers.uk>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 1/2] Bluetooth: hci_h5: Add the Realtek compatible flags for the device tree
Date:   Mon, 21 Jan 2019 20:39:27 +0000
Message-Id: <20190121203928.32723-1-beagleboard@davidjohnsummers.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJ2E7kujyoQDB+FJNr6oFMeyDm2Cmxxz00+69wC9m0pw1EdZ84Zbk8yx8zq2mbTymL3aQoWwVtuUQNzkEgTR4VJL9UKW4HqGb4Q5Yh9S71RLMDWkc4fb
 GA5GVV7/GbI08eJ96hE52Ng8+i9OPP56ERJ1UFYOddF4b5YRCnrrEXjnGxvTxRj58c/rlMZ14pQ9pnafbsd9f15/63cnN5lSP4E=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

With the changes requested by Marcel Holtmann and Rob Herring.

The patch is unchanged, but subject changed to the norm.

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

