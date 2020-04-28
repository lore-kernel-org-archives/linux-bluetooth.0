Return-Path: <SRS0=u/yl=6M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC74C83000
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 22:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1163720575
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 22:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RVxntICe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgD1WnO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726042AbgD1WnO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Apr 2020 18:43:14 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ECFC03C1AC
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 15:43:13 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id z6so54831plk.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 15:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5bhB3Jpj0w1XM6aCsjoDoYXeoc9RzG5a6jlvWVtpyw=;
        b=RVxntICea9rniI5Ki76z2Vgdcaf48IgCdal9dJgdlCQ98Ljn+Y939gbtgykge0nXWB
         H4NGGW1hUm0Nt2vU0JHEh48Z87S/jQLB9L8Z/U9rfVPKOY0FZ5rS2YgAqQ1Pykr+8mO+
         GPKxtzmipbJ/9AeDg4M1gnpftIE28/XbtDdlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5bhB3Jpj0w1XM6aCsjoDoYXeoc9RzG5a6jlvWVtpyw=;
        b=JMif+SnWTQ37CQ94yWRJCTbgqgvwJvpeCOydvtxjTinNFL8Q2WOp0sNLV3Jtb5W6CK
         CzbNftGCZZto6dj82MCBBCRyIW5Zk7HUoX9ABJsJ/L4P8zKXwDx97oxFAiJO2Lg6E1mH
         fRu1X6SFn13tkuc8eyptXhTBKo/pLRcrl0hoCku2r1yHCwyWP50uMgYGMd9H356P1U0Y
         5bK0cSorLDvDg8VX4Q49feec6a9A4LsdI66UtpWH4q/ofwF4WB0tUznOhCCOUSUieECk
         KfO3zF5UbGBj9EwWnjkmVId0PbbNXV1RDarioNlL/ytdVVgfk2oMAY9wzd522ZjJWcRA
         8kEA==
X-Gm-Message-State: AGi0PuaMGHZ+SJU1H9WnF2UcqGl6CfTiuczFm/f7w0wl1pmd3y9loTPK
        p6VbAnKi8v8OLMvATKMED91oRfwfYJk=
X-Google-Smtp-Source: APiQypLczWP7OVcNSsdQUGPrEqvagkI7DsJFnnxrKIo3iQoT8e3XOXuUQiXHoizfrtG93WiF2Fl0qg==
X-Received: by 2002:a17:90a:fb4e:: with SMTP id iq14mr7832375pjb.146.1588113792094;
        Tue, 28 Apr 2020 15:43:12 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id m1sm3148771pjg.26.2020.04.28.15.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 15:43:11 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v4] doc: Describe the new Advertisement Monitor support
Date:   Tue, 28 Apr 2020 15:43:07 -0700
Message-Id: <20200428154221.BlueZ.v4.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This describes the following commands and event.
- Read Advertisement Monitor Features command
- Add Advertisement Patterns Monitor command
- Remove Advertisement Monitor command
- Advertisement Monitor Added event
- Advertisement Monitor Removed event
Note that the content of a monitor can differ based on its type. For now we
introduce only pattern-based monitor, so you may find that unlike the
command of removing monitor(s), the Add command is tied to a specific type.
---

Changes in v4:
- In Read Advertisement Monitor Features command, rename
Adopted_Features to Enabled_Features.

Changes in v3:
- Remove Advertisement Monitor can perform the removal of one monitor
or all monitors.
- Add Read Advertisement Monitor Features command.
- Add Advertisement Monitor Added event and dvertisement Monitor Removed
event.

Changes in v2:
- Combine commands to remove one monitor and remove all monitors. The
refined command takes multiple handles and an extra field to indicate
whether to remove all monitors.

 doc/mgmt-api.txt | 118 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 39f23c456..e3a115c02 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3138,6 +3138,102 @@ Read Security Information Command
 				Invalid Index
 
 
+Read Advertisement Monitor Features Command
+===========================================
+
+	Command Code:		0x0049
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Supported_Features (4 octets)
+				Enabled_Features (4 octets)
+
+	This command is used to read the advertisement monitor features supported
+	by the controller and stack. Supported_Features lists all related
+	features supported by the controller while Enabled_Features lists the
+	ones currently used by the stack.
+
+	Supported_Features and Enabled_Features are bitmasks with currently the
+	following available bits:
+
+		1	Advertisement content monitoring based on Microsoft HCI
+			extension.
+
+
+Add Advertisement Patterns Monitor Command
+=========================================
+
+	Command Code:		0x004A
+	Controller Index:	<controller id>
+	Command Parameters:	Pattern_count (1 Octets)
+				Pattern1 {
+					AD_Data_Type (1 Octet)
+					Offset (1 Octet)
+					Length (1 Octet)
+					Value (variable length)
+				}
+				Pattern2 { }
+				...
+	Return Parameters:	Monitor_Handle (4 Octets)
+
+	This command is used to add an advertisement monitor whose filtering
+	conditions are patterns. The kernel would track the number of registered
+	monitors to determine whether to perform LE scanning while there is
+	ongoing LE scanning for other intentions, such as auto-reconnection and
+	discovery session. If the controller supports advertisement filtering,
+	the kernel would offload the content filtering to the controller in
+	order to reduce power consumption; otherwise the kernel ignore the
+	content of the monitor. Note that if the there are more than one
+	patterns, OR logic would applied among patterns during filtering. In
+	other words, any advertisement matching at least one pattern in a given
+	monitor would be considered as a match.
+
+	A pattern contain the following fields.
+		AD_Data_Type	Advertising Data Type. The possible values are
+				defined in Core Specification Supplement.
+		Offset		The start index where pattern matching shall be
+				performed with in the AD data.
+		Length		The length of the pattern value in bytes.
+		Value		The value of the pattern in bytes.
+
+	Here is an example of a pattern.
+		{
+			0x16, // Service Data - 16-bit UUID
+			0x02, // Skip the UUID part.
+			0x04,
+			{0x11, 0x22, 0x33, 0x44},
+		}
+
+	Possible errors:	Failed
+				Busy
+				Invalid Parameters
+
+
+Remove Advertisement Monitor Command
+====================================
+
+	Command Code:		0x004B
+	Controller Index:	<controller id>
+	Command Parameters:	Monitor_Handle (4 Octets)
+	Return Parameters:
+
+	This command is used to remove advertisement monitor(s). The kernel
+	would remove the monitor(s) with Monitor_Index and update the LE
+	scanning. If the controller supports advertisement filtering and the
+	monitor(s) has been offloaded, the kernel would cancel the offloading;
+	otherwise the kernel takes no further actions other than removing the
+	monitor(s) from the list.
+
+	Monitor_Handle can be the following values.
+		Value		Operation
+		-------------------------
+		0x00000000		Removes all existing monitor(s)
+		0x00000001 or greater	Removes the monitor with that handle
+
+	Possible errors:	Failed
+				Busy
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
@@ -4020,3 +4116,25 @@ PHY Configuration Changed Event
 	one through which the change was triggered.
 
 	Refer Get PHY Configuration command for PHYs parameter.
+
+
+Advertisement Monitor Added Event
+=================================
+
+	Event Code:		0x0027
+	Controller Index:	<controller id>
+	Event Parameters:	Monitor_Handle (4 Octets)
+
+	This event indicates that an advertisement monitor has been added using
+	the Add Advertisement Monitor command.
+
+
+Advertisement Monitor Removed Event
+===================================
+
+	Event Code:		0x0028
+	Controller Index:	<controller id>
+	Event Parameters:	Monitor_Handle (4 Octets)
+
+	This event indicates that an advertisement monitor has been removed
+	using the Remove Advertisement Monitor command.
-- 
2.24.1

