Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178F6C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01BE760F46
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbhHMMVZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240378AbhHMMVZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:21:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7980C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o3-20020a2541030000b0290557cf3415f8so9130295yba.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RqKChP3cmEAG5YhvPP5S+0jh/xfXTrFO1SopCyOlNiI=;
        b=s5baCrpVBA7jMdLoBSa/LGL8Jj/HJ82ip5JCGgm3ivy+hxxkIxG9IXq+oL15+jSWn/
         78aJRv3D7qnKTDESEl9PnyaHs1TbrlDG+F4kxfJlkKpFpmzvPAYrp5I7M7kdEb+vZKYR
         06qDwg2A6ieNLB6cJ0Q35bDRO7y8evofiM/J2XgV46zP1AAVuCl5eagzwV3v2BzBrit0
         irt70z1RfQL5IkYBd2JNsCOzQM9mbi+s5rUYHTxf3Qlzl90ac/ucJBDNy1qiDFqd2k/v
         NOWptgAwNfcZSGT/rTomFTK3y3cmd8IW+srFIw3NMVccOtuwDGCr6RLOJVo8oKeH4ljc
         roRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RqKChP3cmEAG5YhvPP5S+0jh/xfXTrFO1SopCyOlNiI=;
        b=iJ5Zbk1ynNe7sITFK4gAZOcb8jVZPZDTz1SzFJwXbh+e2bylMUIyQ170hnAE2Vpo29
         tE5hCc5dMse+6XRc8QzluUhMkAlQoSLBGrsRewGlU/AqtupjceqTEQvFOwXJQc79s8rQ
         9+QpkRZJJXg5txMpIBGmRB4SBfeC+muyHeU3vgiNJyfuQDaehdfD+e2Vp2DeFW4W95+Q
         1nirLRarNKYAtrrPvgfRBOhBd3q3h/o9p1OlT5EPSQdN8ZsUQZnNPsdVIhHo9n9u3jrA
         V+LCIrXknIKD3U6P+gjz6FuaVe58pWNCQ8DL+upf29EppSyxEl24RIIz172kgJU65fWt
         AjFw==
X-Gm-Message-State: AOAM530s1SE46vJlJUvtSregqIA7d/QhYVrybFdHp0+XcuaVfJtBkOdW
        VAmIWpn3zzerQjf8kRxTYoSEvlwhKOKH6Qaw2iT/rG1xeSJg0gGRW5Xn65yWn87khFKUKZqKgIV
        Cao8JX9NIn4+gVRWPypCpWLZv7LKiK1LMCuPAPtNrWcbwVwy3x5EMliUaEenVms+gzONwwPT9Qk
        g0
X-Google-Smtp-Source: ABdhPJzOXqFOK6hD9SpeDTeGzJVPloUhYcPXrxLSwC0etN7EMa/qGu2GgGRdQECHJDEqSSaerexY4NeC3HMr
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:3c8:: with SMTP id 191mr2627421ybd.406.1628857257072;
 Fri, 13 Aug 2021 05:20:57 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:07 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.22.I81306d92f461ddd3012624a96eeab1663ac757d6@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 22/62] emulator: Inclusive language in strings
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" and "peripheral" are preferred, as reflected in the BT
core spec 5.3.
---

 emulator/btdev.c  | 34 +++++++++++++++++-----------------
 emulator/le.c     |  6 +++---
 emulator/serial.c |  6 +++---
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 89f7701714..14c7016ea6 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5949,13 +5949,13 @@ static void set_bredrle_features(struct btdev *btdev)
 	btdev->features[2] |= 0x08;	/* Transparent SCO */
 	btdev->features[3] |= 0x40;	/* RSSI with inquiry results */
 	btdev->features[3] |= 0x80;	/* Extended SCO link */
-	btdev->features[4] |= 0x08;	/* AFH capable slave */
-	btdev->features[4] |= 0x10;	/* AFH classification slave */
+	btdev->features[4] |= 0x08;	/* AFH capable peripheral */
+	btdev->features[4] |= 0x10;	/* AFH classification peripheral */
 	btdev->features[4] |= 0x40;	/* LE Supported */
 	btdev->features[5] |= 0x02;	/* Sniff subrating */
 	btdev->features[5] |= 0x04;	/* Pause encryption */
-	btdev->features[5] |= 0x08;	/* AFH capable master */
-	btdev->features[5] |= 0x10;	/* AFH classification master */
+	btdev->features[5] |= 0x08;	/* AFH capable central */
+	btdev->features[5] |= 0x10;	/* AFH classification central */
 	btdev->features[6] |= 0x01;	/* Extended Inquiry Response */
 	btdev->features[6] |= 0x02;	/* Simultaneous LE and BR/EDR */
 	btdev->features[6] |= 0x08;	/* Secure Simple Pairing */
@@ -5985,15 +5985,15 @@ static void set_bredrle_features(struct btdev *btdev)
 
 	if (btdev->type >= BTDEV_TYPE_BREDRLE52) {
 		btdev->le_features[1] |= 0x20;  /* LE PER ADV */
-		btdev->le_features[3] |= 0x10;  /* LE CIS Master */
-		btdev->le_features[3] |= 0x20;  /* LE CIS Slave */
+		btdev->le_features[3] |= 0x10;  /* LE CIS Central */
+		btdev->le_features[3] |= 0x20;  /* LE CIS Peripheral */
 		btdev->le_features[3] |= 0x40;  /* LE ISO Broadcaster */
 		btdev->le_features[3] |= 0x80;  /* LE Synchronized Receiver */
 		btdev->le_features[4] |= 0x01;  /* LE ISO channels */
 	}
 
-	btdev->feat_page_2[0] |= 0x01;	/* CSB - Master Operation */
-	btdev->feat_page_2[0] |= 0x02;	/* CSB - Slave Operation */
+	btdev->feat_page_2[0] |= 0x01;	/* CPB - Central Operation */
+	btdev->feat_page_2[0] |= 0x02;	/* CPB - Peripheral Operation */
 	btdev->feat_page_2[0] |= 0x04;	/* Synchronization Train */
 	btdev->feat_page_2[0] |= 0x08;	/* Synchronization Scan */
 	btdev->feat_page_2[0] |= 0x10;	/* Inquiry Response Notification */
@@ -6011,12 +6011,12 @@ static void set_bredr_features(struct btdev *btdev)
 	btdev->features[1] |= 0x08;	/* SCO link */
 	btdev->features[3] |= 0x40;	/* RSSI with inquiry results */
 	btdev->features[3] |= 0x80;	/* Extended SCO link */
-	btdev->features[4] |= 0x08;	/* AFH capable slave */
-	btdev->features[4] |= 0x10;	/* AFH classification slave */
+	btdev->features[4] |= 0x08;	/* AFH capable peripheral */
+	btdev->features[4] |= 0x10;	/* AFH classification peripheral */
 	btdev->features[5] |= 0x02;	/* Sniff subrating */
 	btdev->features[5] |= 0x04;	/* Pause encryption */
-	btdev->features[5] |= 0x08;	/* AFH capable master */
-	btdev->features[5] |= 0x10;	/* AFH classification master */
+	btdev->features[5] |= 0x08;	/* AFH capable central */
+	btdev->features[5] |= 0x10;	/* AFH classification central */
 	btdev->features[6] |= 0x01;	/* Extended Inquiry Response */
 	btdev->features[6] |= 0x08;	/* Secure Simple Pairing */
 	btdev->features[6] |= 0x10;	/* Encapsulated PDU */
@@ -6037,12 +6037,12 @@ static void set_bredr20_features(struct btdev *btdev)
 	btdev->features[1] |= 0x08;	/* SCO link */
 	btdev->features[3] |= 0x40;	/* RSSI with inquiry results */
 	btdev->features[3] |= 0x80;	/* Extended SCO link */
-	btdev->features[4] |= 0x08;	/* AFH capable slave */
-	btdev->features[4] |= 0x10;	/* AFH classification slave */
+	btdev->features[4] |= 0x08;	/* AFH capable peripheral */
+	btdev->features[4] |= 0x10;	/* AFH classification peripheral */
 	btdev->features[5] |= 0x02;	/* Sniff subrating */
 	btdev->features[5] |= 0x04;	/* Pause encryption */
-	btdev->features[5] |= 0x08;	/* AFH capable master */
-	btdev->features[5] |= 0x10;	/* AFH classification master */
+	btdev->features[5] |= 0x08;	/* AFH capable central */
+	btdev->features[5] |= 0x10;	/* AFH classification central */
 	btdev->features[7] |= 0x80;	/* Extended features */
 
 	btdev->max_page = 1;
@@ -6057,7 +6057,7 @@ static void set_le_features(struct btdev *btdev)
 
 	btdev->le_features[0] |= 0x01;	/* LE Encryption */
 	btdev->le_features[0] |= 0x02;	/* Connection Parameters Request */
-	btdev->le_features[0] |= 0x08;	/* Slave-initiated Features Exchange */
+	btdev->le_features[0] |= 0x08;	/* Peripheral-initiated Features Exchange */
 }
 
 static void set_le_states(struct btdev *btdev)
diff --git a/emulator/le.c b/emulator/le.c
index 23f2579426..31186ce1a1 100644
--- a/emulator/le.c
+++ b/emulator/le.c
@@ -343,7 +343,7 @@ static void reset_defaults(struct bt_le *hci)
 	hci->le_features[0] |= 0x01;	/* LE Encryption */
 	//hci->le_features[0] |= 0x02;	/* Connection Parameter Request Procedure */
 	//hci->le_features[0] |= 0x04;	/* Extended Reject Indication */
-	//hci->le_features[0] |= 0x08;	/* Slave-initiated Features Exchange */
+	//hci->le_features[0] |= 0x08;	/* Peripheral-initiated Features Exchange */
 	hci->le_features[0] |= 0x10;	/* LE Ping */
 	hci->le_features[0] |= 0x20;	/* LE Data Packet Length Extension */
 	hci->le_features[0] |= 0x40;	/* LL Privacy */
@@ -399,8 +399,8 @@ static void reset_defaults(struct bt_le *hci)
 	hci->le_states[0] |= 0x08;	/* High Duty Cycle Directed Advertising */
 	hci->le_states[0] |= 0x10;	/* Passive Scanning */
 	hci->le_states[0] |= 0x20;	/* Active Scanning */
-	hci->le_states[0] |= 0x40;	/* Initiating + Connection (Master Role) */
-	hci->le_states[0] |= 0x80;	/* Connection (Slave Role) */
+	hci->le_states[0] |= 0x40;	/* Initiating + Connection (Central Role) */
+	hci->le_states[0] |= 0x80;	/* Connection (Peripheral Role) */
 	hci->le_states[1] |= 0x01;	/* Passive Scanning +
 					 * Non-connectable Advertising */
 
diff --git a/emulator/serial.c b/emulator/serial.c
index b44af0dcce..c9e6d7cd67 100644
--- a/emulator/serial.c
+++ b/emulator/serial.c
@@ -151,19 +151,19 @@ static void open_pty(struct serial *serial)
 
 	serial->fd = posix_openpt(O_RDWR | O_NOCTTY);
 	if (serial->fd < 0) {
-		perror("Failed to get master pseudo terminal");
+		perror("Failed to get central pseudo terminal");
 		return;
 	}
 
 	if (grantpt(serial->fd) < 0) {
-		perror("Failed to grant slave pseudo terminal");
+		perror("Failed to grant peripheral pseudo terminal");
 		close(serial->fd);
 		serial->fd = -1;
 		return;
 	}
 
 	if (unlockpt(serial->fd) < 0) {
-		perror("Failed to unlock slave pseudo terminal");
+		perror("Failed to unlock peripheral pseudo terminal");
 		close(serial->fd);
 		serial->fd = -1;
 		return;
-- 
2.33.0.rc1.237.g0d66db33f3-goog

