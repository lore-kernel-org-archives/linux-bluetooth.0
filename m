Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3FFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 22:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbhLHWnB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Dec 2021 17:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbhLHWnA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Dec 2021 17:43:00 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14798C061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Dec 2021 14:39:28 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 8so3716115pfo.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Dec 2021 14:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cKwLht1AACZk6fY2XTuSMIVRhpq9sgqQiDy1auNtIpo=;
        b=G+G+CWTVOYKMm90YPOZBK1utnL4CDd8jHEL21/ltlxRblDUJH5eIdd+vfgK8ZgAdIP
         JkMeDrozhbt5h1IEwhB0FjmI6HmD2YrpIfUb72wirFGMucBMT1gIcKFq743a/C2HXKPX
         RTIQD0Q3d80qk4cU7L/nJtJ6cevhANiAVO0Me623CQF5FwYFoKGJ1eOIyq0yREsAiaxo
         9QgBiMB1+EXvk0mMjeG1m7a+t+7k7AU4iK7nwwYn75cLVUinCRYIapWf+/AliiSCERwl
         0VSaHoHgqooOIGcvamhTgYMvTUM1A3/slSGr7xqk1hPjHVQsYH5LCatnfRfXh+49QDLw
         7UMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKwLht1AACZk6fY2XTuSMIVRhpq9sgqQiDy1auNtIpo=;
        b=nSHRT2ACKyUsuy6NkgQO24bLgkAKPRSXLbUrDWwiZf+g0vhNwgkMIFXXehoDHrgSj/
         93dAmGnoTz6+/qw8mePUBv8GDTYRNoNRf9HUqLbNF6XNhdDXPSyuHt6iSmTkFzqcPVoL
         i22ErdmBAKCgEr4XtS8ivoe+AK7O8zQO4l0oMXw7lNGdHqginbBnf+va3aar6+seCc/W
         saYF4WhCF2wsV0szApCd/4josoYxYVFzX8WsBGXirf7WpA3joPRqoa346zgbHA6MdG+T
         tzYN0YrlgJv9qvHX3ZkGTAI3v3lZhf5/qXpccVYMFOE9IQ51IgggntbFRixriL/9bITN
         ACYg==
X-Gm-Message-State: AOAM531Slbc0b1KYdiLuvAVVvyf9B9mmOAJCKfinK5E+pRWWon+KvaTi
        otG/4z8s+AKdEBZhKlgeU7SXodZl16k=
X-Google-Smtp-Source: ABdhPJzwdhgTAZCahqS73LnwB7ZO5qHFizt/347dY+mRNbakhK03KZEuvaRl4QXF/Ixo8C3LeBxhoQ==
X-Received: by 2002:a62:d0c3:0:b0:4ad:51e9:963e with SMTP id p186-20020a62d0c3000000b004ad51e9963emr8176792pfg.36.1639003167298;
        Wed, 08 Dec 2021 14:39:27 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6e9a:66a9:f3af:51f3])
        by smtp.gmail.com with ESMTPSA id n16sm3757948pja.46.2021.12.08.14.39.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 14:39:26 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ V2 PATCH 1/5] emulator: Replace random number generation function
Date:   Wed,  8 Dec 2021 14:39:19 -0800
Message-Id: <20211208223923.519664-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208223923.519664-1-hj.tedd.an@gmail.com>
References: <20211208223923.519664-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch replaces the rand() function to the getrandom() syscall.

It was reported by the Coverity scan
  rand() should not be used for security-related applications, because
  linear congruential algorithms are too easy to break
---
 emulator/le.c  | 11 +++++++++--
 emulator/phy.c | 10 ++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/emulator/le.c b/emulator/le.c
index 07a44c5f1..f8f313f2c 100644
--- a/emulator/le.c
+++ b/emulator/le.c
@@ -20,6 +20,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <sys/uio.h>
+#include <sys/random.h>
 #include <time.h>
 
 #include "lib/bluetooth.h"
@@ -503,11 +504,17 @@ static void send_adv_pkt(struct bt_le *hci, uint8_t channel)
 
 static unsigned int get_adv_delay(void)
 {
+	unsigned int val;
+
 	/* The advertising delay is a pseudo-random value with a range
 	 * of 0 ms to 10 ms generated for each advertising event.
 	 */
-	srand(time(NULL));
-	return (rand() % 11);
+	if (getrandom(&val, sizeof(val), 0) < 0) {
+		/* If it fails to get the random number, use a static value */
+		val = 5;
+	}
+
+	return (val % 11);
 }
 
 static void adv_timeout_callback(int id, void *user_data)
diff --git a/emulator/phy.c b/emulator/phy.c
index 2ae6ad3a2..44cace438 100644
--- a/emulator/phy.c
+++ b/emulator/phy.c
@@ -19,6 +19,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/socket.h>
+#include <sys/random.h>
 #include <netinet/in.h>
 #include <netinet/ip.h>
 #include <time.h>
@@ -173,8 +174,13 @@ struct bt_phy *bt_phy_new(void)
 	mainloop_add_fd(phy->rx_fd, EPOLLIN, phy_rx_callback, phy, NULL);
 
 	if (!get_random_bytes(&phy->id, sizeof(phy->id))) {
-		srandom(time(NULL));
-		phy->id = random();
+		if (getrandom(&phy->id, sizeof(phy->id), 0) < 0) {
+			mainloop_remove_fd(phy->rx_fd);
+			close(phy->tx_fd);
+			close(phy->rx_fd);
+			free(phy);
+			return NULL;
+		}
 	}
 
 	bt_phy_send(phy, BT_PHY_PKT_NULL, NULL, 0);
-- 
2.25.1

