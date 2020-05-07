Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016D8C35280
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 21:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2CE0208D6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 21:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VCsOOkmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgEGVyd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 17:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgEGVyd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 17:54:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC9DC05BD43
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2020 14:54:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so3404361pgb.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2020 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpxEAMo1lkkG16LoiOOmyQhtIAffyqIp4uR/Dx0kU0I=;
        b=VCsOOkmcEtyeqfF+sYBdzt1KFn1ZVG5h3ri7K62EtObvFj8WKjoFDla5ftcMGBSvaC
         LOxVhwwy9gvfdFRCZFwdPRCpO29wQBfDAl4NtchhJy/RKM+lliSiBwj7wFLtK7PYX2hZ
         hgkdqh/PA+5FVUqh8alxzlW0t86yYCRvG8iXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpxEAMo1lkkG16LoiOOmyQhtIAffyqIp4uR/Dx0kU0I=;
        b=lcn6MBUwzrNQ2llKfk8HrjjtLDs+26s9QOBicVt4RGP8obyHOl8qmRVNXTeeMiPql5
         ll+LwrIRBSjuytimNzDGGrBR6QaMwGAHZuAPLv2eqiuo9d4/duqMRq72DTw5Aof7rcbu
         HJPCfHjrFMOwxrPWMu9FRJpQtLgbkeZpHyr/7QowkrdHRnSPUIdRJCvOXC7HfBodx4Q5
         LNVZ6wmqVvO8EjCLRBMlx9ssmcyO3ZUlROyL5uKK2/tLJbSRI4+5lXSPsIdjT2RrFkFX
         h1eBMBpd/WI227wSC/1lTI1kvS5Wjgh7DjUgYgdejPMJsExM0cTQSHUgZJ4QxlwHD0vQ
         7bWA==
X-Gm-Message-State: AGi0PubBUFPwQ41+rLukDtafrn1gdepIq4OydPjFbvcNYojiwNEQlFau
        200Fo/lXZ61BVKaHvfdhYDoCkA4XcZM=
X-Google-Smtp-Source: APiQypLkeQUvX9a8mi5WuRnM2QxDEJrf6eaXUc12YW7nj6sF7gJVOKYqC46SCJ582RPqFf2Vidn5jg==
X-Received: by 2002:a62:174a:: with SMTP id 71mr16590545pfx.297.1588888471638;
        Thu, 07 May 2020 14:54:31 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id f74sm8827287pje.3.2020.05.07.14.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 14:54:30 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v6] doc: Describe the new Advertisement Monitor support
Date:   Thu,  7 May 2020 14:54:24 -0700
Message-Id: <20200507145354.BlueZ.v6.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
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

 doc/mgmt-api.txt | 147 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 39f23c456..3290cc76f 100644
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
+	Command Code:		0x004A
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
+	Command Code:		0x004B
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

