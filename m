Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710C6C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 12:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7D82312E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 12:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgLVMrl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 07:47:41 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46597 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLVMrl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 07:47:41 -0500
Received: from localhost.localdomain (tmo-113-220.customers.d1-online.com [80.187.113.220])
        by mail.holtmann.org (Postfix) with ESMTPSA id DA461CED20
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 13:54:16 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc/mgmt-api.txt: Introduce Set Runtime Firmware command
Date:   Tue, 22 Dec 2020 13:46:51 +0100
Message-Id: <20201222124651.101063-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/mgmt-api.txt | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 1736ef009e75..47686ae32629 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2187,6 +2187,7 @@ Read Controller Configuration Information Command
 
 		0	External configuration
 		1	Bluetooth public address configuration
+		2	Runtime firmware configuration
 
 	It is valid to call this command on controllers that do not
 	require any configuration. It is possible that a fully configured
@@ -3132,6 +3133,10 @@ Read Controller Capabilities Command
 		0x02		Max Encryption Key Size (BR/EDR)
 		0x03		Max Encryption Key Size (LE)
 		0x04		Supported Tx Power (LE)
+		0x05		Complete firmware name
+		0x06		Shortened firmware name
+		0x07		Firmware info string
+		0x08		Hardware info string
 
 	Flags (data type 0x01)
 
@@ -3155,6 +3160,23 @@ Read Controller Capabilities Command
 		field is not available, it indicates that the LE Read
 		Transmit Power HCI command was not available.
 
+	Firmware name (date types 0x05 and 0x06)
+
+		Only one of these will be present if the device is loading
+		some sort of runtime firmware. Only in the firwmare name
+		happens to exceed the 255 charaters, the shortened type
+		shall be used.
+
+		This value represents the driver chosen default firmware
+		for a controller. In case it is changed via Set Runtime
+		Firmware command that change will not be reflected here.
+
+	Firmware and hardware info (data types 0x07 and 0x08)
+
+		When provided by the hardware and the driver, these fields
+		will contain string of the firmware or the hardware for
+		debug or indentification purposes.
+
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
 
@@ -3852,6 +3874,70 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
 				Invalid Parameters
 
 
+Set Runtime Firmware Command
+============================
+
+	Command Code:		0x0057
+	Controller Index:	<controller id>
+	Command Parameters:	Action (1 Octet)
+				Firmware_Length (2 Octets)
+				Firmware (0-65535 Octets)
+	Return Parameters:	Missing_Options (4 Octets)
+
+	This command allows configuration of runtime firmware or patch
+	download setting. Since a vendor specific procedure is required,
+	this command might not be supported by all controllers.
+
+	Possible values for the Action parameter:
+		0	Reset to default driver firmware
+		1	Reset to current or configure new firmware
+
+	When resetting to the default firmware, Firmware_Length shall be
+	set to 0. The system will go back to the original firmware selected
+	by the driver. When resetting to current firmware, Firmware_Length
+	shall also be set to 0. If there has been never specified a new
+	firmware, then a reset to default or current is not different.
+
+	Loading a new firmware can be triggered with the Action 1 and a
+	Firmware specified. The Firmware is a string that would also be
+	used in request_firmware() and has to be NUL terminated. The
+	Firmware_Length field shall include the string length plus the
+	additional NUL byte.
+
+	In the case a driver has no default driver firmware, then an
+	Action 0 will fully reset the device into an unconfigured state.
+
+	When the support for runtime firwmare configuration is indicated
+	in the supported options mask, then this command can be used to
+	set the runtime firmware.
+
+	It is only possible to configure the runtime firmware when the
+	controller is powered off.
+
+	For an unconfigured controller and when Missing_Options returns
+	an empty mask, this means that a Index Added event for the now
+	fully configured controller can be expected.
+
+	For a fully configured controller, the current controller index
+	will become invalid and an Unconfigured Index Removed event will
+	be sent. Once the firmware has been successfully loaded an Index
+	Added event will be sent. There is no guarantee that the controller
+	index stays the same.
+
+	All previous configured parameters and settings are lost when
+	this command succeeds. The controller has to be treated as new
+	one. Use this command for a fully configured controller only when
+	you really know what you are doing.
+
+	This command generates a Command Complete event on success or a
+	Command Status event on failure.
+
+	Possible errors:	Rejected
+				Not Supported
+				Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
-- 
2.29.2

