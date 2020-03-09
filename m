Return-Path: <SRS0=gSSv=42=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F77C10F25
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Mar 2020 21:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8888524649
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Mar 2020 21:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgCIV2u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:28:50 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56142 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgCIV2t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Mar 2020 17:28:49 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9400FCECC4
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2020 22:38:16 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] doc: Add commands and event for global debug configuration
Date:   Mon,  9 Mar 2020 22:28:43 +0100
Message-Id: <20200309212843.430786-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/mgmt-api.txt | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 27a41f334d63..bdc83758456d 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3094,6 +3094,62 @@ Set Wideband Speech Command
 				Invalid Index
 
 
+Get Debug Configuration Command
+===============================
+
+	Command Code:		0x0048
+	Controller Index:	<non-controller>
+	Command Parameters:
+	Return Parameters:	Layers (4 Octets)
+				Flags (4 Octets)
+
+	This command is used to read the current global debug setting of
+	the stack.
+
+	The Layers parameter is a bitmask with following defined bits:
+
+		0	Kernel messages
+		1	Daemon messages
+		2	Tools messages
+
+	If the bit is set, then the corresponding debug messages are
+	enabled. The kernel only acts on the Kernel messages bit and
+	all other bits are just passed back to userspace.
+
+	The Flags parameter is a bitmask with following defined bits:
+
+		0	Include function name
+		1	Include line number
+		2	Include module name
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
+
+
+Set Debug Configuration Command
+===============================
+
+	Command Code:		0x0049
+	Controller Index:	<non-controller>
+	Command Parameters:	Layers (4 Octets)
+				Flags (4 Octets)
+	Return Parameters:
+
+	This command is used to set the current global debug setting of
+	the stack.
+
+	Refer Get Debug Configuration command for parameter description.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
@@ -3976,3 +4032,20 @@ PHY Configuration Changed Event
 	one through which the change was triggered.
 
 	Refer Get PHY Configuration command for PHYs parameter.
+
+
+Debug Configuration Changed Event
+=================================
+
+	Event Code:		0x0027
+	Controller Index:	<non-controller>
+	Event Parameters:	Layers (4 Octets)
+				Flags (4 Octets)
+
+	This event indicates that the current global debug setting of
+	the stack has been changed.
+
+	The event will only be sent to management sockets other than the
+	one through which the change was triggered.
+
+	Refer Get Debug Configuration command for parameter description.
-- 
2.24.1

