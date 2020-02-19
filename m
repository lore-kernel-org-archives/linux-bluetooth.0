Return-Path: <SRS0=cHq6=4H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A903EC34031
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 00:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B652173E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 00:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZC2iTZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgBSAgU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:36:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36947 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgBSAgU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 19:36:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so11557037pfn.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2020 16:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FLPHeBxLvQ+N7tcXSpzXq1fSpXUzn67KKlPMXOk6+ss=;
        b=XZC2iTZIYtOT47i3A4Trba+tu8M5299HIMqoxiYhhqhfa7ImaORt71dr/sRcjX3T8Y
         Y4Zv9hECmVdd56DWfoWHO4XhI5JDkxH+R/4JJwLaXHQDybH6Rr+WL8x82TYI9EjM4YBD
         SKruJF5DDNjkxn/57YGeakJnN0dIQX1VFnJpfYJ1TenbvA7/EozfVNC3PwPP/xYxXthN
         WBIZT5/oneHQAEFyqEeD2yKQGGDadK65thpEnXXK8/BEhGTJPJ/XNSm/kToe2iSmB5v4
         xlqgrGF/sfODONZ8K3+yj+Nu2yXMYxEOvttOQdcg7rmDd5+VpBy2XCOM4gy6XJ7dHz2V
         kAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FLPHeBxLvQ+N7tcXSpzXq1fSpXUzn67KKlPMXOk6+ss=;
        b=VdKvPZv4ijyEFcILBsw567jFo6bKxOK/ol7zuW1s4mqpy1zwY7hUo90PfmABJKPotZ
         hLD/MTlVRdMTPsbynL+57tzalEKB8gVDDLf0JdQ2A5hBXq5W3UCod1QWz3ylBtlz5co1
         lpzJSq4gv7Mb5ZVEsXKGxGQMDOFX1ueXmlRdd27Dnz/cALMi2URIAdiRL5FhfB265Q7F
         HSYn+O1V8iTmkp840me1aJkvDD5+dMQ7amrQfuLNN/arBDsXD/SryMbhots4/bF6PZk7
         S8kVYGNqvsI+OUdM+7hZqHT1xykJ5oLNCfm9CU5cygvi65Ah2MfAOQR6xamCAMbqL/g9
         SxAg==
X-Gm-Message-State: APjAAAXAZz/rCiAPTf6fdwsh3jI8gGjRFqdQaG0greIxIVXPqKFloT4q
        WmsdhLGZO1RVenmvy+dY2JfbJMIg4U4=
X-Google-Smtp-Source: APXvYqz8E/7b17bimeu1mR9QpzYqy7r9czDhTV+wd5qJOYz4+LO0w5hhZ/sUMuZthDrXGIFBE+mY1Q==
X-Received: by 2002:aa7:99c6:: with SMTP id v6mr625129pfi.187.1582072579008;
        Tue, 18 Feb 2020 16:36:19 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.42])
        by smtp.gmail.com with ESMTPSA id v184sm180569pfc.67.2020.02.18.16.36.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 16:36:14 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] btio: Add BT_IO_PHY option
Date:   Tue, 18 Feb 2020 16:36:10 -0800
Message-Id: <20200219003612.14599-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200219003612.14599-1-luiz.dentz@gmail.com>
References: <20200219003612.14599-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BT_IO_PHY option which can be used to read the underline
packet types/PHY in use by the link layer.
---
 btio/btio.c | 37 ++++++++++++++++++++++++++++++++++++-
 btio/btio.h |  1 +
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/btio/btio.c b/btio/btio.c
index af2276db9..db37b99da 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -881,6 +881,7 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 		case BT_IO_OPT_DEST_CHANNEL:
 		case BT_IO_OPT_HANDLE:
 		case BT_IO_OPT_CLASS:
+		case BT_IO_OPT_PHY:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
@@ -968,6 +969,17 @@ static int get_priority(int sock, uint32_t *prio)
 	return 0;
 }
 
+static int get_phy(int sock, uint32_t *phy)
+{
+	socklen_t len;
+
+	len = sizeof(*phy);
+	if (getsockopt(sock, SOL_BLUETOOTH, BT_PHY, phy, &len) < 0)
+		return -errno;
+
+	return 0;
+}
+
 static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 								va_list args)
 {
@@ -979,7 +991,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 	uint16_t handle = 0;
 	socklen_t len;
 	gboolean flushable = FALSE, have_dst = FALSE;
-	uint32_t priority;
+	uint32_t priority, phy;
 
 	if (!get_src(sock, &src, sizeof(src), err))
 		return FALSE;
@@ -1147,6 +1159,13 @@ parse_opts:
 			}
 			*(va_arg(args, uint32_t *)) = priority;
 			break;
+		case BT_IO_OPT_PHY:
+			if (get_phy(sock, &phy) < 0) {
+				ERROR_FAILED(err, "get_phy", errno);
+				return FALSE;
+			}
+			*(va_arg(args, uint32_t *)) = phy;
+			break;
 		case BT_IO_OPT_INVALID:
 		case BT_IO_OPT_SOURCE_TYPE:
 		case BT_IO_OPT_CHANNEL:
@@ -1194,6 +1213,7 @@ static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
 	socklen_t len;
 	uint8_t dev_class[3];
 	uint16_t handle = 0;
+	uint32_t phy;
 
 	if (!get_src(sock, &src, sizeof(src), err))
 		return FALSE;
@@ -1287,6 +1307,13 @@ static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
 			}
 			memcpy(va_arg(args, uint8_t *), dev_class, 3);
 			break;
+		case BT_IO_OPT_PHY:
+			if (get_phy(sock, &phy) < 0) {
+				ERROR_FAILED(err, "get_phy", errno);
+				return FALSE;
+			}
+			*(va_arg(args, uint32_t *)) = phy;
+			break;
 		case BT_IO_OPT_SOURCE_TYPE:
 		case BT_IO_OPT_DEST_TYPE:
 		case BT_IO_OPT_KEY_SIZE:
@@ -1338,6 +1365,7 @@ static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list args)
 	socklen_t len;
 	uint8_t dev_class[3];
 	uint16_t handle = 0;
+	uint32_t phy;
 
 	len = sizeof(sco_opt);
 	memset(&sco_opt, 0, len);
@@ -1385,6 +1413,13 @@ static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list args)
 			}
 			memcpy(va_arg(args, uint8_t *), dev_class, 3);
 			break;
+		case BT_IO_OPT_PHY:
+			if (get_phy(sock, &phy) < 0) {
+				ERROR_FAILED(err, "get_phy", errno);
+				return FALSE;
+			}
+			*(va_arg(args, uint32_t *)) = phy;
+			break;
 		case BT_IO_OPT_SOURCE_TYPE:
 		case BT_IO_OPT_DEST_TYPE:
 		case BT_IO_OPT_DEFER_TIMEOUT:
diff --git a/btio/btio.h b/btio/btio.h
index 2dce9f0c1..41a017acb 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -56,6 +56,7 @@ typedef enum {
 	BT_IO_OPT_FLUSHABLE,
 	BT_IO_OPT_PRIORITY,
 	BT_IO_OPT_VOICE,
+	BT_IO_OPT_PHY,
 } BtIOOption;
 
 typedef enum {
-- 
2.21.1

