Return-Path: <SRS0=bebH=AU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D59FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jul 2020 21:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B61206E2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jul 2020 21:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eLLkvGVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgGIVKY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jul 2020 17:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgGIVKX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jul 2020 17:10:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31390C08C5CE
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2020 14:10:23 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o1so1336885plk.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2020 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nUdWCpDi1dn5PTCttl/9ZFOQYydznYHG0C95TtGGYgk=;
        b=eLLkvGVnTveO6Dj2TJ5JGP7eqEViAf6yw7Y1swsKuYJwNXJj8k37hhsoj9e4OiG0Wl
         +epC6eT+Q33epYdlD4qXdMdt0WqqyBHpqH18TODBJNiObnXXiIlVG/yAlJEOLMrjCGUL
         qS1T/LK5/y+IXvjVjOOhcPkcZR+0N0/sarYlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nUdWCpDi1dn5PTCttl/9ZFOQYydznYHG0C95TtGGYgk=;
        b=iZ9F254dd16IU//cvVneGqV7j4AC3k7gRFK1G3M4pYKvWEmH53KYOCk78YEKF6TJsC
         g1WHtGjtfZKWBUJlYg3XLePvpBbMKh8PqUWMCLRSzywM9+t8prFpcfIsL3CkggnRk1s0
         enmIWrAgK8Wfnu9oQ2MUTtvU4MIBLCzOMUxZW3GFgD9pThvEQJhH+qq8YV2kaba7Igdj
         503SxDAAHFqWaGYAPRHoGqsZmr/RAZx0Gz71VKXZhhIjKYwtXhtCM6opdd2c6PTHpEJ6
         oNgBolPlej+x94rPpmmkbAo//aaCcKq30GD/k9g7rgrfsnkvcdGgRtF0V4hYLIHkVVw7
         pInw==
X-Gm-Message-State: AOAM5335mdmaTUI2Xm0X69Mpi8fXYvfuN1F6J2c7peX3C6qYtBekrbGi
        WiWwFx/r1mo9ay41hmFBHrZfQw==
X-Google-Smtp-Source: ABdhPJwnf5McXN9zUXxfAAwFxxkZM5hsfxOBSrH9p89jSIcJ9ihcjFi8h70h4RQxLMj9spOmwTrLZA==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr15828758ply.140.1594329022590;
        Thu, 09 Jul 2020 14:10:22 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id l191sm3441374pfd.149.2020.07.09.14.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:10:22 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [Bluez PATCH] doc: Add Suspend and Resume events
Date:   Thu,  9 Jul 2020 14:10:02 -0700
Message-Id: <20200709140928.Bluez.1.I9181af521cf0fba8f4315c9b89975848d437d6dd@changeid>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
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

 doc/mgmt-api.txt | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index ca0d38469..f79c0222c 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3834,6 +3834,7 @@ Device Disconnected Event
 		2	Connection terminated by local host
 		3	Connection terminated by remote host
 		4	Connection terminated due to authentication failure
+		5	Connection terminated by local host for suspend
 
 	Note that the local/remote distinction just determines which side
 	terminated the low-level connection, regardless of the
@@ -4577,3 +4578,55 @@ Advertisement Monitor Removed Event
 
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
+	Event Parameters:	Address (6 octets)
+				Address_Type (1 octet)
+				Wake_Reason (1 octet)
+
+	This event indicates that the controller has resumed from suspend.
+
+	Possible values for the Wake_Reason parameter:
+		0	Unexpected Event
+		1	Resume from non-Bluetooth wake source
+		2	Connection Request (BR/EDR)
+		3	Connection Complete (BR/EDR)
+		4	LE Advertisement
+		5	LE Direct Advertisement
+		6	LE Extended Advertisement
+
+	We expect that only peer reconnections should wake us from the suspended
+	state. Any other events that cause a wakeup will be marked as Unexpected
+	Event.
+
+	If the Wake_Reason was any of the expected wake reasons (values 2-6),
+	the address of the peer device that caused the event will be shared in
+	Address and Address_Type. Otherwise, Address and Address_Type will both
+	be zero.
+
+	This event will be sent to all management sockets.
-- 
2.27.0.383.g050319c2ae-goog

