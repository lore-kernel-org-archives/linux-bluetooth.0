Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F03C43219
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Nov 2022 16:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiKBQt3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Nov 2022 12:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiKBQtL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Nov 2022 12:49:11 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C3A1EEC8;
        Wed,  2 Nov 2022 09:47:25 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4144685072;
        Wed,  2 Nov 2022 17:47:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667407643;
        bh=4XK5Cyp7p6i8f2+fuR0IJHEB+iVox8xnrnDJEkhFRW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d2eHUH0jg9ia1ISjacMN/W263RYlkdx38O8uQcdG4nGv1pBhw7II8FUNN0Zo1vcoP
         0RbheIh4FolSfPPm6CgnsdRhPSf0S2HMKSzgnh9gbF5JeDvUMwBcEdShMz7yPjAA+q
         tvQzWwHiWd+thtGh3UonEgso717pjKxD+G07Lboakk/7fN6r6QCi1yDuXer9IC3ZeB
         7MlMNPLWXE+DniWDnGuMMJaPKESJ+bmc3ecKmJ+mDLJrBsHiQI3+0NbRusKGE2Gc0U
         p6pTOd43oN2kOEqx9ps3gQumFQIxo2ZWo/ZE2jsZv3H9DgEfy85Ih/19z8FgrHy0dg
         RPcdEXHrowjGw==
From:   Marek Vasut <marex@denx.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     pbrobinson@gmail.com, Marek Vasut <marex@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hakan Jansson <hakan.jansson@infineon.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_bcm: Add CYW4373A0 support
Date:   Wed,  2 Nov 2022 17:47:05 +0100
Message-Id: <20221102164705.14538-2-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221102164705.14538-1-marex@denx.de>
References: <20221102164705.14538-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

CYW4373A0 is a Wi-Fi + Bluetooth combo device from Cypress.
This chip is present e.g. on muRata 2AE module.

This chip has additional quirk where the HCI command 0xfc45, used on
older chips to switch UART clock from 24 MHz to 48 MHz, to support
baudrates over 3 Mbdps, is no longer recognized by this newer chip.
This newer chip can configure the 4 Mbdps baudrate without the need
to issue HCI command 0xfc45, so add flag to indicate this and do not
issue the command on this chip to avoid failure to set 4 Mbdps baud
rate.

It is not clear whether there is a way to determine which chip does
and which chip does not support the HCI command 0xfc45, other than
trial and error.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Hakan Jansson <hakan.jansson@infineon.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
To: linux-bluetooth@vger.kernel.org
---
V2: - Rename bcm4373a0_device_data to cyw4373a0_device_data to be
      consistent with the rest of the device naming
    - Add RB from Linus
---
 drivers/bluetooth/hci_bcm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index d7e0b75db8a60..2b6c0e1922cb3 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -53,11 +53,13 @@
  * struct bcm_device_data - device specific data
  * @no_early_set_baudrate: Disallow set baudrate before driver setup()
  * @drive_rts_on_open: drive RTS signal on ->open() when platform requires it
+ * @no_uart_clock_set: UART clock set command for >3Mbps mode is unavailable
  * @max_autobaud_speed: max baudrate supported by device in autobaud mode
  */
 struct bcm_device_data {
 	bool	no_early_set_baudrate;
 	bool	drive_rts_on_open;
+	bool	no_uart_clock_set;
 	u32	max_autobaud_speed;
 };
 
@@ -100,6 +102,7 @@ struct bcm_device_data {
  * @is_suspended: whether flow control is currently disabled
  * @no_early_set_baudrate: don't set_baudrate before setup()
  * @drive_rts_on_open: drive RTS signal on ->open() when platform requires it
+ * @no_uart_clock_set: UART clock set command for >3Mbps mode is unavailable
  * @pcm_int_params: keep the initial PCM configuration
  * @use_autobaud_mode: start Bluetooth device in autobaud mode
  * @max_autobaud_speed: max baudrate supported by device in autobaud mode
@@ -140,6 +143,7 @@ struct bcm_device {
 #endif
 	bool			no_early_set_baudrate;
 	bool			drive_rts_on_open;
+	bool			no_uart_clock_set;
 	bool			use_autobaud_mode;
 	u8			pcm_int_params[5];
 	u32			max_autobaud_speed;
@@ -172,10 +176,11 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
 {
 	struct hci_dev *hdev = hu->hdev;
+	struct bcm_data *bcm = hu->priv;
 	struct sk_buff *skb;
 	struct bcm_update_uart_baud_rate param;
 
-	if (speed > 3000000) {
+	if (speed > 3000000 && !bcm->dev->no_uart_clock_set) {
 		struct bcm_write_uart_clock_setting clock;
 
 		clock.type = BCM_UART_CLOCK_48MHZ;
@@ -1529,6 +1534,7 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 		bcmdev->max_autobaud_speed = data->max_autobaud_speed;
 		bcmdev->no_early_set_baudrate = data->no_early_set_baudrate;
 		bcmdev->drive_rts_on_open = data->drive_rts_on_open;
+		bcmdev->no_uart_clock_set = data->no_uart_clock_set;
 	}
 
 	return hci_uart_register_device(&bcmdev->serdev_hu, &bcm_proto);
@@ -1550,6 +1556,10 @@ static struct bcm_device_data bcm43438_device_data = {
 	.drive_rts_on_open = true,
 };
 
+static struct bcm_device_data cyw4373a0_device_data = {
+	.no_uart_clock_set = true,
+};
+
 static struct bcm_device_data cyw55572_device_data = {
 	.max_autobaud_speed = 921600,
 };
@@ -1566,6 +1576,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4349-bt", .data = &bcm43438_device_data },
 	{ .compatible = "brcm,bcm43540-bt", .data = &bcm4354_device_data },
 	{ .compatible = "brcm,bcm4335a0" },
+	{ .compatible = "cypress,cyw4373a0-bt", .data = &cyw4373a0_device_data },
 	{ .compatible = "infineon,cyw55572-bt", .data = &cyw55572_device_data },
 	{ },
 };
-- 
2.35.1

