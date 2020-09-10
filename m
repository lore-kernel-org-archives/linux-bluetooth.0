Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AE6C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA9A7207DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c3huFSrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgIJEnj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgIJEng (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:43:36 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E06C061573
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:43:36 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id w186so3565435pgb.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OwcQPbWK9wBBKShQmm51i7xxWQDNt4zUBesrzpNnDCQ=;
        b=c3huFSrX3k9Le+Pyy5XkkbQf8S2ASR7MD0v/8JgLC9VI9QhJNqDqbIlGYPWuBGw8O+
         T5GTSx2heO1crmv89dfkNtPC7Zzjdhnvaq5e4YPJTh6AUAlQMcDIngiMmeO0SqYJsMot
         eyOwblTCkPjDR3vXBEz0slLWHljKqjTmNOfs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwcQPbWK9wBBKShQmm51i7xxWQDNt4zUBesrzpNnDCQ=;
        b=IXEsqm1vdKAOWOYrNV2+RMhxheuJLfDIKnQ8IQSWD+vBoO9D7b/yx8OtieHxt59pkD
         qybiiPj4q1fFu9VyPcm8Xs15rwCtK5JDxTHWszehBUdc8MYUhMqVuSfkpX40RTmf/5Id
         AE0GCClXNHeT+tn5KDatQdJP4vKiQHtjXVTAWtlFRnU9ykE5hy3Oj6K7PqUR+NwCr91H
         b7n90OIRvHtlj9y8ezsClO2+50hvWZPvqWqgLuhLf/jBCdjGUlGOmmZOqkBRsRU3n7aX
         iC3iaYf5XnM7Nil/G8QBgik1fF/BxiMDr54N1t2g8HFU7Z2uwwrOLSjT1r+5PKyyofpY
         T9xA==
X-Gm-Message-State: AOAM533I4K+CHdzWr/xj2qstdyLa07P6BcpydctpRI5jgP7VZg43WAKt
        hiEBHemhIItELlEyEnd7uYP2NB8GfYE4qw==
X-Google-Smtp-Source: ABdhPJzNj2lgZ3l2qbp/gAEnsjhR9qcwx/NxqS96KXkjNxtf3AWCbebwcXy+F+vQ6BAbT13cFC3ssw==
X-Received: by 2002:a62:1c4a:0:b029:13e:d13d:a136 with SMTP id c71-20020a621c4a0000b029013ed13da136mr3669674pfc.30.1599713015843;
        Wed, 09 Sep 2020 21:43:35 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id k4sm644888pjl.10.2020.09.09.21.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 21:43:34 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v3 7/7] doc: Update Advertisement Monitor API description
Date:   Wed,  9 Sep 2020 21:41:36 -0700
Message-Id: <20200909214058.BlueZ.v3.7.Iee7e9d13c78dd02c5b283a203dea11a4a4ffa7cc@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909214058.BlueZ.v3.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200909214058.BlueZ.v3.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
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

