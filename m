Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF05C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 20:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbhLUUuY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Dec 2021 15:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhLUUuX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Dec 2021 15:50:23 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3B0C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 12:50:23 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso413650pjb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 12:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MmnY8I+w/jkgNmE6nCbTocoxK22UiRXsyy7Z4QQoM3M=;
        b=Dr3qcxVZTV0p4vp4seiGQjbwiakRNuUve8pi8HOsqXpqI65h45krtm31WT7YFUL0EZ
         TRpjnTOrUhMoMJv6xjrXE5cCzIo7bKtlZyhN9sQkvjqtybXxguaBb2pkwHxsSEYaeJ4C
         etqCb8JKuJvtbWiwU6qi9Zbj0WkjXH3CPzzZLQ9UTgwtJwdqaH60QDZkrJnePXWBWvzO
         1Zy++pf5XMS44mJp+00OG7cydkdU1WXM7+NFuc2bjdVtHLbrgPaa35yPc7b2Fr2en2qp
         P8vTm0IgVsKZhBOmkpsfb51633i/asNE51ubSuWBoLStkWQlJHD1BSXIgrtgVsuEfKnu
         dxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MmnY8I+w/jkgNmE6nCbTocoxK22UiRXsyy7Z4QQoM3M=;
        b=UJZUJTe6bWznoQf+YOWah1r2RuUIQoLGcaEOL9DFBGCxwyCtoUD/U/0Cwjv6i7FpTf
         Q8sntzY+hiARWb2rGYwpQ3THS/celwoVEK35LbQkVqjstBIZSiun3m9FkNhswUYPqpKM
         W4YH64Dv0ykrrOagwxrUpmI3hBSg+R7wRxtib5De3EpTlzMWbqd7LOJGcIVl1udUCDyi
         IOHToV5J2LjEV+m7cX0b9Fz4d162UoigHVADyfzJMXLWdXZjjIrRxEIyrp6fyqDH9S77
         TkY/jPG5SocxLRDfmb83PyVNrOyydZCQZMwdVVkoxdOPqPEumKG3zq70Vce7I11UUEga
         o9gA==
X-Gm-Message-State: AOAM531SsFIOqftLgoyuFgUY0Lv6tETEjXu1AiTOv3xZT1czuZ0lSSim
        50BLkJ0Q5Acm9f7tYwUuuTuglBKTbt8=
X-Google-Smtp-Source: ABdhPJyu+SvIHgM+snFiC6C0ftcjEBhaVjn99gLA6XEltTRZLnziBPZKKxAEuWlfEplky/yMp/qnQw==
X-Received: by 2002:a17:90b:3d6:: with SMTP id go22mr35939pjb.221.1640119822781;
        Tue, 21 Dec 2021 12:50:22 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 72sm3973pfu.70.2021.12.21.12.50.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 12:50:22 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/4] build: Fix build when sanitizer are enabled
Date:   Tue, 21 Dec 2021 12:50:17 -0800
Message-Id: <20211221205019.654432-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211221205019.654432-1-luiz.dentz@gmail.com>
References: <20211221205019.654432-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes various issues found when sanitizers are enabled.
---
 Makefile.tools           |  2 ++
 monitor/packet.c         |  3 ++-
 peripheral/main.c        |  2 +-
 profiles/audio/a2dp.c    |  5 ++++-
 profiles/network/bnep.c  |  4 ++--
 src/shared/gatt-server.c |  2 --
 tools/mesh-gatt/util.c   | 11 ++++++++---
 tools/test-runner.c      |  2 +-
 8 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index c7bdff83f..12879859f 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -121,6 +121,8 @@ tools_mgmt_tester_SOURCES = tools/mgmt-tester.c monitor/bt.h \
 				emulator/smp.c
 tools_mgmt_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
+tools_mgmt_tester_LDFLAGS = $(AM_LDFLAGS) -fno-var-tracking-assignments
+tools_mgmt_tester_CFLAGS = $(AM_CFLAGS) -fno-var-tracking-assignments
 
 tools_l2cap_tester_SOURCES = tools/l2cap-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
diff --git a/monitor/packet.c b/monitor/packet.c
index 71f711dc5..397000644 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -330,7 +330,8 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 	if ((filter_mask & PACKET_FILTER_SHOW_INDEX) &&
 					index != HCI_DEV_NONE) {
 		if (use_color()) {
-			n = sprintf(ts_str + ts_pos, "%s", COLOR_INDEX_LABEL);
+			n = snprintf(ts_str + ts_pos, sizeof(ts_str) - ts_pos,
+				     "%s", COLOR_INDEX_LABEL);
 			if (n > 0)
 				ts_pos += n;
 		}
diff --git a/peripheral/main.c b/peripheral/main.c
index 0f5210403..91adb45fc 100644
--- a/peripheral/main.c
+++ b/peripheral/main.c
@@ -73,7 +73,7 @@ static void prepare_filesystem(void)
 	if (!is_init)
 		return;
 
-	for (i = 0; mount_table[i].fstype; i++) {
+	for (i = 0; mount_table[i].fstype && mount_table[i].target; i++) {
 		struct stat st;
 
 		if (lstat(mount_table[i].target, &st) < 0) {
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index eba2f9822..d0808c77a 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1338,9 +1338,12 @@ static gboolean a2dp_reconfigure(gpointer data)
 	if (setup->rsep) {
 		cap = avdtp_get_codec(setup->rsep->sep);
 		rsep_codec = (struct avdtp_media_codec_capability *) cap->data;
+		/* Check that codec really match after closing */
+		if (sep->codec != rsep_codec->media_codec_type)
+			setup->rsep = NULL;
 	}
 
-	if (!setup->rsep || sep->codec != rsep_codec->media_codec_type)
+	if (!setup->rsep)
 		setup->rsep = find_remote_sep(setup->chan, sep);
 
 	if (!setup->rsep) {
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index f94f1da8a..54b950058 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -108,7 +108,7 @@ static int bnep_connadd(int sk, uint16_t role, char *dev)
 	struct bnep_connadd_req req;
 
 	memset(&req, 0, sizeof(req));
-	strncpy(req.device, dev, 16);
+	strncpy(req.device, dev, 15);
 	req.device[15] = '\0';
 
 	req.sock = sk;
@@ -345,7 +345,7 @@ struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role,
 	session->io = g_io_channel_unix_new(dup_fd);
 	session->src = local_role;
 	session->dst = remote_role;
-	strncpy(session->iface, iface, 16);
+	strncpy(session->iface, iface, 15);
 	session->iface[15] = '\0';
 
 	g_io_channel_set_close_on_unref(session->io, TRUE);
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 9beec44be..776e5ce2b 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1119,8 +1119,6 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
 	}
 
 	data = read_mult_data_new(server, chan, opcode, length / 2);
-	if (!data)
-		goto error;
 
 	for (i = 0; i < data->num_handles; i++)
 		data->handles[i] = get_le16(pdu + i * 2);
diff --git a/tools/mesh-gatt/util.c b/tools/mesh-gatt/util.c
index e845c4112..eb8b8eb29 100644
--- a/tools/mesh-gatt/util.c
+++ b/tools/mesh-gatt/util.c
@@ -41,9 +41,14 @@ void print_byte_array(const char *prefix, const void *ptr, int len)
 	char *line, *bytes;
 	int i;
 
-	line = g_malloc(strlen(prefix) + (16 * 3) + 2);
-	sprintf(line, "%s ", prefix);
-	bytes = line + strlen(prefix) + 1;
+	if (prefix) {
+		line = g_malloc(strlen(prefix) + (16 * 3) + 2);
+		sprintf(line, "%s ", prefix);
+		bytes = line + strlen(prefix) + 1;
+	} else {
+		line = g_malloc((16 * 3) + 2);
+		bytes = line + 1;
+	}
 
 	for (i = 0; i < len; ++i) {
 		sprintf(bytes, "%2.2x ", data[i]);
diff --git a/tools/test-runner.c b/tools/test-runner.c
index eac120f4a..71cc0d2df 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -136,7 +136,7 @@ static void prepare_sandbox(void)
 {
 	int i;
 
-	for (i = 0; mount_table[i].fstype; i++) {
+	for (i = 0; mount_table[i].fstype && mount_table[i].target; i++) {
 		struct stat st;
 
 		if (lstat(mount_table[i].target, &st) < 0) {
-- 
2.33.1

