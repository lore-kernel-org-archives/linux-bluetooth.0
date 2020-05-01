Return-Path: <SRS0=Zhcm=6P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62501C47253
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 18:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C7120787
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 18:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgEASHS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 May 2020 14:07:18 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57607 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbgEASHR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 May 2020 14:07:17 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id A7C96CED24
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2020 20:16:55 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add commands and event for experimental feature configuration
Date:   Fri,  1 May 2020 20:07:11 +0200
Message-Id: <20200501180711.115409-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/mgmt-api.txt | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 42e467fab261..3669604a806c 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3138,6 +3138,84 @@ Read Security Information Command
 				Invalid Index
 
 
+Read Experimental Features Information Command
+==============================================
+
+	Command Code:		0x0049
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Feature_Count (2 Octets)
+				Feature1 {
+					UUID (16 Octets)
+					Flags (4 Octets)
+				}
+				Feature2 {  }
+				...
+
+	This command is used to retrieve the supported experimental features
+	by the host stack.
+
+	The UUID values are not defined here. They can change over time and
+	are on purpose not stable. Features that mature will be removed at
+	some point. The mapping of feature UUID to the actual functionality
+	of a given feature is out of scope here.
+
+	The following bits are defined for the Flags parameter:
+
+		0	Feature active
+		1	Change allowed during powered
+		2	Causes change in supported settings
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
+
+
+Set Experimental Feature Command
+================================
+
+	Command Code:		0x004a
+	Controller Index:	<controller id>
+	Command Paramters:	UUID (16 Octets)
+				Action (1 Octet)
+	Return Parameters:	Flags (4 Octets)
+
+	This command is used to change the setting of an experimental feature
+	of the host stack.
+
+	The UUID value must be a supported value returned from the Read
+	Experimental Features Information command.
+
+	The Action parameter is UUID specific, but in most cases it will be
+	just a simple on/off toggle with these values:
+
+		0x00	Disable feature
+		0x01	Enable feature
+
+	It depends on the feature if the command can be used when the
+	controller is powered up. See Flags parameter of Read Experimental
+	Features Information command for details if the controller has
+	to be powered down first.
+
+	The following bits are defined for the Flags return parameter:
+
+		0	Feature active
+		1	Allowed during powered
+		2	Supported settings changed
+
+	When a feature causes the change of supported settings, then it is
+	a good idea to re-read the controller information.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Not Powered
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
@@ -4021,3 +4099,20 @@ PHY Configuration Changed Event
 	one through which the change was triggered.
 
 	Refer Get PHY Configuration command for PHYs parameter.
+
+
+Experimental Feature Changed Event
+==================================
+
+	Event Code:		0x0027
+	Controller Index:	<controller id>
+	Event Parameters:	UUID (16 Octets)
+				Flags (4 Octets)
+
+	This event indicates that the status of an experimental feature
+	has been changed.
+
+	The event will only be sent to management sockets other than the
+	one through which the change was triggered.
+
+	Refer to Set Experimental Feature command for the Flags parameter.
-- 
2.26.2

