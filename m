Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB51C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 May 2022 10:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiEYKub (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 May 2022 06:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiEYKua (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 May 2022 06:50:30 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596FC1C6
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 03:50:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gk22so922237pjb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 03:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/S9U3Gf8VokdT11z/FTy2YkWPpZtI3hDdvP6QmYOARw=;
        b=kAAkzLjGVsaTeOmvN4qaWDZxsyzTbN6+/fJ2VbXIm7HBUjxtomGjv87eFXypj7GB/m
         DUHGdaj0uK4yOsPP6HwTXL6XoTThWcfmR3qQLzERH9rNeW6+8k0LK5wmg8LIXEugKJ0/
         yPQwEin6hCqvVd10Ei8lqjXPxJzfL4JNHEsYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/S9U3Gf8VokdT11z/FTy2YkWPpZtI3hDdvP6QmYOARw=;
        b=7gNhTYOQcA4iT1CQoLmx3sR7Kx86RVxgSiaAj3uhS0UYu92eTL2oZgjHJCOeAWgUXN
         +k+vw6DvcEP7RGrk1BUfHPOA+BybXwRCVl1fTUJPOV5bs1no+FL06ntEZfOKeC3UZ7CX
         5JCi0X1oCPyRL6aC7OLFjmupppkMJtT+UJqalRbCv0j5X7VcBKQ12Gr3xvdHiaU3mliT
         DS1DR30RqQPCO+YtdGHkudo/OSafABQ6lnLW7hp+jPfFL8VjVZY6fw35o2O+DRsY1JaR
         KYwAwxxa4BIk9+SC6T25SigHJFaJ8As6emzDnkzcJ+EqYXW3Om76+A2L8j92kd2yIsaD
         l/lw==
X-Gm-Message-State: AOAM530aX5JLBGg1cZG+cqkt96F6ZRE3G8/a2fwCottOVjno3TaxPt5l
        Mjy9qftOC1rMmX8cvgOgx7nyaGpuWbpZ5g==
X-Google-Smtp-Source: ABdhPJy6aQ7UjkSlbeV/TNGavDFllf6QGicJ5wDbD1QRqDuihIkMWWBE+2j7oJSysCT1jwz8IDDsOQ==
X-Received: by 2002:a17:90b:3ecd:b0:1dc:945e:41b1 with SMTP id rm13-20020a17090b3ecd00b001dc945e41b1mr9815653pjb.208.1653475828702;
        Wed, 25 May 2022 03:50:28 -0700 (PDT)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id z13-20020a056a00240d00b0050dc762819bsm11217510pfh.117.2022.05.25.03.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 03:50:28 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v5 1/8] doc: Introduce the quality report command and event
Date:   Wed, 25 May 2022 18:50:08 +0800
Message-Id: <20220525105015.2315987-1-josephsih@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the MGMT quality report command and event in doc/mgmt-api.txt.

---

Changes in v5:
- Use Quality_Report instead of Action in mgmt-api.txt.
- Modify the description of Set Quality Report Command.

Changes in v4:
- Use "Quality Report Event" without the prefix "Bluetooth" word.
- Combine both MGMT quality report command and event changes in a
  single patch.

Changes in v3:
- Swap AOSP Bluetooth Quality Report Event and Intel Telemetry Event.
- Add 5 new patches (5/9 - 9/9) to enable the quality report
  feature via MGMT_OP_SET_QUALITY_REPORT instead of through the
  experimental features.

Changes in v2:
- This is a new patch for adding the event in doc/mgmt-api.txt

 doc/mgmt-api.txt | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index ebe56afa4..a429f0ef3 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -332,6 +332,7 @@ Read Controller Information Command
 		15	Static Address
 		16	PHY Configuration
 		17	Wideband Speech
+		18	Quality Report
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
@@ -2924,6 +2925,7 @@ Read Extended Controller Information Command
 		15	Static Address
 		16	PHY Configuration
 		17	Wideband Speech
+		18	Quality Report
 
 	The EIR_Data field contains information about class of device,
 	local name and other values. Not all of them might be present. For
@@ -3858,6 +3860,45 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
 				Invalid Parameters
 
 
+Set Quality Report Command
+==========================
+
+	Command Code:		0x0057
+	Controller Index:	<controller id>
+	Command Parameters:	Quality_Report (1 Octet)
+	Return Parameters:	Current_Settings (4 Octets)
+
+	This command is used to enable and disable the controller's quality
+	report feature. The allowed values for the Quality_Report command
+	parameter are 0x00 and 0x01. All other values will return Invalid
+	Parameters.
+
+	The value 0x00 disables the Quality Report, and the value 0x01
+	enables the Quality Report feature.
+
+	This command is only available for the controllers that support
+	either AOSP Bluetooth quality report or Intel telemetry event.
+	It is supported if the supported_settings indicate support for it.
+
+	This command requires to use a valid controller index. Otherwise,
+	an Invalid Index status will be returned.
+
+	The command is sent to the controller to enable/disable the quality
+	report feature, and generates a Command Complete event on success.
+	If the controller failed to execute the action, a Failed status will
+	be returned.
+
+	The quality report state is maintained by the kernel over the adapter
+	power cycle. When the adapter is powered off, the quality report
+	feature is disabled by the kernel. When the adapter is powered on, it
+	is enabled again by the kernel if it was enabled before.
+
+	Possible errors:	Failed
+				Invalid Index
+				Invalid Parameters
+				Not Supported
+
+
 Command Complete Event
 ======================
 
@@ -4978,3 +5019,22 @@ Advertisement Monitor Device Lost Event
 		2	LE Random
 
 	This event will be sent to all management sockets.
+
+
+Quality Report Event
+====================
+
+	Event code:		0x0031
+	Controller Index:	<controller_id>
+	Event Parameters:	Quality_Spec (1 Octet)
+				Report_Len (2 Octets)
+				Report (0-65535 Octets)
+
+	This event carries the Bluetooth quality report sent by the
+	controller.
+
+	Possible values for the Quality_Spec parameter:
+		0	AOSP Bluetooth Quality Report Event
+		1	Intel Telemetry Event
+
+	This event will be sent to all management sockets.
-- 
2.36.1.124.g0e6072fb45-goog

