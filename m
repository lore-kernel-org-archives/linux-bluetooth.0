Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE21C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 01:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E80E2078C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 01:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R/9Y2pFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgE1BY1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 May 2020 21:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgE1BY0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 May 2020 21:24:26 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB64FC05BD1E
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 18:24:26 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id s192so3422736vkh.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 18:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RAJ8vno6YRTG3jxZLPEtz5iL0Y3/+q1Rvr89mCmtx8A=;
        b=R/9Y2pFD2l41EaJe+MKqDBsJmGACKu0ZyrqYf5z8hWIPGUyYPd71ssA7FsmG0gK/qh
         UWiwhpLfgS60gnHA0m5dHJOkcao/n5xRj17bbXg08MKqkVA43tXQlCcZTk6f58B9ZkQ4
         GvIz78DUXPXZvuiSDBB9qxXYgNqsK1SMBwJIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RAJ8vno6YRTG3jxZLPEtz5iL0Y3/+q1Rvr89mCmtx8A=;
        b=mTBgRY4bGj0zCKoIKvJGVq8Yn9oHawQByJ3fmc68EekZ4bh1nwch0C8MvpFil2QkZS
         MbMIEuqXLV9sBLkHgwgkuXyNqpWXegnuJU10tj8iWFCrsmRlwHwPSZIP1Ofqu5rlvIEl
         OYszsIL6/kEnJ43NLPKqmsj5cELmneF2u3aLVugfKmbl1iRzYh1isr9GIGjmph6a5aiG
         LxGnGhdUHcZzPmX7Mw4cEjpdtOLBOfIzfsF213wlG4QQdyb0OYij+Jhqwh59x8Ez7mTT
         PtDPcHiFstK5Yk/x+53Kftk+3esZE8w6oJBn8g8RgeE1ZddxLsZXolpbuv+/Aa9FMaR1
         gFxw==
X-Gm-Message-State: AOAM531wgVXkUwe25cIz5RFRvYi7+kwrSkR3A9ZntpQANZDSOw/nPZPJ
        YqrfDnglJgiuQ2kFe9vY2z5qX5rFeP4=
X-Google-Smtp-Source: ABdhPJwb+jmES4BlSM+aSJRE+YZTCLDt04nYufXPFZIZl2VOtMHHQ/gGKGGX1tWQYyVjD4acGy0hmw==
X-Received: by 2002:a1f:5f4f:: with SMTP id t76mr493319vkb.77.1590629065566;
        Wed, 27 May 2020 18:24:25 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id l2sm332863vsh.21.2020.05.27.18.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 18:24:24 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v5] doc:adding definitions for load default params mgmt op
Date:   Thu, 28 May 2020 01:24:21 +0000
Message-Id: <20200528012421.136864-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
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

 doc/mgmt-api.txt | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 6ee01fed8..14e3179b5 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3223,6 +3223,65 @@ Set Experimental Feature Command
 				Invalid Index
 
 
+Load Default Controller Parameter Command
+=============================
+
+	Command Code:		0x004b
+	Controller Index:	<controller id>
+	Command Parameters:	Parameter1 {
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
+		0x000f	LE Scanning Interval for wake scenarios
+		0x0010	LE Scanning Window for wake scenarios
+		0x0011	LE Scanning Interval for discovery
+		0x0012	LE Scanning Window for discovery
+		0x0013	LE Scanning Interval for adv monitoring
+		0x0014	LE Scanning Window for adv monitoring
+		0x0015	LE Scanning Interval for connect
+		0x0016	LE Scanning Window for connect
+		0x0017	LE Min Connection Interval
+		0x0018	LE Max Connection Interval
+		0x0019	LE Connection Latency
+		0x001a	LE Connection Supervision Timeout
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
+
+
 Command Complete Event
 ======================
 
-- 
2.27.0.rc0.183.gde8f92d652-goog

