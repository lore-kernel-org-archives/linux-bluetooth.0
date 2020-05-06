Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38B9C47247
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 00:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E50A206A5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 00:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B8+OX+/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgEFAye (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 May 2020 20:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729332AbgEFAyd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 May 2020 20:54:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB14C061A0F
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2020 17:54:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a5so36164pjh.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2020 17:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8sMT7lAv4GZKOhjhPa0nWF7eit2w6jNHxcFCAZHV/I0=;
        b=B8+OX+/szYT/2njnQElBJVWmUlNVohyI1HoC9e5ShEYqhR/4Vbxdy9JNfc3a3taf4T
         Z4SfzoYTFaCheWVwtRusVjsmxhvG5sp8d1d1YSMUn5HSxwRdz/hJ9ZlKgEJ6481QYYMU
         CQBhJfKtzohQtfV+mBdOOVsXVdT5ti5LsfSmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8sMT7lAv4GZKOhjhPa0nWF7eit2w6jNHxcFCAZHV/I0=;
        b=ZOLkJrS72dlqUY2fCsApruE3Ngula5t+4AxBaVX2CWQGg+brthlbUuYh4CTlLbf1WL
         WJB0V2MdOkPgqZf9NL+En7vqMbxKo4nRZaf/iUfUuXm7nd6qPeU6wA5Deh7s9FDlYnw3
         ajGcBQe7xAtaT+XN/Gzie18miMDqXijKbWmkuzpzHLtWRKz33vAMH3VJ8rOO7W7GsEDp
         H7FHJjXIrTeRXVpMP1VEFi2FJ2yIt1eEXBjAvzQv5fs7icW00+tWGJ6LtMeaSH0yb3S9
         +EesffkOorBcF1EALBTPyhhsXcslA66MHVPrPU4bFDpzG2X4Xa/iCrnC+IlVyclmMsfX
         eggA==
X-Gm-Message-State: AGi0PubHiDlABzkPs+coL7hjhR6FDN+iewh7zCD2sQ6S4vKMSaj69eel
        hc3CblISMcNB9IFlstOSm1/4SK4DAQc=
X-Google-Smtp-Source: APiQypKrRXicHFARlrf1gdfIfTNHdeNyyucFo455Q3pGUmN2zh7b0lR4FI4HeJybWjxxofiY158uSQ==
X-Received: by 2002:a17:90b:1044:: with SMTP id gq4mr5963779pjb.81.1588726472766;
        Tue, 05 May 2020 17:54:32 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id f99sm3365362pjg.22.2020.05.05.17.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 17:54:31 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Michael Sun <michaelfsun@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v1] doc/advertisement-monitor-api: Rename methods and shorten the preset strings
Date:   Tue,  5 May 2020 17:54:20 -0700
Message-Id: <20200505175338.BlueZ.v1.1.Ibb4c8b00abb07d20022768dfc8b9479b35e1d9a3@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This renames RegisterApplication/UnregisterApplication to
RegisterMonitor/UnregisterMonitor and shortens the strings used in some
properties.
---
Hi Maintainers,

This patch updates the experimental API for advertisement monitoring.

Thanks,
Miao

 doc/advertisement-monitor-api.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
index 604448f56..74adbfae9 100644
--- a/doc/advertisement-monitor-api.txt
+++ b/doc/advertisement-monitor-api.txt
@@ -89,7 +89,7 @@ Service		org.bluez
 Interface	org.bluez.AdvertisementMonitorManager1 [experimental]
 Object path	/org/bluez/{hci0,hci1,...}
 
-Methods		void RegisterApplication(object application)
+Methods		void RegisterMonitor(object application)
 
 			This registers a hierarchy of advertisement monitors.
 			The application object path together with the D-Bus
@@ -99,7 +99,7 @@ Methods		void RegisterApplication(object application)
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.AlreadyExists
 
-		void UnregisterApplication(object application)
+		void UnregisterMonitor(object application)
 
 			This unregisters advertisement monitors that have been
 			previously registered. The object path parameter must
@@ -118,7 +118,7 @@ Properties	array{string} SupportedMonitorTypes [read-only]
 
 			Possible values for monitor types:
 
-			"patterns_with_logic_or"
+			"or_patterns"
 				Patterns with logic OR applied. With this type,
 				property "Patterns" must exist and has at least
 				one pattern.
@@ -130,7 +130,7 @@ Properties	array{string} SupportedMonitorTypes [read-only]
 
 			Possible values for features:
 
-			"controller-based-monitor-by-patterns"
+			"controller-patterns"
 				If the controller is capable of performing
 				advertisement monitoring by patterns, BlueZ
 				would offload the patterns to the controller to
-- 
2.24.1

