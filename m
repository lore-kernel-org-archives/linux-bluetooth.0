Return-Path: <SRS0=5ENf=AZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5A4C433E3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jul 2020 19:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3ACD22BF5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jul 2020 19:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YmYxRna2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgGNTvk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbgGNTvj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jul 2020 15:51:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDC9C061755
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2020 12:51:39 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d1so2204136plr.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2020 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VPwCP5Z0Rhdnq92HhIud0aSAxStvJXr6W4dUKLtLBOA=;
        b=YmYxRna25SgjM+JEwS0tqppDvfeBV/qU9QsX6CYlPCcHVV9leU80Cnyh0NEHhThURq
         eoexJTg9KAz2whnzYLk5ZmKVI0Z5A3Dvc/7RBHnmyMH01FXXUVEaBtL4jo451g0pIkF8
         20c6LzLkW6kZvJLTRH9j2AZS9chKtTnrINLtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VPwCP5Z0Rhdnq92HhIud0aSAxStvJXr6W4dUKLtLBOA=;
        b=qzkYseWRUCc/SaXHHHMqfttDKl+G87SmSMGjPZP4IPPQwlRljd9/Np0RQl9iaLEvk0
         wuvS9QYyOjVIwf5txDXAznIFjCnbmo83lQ1J+iQP6i1Z4ViFdSEz03XiDYjr/ykxwpz8
         7/R6VyIfNSQ8uwTTkB3Oph4LAggM8f+09I80RxbTlljTu8wFiI0CvDUi0k/oBd1Zi02i
         eW3rN5H4BzRsIVfKMJhAf2ctA+oN/dS0WPig0tZBHNS3Of6hMOXvx3ZgTpyeXJrTxUCS
         RfjuBQjAviqcmfd4F6rFeDdkPKrCHHqKXhezJuuSDDOxpiFccjdKpluTeTGuqFCanEiR
         8dPg==
X-Gm-Message-State: AOAM532rw/Y6cwyKtux2e66OlN1aQas3x16tCdGWVsRlNQQG43FIpsOX
        +sPOzhBI2zdR9VoZZwktDlDcwA==
X-Google-Smtp-Source: ABdhPJwYPtlW44unqGfV01GTHWMUkecTDgeXt1t7arg3sjWlLPfO2Bqw+bL9pwJF2r5QmVDjXvLsrQ==
X-Received: by 2002:a17:90a:3488:: with SMTP id p8mr6634739pjb.211.1594756299490;
        Tue, 14 Jul 2020 12:51:39 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id 204sm30669pfx.3.2020.07.14.12.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 12:51:38 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [Bluez PATCH v2] doc: Add Suspend and Resume events
Date:   Tue, 14 Jul 2020 12:51:31 -0700
Message-Id: <20200714125120.Bluez.v2.1.I9181af521cf0fba8f4315c9b89975848d437d6dd@changeid>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add Controller Suspend Event and Controller Resume Event to identify
suspend or resume of the Bluetooth stack has occurred.

Also update Device Disconnected Event to indicate a new disconnect
reason: "Connection terminated by local host for suspend"

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v2:
- Moved Wake_Reason to first value
- Reduced Wake_Reason to not Bluetooth, unexpected event and remote wake

 doc/mgmt-api.txt | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index ca0d38469..e7a713824 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3834,6 +3834,7 @@ Device Disconnected Event
 		2	Connection terminated by local host
 		3	Connection terminated by remote host
 		4	Connection terminated due to authentication failure
+		5	Connection terminated by local host for suspend
 
 	Note that the local/remote distinction just determines which side
 	terminated the low-level connection, regardless of the
@@ -4577,3 +4578,50 @@ Advertisement Monitor Removed Event
 
 	The event will only be sent to management sockets other than the
 	one through which the command was sent.
+
+
+Controller Suspend Event
+========================
+
+	Event code:		0x002d
+	Controller Index:	<controller_id>
+	Event Parameters:	Suspend_State (1 octet)
+
+	This event indicates that the controller is suspended for host suspend.
+
+	Possible values for the Suspend_State parameter:
+		0	Running (not disconnected)
+		1	Disconnected and not scanning
+		2	Page scanning and/or passive scanning.
+
+	The value 0 is used for the running state and may be sent if the
+	controller could not be configured to suspend properly.
+
+	This event will be sent to all management sockets.
+
+
+Controller Resume Event
+=======================
+
+	Event code:		0x002e
+	Controller Index:	<controller_id>
+	Event Parameters:	Wake_Reason (1 octet)
+				Address (6 octets)
+				Address_Type (1 octet)
+
+	This event indicates that the controller has resumed from suspend.
+
+	Possible values for the Wake_Reason parameter:
+		0	Resume from non-Bluetooth wake source
+		1	Wake due to unexpected event
+		2	Remote wake due to peer device connection
+
+	Currently, we expect that only peer reconnections should wake us from
+	the suspended state. Any other events that occurred while the system
+	should have been suspended results in wake due to unexpected event.
+
+	If the Wake_Reason is Remote wake due to connection, the address of the
+	peer device that caused the event will be shared in Address and
+	Address_Type. Otherwise, Address and Address_Type will both be zero.
+
+	This event will be sent to all management sockets.
-- 
2.27.0.389.gc38d7665816-goog

