Return-Path: <SRS0=e/tT=4Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821A8C3F2D4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580BC246B5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVarktRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgB1XrH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:47:07 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:44861 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgB1XrG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 18:47:06 -0500
Received: by mail-pl1-f172.google.com with SMTP id d9so1827783plo.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2020 15:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XGWE9lkXskeRh9mJU7EOBpH5ngFpikJQY3KMiOnIcZA=;
        b=CVarktRLphIVsaupESJaDJPI+GeH5pN9S1eJJtuTaUIwhvvdjuPBOnshRQkp8Wt79B
         3GRDcnAeq4E2wn2duzDr482x9iwR37Ak0oaDuOa8WxQ8in+8QqLcSlBsLQqPRIUtzfJ/
         8NYQB9luotpofWUyZUfN1Um/A34Ba0zC1b7cwlKmzzj2amf1hcO1ug/OnEdsjmur9f/5
         d8WgjtNnDMqu3uzu++Y/AfE6tXK/BdH59mbBnOBIhJJeFWDaSsevFlPxi4AvDy0UIWT7
         ih+RsQjXzlZzyCUTpSITkypXIkHVdv/+R75POcwJ4/UHqFgNSXArZlYv0CMfylc14FoS
         ViEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGWE9lkXskeRh9mJU7EOBpH5ngFpikJQY3KMiOnIcZA=;
        b=Co+AKcbDL/GhPGlgfrxQ2mTHthILgIO9Rahm1qlgvfsoQOpQ5Cx/RtCjbhwL6WQHtk
         uQwyAy0EUn0MAwpYDYbVgqbuRDDmVaNpjuK5lLvkNS1BSf6k94RyvQe18wfuywT8wnGU
         5dzgNlbTmpiKTRldxN5QmNg4lUB7E/RcY2QEQ3Oi9HGFcZVSXeCJkYh8rmDHsmJa+646
         gawLa9YTtXvkFLFHqTuMJUqNDrworCPABzdOuMi/+jQFTAVatrIefZBFXfagDbBWuCAz
         m2xoVRXx1wNzSCbeHvhr2bEKh52p6XuLzjRE1vT1y8AwBSYk/5gAW5qD7tJUG9WdXfwj
         mr/w==
X-Gm-Message-State: APjAAAWv8Bc4XVIWpy0kbvtlUpgFodWsUKrcHTJ6WHKZUi8LZC438IfC
        GnNaUdbOnwFFKOsdHrr0HOe6CbAEge0=
X-Google-Smtp-Source: APXvYqzxouOEocRjtAd84wyirrhsFWVMy42AjkdaOacpoeWN117HE9Az+aByaDJvxb/M/J7bDOJD/g==
X-Received: by 2002:a17:902:c113:: with SMTP id 19mr6390408pli.138.1582933625315;
        Fri, 28 Feb 2020 15:47:05 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q13sm13643954pfn.162.2020.02.28.15.47.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:47:04 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 02/12] btio: Add mode to for Enhanced Credit Mode
Date:   Fri, 28 Feb 2020 15:46:51 -0800
Message-Id: <20200228234701.14614-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228234701.14614-1-luiz.dentz@gmail.com>
References: <20200228234701.14614-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BT_IO_MODE_ECRED which directly maps to L2CAP_MODE_ECRED.
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

