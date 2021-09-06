Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61740C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B2360F9E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbhIFIGN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Sep 2021 04:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240617AbhIFIGJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Sep 2021 04:06:09 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5990C061575
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Sep 2021 01:05:04 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id f22-20020a631016000000b00269ef9aae08so1119652pgl.20
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Sep 2021 01:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pPqby/cfREhmOo2yCrpo9uCwUyrL1BiDQxIlMXpw/OY=;
        b=Dh/T5ygPqRGJWv7O419MulD5jHbHlyhuNkjErFJbLtWaMjJbCWFNMTVPg+FXTmwpTg
         nqJUlaUl70f0Kjlm6P1MGZf51Cfb7Z0jDN7nulSoQU4SjWe4VjIm2vLgx2MnbiIG495B
         cdQNqx6bYr5wTOTqh0b+/QfaPUyYPqTBM7t7NCLtsg1B/pGVQBpwCbCs+uWHYGXtDJ+A
         Ehk1R5QMv1UYar8+/twOPMPooagAh/SySkNOBz0bSOfK4HetSAShHkvqIXKtTrDrSi9l
         J324h97SCLfvFjWvXao68TimqLvZQhAVGdSb0KpOyijQeMUCEp/BNmXX0rqq1clxqSvp
         ssCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pPqby/cfREhmOo2yCrpo9uCwUyrL1BiDQxIlMXpw/OY=;
        b=TRSbRaiJKa01SbRWJzAxcKJLz5Fdbzgk+Yv8ixMQ68aP5yNFAWj2BfX+2Chd+pjZGo
         1TGIqwzke0XHN2fRiXIUVB1kAuOAA3B0SpDbLZteWcnWp1/AyQKJnfSVndlFnul9XHOB
         1oFrCqUJozq1JI7X8J9v3BOvo3F4VL27vimSoVN2NS9ZD5fxBMGU4I6AlXu/nU1fMAUY
         OZ2PkcDkxUS2MJNOyazCiI7i3yFJFW71vzhI9OmkBkTKJIOhnat4LMCz14Awz52XW2fZ
         tAKY1V9IW1fhjml/0oHksT0Sgxj789zOCFbsRjSdsf/twsLam1xdwJDjZgVSZ1zxvp6D
         bYvg==
X-Gm-Message-State: AOAM531FFkC2gz8RlUsUAHkY/Py1spqlJBMs9ki59UPrCJSQ8P9eeVrG
        NHknI0ZQ26iPG15uiozWaOxaqebsQFx3y/aPDlKY1fUhFg+kN3DDA/vNnaBKZ6nB+V5bsrSMGqD
        G2MNJ2I8fEpZogZHyBPvze0yTXUnauD2Ds7W0rb8XsgLWLXEMs6F1dwtT1gFITENdnVPVTXNnIP
        0n
X-Google-Smtp-Source: ABdhPJztISaouuCS+nhvO0ZEIC550n4ubGQo09JZST9r2/nd11rTZviYwl0MtagZif4PyH5qSz2w6V5wKsmz
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3b13:95ba:12e5:7134])
 (user=apusaka job=sendgmr) by 2002:a05:6a00:bcf:b0:411:dc42:e38a with SMTP id
 x15-20020a056a000bcf00b00411dc42e38amr10669075pfu.65.1630915504138; Mon, 06
 Sep 2021 01:05:04 -0700 (PDT)
Date:   Mon,  6 Sep 2021 16:04:40 +0800
In-Reply-To: <20210906080450.1771211-1-apusaka@google.com>
Message-Id: <20210906160340.Bluez.v4.2.Ieb652c069b1583fec1439ee784a0f49a02afed11@changeid>
Mime-Version: 1.0
References: <20210906080450.1771211-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [Bluez PATCH v4 02/12] btio: Inclusive language changes
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

BT core spec 5.3 promotes the usage of inclusive languages.
This CL uses "central" as it is deemed to be more appropriate.
---

(no changes since v1)

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
index 1f1c374bca..f4f53574c8 100644
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
 		if (flags & L2CAP_LM_MASTER)
 			return 0;
 		flags |= L2CAP_LM_MASTER;
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
 		if (flags & RFCOMM_LM_MASTER)
 			return 0;
 		flags |= RFCOMM_LM_MASTER;
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
index 02caa83e1c..38a46c077a 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2518,7 +2518,7 @@ static bool a2dp_server_listen(struct a2dp_server *server)
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
2.33.0.153.gba50c8fa24-goog

