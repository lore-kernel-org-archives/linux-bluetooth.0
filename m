Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DC1C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 20:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiKAU1Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 16:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKAU0y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 16:26:54 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44F817052
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 13:26:52 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C9E7881E72;
        Tue,  1 Nov 2022 21:26:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667334409;
        bh=BI0DSBzt0iCEGjMm9lMBHI/sxUx7WMYe3vKEcXVY5/4=;
        h=From:To:Cc:Subject:Date:From;
        b=QJhXesLC7GzrBVykzX1wa9FEhBOY9tMp/YftWDJhF3XHdmLKLzzLub+wD/RBApejn
         wOoJmHzcwqxQb+2+5HS9oVmgYYMmxSTdFdP/kyZb08Zkae/JmkS2O6JlXISLW6G1Ct
         0i6viBsRtXEA877zQun+M5U+dAIciJEgLxx2Dt6tRXs3JJ9/pBUqlNynundlCwcm12
         YQjwe/wl+2T7+Hm2cBLd9VoLQ6BiKpi3qyZu6BKXrmI4TpfV7oKdy1k1xTedIXOKRK
         YyHsariu40Ste2/znS+UWMjwETdkvBkzBlPhyKeK0P4MF/FgLxJ4YOxPmSVQxohOie
         Ad80WXxX76isw==
From:   Marek Vasut <marex@denx.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>
Subject: [PATCH BlueZ] tools: Switch hciattach_qualcomm to FAILIF macro completely
Date:   Tue,  1 Nov 2022 21:26:36 +0100
Message-Id: <20221101202636.143165-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use the FAILIF() macro consistently to avoid unused variable n warnings.

Signed-off-by: Marek Vasut <marex@denx.de>
---
 tools/hciattach_qualcomm.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/tools/hciattach_qualcomm.c b/tools/hciattach_qualcomm.c
index d228aeec0..d751f42b1 100644
--- a/tools/hciattach_qualcomm.c
+++ b/tools/hciattach_qualcomm.c
@@ -175,10 +175,8 @@ int qualcomm_init(int fd, int speed, struct termios *ti, const char *bdaddr)
 		}
 
 		/* Read reply. */
-		if (read_hci_event(fd, resp, 100) < 0) {
-			perror("Failed to read init response");
-			return -1;
-		}
+		n = read_hci_event(fd, resp, 100);
+		FAILIF(n < 0, "Failed to read init response");
 
 		/* Wait for command complete event for our Opcode */
 	} while (resp[4] != cmd[1] && resp[5] != cmd[2]);
@@ -215,10 +213,8 @@ int qualcomm_init(int fd, int speed, struct termios *ti, const char *bdaddr)
 		}
 
 		/* Read reply. */
-		if ((n = read_hci_event(fd, resp, 100)) < 0) {
-			perror("Failed to read vendor init response");
-			return -1;
-		}
+		n = read_hci_event(fd, resp, 100);
+		FAILIF(n < 0, "Failed to read vendor init response");
 
 	} while (resp[3] != 0 && resp[4] != 2);
 
@@ -229,10 +225,8 @@ int qualcomm_init(int fd, int speed, struct termios *ti, const char *bdaddr)
 				resp[32], resp[33], resp[34], resp[35]);
 
 	/* Wait for command complete event for our Opcode */
-	if (read_hci_event(fd, resp, 100) < 0) {
-		perror("Failed to read init response");
-		return -1;
-	}
+	n = read_hci_event(fd, resp, 100);
+	FAILIF(n < 0, "Failed to read init response");
 
 	qualcomm_load_firmware(fd, fw, bdaddr);
 
@@ -250,10 +244,8 @@ int qualcomm_init(int fd, int speed, struct termios *ti, const char *bdaddr)
 		}
 
 		/* Read reply. */
-		if ((n = read_hci_event(fd, resp, 100)) < 0) {
-			perror("Failed to read reset response");
-			return -1;
-		}
+		n = read_hci_event(fd, resp, 100);
+		FAILIF(n < 0, "Failed to read reset response");
 
 	} while (resp[4] != cmd[1] && resp[5] != cmd[2]);
 
-- 
2.35.1

