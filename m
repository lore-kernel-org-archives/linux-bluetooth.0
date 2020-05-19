Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C224C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 03:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E90E206D4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 03:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XrpsN3yE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgESDhi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 23:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgESDhi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 23:37:38 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7180CC061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 20:37:38 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s20so5062738plp.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 20:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fsKMiacdLAxm2PlTmqQC0rSvDB6hFo8JlxEY+9eC97A=;
        b=XrpsN3yEuYmigeyDxn6bjuWclOdNLksvG2OxjTLLMi+gm07po2XMfNK6lkQBQckxz7
         LHJh/ie4iXSeVle0h7nuGqkeT3SRJnQnK12gMmKI1zUmUaGNsDM7PhyU1FY9nbCuUbnl
         I8dSbIR3hhbrMh+Jo7xWg5QDIuCrgKm3WwbZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fsKMiacdLAxm2PlTmqQC0rSvDB6hFo8JlxEY+9eC97A=;
        b=niRXHMEztsStJNu+LWb0H8/Ls32fUkrAPDebBAOEuD8SFy+UdFGkJX6W7pLIP4lUb4
         ophgOOHgXzB96hvArXgoy9vBJ8PqazzogWJEl1jZ8ffJUnTir038nN4TSOoYVkWbrRAA
         9ebTHleDNF9xZwNQvKnAnGTkgbbcDIqTcVPcaMUoPUrLHB+EgfFswigd7E9qKxwea4zl
         wHsMu1yDs8/tR8b2XOYEWQ018dSGvcVf7WLuJdicJlUeahoytE/DYnBVX3tQcg8exZ16
         an0bttFzAJ4ax307BhzQB/t4+GVxwUKKcClI4RF2ETbGZ5DeA8YHSMrrTZBqr+bEG6AQ
         Guzw==
X-Gm-Message-State: AOAM5328E0aTAv/T/zbQ/NcnozZA82sd1KnS+kj90sBIAET+Pr7j8WAt
        gzDlT1RCpEhG14H+zcNfkUpyT8Tb3hA=
X-Google-Smtp-Source: ABdhPJz0emg70nGqb6Z/euklm/Wy98MkC6PmNJ49+CeshKHj/9BcKiohy9Tm4KAgxOmDHwz02NDpag==
X-Received: by 2002:a17:90a:ad49:: with SMTP id w9mr2861072pjv.20.1589859457063;
        Mon, 18 May 2020 20:37:37 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id ce21sm768041pjb.51.2020.05.18.20.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 20:37:36 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v8] doc: Describe the new Advertisement Monitor support
Date:   Mon, 18 May 2020 20:37:31 -0700
Message-Id: <20200518203627.BlueZ.v8.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
X-Mailer: git-send-email 2.26.2
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

Changes in v8:
- Fix bit index of advertisement monitor feature and remove a tailing line.

Changes in v7:
- Update command/event opcodes after rebasing.

Changes in v6:
- Refine the description of commands.
- Add Monitor_Handle as the return parameter of Remove Advertisement
Monitor command.

Changes in v5:
- Add more fields in the return value of Read Advertisement Monitor
Features command.
- Refine the description of commands and events.

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

 doc/mgmt-api.txt | 146 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index b7c4db907..211f085fa 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3218,6 +3218,124 @@ Set Experimental Feature Command
 				Invalid Index
 
 
+Read Advertisement Monitor Features Command
+===========================================
+
+	Command Code:		0x004b
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Supported_Features (4 Octets)
+				Enabled_Features (4 Octets)
+				Max_Num_Handles (2 Octets)
+				Max_Num_Patterns (1 Octet)
+				Num_Handles (2 Octets)
+				Handle1 (2 Octets)
+				Handle2 (2 Octets)
+				...
+
+	This command is used to read the advertisement monitor features
+	supported by the controller and stack. Supported_Features lists all
+	related features supported by the controller while Enabled_Features
+	lists the ones currently used by the kernel.
+
+	Supported_Features and Enabled_Features are bitmasks with currently
+	the following available bits:
+
+		0	Advertisement content monitoring based on patterns with
+			logic OR.
+
+	Max_Num_Handles indicates the maximum number of supported
+	advertisement monitors. Note that the actual number of supported
+	ones might be less depending on the limitation of the controller.
+
+	Max_Num_Pattern indicates the maximum number of supported patterns
+	in an advertisement patterns monitor. Note that the actual number
+	of supported ones might be less depending on the limitation of the
+	controller.
+
+	Num_Handles indicates the number of added advertisement monitors,
+	and it is followed by a list of handles.
+
+	This command can be used when the controller is not powered.
+
+
+Add Advertisement Patterns Monitor Command
+=========================================
+
+	Command Code:		0x004c
+	Controller Index:	<controller id>
+	Command Parameters:	Pattern_Count (1 Octet)
+				Pattern1 {
+					AD_Type (1 Octet)
+					Offset (1 Octet)
+					Length (1 Octet)
+					Value (31 Octets)
+				}
+				Pattern2 { }
+				...
+	Return Parameters:	Monitor_Handle (2 Octets)
+
+	This command is used to add an advertisement monitor whose
+	filtering conditions are patterns. The kernel will trigger scanning
+	if there is at least one monitor added. If the controller supports
+	advertisement filtering, the kernel would offload the content
+	filtering to the controller in order to reduce power consumption;
+	otherwise the kernel ignores the content of the monitor. Note that
+	if the there are more than one patterns, OR logic would applied
+	among patterns during filtering. In other words, any advertisement
+	matching at least one pattern in a given monitor would be
+	considered as a match.
+
+	A pattern contains the following fields.
+		AD_Data_Type	Advertising Data Type. The possible values
+				are defined in Core Specification
+				Supplement.
+		Offset		The start index where pattern matching
+				shall be performed with in the AD data.
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
+	This command can be used when the controller is not powered and
+	all settings will be programmed once powered.
+
+	Possible errors:	Failed
+				Busy
+				No Resources
+				Invalid Parameters
+
+
+Remove Advertisement Monitor Command
+====================================
+
+	Command Code:		0x004d
+	Controller Index:	<controller id>
+	Command Parameters:	Monitor_Handle (2 Octets)
+	Return Parameters:	Monitor_Handle (2 Octets)
+
+	This command is used to remove advertisement monitor(s). The kernel
+	would remove the monitor(s) with Monitor_Handle and update the LE
+	scanning.
+
+	When the Monitor_Handle is set to zero, then all previously added
+	handles will be removed.
+
+	Removing a monitor while it is being added will be ignored.
+
+	This command can be used when the controller is not powered and
+	all settings will be programmed once powered.
+
+	Possible errors:	Failed
+				Busy
+
+
 Command Complete Event
 ======================
 
@@ -4118,3 +4236,31 @@ Experimental Feature Changed Event
 	one through which the change was triggered.
 
 	Refer to Set Experimental Feature command for the Flags parameter.
+
+
+Advertisement Monitor Added Event
+=================================
+
+	Event Code:		0x0028
+	Controller Index:	<controller id>
+	Event Parameters:	Monitor_Handle (2 Octets)
+
+	This event indicates that an advertisement monitor has been added
+	using the Add Advertisement Monitor command.
+
+	The event will only be sent to management sockets other than the
+	one through which the command was sent.
+
+
+Advertisement Monitor Removed Event
+===================================
+
+	Event Code:		0x0029
+	Controller Index:	<controller id>
+	Event Parameters:	Monitor_Handle (2 Octets)
+
+	This event indicates that an advertisement monitor has been removed
+	using the Remove Advertisement Monitor command.
+
+	The event will only be sent to management sockets other than the
+	one through which the command was sent.
-- 
2.26.2

