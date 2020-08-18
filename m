Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF27C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E524420786
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Og4WU3id"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgHRWbj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgHRWbg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 18:31:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18C3C061389
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 15:31:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d188so10666012pfd.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 15:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zlvqf0NUFaWEm48IkgWk2VefD7B2sDw4UkatyR8sS4M=;
        b=Og4WU3idPrNBah+5oHG6lq3gGErO6ayxnp8JMMw5yJouuau6A6b8eYM1qJt/Cljg4z
         qwDMW1Lx9mq6pZDx/Z6zbFJrxWYTkEci6KEE24x+0K7aA4aASeQfdKs8x0GAIlBQJg8n
         dqXcyZphfgWnESFkCn2TnXPyOfDxFer6l3N4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zlvqf0NUFaWEm48IkgWk2VefD7B2sDw4UkatyR8sS4M=;
        b=Ujy6SbqkaaObLyFzyIsV+8n0ThGtzvWSIpADHZcidXakKYFvl4BYQ3EOf/84pqDXub
         BP4r+3AWXS2kidOYswmZS7wT2NsTdtz4ap7IIykswhAyvPeIX9aSNuEAIxSegrArcm4s
         F4Zmun2DstKFatzUGZYBpJtOcKna+ZrNMJ1sFv91KtQO92dyCHVUTwpIKSy8I9JafpSG
         BMfgnDdmnQoK07H71cKrXVv5MpRmkJ0s7J+vPueTuUR/XRdVBiXocjZnVMkqn+tB1CRN
         efFJoixQzD6Lzcj3jusFBPtvURePcHCYWAgaiXYYW+GfBj8Dzi1/GJ7vQ8qjOWRNl9tv
         oa9Q==
X-Gm-Message-State: AOAM5334PN0fZvnKaIrZPLZTHmFDi53C18REiozGlnWVmGEA64H4depW
        R9Lp46gKzmRCMQOPKhLU9lJTR6p6m2G6iw==
X-Google-Smtp-Source: ABdhPJza4ZBSSzG1cmahVgzR81br3ediWZBIno7IgUWM9sSJsZ9iOBawNuJ6xQ7pzQ8T4RrMvI/B9Q==
X-Received: by 2002:a65:6a55:: with SMTP id o21mr2016373pgu.64.1597789895904;
        Tue, 18 Aug 2020 15:31:35 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id mp3sm14137286pjb.0.2020.08.18.15.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2020 15:31:35 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v1 7/7] doc/advertisement-monitor-api: Update Advertisement Monitor API description
Date:   Tue, 18 Aug 2020 15:26:47 -0700
Message-Id: <20200818152612.BlueZ.v1.7.Iee7e9d13c78dd02c5b283a203dea11a4a4ffa7cc@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This modifies the following description to Advertisement Monitor API.
- Add org.bluez.Error.Failed to RegisterMonitor() method.
- Add more description about the usage of RegisterMonitor() and
UnregisterMonitor() methods.
- Add description about the ranges for the fields in property
RSSIThresholdsAndTimers.

Reviewed-by: Yun-Hao Chung <howardchung@google.com>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

 doc/advertisement-monitor-api.txt | 34 +++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
index 74adbfae9..e09b6fd25 100644
--- a/doc/advertisement-monitor-api.txt
+++ b/doc/advertisement-monitor-api.txt
@@ -49,7 +49,7 @@ Properties	string Type [read-only]
 			org.bluez.AdvertisementMonitorManager1 for the available
 			options.
 
-		(Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers [read-only, optional]
+		(Int16, Uint16, Int16, Uint16) RSSIThresholdsAndTimers [read-only, optional]
 
 			This contains HighRSSIThreshold, HighRSSIThresholdTimer,
 			LowRSSIThreshold, LowRSSIThresholdTimer in order. The
@@ -66,7 +66,11 @@ Properties	string Type [read-only]
 			RSSIs of the received advertisement(s) during
 			LowRSSIThresholdTimer do not reach LowRSSIThreshold.
 
-		array{(uint8, uint8, string)} Patterns [read-only, optional]
+			The valid range of a RSSI is -127 to +20 dBm while 127
+			dBm indicates unset. The valid range of a timer is 1 to
+			300 seconds while 0 indicates unset.
+
+		array{(uint8, uint8, array{byte})} Patterns [read-only, optional]
 
 			If Type is set to 0x01, this must exist and has at least
 			one entry in the array.
@@ -80,8 +84,9 @@ Properties	string Type [read-only]
 				See https://www.bluetooth.com/specifications/
 				assigned-numbers/generic-access-profile/ for
 				the possible allowed value.
-			string content_of_pattern
-				This is the value of the pattern.
+			array{byte} content_of_pattern
+				This is the value of the pattern. The maximum
+				length of the bytes is 31.
 
 Advertisement Monitor Manager hierarchy
 =======================================
@@ -91,20 +96,31 @@ Object path	/org/bluez/{hci0,hci1,...}
 
 Methods		void RegisterMonitor(object application)
 
-			This registers a hierarchy of advertisement monitors.
+			This registers the root path of a hierarchy of
+			advertisement monitors.
 			The application object path together with the D-Bus
 			system bus connection ID define the identification of
 			the application registering advertisement monitors.
+			Once a root path is registered by a client via this
+			method, the client can freely expose/unexpose
+			advertisement monitors without re-registering the root
+			path again. After use, the client should call
+			UnregisterMonitor() method to invalidate the
+			advertisement monitors.
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.AlreadyExists
+					 org.bluez.Error.Failed
 
 		void UnregisterMonitor(object application)
 
-			This unregisters advertisement monitors that have been
-			previously registered. The object path parameter must
-			match the same value that has been used on
-			registration.
+			This unregisters a hierarchy of advertisement monitors
+			that has been previously registered. The object path
+			parameter must match the same value that has been used
+			on registration. Upon unregistration, the advertisement
+			monitor(s) should expect to receive Release() method as
+			the signal that the advertisement monitor(s) has been
+			deactivated.
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.DoesNotExist
-- 
2.26.2

