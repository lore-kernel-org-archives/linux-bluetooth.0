Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D443C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 13:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiBONgv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 08:36:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiBONgv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 08:36:51 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAF565179
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 05:36:41 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so2822584pjv.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 05:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NtYn16i6PJcNVrCsQ+T6vBaD/84nYyIgGCOm5X0Geo8=;
        b=IsluOudZIENxbcowX78dU+siIAI+y1KS7Pv9LAboZAVdAwdGtHeCMNfnynJ8b96iEG
         JIrhUxbZbKvXGqDnu8ahrkLO8I4gCBA94//wEpJrV0lsuAv6TDQw9xYFirm7zfdrsQNR
         TsiXSGLZe7ImOVfYtEXPqdPnExlTRgxQrN4Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NtYn16i6PJcNVrCsQ+T6vBaD/84nYyIgGCOm5X0Geo8=;
        b=wcDEfJr6TzBH4uu/TpDXOyzm5SazZXQ09+jitMXLo0k+PJAGeLc1+JVdS7U08+nnIU
         vevWpaOMkQHmODK6Df+MCSrquqFTmKsaSCXDwY5ydZ18ptRGOgTGsxqRQmsOz0mkTtpi
         OwmaP0ujxKzQFHs1gpWwM2TFAuED6+1d/0KvxMDc7WquAfUMuQOR4hQ3PpmeZw1NedhJ
         WCCBteAMfNR3bTubg0+28B60AoCkgiKWTZTHCTsKvJPNoU6vrzoaA+3EEhFujcGLDTTv
         ShBQL4/i/SxZxjzd7TsXA1Gs5OuKDsMYIu4JrFI4vqez/k2dlvA/08MffGMUFovZPaY5
         jnCQ==
X-Gm-Message-State: AOAM532iPusMmUhh5LUcoQ4xySwNQgDoC5k0GfdHMuYIkbIG1nWcuPG0
        hZg9Sfo/JO7Gnzm83730XmKZYGKfSA3KFQ==
X-Google-Smtp-Source: ABdhPJyBZAcwgosFNefMiH276nP4bJ0x2Bkw2FYhvC0bQuFAEhQMfmoDS2i+KOo5V9m6b7rqoyZbsw==
X-Received: by 2002:a17:903:2443:: with SMTP id l3mr4223570pls.146.1644932200442;
        Tue, 15 Feb 2022 05:36:40 -0800 (PST)
Received: from localhost (208.158.221.35.bc.googleusercontent.com. [35.221.158.208])
        by smtp.gmail.com with UTF8SMTPSA id s29sm3035010pfg.146.2022.02.15.05.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 05:36:39 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v4 1/8] doc: Introduce the quality report command and event
Date:   Tue, 15 Feb 2022 21:36:29 +0800
Message-Id: <20220215133636.2827039-1-josephsih@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the MGMT quality report command and event in doc/mgmt-api.txt.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

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

 doc/mgmt-api.txt | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index ebe56afa4..a494f5d7e 100644
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
@@ -3858,6 +3860,46 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
 				Invalid Parameters
 
 
+Set Quality Report Command
+==========================
+
+	Command Code:		0x0057
+	Controller Index:	<controller id>
+	Command Parameters:	Action (1 Octet)
+	Return Parameters:	Current_Settings (4 Octets)
+
+	This command is used to enable and disable the controller's quality
+	report feature. The allowed values for the Action command parameter
+	are 0x00 and 0x01. All other values will return Invalid Parameters.
+
+	The value 0x00 disables the Quality Report, and the value 0x01
+	enables the Quality Report feature.
+
+	This command is only available for the controllers that support
+	either AOSP Bluetooth quality report or Intel telemetry event.
+	For a controller supporting the AOSP specification, it should call
+	hci_set_aosp_capable() in its driver. The controller should also
+	return version_supported v0.98 or higher in its Vendor-specific
+	capabilities responding to the LE_Get_Vendor_Capabilities_Command.
+	On the other hand, for a controller supporting Intel specification,
+	it should set up the set_quality_report callback properly. The driver
+	is responsible of setting up the quality report capability as
+	described above; otherwise, a Not Supported status will be returned.
+
+	This command requires to use a valid controller index. Otherwise,
+	an Invalid Index status will be returned.
+
+	The command is sent to the controller to enable/disable the quality
+	report feature, and generates a Command Complete event on success.
+	If the controller failed to execute the action, a Failed status will
+	be returned.
+
+	Possible errors:	Failed
+				Invalid Index
+				Invalid Parameters
+				Not Supported
+
+
 Command Complete Event
 ======================
 
@@ -4978,3 +5020,22 @@ Advertisement Monitor Device Lost Event
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
2.35.1.265.g69c8d7142f-goog

