Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3682CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 11:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E6561215
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 11:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhKKL6Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Nov 2021 06:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhKKL6O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Nov 2021 06:58:14 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4765C061767
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 03:55:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x75-20020a25ce4e000000b005c5d04a1d52so8786531ybe.23
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 03:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DebpcHzG76f+oQx4xcnPCu4QqF/Q5+ujaO2zZj7OJSg=;
        b=EHolyrGHgexmy0UqFvTGJ89yPG2E0xsjMCY4XxjSBAJ9wOugjaciurWFK1Zs42pUFI
         lJZEapmwi3lRxXpVsTgCQ0MzeUKCWYrcdqx9eBEPOGRU2Tbgm2P5c5Y8FLNeWyQzye1i
         C1X+/1VDGu0A1NfO0W4sQ7Ns2+i3CjGh5y6XQYJs7UxWTDDcP9Ox63cKuhHE2F7caSPN
         YfaldPRyHzkpI7mKRzyb2cNu/C6sQ1AGOB9q5lXkXfIQUDn5Wo4OzA2X8U4T8CGuG/4M
         FYuYKYfkgdCtwKdwoxXtMVc0fiPPEOJEeI0FJqRqBn81lFAxm7hCLO2IYWQaoSu7B/pa
         RsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DebpcHzG76f+oQx4xcnPCu4QqF/Q5+ujaO2zZj7OJSg=;
        b=jWMma1U6YpP1UQbyjsK5m9Q9YI7T5ah68AVGMgzyb1HQnoJhT0p86CN8CAASKYWIvv
         A9IEhVWOI6rajwbCq7/34YXnQpOJjN2bdCNvrO/ULpgj9g9miRfjWZPVMYdjUi/XAVSX
         VhrbJtkPfJVmRmF0LSuxswTiVI78oWgWRTmI13X7MnqlpvwdDJ2NeG+b8HMxEqCxd8Kg
         2Z3sVD6Zhj9A9V1DPcwRxZNJwJoYHgunXinDvA7MyTAfW6MnWOG+u+J02LkRVspt7cV/
         8iwhrAfXDTQFjEbXdnqRb8Ep7plpKRMyQCiQsTKThbz3Rp0fhg9wIaR0mOygXUuWd51X
         CaVg==
X-Gm-Message-State: AOAM531/GXTUGz+7RQSVBaD2iSeHi1uN75KJgwM4lWXmvU+VXJpmedG2
        CMb7FX3WlLxvgiMMQMX/FuBIisQcWEBOkjPE2m75wp4WSU++hyzht1DHnD7Ioyh8BG85jtw8FIM
        lekAJfjvX8LQsoxpGoeT3Kn1WK5hPGx1a6BhsrMUnCMFHZ0n5WrVzUNG/Fub/G/Mo8BgcfxQR7A
        6i
X-Google-Smtp-Source: ABdhPJxt5i5uhq0hsrQ8eKhQE0oo3CJWKuJVEDn3ukWh8vIhgGSJQFWlYaVz/ZJUkyUx78Mlp0aR/0sjmpyf
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b87e:3eb:e17e:1273])
 (user=apusaka job=sendgmr) by 2002:a25:488:: with SMTP id 130mr7242514ybe.346.1636631717862;
 Thu, 11 Nov 2021 03:55:17 -0800 (PST)
Date:   Thu, 11 Nov 2021 19:54:54 +0800
In-Reply-To: <20211111195423.Bluez.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
Message-Id: <20211111195423.Bluez.3.I29367ca288fc8f4fcc3b4063425b791501c6534c@changeid>
Mime-Version: 1.0
References: <20211111195423.Bluez.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [Bluez PATCH 3/3] doc: Add Name Resolve Fail flag in device found event
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Userspace should use this new flag to decide whether to do the remote
name resolving or not, by sending Confirm Name MGMT command and set
the appropriate flag.

This patch also extends the Confirm Name command by allowing userspace
to send 0x02 to show it doesn't care about the peer devices names.
---

 doc/mgmt-api.txt | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 97d33e30a1..e4c8de39f0 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1493,7 +1493,7 @@ Confirm Name Command
 	Controller Index:	<controller id>
 	Command Parameters:	Address (6 Octets)
 				Address_Type (1 Octet)
-				Name_Known (1 Octet)
+				Name_State (1 Octet)
 	Return Parameters:	Address (6 Octets)
 				Address_Type (1 Octet)
 
@@ -1506,10 +1506,11 @@ Confirm Name Command
 		1	LE Public
 		2	LE Random
 
-	The Name_Known parameter should be set to 0x01 if user space
-	knows the name for the device and 0x00 if it doesn't. If set to
-	0x00 the kernel will perform a name resolving procedure for the
-	device in question.
+	The Name_State parameter should be set to 0x00 if user space
+	doesn't know the name for the device to make the kernel
+	perform a name resolving procedure for the device in question.
+	Otherwise, set to 0x01 if user space already knew the device's
+	name, or 0x02 if it doesn't care.
 
 	This command can only be used when the controller is powered.
 
@@ -4089,6 +4090,7 @@ Device Connected Event
 		1	Legacy Pairing
 		2	Reserved (not in use)
 		3	Initiated Connection
+		4	Reserved (not in use)
 
 
 Device Disconnected Event
@@ -4263,6 +4265,7 @@ Device Found Event
 		1	Legacy Pairing
 		2	Not Connectable
 		3	Reserved (not in use)
+		4	Name Resolve Fail
 
 	For the RSSI field a value of 127 indicates that the RSSI is
 	not available. That can happen with Bluetooth 1.1 and earlier
@@ -4285,6 +4288,11 @@ Device Found Event
 	accept any connections. This can be indicated by Low Energy
 	devices that are in broadcaster role.
 
+	The Name Resolve Fail flag indicates that name resolving
+	procedure has ended with failure for this device. The user space
+	should use this information to determine when is a good time to
+	retry the name resolving procedure.
+
 
 Discovering Event
 =================
-- 
2.34.0.rc0.344.g81b53c2807-goog

