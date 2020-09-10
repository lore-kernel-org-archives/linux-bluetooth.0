Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62B0C2BB84
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA042078B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R7NQ3PQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgIJEik (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgIJEig (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:38:36 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EC7C061573
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:38:35 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g29so3584296pgl.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OwcQPbWK9wBBKShQmm51i7xxWQDNt4zUBesrzpNnDCQ=;
        b=R7NQ3PQE0aZ0JhPX44PwcsKwYpCKaHUHx2NVfARomjcVco8wG6Taa7jOOfWD8ujXFl
         7XeldgTgFjT6ZjvtQwRWd/fQvmoJYi32w5CSXeeBf6DA3x7MuKanhKvFOQKabVwp7wCF
         wt5He55q490tuVtxPgEj+gC1iXJiw7iWEw5Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwcQPbWK9wBBKShQmm51i7xxWQDNt4zUBesrzpNnDCQ=;
        b=EhL9o9kuIvTc1EYv8wy5H9QTb5VcBP5Af3PnwHS3AWuUV559PSMKb44NQRSHhPYkCY
         bU3uF8F6p4+BMwHTmXCDupjUNCVIT2rNV9TvXlyGRUU3EmCA76kqAMj+cawZZate6RBK
         qxtiWrq2R81Jr8CQ65dWCnBgxEGCknE3mbmSJAD839ldnattQpVz2aFHsp4d0TC0Y4gc
         i5opBgnvK6mNObFWBdcPsW5B/ZDHnL8kswnBNWmH2q1ybn2F/ojZYBAJdKMKAs9MUviK
         Wc9wE1W6DZyqcCcQ+BNBEPebqHPog4mwDLCIWRRbx/O35uNSX0FiSkw0Cd6TPqI3ARIH
         gyIg==
X-Gm-Message-State: AOAM532r0mDazDPP29+51wbcWf761lnD9yQ3gCQuhq65LeOuvkwVqw5g
        GX+282fpWAsywsyATq95TU1h46LuVNUILw==
X-Google-Smtp-Source: ABdhPJz+5RaXIqT8f3AdADKzxAUoo15JNBX5cbprejOmiqFlFuA3fi1UOgp1zbKKNEsnx5noZk71jA==
X-Received: by 2002:a65:4c0f:: with SMTP id u15mr2871310pgq.296.1599712713533;
        Wed, 09 Sep 2020 21:38:33 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id y4sm4149820pfq.215.2020.09.09.21.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 21:38:32 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2 7/7] doc: Update Advertisement Monitor API description
Date:   Wed,  9 Sep 2020 21:35:44 -0700
Message-Id: <20200909213423.BlueZ.v2.7.Iee7e9d13c78dd02c5b283a203dea11a4a4ffa7cc@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909213423.BlueZ.v2.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200909213423.BlueZ.v2.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
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

(no changes since v1)

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

