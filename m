Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D9BC4332E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E484F20775
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb4jyRwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCTUkm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:40:42 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:36748 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCTUkm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 16:40:42 -0400
Received: by mail-pg1-f175.google.com with SMTP id z72so3669994pgz.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2020 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=J0gRxRXyxfA2V4DkT12cYVAYJsKd5h2szCe6R/5EH1M=;
        b=Xb4jyRwN4wKuLxMYT1/XKZBSHORuNMRDBRfQ5XCi8DDBP17eoQm6EfmN9P9P3zlIKQ
         swnCL7z8hc7inR0DRg2oCNQ0hf3oI2F8Hl67kkhIpgvK5ETP9mF3vHG9A7ZldPp/5dfD
         agcbyW2um8O7ldQvuNOKEKFeOjfHFeWAWpNomrw2zmshnldjFq/YI8Xq6bTI0hIe6HOI
         85wLytVWaNGQFJWC1Y+GQmz0ttcpxzVd5BIrPN/WxlD0ltZ/lgamzR7DwVt6g0r+z8JC
         FVEHAo3U7z24+To6FGnogEqmeGS5eBMvqmJPXVT7YoEaG9oSIbPIPmVAS6+x/4HpZPT0
         otHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0gRxRXyxfA2V4DkT12cYVAYJsKd5h2szCe6R/5EH1M=;
        b=Tu4LgusK7nrQzXmvNlytEUOIzNo1y/N95RZcaL2i5Hay/54IW+w67Iv1kDXhMNQ3u3
         NCaG9OhIp1mLjbJKI8nyu8UD7hP+swflImJLLTxCSmCtc3VkN/naGfH8+WRNxSo0EKta
         3OggBi9vXFAGM8+FhiocoHJELHWSP/BvHOMxEUYoceTwCNNm9V7YWXuI/6HNi5BGqy+l
         FlqqD5ZewAXkgpRcQ76I9IvHGSzb3lGXRCNfNZ5qy0VRMR0qpM0uJBCM0YlrCzwngfOK
         Dkko1OWcggcKCRTSUBKU9ycM2ZMYP6Kach631vha45XZHhqD6Y1EGWMAHGRy+kR7j6hm
         v7CQ==
X-Gm-Message-State: ANhLgQ3Ttlk4rt/QLZtKM+t1Cn+bGEjfLIn/OlMdWkdNmDSSpKe4KIrp
        bimnw8Sc0szSsSRA6ATwV/SRxZYr
X-Google-Smtp-Source: ADFU+vuQTtfHoIydPozPscwUtF8scqXiOI8kOH1rkT1Z2xtC4TF/IBPEwzlTLEDMvH+Ot6LnTP7qyw==
X-Received: by 2002:a63:ba5d:: with SMTP id l29mr10200784pgu.67.1584736840679;
        Fri, 20 Mar 2020 13:40:40 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d5sm6219522pga.36.2020.03.20.13.40.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:40:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/6] btio: Add mode to for Enhanced Credit Mode
Date:   Fri, 20 Mar 2020 13:40:34 -0700
Message-Id: <20200320204038.11799-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320204038.11799-1-luiz.dentz@gmail.com>
References: <20200320204038.11799-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BT_IO_MODE_EXT_FLOWCTL which directly maps to
BT_MODE_EXT_FLOWCTL.
---
 btio/btio.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++------
 btio/btio.h |  6 +++---
 2 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index db37b99da..e7b4db16b 100644
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
@@ -1644,6 +1685,12 @@ GIOChannel *bt_io_connect(BtIOConnect connect, gpointer user_data,
 
 	sock = g_io_channel_unix_get_fd(io);
 
+	/* Use DEFER_SETUP when connecting using Ext-Flowctl */
+	if (opts.mode == BT_IO_MODE_EXT_FLOWCTL && opts.defer) {
+		setsockopt(sock, SOL_BLUETOOTH, BT_DEFER_SETUP, &opts.defer,
+							sizeof(opts.defer));
+	}
+
 	switch (opts.type) {
 	case BT_IO_L2CAP:
 		err = l2cap_connect(sock, &opts.dst, opts.dst_type,
diff --git a/btio/btio.h b/btio/btio.h
index 41a017acb..23e0ef72b 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -68,10 +68,10 @@ typedef enum {
 
 typedef enum {
 	BT_IO_MODE_BASIC = 0,
-	BT_IO_MODE_RETRANS,
-	BT_IO_MODE_FLOWCTL,
 	BT_IO_MODE_ERTM,
-	BT_IO_MODE_STREAMING
+	BT_IO_MODE_STREAMING,
+	BT_IO_MODE_LE_FLOWCTL,
+	BT_IO_MODE_EXT_FLOWCTL
 } BtIOMode;
 
 typedef void (*BtIOConfirm)(GIOChannel *io, gpointer user_data);
-- 
2.21.1

