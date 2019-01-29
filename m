Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C83DC169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 12:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDB820881
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 12:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMpQE1Vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbfA2LnH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:43:07 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:37302 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730214AbfA2LnF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:05 -0500
Received: by mail-ed1-f54.google.com with SMTP id h15so15705868edb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 03:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=2SeDtgkij5RzAn5Ydahnc+0UdTyRPe4w8M4KMznAQ8g=;
        b=CMpQE1Vkt/Jf8mOGGGw+2gS1eksKLqJE8X5FyPd0J5z9FaKyplDzIstTpz7EHi9RPk
         kaWV+TwZwUcionf/GoklcYvAPmPEy8Zqb7i2abTd8eJRy8rBUlxfp2blKKRilAMB8iD4
         WGV44HQp6GzqfHEKiL6yGoTdpuk8zgDVPk2U4FASCwol8SluvIx+LPp9DqzbnOhf3Y8o
         f9PWR/9a4wkzkHZd5qjlUNl3aQYSfJKFkqelHRR1aCICc02AjK+j6rJV2zOD5dYCrBAq
         71fPu2IF8KOVvSVYuFQWXpMuKPL314cORuvcZ+dYPm/ledZ7GToD8UaZVuvS/DXL+SUh
         7Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=2SeDtgkij5RzAn5Ydahnc+0UdTyRPe4w8M4KMznAQ8g=;
        b=AJnnk8qo+J90E5jzXyKm/6mVwxEXgNEb066PsWgqdRnK57iPYck0poGsjRFNFeqQ34
         H0O2t2vztqpomJ1BLrv3GnRJJJT+58VZ8K7y3M3DT1LJHSOMltsXi5WN3KMmXqccjNSe
         1Vj074+0BTExQU1ndkjmwCbmw7gnMYxxB2+DNW7yVLZHfWzxT4D263uPdUOk1hQnZP4l
         PlbcEJI4ytKp2Z0wmbAE7iFT7gD32gGc/yk59WTAWEfSOpM2DTpBUenBee7RU3NnY3TX
         mWN51/KPn8BtHhM/4MEQnFpAmmi+I/WzSnfVcyffd8LlI7p+GbQizeSz+FyLqltMBJXW
         jg+g==
X-Gm-Message-State: AJcUukex2oxLclIxx6J+HTSsKzxsASQC06NtV/gpbvHUHAlvvVJsHggF
        y9p/lbQA24wi0wl+q/RRf0qkho0U
X-Google-Smtp-Source: ALg8bN57evQCnrFxvRqMobVhLstRiOSteDxjVWUVRrVLGj0O4Jg0RI65flrVr13oaHeCdNa3vRi0Eg==
X-Received: by 2002:aa7:ca4a:: with SMTP id j10mr24263832edt.213.1548762182339;
        Tue, 29 Jan 2019 03:43:02 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id d56sm14675692ede.76.2019.01.29.03.43.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 03:43:01 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] doc/gatt-api: Add Handle property
Date:   Tue, 29 Jan 2019 13:42:53 +0200
Message-Id: <20190129114258.20945-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When acting as server it is useful to select where to allocate the
handle for an attribute so it can be restored in the same position when
restarting the daemon or rebooting the system.

In order to do that the application also needs to know in which handle
the attribute is allocated the very first time it is registered, this
also allows for a better integration with PTS and tools like auto-pts
which needs to know the handles where the attributes have been
allocated.
---
 doc/gatt-api.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 8dda60b8a..491eb026a 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -50,6 +50,14 @@ Properties	string UUID [read-only]
 			Array of object paths representing the included
 			services of this service.
 
+		uint16 Handle [read-write, optional] (Server Only)
+
+			Service handle. When available in the server it
+			would attempt to use to allocate into the database
+			which may fail, to auto allocate the value 0x0000
+			shall be used which will cause the allocated handle to
+			be set once registered.
+
 
 Characteristic hierarchy
 ========================
@@ -257,6 +265,14 @@ Properties	string UUID [read-only]
 				"secure-write" (Server only)
 				"authorize"
 
+		uint16 Handle [read-write, optional] (Server Only)
+
+			Characteristic handle. When available in the server it
+			would attempt to use to allocate into the database
+			which may fail, to auto allocate the value 0x0000
+			shall be used which will cause the allocated handle to
+			be set once registered.
+
 Characteristic Descriptors hierarchy
 ====================================
 
@@ -332,6 +348,14 @@ Properties	string UUID [read-only]
 				"secure-write" (Server Only)
 				"authorize"
 
+		uint16 Handle [read-write, optional] (Server Only)
+
+			Characteristic handle. When available in the server it
+			would attempt to use to allocate into the database
+			which may fail, to auto allocate the value 0x0000
+			shall be used which will cause the allocated handle to
+			be set once registered.
+
 GATT Profile hierarchy
 =====================
 
-- 
2.17.2

