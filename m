Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58659C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Dec 2021 19:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350169AbhLWTuG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Dec 2021 14:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350165AbhLWTuG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Dec 2021 14:50:06 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55481C061401
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Dec 2021 11:50:06 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so9641440pjj.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Dec 2021 11:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gEEKJ+AwmI9ikcjPBu/gOgRvNQQVYakBGVrX14t7xyw=;
        b=afQlDyXRPmffBSkTKypQaUEcgLfEvJhVF03+MCVXNug7ju0FaLw8ZRHXCfGGgwHBud
         HhlKqMvLoNMkjkW/i0we5Vlr8II9hT7zYXJtILwAZ7fLwR4dEmzTkoaWTuHO39DbXY0R
         kc4pMfwQ6uiHd88tNWPPhgvZ5C7opx6d0w3wO45/b8N9l/PxJ8zjfGoG15m2lvPUDAbT
         JQIFfiuCnJka8/hu2kS17+VzMn3oWoWrZiLLj7IXueji/ntzZsNKxi7l0m8ej6PlPtYC
         oynTUUG5M8UREFd+9VePILd6mK9gPveK9M2ePaWfHn7vFjPaS+cPl4p10ppiSoKaFAJB
         LdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gEEKJ+AwmI9ikcjPBu/gOgRvNQQVYakBGVrX14t7xyw=;
        b=KZi6b8FsWHVoZnbqK49lQ+lgubHnvitXvCxzmskPBR6nB6OqMNEcSUpNxAXKVuMuiV
         QtOk3+wXm/l9R3gJkS2RbI+MPAD5q5UUGMCfD1MOaDpk/BwcYel0mhxBxdLgvbaJtU4K
         aPhOwD+2rQilqiB6HahMxA9Go5Y0C0PCUc665Jaea5B8r5zyyXE8/60zE14NJnR1IWGW
         N3d/QTyQMQdcMv5E4t0TaIZNcxen7S7kDX8Xme+KmaTd92NNX8uXPUGGyQtOeoNVXg8C
         zLVRWEC/+T5kp25WBH/uc/hMILV3npF6dm00W24uJEOaWTI/YrlH/qk0sIyqZ5gOT5Xy
         Y2qw==
X-Gm-Message-State: AOAM530lYBmvJpX4Ng/I/Ph5T3Fv9jNPw9+NKbWYycRXQPDzJ9y1EYGO
        thWohvUefZ59OWyOB9UTqJeEm5uYLu0=
X-Google-Smtp-Source: ABdhPJxHw8qZJ6AwJf9PIcJZi8nMp0egZcEIIttI5pQlfiDUtP1ApEuLxJsQymiL6za9R6fQbN2oBw==
X-Received: by 2002:a17:902:b210:b0:143:789a:7418 with SMTP id t16-20020a170902b21000b00143789a7418mr3641855plr.38.1640289005490;
        Thu, 23 Dec 2021 11:50:05 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id mu2sm6631894pjb.43.2021.12.23.11.50.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 11:50:05 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/4] build: Fix build when sanitizer are enabled
Date:   Thu, 23 Dec 2021 11:50:01 -0800
Message-Id: <20211223195003.1647434-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223195003.1647434-1-luiz.dentz@gmail.com>
References: <20211223195003.1647434-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes various issues found when sanitizers are enabled.
---
 monitor/packet.c         |  3 ++-
 peripheral/main.c        |  2 +-
 profiles/audio/a2dp.c    |  5 ++++-
 profiles/audio/avctp.c   |  2 +-
 profiles/network/bnep.c  |  4 ++--
 src/shared/gatt-server.c |  2 --
 tools/mesh-gatt/util.c   | 11 ++++++++---
 tools/test-runner.c      |  2 +-
 8 files changed, 19 insertions(+), 12 deletions(-)

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
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 9113b5ddc..64d1a8504 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1177,7 +1177,7 @@ static int uinput_create(struct btd_device *device, const char *name,
 	memset(&dev, 0, sizeof(dev));
 
 	if (name) {
-		strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE);
+		strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1);
 		dev.name[UINPUT_MAX_NAME_SIZE - 1] = '\0';
 	}
 
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

