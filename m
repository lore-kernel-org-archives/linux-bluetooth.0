Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E89C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D226321A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbhKOJJw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbhKOJJu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 04:09:50 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679E4C061766
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 01:06:55 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w5-20020a25ac05000000b005c55592df4dso25616535ybi.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 01:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CrUmcslhzzM6ekmANoCOB8Gym39OQf4Ao70U2CK1CIM=;
        b=V3kKQKDXgoRw6elyn+ps+y67RwrVhCdSQMWT1gMgC6F2Qpv5piO+QQHlFBmGoasSPB
         p7++/Ndj9JLgM+jpQ4AmDvAPQ8zpEj0+Bq9+kHwDXTOt5ygUtDKb3drVOCMKiGq8kAq2
         o4HGCXE97MnYZLzQ0pipG58Oj1XrtWVbLqEyRa5ENU4TEwFRcKz+ito3gVO3PStrEqj/
         TU9dxpFkpCrCt2MD2bPjPP3uMr1TRR4R99GC6WzlIY0F516AVWNkiyYhWGd/Lr/RKx/c
         c8i4dpkKoPQy6BgR32XVvqv4dAV8zE60lvr3CDGM6gLhZ1plOZupUQhhWE0BS60Xea3f
         x6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CrUmcslhzzM6ekmANoCOB8Gym39OQf4Ao70U2CK1CIM=;
        b=JNMtHxkeS5FfdNz9GDQRpKIFvmGax/W70Uxo+JDpc77npi995CuVJF0/g0vi//+lNx
         KE+R63sedyxa+nOB2Jb+8R32JCxseGmoKIZrRSwPpDBrN04YFwJzPy5GPpc/uB7Ct5gY
         BforSpNACseHjUVmFCa+pOHaplxcqBA8NL4es0F8XDkqPuvRSws+5IOqQzcSEZg0WKew
         Jr4bEf0qSfI7afxiVEVX6ofp3YtDRg+osxy7bCda7zHtDPv5D/QpP3w8o3pZHPWu+Ad8
         WFDJ8fK3HIIE8kXanwrnQuQcKesMhhI9FaeufO2mgbcOXolu+q7rsCBnsgYpObNJR6vK
         GXqg==
X-Gm-Message-State: AOAM533IQVrQxnLqkYrxdNM6L3NDdfRYij+LQx0vN1gI0eCuLiQ1MRxm
        tvc363aVklW3tgM+3rRO4smHIyTtSPIql0QyDVLfa9SUPUh/WIWzc7VvwjoHBXn3mAUYWHlb6ES
        X3pUUdAZAZ10IXkzvk+JQAJcAJM684ORkVHiSXKgInXF/VmFrj+1fgj1UbaekfXRV2cR5wUJau3
        Z6
X-Google-Smtp-Source: ABdhPJzHujGiYJ5+8ZV3kcQJlB3blI3mBMRZAF5hN5Y+n5JKSwWXWmF8i5GtzvlCkvurUxnvQ0kr4cGipxoR
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5c8f:7191:e5ca:14fb])
 (user=apusaka job=sendgmr) by 2002:a25:25d4:: with SMTP id
 l203mr40410179ybl.228.1636967214610; Mon, 15 Nov 2021 01:06:54 -0800 (PST)
Date:   Mon, 15 Nov 2021 17:06:24 +0800
In-Reply-To: <20211115170538.Bluez.v2.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
Message-Id: <20211115170538.Bluez.v2.3.I29367ca288fc8f4fcc3b4063425b791501c6534c@changeid>
Mime-Version: 1.0
References: <20211115170538.Bluez.v2.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [Bluez PATCH v2 3/3] doc: Add Name Resolve Fail flag in device found event
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
---

Changes in v2:
* Update docs to reflect not sending DONT_CARE flag behavior.

 doc/mgmt-api.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 97d33e30a1..340d8ffa85 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -4089,6 +4089,7 @@ Device Connected Event
 		1	Legacy Pairing
 		2	Reserved (not in use)
 		3	Initiated Connection
+		4	Reserved (not in use)
 
 
 Device Disconnected Event
@@ -4263,6 +4264,7 @@ Device Found Event
 		1	Legacy Pairing
 		2	Not Connectable
 		3	Reserved (not in use)
+		4	Name Resolve Failed
 
 	For the RSSI field a value of 127 indicates that the RSSI is
 	not available. That can happen with Bluetooth 1.1 and earlier
@@ -4285,6 +4287,11 @@ Device Found Event
 	accept any connections. This can be indicated by Low Energy
 	devices that are in broadcaster role.
 
+	The Name Resolve Failed flag indicates that name resolving
+	procedure has ended with failure for this device. The user space
+	should use this information to determine when is a good time to
+	retry the name resolving procedure.
+
 
 Discovering Event
 =================
-- 
2.34.0.rc1.387.gb447b232ab-goog

