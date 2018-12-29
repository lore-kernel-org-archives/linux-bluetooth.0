Return-Path: <SRS0=rkTY=PG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5244C43387
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Dec 2018 12:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85508217F4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Dec 2018 12:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeL2MDJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Dec 2018 07:03:09 -0500
Received: from avasout02.plus.net ([212.159.14.17]:39029 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeL2MDJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Dec 2018 07:03:09 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Dec 2018 07:03:08 EST
Received: from localhost.localdomain ([87.112.196.180])
        by smtp with ESMTPA
        id dDDAgftdex6b6dDDLgdY8I; Sat, 29 Dec 2018 11:55:36 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=T4GiscCQ c=1 sm=1 tr=0
 a=Y1wGFK3FhPvFCcGACwKsaA==:117 a=Y1wGFK3FhPvFCcGACwKsaA==:17
 a=sjixkyzJrpERljILJL8A:9 a=CutxRP_YRTV_cuNQ:21 a=L3cMPTktaLIlAMl3:21
X-AUTH: davidjohnsummers@:2500
From:   David Summers <beagleboard@davidjohnsummers.uk>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     David Summers <beagleboard@davidjohnsummers.uk>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: [PATCH] bluetooth: realtek: devicetree: Add device tree description to bluetooth rtl drivers
Date:   Sat, 29 Dec 2018 11:55:13 +0000
Message-Id: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGzjjyLG7GEU87vu5rtmbaX1gtSoyIgYNmRhx9qACzi6tj4P+6DwBiqJdVNertEuam4HUdnMptH05wAnKetaeT8ai5Y9bwM5cMTFJgtLX1nsEFhkc5pL
 QIBbDKXhXi+sInnBJX5FzOJZ7gIKm4Md5kOBV4nMo/ZVrtIveB8uf5fzc4hY4ehUxW0whjADopN3XaMsMhTVNyuuh6hqStkdPv4=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch add the relevent device tree handles to the bluetooth driver
for serial realtek devices.

Specifically it takes all devices listed in btrtk.c identifes from the
realtek web site which are serial devices (this invariably means
devices that end with and "s" in the device name).

Most of these devices are dual wifi and bluetooth, with wifi on and
sdio connection, and bluetooth on a serial uart. As these two
interfaces will need independent listings in the device tree, the
nodes here have "-bluetooth" added. The only exception is the
rtl8761atv device, which is bluetooth only - and only has a uart
interface.

Can devicetree people revive the naming scheme used here, and confirm
it is acceptable.

Marcel, if the device tree people are happy can you apply to the
bluetooth tree.

Thanks,

David.

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
---
 drivers/bluetooth/hci_h5.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 8eede1197cd2..61c9e729efc1 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -925,6 +925,20 @@ static struct h5_vnd rtl_vnd = {
 };
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id h5_of_match[] = {
+       { .compatible = "realtek,rtl8723as-bluetoooth"},
+       { .compatible = "realtek,rtl8723bs-bluetoooth"},
+       { .compatible = "realtek,rtl8723ds-bluetoooth"},
+       { .compatible = "realtek,rtl8761atv"},
+       { .compatible = "realtek,rtl8821as-bluetoooth"},
+       { .compatible = "realtek,rtl8821cs-bluetoooth"},
+       { .compatible = "realtek,rtl8822bs-bluetoooth"},
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

