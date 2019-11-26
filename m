Return-Path: <SRS0=oE9z=ZS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B3DC432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 19:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353F12073F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 19:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cKWx3UBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfKZTJt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:09:49 -0500
Received: from mail-vs1-f43.google.com ([209.85.217.43]:43522 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfKZTJt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Nov 2019 14:09:49 -0500
Received: by mail-vs1-f43.google.com with SMTP id b16so13548626vso.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2019 11:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3oi5wa/2Wgh34oCD/uJ752UvlAl6z1y/Bzf5ICSYg8M=;
        b=cKWx3UBU8VeY4IPGiPqf/6kruXKZOzF6m1meV2sJbaSFjoP7bFU8JAwROtCTz79FbQ
         K0qvWHyf/qeKGSY7JpBqu4KWzH6vp3Ht1YYrMF9GyiMOq6+OR41NRIQI2gnv+TiZOh9X
         VYO1kAss036RikeB+FucIOSBbmEg228RmbGFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3oi5wa/2Wgh34oCD/uJ752UvlAl6z1y/Bzf5ICSYg8M=;
        b=YaHWq4ebeP0LP8py01wS92qKEdJxsDAR7EruGo7kdzeUA9IiKSOdHrgFEQuqrZc9Fc
         usQnjOlR75qOprmELIVPfbBh46rjN3G1nWbG1clXY3iDiaXSkxQeyab0Le4dlskODZQC
         kn0gwnRgaWGU9mCIFihhtu1fYV3LD64l1xKi/tlPzcofnBJgivlT3KjblZMzbNZOy9v2
         aEy9APYuJuVuZ6lFfk/zxULZsIubXqdilPnAaAmtkFGCjX+ZQgfO0+Rc2fJswoyTT9d8
         JKcPNbMzY5Znt8By7W3Y4vQb4h7Fv11i5um8cwwu1EJRZ7IlXfPh+T03F7bTADA6C25R
         ZyEQ==
X-Gm-Message-State: APjAAAX4DyT4fuEiCa7i96sgyRvbMic4mkQCwO16Ecan1o1ga9T+mo9Y
        JGqfdexbjmz6XXvGCgjHVKbJIOhpe8RmXg==
X-Google-Smtp-Source: APXvYqxXtzry0uvSh0YAmSGfawH0zDR7YdtE9qz7aVvwCnZRIpX1gP+JLKXjpUoESKfJ6BQS/oI82g==
X-Received: by 2002:a67:be18:: with SMTP id x24mr8223975vsq.55.1574795386954;
        Tue, 26 Nov 2019 11:09:46 -0800 (PST)
Received: from alain.us-east1-b.c.cloudtop-prod.google.com.internal (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id 134sm3245712vkz.56.2019.11.26.11.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 11:09:46 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH] Fixing miss aligned mgmt command opcodes.
Date:   Tue, 26 Nov 2019 19:09:41 +0000
Message-Id: <20191126190941.23003-1-alainm@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/mgmt-api.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 0d11aa035..fd2325471 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2916,7 +2916,7 @@ Read Extended Controller Information Command
 Set Appearance Command
 ======================
 
-	Command Code:		0x0042
+	Command Code:		0x0043
 	Controller Index:	<controller id>
 	Command Parameters:	Appearance (2 Octets)
 	Return Parameters:
@@ -2945,7 +2945,7 @@ Set Appearance Command
 Get PHY Configuration Command
 =============================
 
-	Command Code:		0x0043
+	Command Code:		0x0044
 	Controller Index:	<controller id>
 	Command Parameters:
 	Return Parameters:	Supported_PHYs (4 Octet)
@@ -2988,7 +2988,7 @@ Get PHY Configuration Command
 Set PHY Configuration Command
 =============================
 
-	Command Code:		0x0044
+	Command Code:		0x0045
 	Controller Index:	<controller id>
 	Command Parameters: 	Selected_PHYs (4 Octet)
 	Return Parameters:
-- 
2.24.0.432.g9d3f5f5b63-goog

