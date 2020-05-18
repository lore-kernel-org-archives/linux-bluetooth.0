Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE316C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 23:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF9C0207D4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 23:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y85p3SPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgERXrS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 19:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgERXrP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 19:47:15 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84710C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 16:47:15 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nu7so545302pjb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 16:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LCiAqBRsXISrZ5/nVFELTUI25XboaF04jqUBEgDsgQ8=;
        b=Y85p3SPCfH8JbzuIW3c7CHmULQqwqZUEFFxltp9U7+2Zl43nTMCWMBt+LxBpw7AGZZ
         hz6ppV/w01tPFnXcto30sqFopLDoUx3okVjoUxjShiiG7uQuvbTtodIjFK8vWXPaWXk9
         GJWeSuvxAyLtpFlTJkQfLWis3SD0fqicJRUVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LCiAqBRsXISrZ5/nVFELTUI25XboaF04jqUBEgDsgQ8=;
        b=XrojNuphL5Y5f187yrVYSdJl6aWrDU0DkmzbMriWT2NiX4Ml+4BrGc8KgZ/a3orZyP
         gBsXGNOIvsoklvvx/Y50Z9m4MR7m2Y+RM1YwU7uB9OVb4JCV/0j3i00kyKIIyRYnSEz7
         ilKC5AO5AaWHEgq9FvxmkAjT1mJalt/FnXKIj2RRCPecz1eN15Kai/Ng5mlt0YlIUMFT
         SonKP9qnnwV3w0ZD2RRHYY866QTK7ua9Mv8Tt08q6wcF/F2KrT5I/oGWKcmVJmKQqcdZ
         meAX/oM7935qE9gasXKLqBuFG38hNaKVQXrAwPoaR+oZ/1EF60vIctkAVsesstLCkSWn
         fbHA==
X-Gm-Message-State: AOAM532Iyx69mGiucBKSyBP/L5npnO68p5X7/xzMM+6nnvnjurj75HW5
        o343eQLPuNqmTlnNJUVUoTqwth+CwrA=
X-Google-Smtp-Source: ABdhPJw4+M4IfKzF8wo+448+jLEc1Rua13cKQgIWVINEDRYdCyFS7REimmpLGvUtSj8wvUfYC5l2MQ==
X-Received: by 2002:a17:90a:1b25:: with SMTP id q34mr1970936pjq.12.1589845634357;
        Mon, 18 May 2020 16:47:14 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id p5sm8385186pgk.28.2020.05.18.16.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 16:47:13 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Michael Sun <michaelfsun@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v7] doc: Describe the new Advertisement Monitor support
Date:   Mon, 18 May 2020 16:47:09 -0700
Message-Id: <20200518164642.BlueZ.v7.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
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

 doc/mgmt-api.txt | 148 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index b7c4db907..0d6d8b312 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3215,7 +3215,124 @@ Set Experimental Feature Command
 
 	Possible errors:	Invalid Parameters
 				Not Powered
-				Invalid Index
+
+
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
+		1	Advertisement content monitoring based on patterns with
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
 
 
 Command Complete Event
@@ -4118,3 +4235,32 @@ Experimental Feature Changed Event
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
+>>>>>>> c26c91bd3... Describe the new Advertisement Monitor support
-- 
2.26.2

