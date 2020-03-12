Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4DEC1975A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E02206CD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtWKksS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCLWZV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:25:21 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:50182 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgCLWZU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 18:25:20 -0400
Received: by mail-pj1-f54.google.com with SMTP id u10so3130616pjy.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 15:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ielx6dlIxOmnUucczPAY2oahbPtXgftjqix4HktkLOY=;
        b=AtWKksS7eyHSn/h/6nFg/GGIrLU+x7EJPZtf5RrVhSRR86EMOJqBL2llMWaM+v9kbC
         m5qD888CsXvImCTj8gl5/nssTPQgoHlHwHRApy43EOw6kk6P7D81Teim4Ii5BGcyH/Mb
         I6X+NPpL1NyBwF5f2+lDK5LLmoDKUop8rIqcMrMUKYVXb9gr6SAVXfMXr5T2p3SpV2VA
         q6Id/K409BF5U4iOi6zenVUCLFMTol5AoPVWBKtSjTdrx+BkQ3ukDApICaW5gE/rNxh8
         ZHWhtynPg40K0pftJhcD+uxqWNp2pN3z2gpWKI2G8HLw50maCe8uAIurLbtvKCLmiAkG
         ELSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ielx6dlIxOmnUucczPAY2oahbPtXgftjqix4HktkLOY=;
        b=t23ju6WwEHhZaC1nBIFyPkDIxaJ13oflWUFTqBDLkDCKj44Fix3oFAgLUpyj6D0EKd
         nZATTACyloQgenWwIawNg9EPoW0uLrj6lPikSPx+Epp2v0cmS9ddhuGjxTMynRMonPWl
         TwTEzAB9h9mYOxQ245YnbGb7vk37Ho+aqQscV6xD+5OPJwFXiQGRCDmSlmZCf1UU8ndX
         LpJOjbUzJLyV2tmf1apAHXPePKSbuWeqIwOY2k/vBU5lb3sQhCgoJ+FJFJzpP8+LsjWX
         N9YozB/tPOjMNpQjVzhvq7kCS0cYLGRNHvHI27ZMUoV2ZYcZbroMdR0UqGPyGHFCoLAT
         4ELw==
X-Gm-Message-State: ANhLgQ0iCFTaOfYA/88nQaV65Tfs6kfc9iZw8+AsFE169E41sUp7vFJg
        w2KLCh9/+41zs6G+WQoawnLxI+Csb/g=
X-Google-Smtp-Source: ADFU+vv0wuraUDhkHXotcfokNnXGVCDtwkMLVCDECpUbecFYV3Cc6Mkma39LVkSMXAKvwl5jgLxUew==
X-Received: by 2002:a17:90a:ec0f:: with SMTP id l15mr6678557pjy.191.1584051919214;
        Thu, 12 Mar 2020 15:25:19 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i13sm4296468pfd.180.2020.03.12.15.25.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 15:25:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] btio: Add mode to for Enhanced Credit Mode
Date:   Thu, 12 Mar 2020 15:25:13 -0700
Message-Id: <20200312222516.5179-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200312222516.5179-1-luiz.dentz@gmail.com>
References: <20200312222516.5179-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BT_IO_MODE_EXT_FLOWCTL which directly maps to
L2CAP_MODE_EXT_FLOWCTL.
---
 btio/btio.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++------
 btio/btio.h |  3 ++-
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index db37b99da..4c84da0ee 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -630,18 +630,34 @@ static gboolean set_le_imtu(int sock, uint16_t imtu, GError **err)
 	return TRUE;
 }
 
+static gboolean set_le_mode(int sock, uint8_t mode, GError **err)
+{
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_MODE, &mode,
+						sizeof(mode)) < 0) {
+		ERROR_FAILED(err, "setsockopt(BT_MODE)", errno);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 static gboolean l2cap_set(int sock, uint8_t src_type, int sec_level,
 				uint16_t imtu, uint16_t omtu, uint8_t mode,
 				int master, int flushable, uint32_t priority,
 				GError **err)
 {
 	if (imtu || omtu || mode) {
-		gboolean ret;
+		gboolean ret = FALSE;
 
 		if (src_type == BDADDR_BREDR)
 			ret = set_l2opts(sock, imtu, omtu, mode, err);
-		else
-			ret = set_le_imtu(sock, imtu, err);
+		else {
+			if (imtu)
+				ret = set_le_imtu(sock, imtu, err);
+
+			if (ret && mode)
+				ret = set_le_mode(sock, mode, err);
+		}
 
 		if (!ret)
 			return ret;
@@ -980,6 +996,30 @@ static int get_phy(int sock, uint32_t *phy)
 	return 0;
 }
 
+static int get_le_imtu(int sock, uint16_t *mtu)
+{
+	socklen_t len;
+
+	len = sizeof(*mtu);
+
+	if (getsockopt(sock, SOL_BLUETOOTH, BT_RCVMTU, mtu, &len) < 0)
+		return -errno;
+
+	return 0;
+}
+
+static int get_le_mode(int sock, uint8_t *mode)
+{
+	socklen_t len;
+
+	len = sizeof(*mode);
+
+	if (getsockopt(sock, SOL_BLUETOOTH, BT_MODE, mode, &len) < 0)
+		return -errno;
+
+	return 0;
+}
+
 static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 								va_list args)
 {
@@ -999,10 +1039,11 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 	memset(&l2o, 0, sizeof(l2o));
 
 	if (src.l2_bdaddr_type != BDADDR_BREDR) {
-		len = sizeof(l2o.imtu);
-		if (getsockopt(sock, SOL_BLUETOOTH, BT_RCVMTU,
-						&l2o.imtu, &len) == 0)
+		if (get_le_imtu(sock, &l2o.imtu) == 0) {
+			/* Older kernels may not support BT_MODE */
+			get_le_mode(sock, &l2o.mode);
 			goto parse_opts;
+		}
 
 		/* Non-LE CoC enabled kernels will return one of these
 		 * in which case we need to fall back to L2CAP_OPTIONS.
diff --git a/btio/btio.h b/btio/btio.h
index 41a017acb..5ebfb85c6 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -71,7 +71,8 @@ typedef enum {
 	BT_IO_MODE_RETRANS,
 	BT_IO_MODE_FLOWCTL,
 	BT_IO_MODE_ERTM,
-	BT_IO_MODE_STREAMING
+	BT_IO_MODE_STREAMING,
+	BT_IO_MODE_EXT_FLOWCTL = 0x81
 } BtIOMode;
 
 typedef void (*BtIOConfirm)(GIOChannel *io, gpointer user_data);
-- 
2.21.1

