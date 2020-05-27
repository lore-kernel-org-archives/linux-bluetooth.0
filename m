Return-Path: <SRS0=nKc5=7J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BEDC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 15:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FBE20899
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 15:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R/oPUx1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgE0PmZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 May 2020 11:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgE0PmZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 May 2020 11:42:25 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACAFC05BD1E
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 08:42:25 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id r10so1619666vsa.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 08:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hYfhSUsIkz92mjrRMI3jfLi9LV8ibmLGXbRODHuw28c=;
        b=R/oPUx1+vwS0q8WZ8xwBHhfg/n4Nvr/L5DVDqy/J0wuW0wjZJNCBleUPvckFgt1dhW
         T7bWmrLBpiDc955+weAbKw70IGB2y1rLrpfUJ1t0x+O43X3Y4AxFTFWS3dmo34XCgg2o
         3e9ZgwWwM6aUmjUcAiY/OC7B/9NWynCKM06bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hYfhSUsIkz92mjrRMI3jfLi9LV8ibmLGXbRODHuw28c=;
        b=Adp+CeOhnYYN24CFIQRXV2GKuABbW2Xo3jcbouZm8j1H2PDnmiH+XjoGiLnM9DqR+e
         fO8x3oah8aEeReGNkH4L3/qIcuCoB//0xuoQa+BbjXwzkV/359rpmTNw0E96YXyX3ipG
         9FsYTz1ahtmjFGThwsXxxHnt3cuoxMGekS6ifflFzRyHL3ahetKBPTl7pocvvTSRcBO8
         6xjgNPqiWaUeNx6LROdNupSzezeNUDrCTeG/GHogfV3Wy+lMSmx+aDb/k1gEFaP2bquW
         ZLnT8M521OIJQjLl+qjtYJK+dwEOk6OQyg8FT9EypmyCFJ0WWbzUJvWQq2Kzpm7q1FZm
         SpJg==
X-Gm-Message-State: AOAM530q+o4MV3McolRRml0O1xsAKnJUEVVZdtwNYvppx7wJoSG4yNGg
        KuwBGkMNSCix74lTB6QYymET2Vci8NY=
X-Google-Smtp-Source: ABdhPJwy/g4yEoSwHyLo9XCTLMBldFxxOe6pEJxXCQie4MR6CwERdL36YMmPqoUhGr4KTxGbOvJI/w==
X-Received: by 2002:a05:6102:3033:: with SMTP id v19mr4996881vsa.217.1590594143910;
        Wed, 27 May 2020 08:42:23 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id s65sm17194vss.5.2020.05.27.08.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 08:42:23 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v4] doc:adding definitions for load default params mgmt op
Date:   Wed, 27 May 2020 15:42:17 +0000
Message-Id: <20200527154217.21115-1-alainm@chromium.org>
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

---

 doc/mgmt-api.txt | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 6ee01fed8..391e818de 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3223,6 +3223,66 @@ Set Experimental Feature Command
 				Invalid Index
 
 
+Load Default Controller Parameter Command
+=============================
+
+	Command Code:		0x004b
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
+		0x0019	LE Connection Connection Latency
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

