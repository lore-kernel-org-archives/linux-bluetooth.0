Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A97C2BA17
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 18:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C3E20678
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 18:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgDFSDh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:03:37 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51690 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDFSDh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 14:03:37 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3E8D0CECC9
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2020 20:13:10 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add commands and event for handling device flags
Date:   Mon,  6 Apr 2020 20:03:31 +0200
Message-Id: <20200406180331.891822-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/mgmt-api.txt | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 39f23c456080..ac5b6c97d64a 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3138,6 +3138,74 @@ Read Security Information Command
 				Invalid Index
 
 
+Get Device Flags Command
+========================
+
+	Command Code:		0x0049
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Supported_Flags (4 Octets)
+				Current_Flags (4 Octets)
+
+	This command is used to retrieve additional flags and settings
+	for devices that are added via Add Device command.
+
+	Possible values for the Address_Type parameter:
+		0	BR/EDR
+		1	LE Public
+		2	LE Random
+
+	The Flags parameters are a bitmask with currently the following
+	available bits:
+
+		0	Remote Wakeup enabled
+
+	This command generates a Command Complete event on success
+	or a Command Status event on failure.
+
+        Possible errors:	Invalid Parameters
+				Invalid Index
+
+
+Set Device Flags Command
+========================
+
+	Command Code:		0x004a
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Current_Flags (4 Octets)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+
+	This command is used to configure additional flags and settings
+	for devices that are added via Add Device command.
+
+	Possible values for the Address_Type parameter:
+		0	BR/EDR
+		1	LE Public
+		2	LE Random
+
+	The list of supported Flags can be retrieved via the Get Device
+	Flags or Device Flags Changed command. Selecting unsupported flags
+	will result in an Invalid Parameter error;
+
+	Refer to the Get Device Flags command for a detailed description
+	of the Flags parameters.
+
+	This command can be used when the controller is not powered and
+	all settings will be programmed once powered.
+
+	This command generates a Command Complete event on success
+	or a Command Status event on failure.
+
+        Possible errors:	Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
@@ -4004,6 +4072,7 @@ Extended Controller Information Changed Event
 	The event will only be sent to management sockets other than the
 	one through which the change was triggered.
 
+
 PHY Configuration Changed Event
 ===============================
 
@@ -4020,3 +4089,30 @@ PHY Configuration Changed Event
 	one through which the change was triggered.
 
 	Refer Get PHY Configuration command for PHYs parameter.
+
+
+Device Flags Changed Event
+==========================
+
+	Event Code:		0x0027
+	Controller Index:	<controller id>
+	Event Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Supported_Flags (4 Octets)
+				Current_Flags (4 Octets)
+
+	This event indicates that the device flags have been changed via
+	the Set Device Flags command or that a new device has been added
+	via the Add Device command. In the latter case it is send right
+	after the Device Added event.
+
+	Possible values for the Address_Type parameter:
+		0	BR/EDR
+		1	LE Public
+		2	LE Random
+
+	The event will only be sent to management sockets other than the
+	one through which the command was sent.
+
+	In case this event is triggered by Add Device then it is sent to
+	all management sockets.
-- 
2.25.1

