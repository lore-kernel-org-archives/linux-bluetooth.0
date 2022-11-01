Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBEEFA373D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 11:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKALye (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 07:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiKALyU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 07:54:20 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957A163D5
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 04:53:41 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2B85A84EBB;
        Tue,  1 Nov 2022 12:53:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667303619;
        bh=l9OvVLvwgYnDR8+sUsebF0YYjBXCCkkE1ZDXIn6HK5E=;
        h=From:To:Cc:Subject:Date:From;
        b=ts28w9YR4oPhl+lxiMz2t/lb7oWafmAJEnOwM8IUSUlaH2Nvg9bRNTO7HXAjflCFT
         B7N7Xpswufp2Klg0ixHv7ZLgFf+hhQgAPipsjbDb5wpScak5K0MMaENrQKLFgxRaKW
         cproYLCQVdg4tdqSva0qqWbwIInQLnYVW1DG9f3KcOC8Bzst4TdUakptjP287vbavI
         C+6Mv/USyJbRPc7UmLwtow6ug0adUcwqOqRmVXPaeCjmDrwV+uPF9cCZOa0POZnjPr
         N6jNA1XKZO1/LlUF8cwvZEIHrnZnRkihCL2tYQSrBxJUlM8Rjn03dg/aL5MHkgZRyZ
         eP9F6W4bOWOUg==
From:   Marek Vasut <marex@denx.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>
Subject: [PATCH BlueZ] tools: Make hciattach_* firmware path build-time configurable
Date:   Tue,  1 Nov 2022 12:53:33 +0100
Message-Id: <20221101115333.18223-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Make hciattach_qualcomm.c and hciattach_tialt.c behave the same way
as hciattach_bcm43xx.c does, where FIRMWARE_DIR can be overridden
at build time by using -DFIRMWARE_DIR= CFLAGS.

Signed-off-by: Marek Vasut <marex@denx.de>
---
 tools/hciattach.h          | 4 ++++
 tools/hciattach_bcm43xx.c  | 4 ----
 tools/hciattach_qualcomm.c | 3 ++-
 tools/hciattach_tialt.c    | 3 ++-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/hciattach.h b/tools/hciattach.h
index 26c0d5424..dfa4c1e7a 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -40,6 +40,10 @@
 #define HCI_UART_EXT_CONFIG	4
 #define HCI_UART_VND_DETECT	5
 
+#ifndef FIRMWARE_DIR
+#define FIRMWARE_DIR "/etc/firmware"
+#endif
+
 int read_hci_event(int fd, unsigned char *buf, int size);
 int set_speed(int fd, struct termios *ti, int speed);
 int uart_speed(int speed);
diff --git a/tools/hciattach_bcm43xx.c b/tools/hciattach_bcm43xx.c
index dbb5a3fe3..b89fc1b50 100644
--- a/tools/hciattach_bcm43xx.c
+++ b/tools/hciattach_bcm43xx.c
@@ -30,10 +30,6 @@
 
 #include "hciattach.h"
 
-#ifndef FIRMWARE_DIR
-#define FIRMWARE_DIR "/etc/firmware"
-#endif
-
 #define FW_EXT ".hcd"
 
 #define BCM43XX_CLOCK_48 1
diff --git a/tools/hciattach_qualcomm.c b/tools/hciattach_qualcomm.c
index 77b6db170..d228aeec0 100644
--- a/tools/hciattach_qualcomm.c
+++ b/tools/hciattach_qualcomm.c
@@ -222,7 +222,8 @@ int qualcomm_init(int fd, int speed, struct termios *ti, const char *bdaddr)
 
 	} while (resp[3] != 0 && resp[4] != 2);
 
-	snprintf(fw, sizeof(fw), "/etc/firmware/%c%c%c%c%c%c_%c%c%c%c.bin",
+	snprintf(fw, sizeof(fw), "%s/%c%c%c%c%c%c_%c%c%c%c.bin",
+				FIRMWARE_DIR,
 				resp[18], resp[19], resp[20], resp[21],
 				resp[22], resp[23],
 				resp[32], resp[33], resp[34], resp[35]);
diff --git a/tools/hciattach_tialt.c b/tools/hciattach_tialt.c
index 4f7fd42a3..bf6e84923 100644
--- a/tools/hciattach_tialt.c
+++ b/tools/hciattach_tialt.c
@@ -221,7 +221,8 @@ int texasalt_init(int fd, int speed, struct termios *ti)
 				((brf_chip > 7) ? "unknown" : c_brf_chip[brf_chip]),
 				brf_chip);
 
-		sprintf(fw, "/etc/firmware/%s.bin",
+		sprintf(fw, "%s/%s.bin",
+			FIRMWARE_DIR,
 			(brf_chip > 7) ? "unknown" : c_brf_chip[brf_chip]);
 		texas_load_firmware(fd, fw);
 
-- 
2.35.1

