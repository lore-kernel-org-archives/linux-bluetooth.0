Return-Path: <SRS0=oHG9=PL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805D8C43387
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jan 2019 16:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519D72070D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jan 2019 16:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732360AbfACQno (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:43:44 -0500
Received: from avasout03.plus.net ([84.93.230.244]:41583 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732359AbfACQno (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jan 2019 11:43:44 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jan 2019 11:43:40 EST
Received: from localhost.localdomain ([87.112.196.180])
        by smtp with ESMTPA
        id f5yHgSh7KimnMf5yfgALWW; Thu, 03 Jan 2019 16:36:14 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CoqRjEwD c=1 sm=1 tr=0
 a=Y1wGFK3FhPvFCcGACwKsaA==:117 a=Y1wGFK3FhPvFCcGACwKsaA==:17
 a=08VI1bL2Rn6wF1MGSkkA:9 a=HBl-pWRkaHKTX-Y4:21 a=MtzrMieHWah2KP3q:21
X-AUTH: davidjohnsummers@:2500
From:   David Summers <beagleboard@davidjohnsummers.uk>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     David Summers <beagleboard@davidjohnsummers.uk>,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCHv2] Patch to add the realtek bluetooth device tree refs to the code
Date:   Thu,  3 Jan 2019 16:35:38 +0000
Message-Id: <20190103163538.6575-2-beagleboard@davidjohnsummers.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103163538.6575-1-beagleboard@davidjohnsummers.uk>
References: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
 <20190103163538.6575-1-beagleboard@davidjohnsummers.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJ3ZsIL67fs0G4mFxi9UnwIVyOgUyC3xEhXTIXUqi3aziO5QnJ1YVWFKFj2nBViO9mFbuIuW4HbHjEvF1KbwNgUMXfRvraHH9Hl0ueXD4d8ieyhZRlC9
 kgUmE/IBQ/YrdIFnyGR9JrFplcq3EyjzlT1YBTrgnTGyShwy3JXCL0ASk0Ku3bEYl/R+AhFhdBXXC9yyjQEXz5P+hSXbhJdLl2k=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the necessary device tree hooks to the realtek
bluetooth driver for serial connections.

The realtek devices that are listed btrtl.c are searched on the
realtek web site for the version that have serial connections.

Most of these devices also have wi-fi connected via sdio, that is not
covered by the bluetooth driver - but as that interface will also be
needed in the device tree, the hocks here have "-bluetooth" added. The
exception to this is the rtl8761atv, which only has a serial
bluetooth.

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
---
 drivers/bluetooth/hci_h5.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 8eede1197cd2..2fec7ff2ce7c 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -925,6 +925,22 @@ static struct h5_vnd rtl_vnd = {
 };
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id h5_of_match[] = {
+#ifdef CONFIG_BT_HCIUART_RTL
+       { .compatible = "realtek,rtl8723as-bluetooth"},
+       { .compatible = "realtek,rtl8723bs-bluetooth"},
+       { .compatible = "realtek,rtl8723ds-bluetooth"},
+       { .compatible = "realtek,rtl8761atv"},
+       { .compatible = "realtek,rtl8821as-bluetooth"},
+       { .compatible = "realtek,rtl8821cs-bluetooth"},
+       { .compatible = "realtek,rtl8822bs-bluetooth"},
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

