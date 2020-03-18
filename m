Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FED2C4332E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 21:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350E82076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 21:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJ8drzsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCRVv2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:51:28 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:37667 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgCRVv2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 17:51:28 -0400
Received: by mail-pj1-f49.google.com with SMTP id ca13so27044pjb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2020 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pXnDcxxE1zmo2t5aTdjtgw5YWupzZKBA0Z5OuAGW7ro=;
        b=eJ8drzsnPo1ZKqbUCon899SI1WnJuNbUPTs3TRuGlliuI12Y9rrmkJmHyrMdKXNUPr
         v/1/H48qFDrI1ekvPDQrLw+Q9Du7GSIwNNNIDw85v9tD9kU8/ESiFmzPYPzfVb1pfdG7
         +pjDP9LJVQpr4Xe8TQUPxuoWj9pakS1rDloOyQcNJC7aeKis1kNYcSM7ZECsdnA6Zx1c
         nDAEGwYT4lHuzabo+bB69UZeJxFEBwRe3+RP6NdW2bXgoEF7L57ATarDc7Yzjin8rNuf
         xSS+OqBtkaYmS60+cSP+n87CiYPUcb+Tz1XKc2/oHGwL63k9bxr3JwCSUMc1B/Z/mC1C
         o0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pXnDcxxE1zmo2t5aTdjtgw5YWupzZKBA0Z5OuAGW7ro=;
        b=SJn01QS0DfLj9i227S7EMTSbduIJi+sc6CHhy2Q75hwgK3OgaeSotPQWwPzn2EEb7t
         HfXm1kzi46bj5n+v8lSk45NtP5n+P/dE9wNknH/o4B2d0GGHmSrqQ/2IsAvREfC05A4Q
         K585YUS52/A4LHlNOrCxyI+BOykJkVtlz+d/HtA7RNtu3nccBgWk0LlOTHHLA8BcWYRe
         m5ej9ntM7JTO0Xx4Gaw7egV5UE4H9MPIgqQiFVOE3mwRSKh7Wrru6J4Ybl0Spv+eKfix
         2uKo/xhd9SsEzCf/jISBFriV5hh6WFSqqbzKQVBnb6A2IUzQ+/mCQBzDNO+F52HuKJg0
         pJUw==
X-Gm-Message-State: ANhLgQ1/ZxY5q/JquUAtBr7u4qy+fTJDxONcvTFZnqtlZvDsr0mPJXX5
        2myrHANFgXC7dpdOKVvPwSNmURAw
X-Google-Smtp-Source: ADFU+vs6u0DHsPNs1noXNqsUQu2KAGvIuKP+QgcQBvfZRqE+PQxgw/DIOvRX1l2lqHtfTbgXkF6G5Q==
X-Received: by 2002:a17:90b:1997:: with SMTP id mv23mr299963pjb.84.1584568287101;
        Wed, 18 Mar 2020 14:51:27 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r13sm83709pgf.1.2020.03.18.14.51.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:51:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/6] btio: Add mode to for Enhanced Credit Mode
Date:   Wed, 18 Mar 2020 14:51:20 -0700
Message-Id: <20200318215124.21880-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200318215124.21880-1-luiz.dentz@gmail.com>
References: <20200318215124.21880-1-luiz.dentz@gmail.com>
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
 btio/btio.h |  3 ++-
 2 files changed, 55 insertions(+), 7 deletions(-)

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
index 41a017acb..461c43eb0 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -71,7 +71,8 @@ typedef enum {
 	BT_IO_MODE_RETRANS,
 	BT_IO_MODE_FLOWCTL,
 	BT_IO_MODE_ERTM,
-	BT_IO_MODE_STREAMING
+	BT_IO_MODE_STREAMING,
+	BT_IO_MODE_EXT_FLOWCTL
 } BtIOMode;
 
 typedef void (*BtIOConfirm)(GIOChannel *io, gpointer user_data);
-- 
2.21.1

