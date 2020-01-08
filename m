Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F11BC33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AEE206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdFWZBOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgAHAdz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:33:55 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:36870 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgAHAdy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:33:54 -0500
Received: by mail-pl1-f170.google.com with SMTP id c23so381593plz.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zqKf6NypyrHZYTy26aLa9pjq4Ob1TC2wzN2VrzLQVVQ=;
        b=tdFWZBOCskklLE5DTdvvvsUwpERIhSxe0D1wNLdqcGhJnOv5muSLwU2dVBR+1keUce
         oJ8pQTvN34EjVGiQ14KxRx817cHyUclnMpWFkIQIp5V4Yca/1GY+vga7OFPCM2HTFUG5
         QguOpk0xULU+RPybxcTyydF4EmE8r4NCKNUOac72ob2PHZSMt9TMfLOOokSHlbLHetTv
         Cxng60Za/+/Api6x+RWjgdbzlEPFSReweqaDf1dCesRsr5LTsS9oG2bA9y8okyRWil1I
         DqT9iU+o+JMhNABqAErW4SKnHrfDpFApbKCxhwjhYluPMZ6ZrTKXsDuu1Tzu+3j5cqkp
         JbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqKf6NypyrHZYTy26aLa9pjq4Ob1TC2wzN2VrzLQVVQ=;
        b=ajvwMZl1vOiWt2kcYUjjArdtMb38SpWkrtBU/iRLBSe2IACuWKBb9uu6O1189szG1k
         OfiZJfn21jz+plL1vga+1o45fjoOofh/S+KRUROjBRsZWf3vuS9mXqc9xj8mVVTSpZQz
         r+FO9HRRp+QRZmJrZd3h/DukBcG27UUjkOEYf/zdOuTE74v9XRWQ48DZV6LNpPP1g50Q
         pDrmwYNmZyyqEAOQFvF4rzc2XzQIyJSv/KsVhyk8wI3F0QR2yqKRoYZiie6twh4qsjxv
         x/tzoPo1NvY19lhGggVgBKwGNqgpdanCjBEhCjHus3mo2ZHz/c7ikKthKQ4QETfdlede
         O7iA==
X-Gm-Message-State: APjAAAWOH53QNJQobgo0rYxDqVd89LfIzo6D0YTrdMiof/o79idfnD0w
        YGFJ7Yf4RjRG1CrCGOhmUwveNY3xIaY=
X-Google-Smtp-Source: APXvYqz3YvNACbB62WEtqOG9u4gtL79NGMAwQlk1xDBeY8zu+GZkPCNPL10tBd4PnEnPq6fRw0Sd1g==
X-Received: by 2002:a17:90a:d985:: with SMTP id d5mr1410275pjv.73.1578443634003;
        Tue, 07 Jan 2020 16:33:54 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.33.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:33:53 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/22] btio: Add mode to for Enhanced Credit Mode
Date:   Tue,  7 Jan 2020 16:33:31 -0800
Message-Id: <20200108003342.15458-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200108003342.15458-1-luiz.dentz@gmail.com>
References: <20200108003342.15458-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BT_IO_MODE_ECRED which directly maps to L2CAP_MODE_ECRED.
---
 btio/btio.c | 2 +-
 btio/btio.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index af2276db9..bd076b4c8 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -638,7 +638,7 @@ static gboolean l2cap_set(int sock, uint8_t src_type, int sec_level,
 	if (imtu || omtu || mode) {
 		gboolean ret;
 
-		if (src_type == BDADDR_BREDR)
+		if (src_type == BDADDR_BREDR || mode)
 			ret = set_l2opts(sock, imtu, omtu, mode, err);
 		else
 			ret = set_le_imtu(sock, imtu, err);
diff --git a/btio/btio.h b/btio/btio.h
index 2dce9f0c1..91398f72d 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -70,7 +70,8 @@ typedef enum {
 	BT_IO_MODE_RETRANS,
 	BT_IO_MODE_FLOWCTL,
 	BT_IO_MODE_ERTM,
-	BT_IO_MODE_STREAMING
+	BT_IO_MODE_STREAMING,
+	BT_IO_MODE_ECRED = 0x81
 } BtIOMode;
 
 typedef void (*BtIOConfirm)(GIOChannel *io, gpointer user_data);
-- 
2.21.0

