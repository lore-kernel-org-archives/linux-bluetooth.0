Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62273C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 11:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347093AbiEZLZF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 07:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbiEZLZC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 07:25:02 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84643CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 04:25:01 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c14so1470729pfn.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 04:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJBvj6G+GQCxUKbSubCwcRd/ln0obOikcaZZWNEA07o=;
        b=alb94opfuKa0czBSgKs3+KHG1ZSHM2tA86Vg9nm4CD4XzXxUeaJBBJqPmohC9TrN7F
         qGzIbVvQLtxMf8F9HASEq6sg3CWdkNJ5uu0Sfos3wV2z6OrN+kHRaqfmYNji9HZEXyiz
         QXMqpEayUBi5t+VCMCQQH+TOdiirh9dekdDbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJBvj6G+GQCxUKbSubCwcRd/ln0obOikcaZZWNEA07o=;
        b=CQciomRe9rhZm7gTPw0njyTl3K2fZFrs2GWnn+NujfecyYI16UrcHeus94vr0Hn+mu
         E1JKIkBJehZMZXzqXY6LiYt+08WvgFbYgHhKEMhyIwsQHq8nFrRd9I/TCh6eI0bN7yQW
         2hQZJNHNFZQerJLzRBPdkHUiEvCuGizwk4X4eprJwWP46PaHxotGaaRnUsxFlzl18Dud
         0LBEXeFHmy8EyTyHRfDPnM8f3f8IWHtbwHufXRNtdQzOryoqmn4MBHm67FzmnnhekO/U
         pUxRI8qhet+hfgEDdXlswZnr88IX3Fv0ilk/MyyM6Cmo/hodILijx2T3NVRL71fkhBMa
         Tggw==
X-Gm-Message-State: AOAM5333cUnaQhjeBRVlHLsGSgVY3DvJZmiecJkwEHLw3TlOiE/sfpk9
        LMLNW2kpmFaItECv+FGu+CWiY8SV0ndAzg==
X-Google-Smtp-Source: ABdhPJzEWhNGfNSDX685jC2sCnWt11akQ2mHs/KEKZz55IeQR1g2vXjWUzc2RS3YDddjvGiMeyRSjA==
X-Received: by 2002:a65:6d0d:0:b0:3fb:1477:5191 with SMTP id bf13-20020a656d0d000000b003fb14775191mr2548410pgb.541.1653564300868;
        Thu, 26 May 2022 04:25:00 -0700 (PDT)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id m5-20020a63f605000000b003faebbb772esm1315159pgh.25.2022.05.26.04.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 04:25:00 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v6 1/8] doc: Introduce the quality report command and event
Date:   Thu, 26 May 2022 19:24:49 +0800
Message-Id: <20220526112456.2488536-1-josephsih@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the MGMT quality report command and event in doc/mgmt-api.txt.

---

Changes in v6:
- No update in this patch. The patch 3/8 is updated to resolve a
  patch conflict.

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

