Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE67C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1BE1610A4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbhHMMUg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240257AbhHMMUf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:20:35 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4D0C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:08 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id v3-20020a17090ac903b029017912733966so5351672pjt.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ejnwLlyLznKWLUa0eV7/KWaNGPYz6cgbkPhMFmYxfVs=;
        b=ngEGNwSRSlmganPA3oWy4Be+YcaSD6XVGuoJ9AGnbWOBKUa1AYt0nTuV+ZgBHmyixv
         8WMU8RUyD0qDXmo5Av7MytoVmqsv3Pd6FVP3Tf7tutVUpf4htPT3Gaj+xDfzEqO+WW6W
         S5GPigepGBzf2Xz/CBi1FGaJEvwnQ9zxUxBv5g0aF4u6aLC66tCtjXFuAdxDV/WkC0LT
         Tle/jd3hWJEq/Av8upj+iGWb6Gx6zaa+H/a6E7UnE/6+d907fLbs5Td6HS0GGx0vQOXQ
         rZ/kl5xmiqncENx+9AN0shqR/abnDgIpaM6N6drUOOLmOpQEwCq5eDou4zkyLhY0vsMJ
         pqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ejnwLlyLznKWLUa0eV7/KWaNGPYz6cgbkPhMFmYxfVs=;
        b=k6J211AhF/R31ipsGO28MQN4dKUedADOJoRtFTIY5TxbcMNuN+8MnM3BcSW/8nueqO
         NyGUV4xMVg2IGqh2HxGoivsyuWQs2+AJeH7UL4vX3E0HheYcRkKF/8aWIIeut43B7r/M
         lrwzgrATRGx19z/1g0qpdxBU3uFa9wKUPhd8imzgI2BP4WMIFWjGlDg09z89IFZPmgrU
         T9+vYQtUXRCE3I90LcnFfY8P+gZa3Qf5K9WMmSmq5KQQgrfKqVMk4QQirHJXA2mFP/Np
         7pJNwIBSHEU+nAq7t8wV7RMI14oH37wmD4mhL6O1wt6AybEgL1GpK49o7trYvVxnNdC9
         oRIg==
X-Gm-Message-State: AOAM5334UxxtUZ4Tvspaz/eiDYoWQ+CeLSSjPsTN697Fmg3s3OOEopIw
        b+4yFzfPkW6r9yPhaxnP/J7t55pc4XGIM/JzKMUy3prdjqA20kZAIlJOlFjA97BHJp7e4fTBeEV
        U2TR0AxuW3eu6AN/5wICr1uZ5xN8WHApbOVD5MzsyRR2/eLefogNeMG5zw2Wcia01ZpV38fijoi
        1T
X-Google-Smtp-Source: ABdhPJy/kBx+w0AIhvFl2p1Kw4D2bmH3qqMezIu2hC7RwDm6ATcDt1cmQnSnIrcAaMV56e4kxIbITW9T3MXM
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:aa7:80d1:0:b029:399:ce3a:d617 with SMTP id
 a17-20020aa780d10000b0290399ce3ad617mr2252807pfn.16.1628857207890; Fri, 13
 Aug 2021 05:20:07 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:17:54 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.9.Ieb652c069b1583fec1439ee784a0f49a02afed11@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 09/62] btio: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" is preferred, as is reflected in the BT core spec 5.3.
---

 android/a2dp.c         |  2 +-
 btio/btio.c            | 42 +++++++++++++++++++++---------------------
 btio/btio.h            |  2 +-
 profiles/audio/a2dp.c  |  2 +-
 profiles/audio/avctp.c |  2 +-
 profiles/sap/server.c  |  2 +-
 tools/btiotest.c       |  8 ++++----
 7 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index e24f79348d..029107cf5c 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -1692,7 +1692,7 @@ bool bt_a2dp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 				BT_IO_OPT_PSM, AVDTP_PSM,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_MASTER, true,
+				BT_IO_OPT_CENTRAL, true,
 				BT_IO_OPT_INVALID);
 	if (!server) {
 		error("Failed to listen on AVDTP channel: %s", err->message);
diff --git a/btio/btio.c b/btio/btio.c
index ce958bdd09..bc6ede08fa 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -61,7 +61,7 @@ struct set_opts {
 	uint16_t mtu;
 	uint16_t imtu;
 	uint16_t omtu;
-	int master;
+	int central;
 	uint8_t mode;
 	int flushable;
 	uint32_t priority;
@@ -359,7 +359,7 @@ static int l2cap_connect(int sock, const bdaddr_t *dst, uint8_t dst_type,
 	return 0;
 }
 
-static int l2cap_set_master(int sock, int master)
+static int l2cap_set_central(int sock, int central)
 {
 	int flags;
 	socklen_t len;
@@ -368,7 +368,7 @@ static int l2cap_set_master(int sock, int master)
 	if (getsockopt(sock, SOL_L2CAP, L2CAP_LM, &flags, &len) < 0)
 		return -errno;
 
-	if (master) {
+	if (central) {
 		if (flags & L2CAP_LM_CENTRAL)
 			return 0;
 		flags |= L2CAP_LM_CENTRAL;
@@ -384,7 +384,7 @@ static int l2cap_set_master(int sock, int master)
 	return 0;
 }
 
-static int rfcomm_set_master(int sock, int master)
+static int rfcomm_set_central(int sock, int central)
 {
 	int flags;
 	socklen_t len;
@@ -393,7 +393,7 @@ static int rfcomm_set_master(int sock, int master)
 	if (getsockopt(sock, SOL_RFCOMM, RFCOMM_LM, &flags, &len) < 0)
 		return -errno;
 
-	if (master) {
+	if (central) {
 		if (flags & RFCOMM_LM_CENTRAL)
 			return 0;
 		flags |= RFCOMM_LM_CENTRAL;
@@ -656,7 +656,7 @@ static gboolean set_le_mode(int sock, uint8_t mode, GError **err)
 
 static gboolean l2cap_set(int sock, uint8_t src_type, int sec_level,
 				uint16_t imtu, uint16_t omtu, uint8_t mode,
-				int master, int flushable, uint32_t priority,
+				int central, int flushable, uint32_t priority,
 				GError **err)
 {
 	if (imtu || omtu || mode) {
@@ -676,8 +676,8 @@ static gboolean l2cap_set(int sock, uint8_t src_type, int sec_level,
 			return ret;
 	}
 
-	if (master >= 0 && l2cap_set_master(sock, master) < 0) {
-		ERROR_FAILED(err, "l2cap_set_master", errno);
+	if (central >= 0 && l2cap_set_central(sock, central) < 0) {
+		ERROR_FAILED(err, "l2cap_set_central", errno);
 		return FALSE;
 	}
 
@@ -733,13 +733,13 @@ static int rfcomm_connect(int sock, const bdaddr_t *dst, uint8_t channel)
 	return 0;
 }
 
-static gboolean rfcomm_set(int sock, int sec_level, int master, GError **err)
+static gboolean rfcomm_set(int sock, int sec_level, int central, GError **err)
 {
 	if (sec_level && !set_sec_level(sock, BT_IO_RFCOMM, sec_level, err))
 		return FALSE;
 
-	if (master >= 0 && rfcomm_set_master(sock, master) < 0) {
-		ERROR_FAILED(err, "rfcomm_set_master", errno);
+	if (central >= 0 && rfcomm_set_central(sock, central) < 0) {
+		ERROR_FAILED(err, "rfcomm_set_central", errno);
 		return FALSE;
 	}
 
@@ -828,7 +828,7 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 	/* Set defaults */
 	opts->type = BT_IO_SCO;
 	opts->defer = DEFAULT_DEFER_TIMEOUT;
-	opts->master = -1;
+	opts->central = -1;
 	opts->mode = L2CAP_MODE_BASIC;
 	opts->flushable = -1;
 	opts->priority = 0;
@@ -889,8 +889,8 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 			if (!opts->mtu)
 				opts->mtu = opts->imtu;
 			break;
-		case BT_IO_OPT_MASTER:
-			opts->master = va_arg(args, gboolean);
+		case BT_IO_OPT_CENTRAL:
+			opts->central = va_arg(args, gboolean);
 			break;
 		case BT_IO_OPT_MODE:
 			opts->mode = va_arg(args, int);
@@ -1171,7 +1171,7 @@ parse_opts:
 		case BT_IO_OPT_IMTU:
 			*(va_arg(args, uint16_t *)) = l2o.imtu;
 			break;
-		case BT_IO_OPT_MASTER:
+		case BT_IO_OPT_CENTRAL:
 			len = sizeof(flags);
 			if (getsockopt(sock, SOL_L2CAP, L2CAP_LM, &flags,
 								&len) < 0) {
@@ -1336,7 +1336,7 @@ static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
 
 			*(va_arg(args, uint8_t *)) = dst.rc_channel;
 			break;
-		case BT_IO_OPT_MASTER:
+		case BT_IO_OPT_CENTRAL:
 			len = sizeof(flags);
 			if (getsockopt(sock, SOL_RFCOMM, RFCOMM_LM, &flags,
 								&len) < 0) {
@@ -1484,7 +1484,7 @@ static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		case BT_IO_OPT_DEST_CHANNEL:
 		case BT_IO_OPT_PSM:
 		case BT_IO_OPT_CID:
-		case BT_IO_OPT_MASTER:
+		case BT_IO_OPT_CENTRAL:
 		case BT_IO_OPT_MODE:
 		case BT_IO_OPT_FLUSHABLE:
 		case BT_IO_OPT_PRIORITY:
@@ -1578,10 +1578,10 @@ gboolean bt_io_set(GIOChannel *io, GError **err, BtIOOption opt1, ...)
 	switch (type) {
 	case BT_IO_L2CAP:
 		return l2cap_set(sock, opts.src_type, opts.sec_level, opts.imtu,
-					opts.omtu, opts.mode, opts.master,
+					opts.omtu, opts.mode, opts.central,
 					opts.flushable, opts.priority, err);
 	case BT_IO_RFCOMM:
-		return rfcomm_set(sock, opts.sec_level, opts.master, err);
+		return rfcomm_set(sock, opts.sec_level, opts.central, err);
 	case BT_IO_SCO:
 		return sco_set(sock, opts.mtu, opts.voice, err);
 	case BT_IO_INVALID:
@@ -1628,7 +1628,7 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 			goto failed;
 		if (!l2cap_set(sock, opts->src_type, opts->sec_level,
 				opts->imtu, opts->omtu, opts->mode,
-				opts->master, opts->flushable, opts->priority,
+				opts->central, opts->flushable, opts->priority,
 				err))
 			goto failed;
 		break;
@@ -1641,7 +1641,7 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 		if (rfcomm_bind(sock, &opts->src,
 					server ? opts->channel : 0, err) < 0)
 			goto failed;
-		if (!rfcomm_set(sock, opts->sec_level, opts->master, err))
+		if (!rfcomm_set(sock, opts->sec_level, opts->central, err))
 			goto failed;
 		break;
 	case BT_IO_SCO:
diff --git a/btio/btio.h b/btio/btio.h
index f0259cf1db..50a2a4dc02 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -36,7 +36,7 @@ typedef enum {
 	BT_IO_OPT_MTU,
 	BT_IO_OPT_OMTU,
 	BT_IO_OPT_IMTU,
-	BT_IO_OPT_MASTER,
+	BT_IO_OPT_CENTRAL,
 	BT_IO_OPT_HANDLE,
 	BT_IO_OPT_CLASS,
 	BT_IO_OPT_MODE,
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 86bc02994f..a09ebce086 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2418,7 +2418,7 @@ static bool a2dp_server_listen(struct a2dp_server *server)
 				BT_IO_OPT_PSM, AVDTP_PSM,
 				BT_IO_OPT_MODE, mode,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_MASTER, true,
+				BT_IO_OPT_CENTRAL, true,
 				BT_IO_OPT_INVALID);
 	if (server->io)
 		return true;
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 50de336181..9f717f35bb 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1625,7 +1625,7 @@ static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master,
 				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_PSM, psm,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_MASTER, master,
+				BT_IO_OPT_CENTRAL, master,
 				BT_IO_OPT_MODE, mode,
 				BT_IO_OPT_INVALID);
 	if (!io) {
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index 82365fca90..e6f3024ea6 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -1369,7 +1369,7 @@ int sap_server_register(struct btd_adapter *adapter)
 			btd_adapter_get_address(adapter),
 			BT_IO_OPT_CHANNEL, SAP_SERVER_CHANNEL,
 			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
-			BT_IO_OPT_MASTER, TRUE,
+			BT_IO_OPT_CENTRAL, TRUE,
 			BT_IO_OPT_INVALID);
 	if (!io) {
 		error("Can't listen at channel %d.", SAP_SERVER_CHANNEL);
diff --git a/tools/btiotest.c b/tools/btiotest.c
index cb8cc35348..3f4900a5a5 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -343,7 +343,7 @@ static void l2cap_listen(const char *src, uint8_t addr_type, uint16_t psm,
 					BT_IO_OPT_PSM, psm,
 					BT_IO_OPT_CID, cid,
 					BT_IO_OPT_SEC_LEVEL, sec,
-					BT_IO_OPT_MASTER, master,
+					BT_IO_OPT_CENTRAL, master,
 					BT_IO_OPT_INVALID);
 	else
 		l2_srv = bt_io_listen(conn, cfm, data,
@@ -353,7 +353,7 @@ static void l2cap_listen(const char *src, uint8_t addr_type, uint16_t psm,
 					BT_IO_OPT_PSM, psm,
 					BT_IO_OPT_CID, cid,
 					BT_IO_OPT_SEC_LEVEL, sec,
-					BT_IO_OPT_MASTER, master,
+					BT_IO_OPT_CENTRAL, master,
 					BT_IO_OPT_INVALID);
 
 	if (!l2_srv) {
@@ -427,7 +427,7 @@ static void rfcomm_listen(const char *src, uint8_t ch, gboolean defer,
 					BT_IO_OPT_SOURCE, src,
 					BT_IO_OPT_CHANNEL, ch,
 					BT_IO_OPT_SEC_LEVEL, sec,
-					BT_IO_OPT_MASTER, master,
+					BT_IO_OPT_CENTRAL, master,
 					BT_IO_OPT_INVALID);
 	else
 		rc_srv = bt_io_listen(conn, cfm,
@@ -435,7 +435,7 @@ static void rfcomm_listen(const char *src, uint8_t ch, gboolean defer,
 					&err,
 					BT_IO_OPT_CHANNEL, ch,
 					BT_IO_OPT_SEC_LEVEL, sec,
-					BT_IO_OPT_MASTER, master,
+					BT_IO_OPT_CENTRAL, master,
 					BT_IO_OPT_INVALID);
 
 	if (!rc_srv) {
-- 
2.33.0.rc1.237.g0d66db33f3-goog

