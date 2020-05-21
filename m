Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAC4C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 14:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 734BB20826
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 14:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OHXutEyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgEUOrd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 10:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgEUOrc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 10:47:32 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46DCC061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 07:47:32 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id z3so1739925vka.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s71uf2WU8TIs9FoRRuewwJRCxbNaAyTTvDmfgfqgOP8=;
        b=OHXutEybvjAc59If2dE5UZp+w6uVocKsLUWe7jUHxbRRQcXvPPIEvyzThYfgmPXPN9
         WrPVGi+rz10a5qSfJwTKwYsyeeWF+GfQpP1GHmMSc3FSEPTstCCs39XT0vFPvYrHCJIl
         5IoZcNhNyduTFkhA5SF95fBzsMI1c5CiV8rII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s71uf2WU8TIs9FoRRuewwJRCxbNaAyTTvDmfgfqgOP8=;
        b=i4f/PwMwC8T11l3+AoC3ZuNxQRYOdZg952ShdN3P550ZwX9PdQ5ouerfZL9DCf1EHw
         IBYmAFfmuNY8yk0EFwTQly6ldh353q7lWufYnY34KSwEIqzWp2cP/AHfElaUNbS3vR6s
         l0JXawDDWrWt9WBv7J0tN2XMfFTK7VnmtgHs6ooWcpRSa4kGADX8gHV4ghV1ajFOicOc
         r6x07L6po8urO8S2djXqrDmzucXIE94hA7KB8GRS+ya+3evAgqdkWyQ0KFV9FN1PQxD/
         CtMTl81mC3dcHPKfGL/i4qIIa/weOsTVeDIHsgZRlUrkFA8D7p1frJyWDfEnt4Q9PjSI
         T6dg==
X-Gm-Message-State: AOAM5305PmGsBpuEDAZTuozN8giES5cfC81xCHq73dWopr+39UNgEMya
        oFmxwnxNu0ebX8GQMfK0MYDZvUGgUvcdBg==
X-Google-Smtp-Source: ABdhPJyH19pHCzFekB8czx9E6BS2edfsxpXTBa0q4f6e5XRyV1evM1p5Tns88ftboPLqxpYa+V5OUQ==
X-Received: by 2002:a1f:cd06:: with SMTP id d6mr7800108vkg.94.1590072451463;
        Thu, 21 May 2020 07:47:31 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id i199sm791766vke.20.2020.05.21.07.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 07:47:30 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v2] doc:adding definitions for load default params mgmt op
Date:   Thu, 21 May 2020 14:47:27 +0000
Message-Id: <20200521144728.243834-1-alainm@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds the definition for the load default parameter command.
In particular, this command is used to load default parameters for
various operations in the kernel. This mechanism is also expandable to
future values that may be necessary.

This will allow bluetoothd to load parameters from a conf file that may
be customized for the specific requirements of each platforms.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 doc/mgmt-api.txt | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 39f23c456..be8d6ff33 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3137,6 +3137,66 @@ Read Security Information Command
 	Possible errors:	Invalid Parameters
 				Invalid Index
 
+Load Default Controller Parameter Command
+=============================
+
+	Command Code:		0x0049
+	Controller Index:	<controller id>
+	Command Parameters:	Parameter_Count (2 Octets)
+				Parameter1 {
+					Parameter_Type (2 Octet)
+					Value_Length (1 Octet)
+					Value (0-255 Octets)
+				}
+				Parameter2 { }
+				...
+	Return Parameters:
+
+	This command is used to feed the kernel a list of default controller
+	parameters.
+
+	Currently defined Parameter_Type values are:
+
+		0x0000	BR/EDR Page Scan Type
+		0x0001	BR/EDR Page Scan Interval
+		0x0002	BR/EDR Page Scan Window
+		0x0003	BR/EDR Inquiry Scan Type
+		0x0004	BR/EDR Inquiry Scan Interval
+		0x0005	BR/EDR Inquiry Scan Window
+		0x0006	BR/EDR Link Supervision Timeout
+		0x0007	BR/EDR Page Timeout
+		0x0008	BR/EDR Min Sniff Interval
+		0x0009	BR/EDR Max Sniff Interval
+		0x000a	LE Advertisement Min Interval
+		0x000b	LE Advertisement Max Interval
+		0x000c	LE Multi Advertisement Rotation Interval
+		0x000d	LE Scanning Interval for auto connect
+		0x000e	LE Scanning Window for auto connect
+		0x000f	LE Scanning Interval for HID only
+		0x0010	LE Scanning Window for HID only
+		0x0012	LE Scanning Interval for wake scenarios
+		0x0013	LE Scanning Window for wake scenarios
+		0x0014	LE Scanning Interval for discovery
+		0x0015	LE Scanning Window for discovery
+		0x0016	LE Scanning Interval for adv monitoring
+		0x0017	LE Scanning Window for adv monitoring
+		0x0018	LE Scanning Interval for connect
+		0x0019	LE Scanning Window for connect
+		0x001a	LE Min Connection Interval
+		0x001b	LE Max Connection Interval
+		0x001c	LE Connection Connection Latency
+		0x001d	LE Connection Supervision Timeout
+
+	This command can be used when the controller is not powered and
+	all settings will be programmed once powered.  Note that these only
+	control the default parameters.  Higher level Apis may influence the
+	effective value used.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
 
 Command Complete Event
 ======================
-- 
2.26.2.761.g0e0b3e54be-goog

