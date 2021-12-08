Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6E3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 00:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbhLHA6Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 19:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbhLHA6Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 19:58:24 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0969C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 16:54:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so828734pjb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 16:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ua4DPC4fWRMXlVMRPHDaZjGghpOdbFEAmDad48c2TvI=;
        b=iArJb+VGOaPOsHHNEiF4WOiZQCncnRUOGEyeWv+c2+JLj4YZqjBR6uM/z5hd65w1gn
         MQ4pwFLvQ/o0ZeSWLm/SiaPCqJvdVa7ynCQndlmNxsTq0WKkMzfJd5X/y+V9qqC++tPB
         GpLz62HyFDNkiIXv9vmLFF13qGiRvFzHpzx3bMIrLlh/Ey3yP8mmCX63lcC/F4ALaVzS
         1j3AQ8uOO1+nmSFJU75hzBiM8qQ70ewFGmdnGFGtGjLatu5g00JEDVABvWzsalqLWtDA
         eyTXccgDzC8B2FWJSe3vFv6hPy1FqBmUGxMlqhs32bAtDZFb5NiFkIcoQyW7DJ8BVnIM
         emMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ua4DPC4fWRMXlVMRPHDaZjGghpOdbFEAmDad48c2TvI=;
        b=Gqz0GTBdXpmIk/bHdnTPU/CiiOyu9QnfvtDMj3v59V8BpjP7jxbbS6lievIGu/2Do8
         tTmSG2dPw5Jo931SMdcW48t5cyklKmKWN49OwsCNmwuH3mVbt5WOPzfjOBq7HK7cx+vg
         UAAe2kRWooHijWrs5f+ne3yg6BsiCeiQoQUBkqDl94yYqHzOgKM29yV+kWeNyoFLFoT4
         h0euhVI2TXJgBU5QfoFw757abLg08Tn4SG3mbSNPR+9lPB51Za9mKwh511wsNZ9+oTbm
         UkeIS8nopdiwLzL3M5xaQMo0CuWIpstUc69B+ZVetBlUKk5bQUaHdMfQZcwphNQRPA/s
         ixwA==
X-Gm-Message-State: AOAM530rMxVcaHsbYZAnMOHCboL05vPTg54rkV1HC/EQtVU0Z2PiJLB1
        OG9fxOxI8xk9gGgfN8mr8O8xaUoCrKg=
X-Google-Smtp-Source: ABdhPJw7ba6DTne7Vz61N9g5O5FiF23q5By1L9RvpKvHcCO9ZO1CF6P7nPEBMvBl6xsRbm4sa7JkJw==
X-Received: by 2002:a17:902:e8d8:b0:142:5622:f9e5 with SMTP id v24-20020a170902e8d800b001425622f9e5mr56083509plg.42.1638924892907;
        Tue, 07 Dec 2021 16:54:52 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:52cb:f76a:51b5:e541])
        by smtp.gmail.com with ESMTPSA id d195sm604191pga.41.2021.12.07.16.54.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:54:52 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 1/5] emulator: Replace random number generation function
Date:   Tue,  7 Dec 2021 16:54:42 -0800
Message-Id: <20211208005446.196637-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208005446.196637-1-hj.tedd.an@gmail.com>
References: <20211208005446.196637-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch replaces the rand() function to the l_getrandom() from ELL,
which uses the getrandom() system call.

It was reported by the Coverity scan
  rand() should not be used for security-related applications, because
  linear congruential algorithms are too easy to break
---
 Makefile.tools | 3 ++-
 emulator/le.c  | 4 ++--
 emulator/phy.c | 6 ++++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index c7bdff83f..8312d4d27 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -93,7 +93,8 @@ emulator_btvirt_SOURCES = emulator/main.c monitor/bt.h \
 				emulator/phy.h emulator/phy.c \
 				emulator/amp.h emulator/amp.c \
 				emulator/le.h emulator/le.c
-emulator_btvirt_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la
+emulator_btvirt_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la \
+				src/libshared-ell.la $(ell_ldadd)
 
 emulator_b1ee_SOURCES = emulator/b1ee.c
 emulator_b1ee_LDADD = src/libshared-mainloop.la
diff --git a/emulator/le.c b/emulator/le.c
index 07a44c5f1..fed3a7815 100644
--- a/emulator/le.c
+++ b/emulator/le.c
@@ -21,6 +21,7 @@
 #include <sys/un.h>
 #include <sys/uio.h>
 #include <time.h>
+#include <ell/ell.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -506,8 +507,7 @@ static unsigned int get_adv_delay(void)
 	/* The advertising delay is a pseudo-random value with a range
 	 * of 0 ms to 10 ms generated for each advertising event.
 	 */
-	srand(time(NULL));
-	return (rand() % 11);
+	return (l_getrandom_uint32() % 11);
 }
 
 static void adv_timeout_callback(int id, void *user_data)
diff --git a/emulator/phy.c b/emulator/phy.c
index 2ae6ad3a2..570a9c975 100644
--- a/emulator/phy.c
+++ b/emulator/phy.c
@@ -22,6 +22,7 @@
 #include <netinet/in.h>
 #include <netinet/ip.h>
 #include <time.h>
+#include <ell/ell.h>
 
 #include "src/shared/util.h"
 #include "src/shared/mainloop.h"
@@ -152,6 +153,7 @@ static int create_tx_socket(void)
 struct bt_phy *bt_phy_new(void)
 {
 	struct bt_phy *phy;
+	uint64_t phy_id;
 
 	phy = calloc(1, sizeof(*phy));
 	if (!phy)
@@ -173,8 +175,8 @@ struct bt_phy *bt_phy_new(void)
 	mainloop_add_fd(phy->rx_fd, EPOLLIN, phy_rx_callback, phy, NULL);
 
 	if (!get_random_bytes(&phy->id, sizeof(phy->id))) {
-		srandom(time(NULL));
-		phy->id = random();
+		l_getrandom(&phy_id, sizeof(phy_id));
+		phy->id = phy_id;
 	}
 
 	bt_phy_send(phy, BT_PHY_PKT_NULL, NULL, 0);
-- 
2.25.1

