Return-Path: <SRS0=orbE=6O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C147C83003
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Apr 2020 03:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025572083B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Apr 2020 03:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wb61UyZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgD3DbC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD3DbC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Apr 2020 23:31:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF30FC035494
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 20:31:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so142254pjb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 20:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5s9YHaWtzDXo107Kcfzp1XkWTCE/gzb+RAWh5n/g0Z8=;
        b=Wb61UyZQbBV271LNuoV6j9tIl18v8hWNIh5cuIhhZa8kIAs7orPd9LY3bUOyVNJnQn
         eTGfirXddPHfXGUOoLacYp/onjPOKVPC+vJaJkc5NDfLfHnU/XGICPbT9xDYRrvmNWEc
         KcPjvRZwGQmWm+7aw22t8cukm9WrWaoTBYvsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5s9YHaWtzDXo107Kcfzp1XkWTCE/gzb+RAWh5n/g0Z8=;
        b=a45BQojbJuK9fxqYgdcIklu6ec7bnZV0AmTsMEVCT1OsHj3prl/SeYBQrQwRo0d7ZX
         tGQSBvU4dGO/IBF8f2ogf+hoUHloPTJoX5KevWojxf4Toh+JQcffO4lqW1/Oj5llxAJv
         /qxzI0hxRYJIjRulmqUZisGUJB3HMBiHl1kZFnnDuAlByBXsVkX+/WmFaPxBnyah7rtq
         9R9yW4XSgno3AYez09biwSffOm84e1uPCOm0glwW1JYiEvmFCqEopZT9RF745NWFWV+i
         jlqNMHRclxQNSHkMS5OOwDKLTQA5jcuHN14r1q6oif3XqfQlr+xAkNhqR4bX6HbBsm8Q
         Wfjw==
X-Gm-Message-State: AGi0PuYm/UUklnOYXoK/G8V+QGO7qu1ocQX54lN3FzoA45eC1BSESaf3
        y4o4U4OzjhzXn4HGCXeWn3AiH3YU7bk=
X-Google-Smtp-Source: APiQypKy7x4GVidHW/GLUhsFEvei6w0HpADSgQgYSST/GVZBpgk1hndiW3vHVbH0yRmMDWjIMwXP0g==
X-Received: by 2002:a17:90a:17ed:: with SMTP id q100mr633232pja.80.1588217460464;
        Wed, 29 Apr 2020 20:31:00 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id fh18sm565384pjb.0.2020.04.29.20.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 20:30:59 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v5] doc: Describe the new Advertisement Monitor support
Date:   Wed, 29 Apr 2020 20:30:48 -0700
Message-Id: <20200429203031.BlueZ.v5.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
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

 doc/mgmt-api.txt | 147 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 39f23c456..4aa755c45 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3138,6 +3138,125 @@ Read Security Information Command
 				Invalid Index
 
 
+Read Advertisement Monitor Features Command
+===========================================
+
+	Command Code:		0x0049
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Supported_Features (4 octets)
+				Enabled_Features (4 octets)
+				Max_Num_Handles (2 octets)
+				Max_Num_Patterns (1 octet)
+				Num_Handles (2 octets)
+				Handle1 (2 octets)
+				Handle2 (2 octets)
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
+		1	Advertisement content monitoring based on Microsoft
+			HCI extension.
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
+	Command Code:		0x004B
+	Controller Index:	<controller id>
+	Command Parameters:	Monitor_Handle (2 Octets)
+	Return Parameters:
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
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
@@ -4020,3 +4139,31 @@ PHY Configuration Changed Event
 	one through which the change was triggered.
 
 	Refer Get PHY Configuration command for PHYs parameter.
+
+
+Advertisement Monitor Added Event
+=================================
+
+	Event Code:		0x0027
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
+	Event Code:		0x0028
+	Controller Index:	<controller id>
+	Event Parameters:	Monitor_Handle (2 Octets)
+
+	This event indicates that an advertisement monitor has been removed
+	using the Remove Advertisement Monitor command.
+
+	The event will only be sent to management sockets other than the
+	one through which the command was sent.
-- 
2.24.1

