Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042E0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Dec 2021 23:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhLTX71 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Dec 2021 18:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhLTX71 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Dec 2021 18:59:27 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056DFC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Dec 2021 15:59:27 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso808315pji.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Dec 2021 15:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=k/fLV8CdKPgoCUJvtnrsdnTjxc7GBN/97gHtX7BSUH4=;
        b=NSSOamfNhApbDwl2QLC2tf7quoim6VdeBTr2YLDcP6LO8ObD9j0EKxzrWiGDhcw4my
         K9tqDQitFZEZ4UTp6dh7BsCHWhS/DaqVG2CRAtVEpeFnpnWUq6KArIVrzAYUwaTYjLfc
         T7Y7dUjBIf19FwSECQ3Evnsg5DtgYjyJ7nsH7qH/6yFI5Q84Yu5Nz7QVQQ/dt4NWoLbW
         dFhC+O0kz2lwqVo3ZCKo4SUyVMKkYvWHMsj6v/Zn+rEjD1xTNnA5q8x4EK+sNjEMbqiy
         cI00aOtzhBB0J77nXS5CFy0i/Z28Qmw6Ku8E/JyoAF8+XdVgc0ovnK0mzJBmWaNSibf1
         77Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/fLV8CdKPgoCUJvtnrsdnTjxc7GBN/97gHtX7BSUH4=;
        b=5bY2mLaB5TmnFqDZv7HGAjlhwxbhfD3wM7E46t5mK4iXckoW1K5rFZrtXhFsUOfdJg
         q1UJjnWdgDPF6NHj1VKZLU8wiDmfjR+t6THl7ImLYhXGStNAf3JSPUpiRFOTluioQxXA
         krEMzA+Y7G2LHP6KkFzAxVu5WQaGabxWvILKO0pUcJ4W/tPtYsEqeB2mt/cfqbVvF5Rd
         +62YTW6M59cX9DWwGs2uyaSfVrFkQP2JtgZ9zQg/K9OMG2FU0tVtBJ13dIqJmhQWU2KX
         73XsLfKJxTgivVTQaCJ8ZqhRF+nYRDT4YE9XLQw0s4k+n76MmM2iDEn43r7DioZLQ/pd
         TT5A==
X-Gm-Message-State: AOAM531Ch/LF51V1eXIiVNF+Jim35DUKnMDVATWf1mvLAi0jCK16zlEg
        tavATSzdS6+olUFttFpdK6Kq9pLdaxc=
X-Google-Smtp-Source: ABdhPJwvBXiupRoQW5OJnv0rCf/BUQaf4uAASl1gwdwergaAOxbnrP9ayH5RNbaJIuq4ehJEfLq3Sw==
X-Received: by 2002:a17:902:8a94:b0:149:218c:b0f9 with SMTP id p20-20020a1709028a9400b00149218cb0f9mr552450plo.37.1640044766216;
        Mon, 20 Dec 2021 15:59:26 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x9sm447263pjp.48.2021.12.20.15.59.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 15:59:25 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] build: Fix build when sanitizer are enabled
Date:   Mon, 20 Dec 2021 15:59:23 -0800
Message-Id: <20211220235924.349373-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211220235924.349373-1-luiz.dentz@gmail.com>
References: <20211220235924.349373-1-luiz.dentz@gmail.com>
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
 profiles/network/bnep.c  |  2 +-
 src/shared/gatt-server.c |  2 --
 tools/mesh-gatt/util.c   | 11 ++++++++---
 tools/test-runner.c      |  2 +-
 7 files changed, 17 insertions(+), 10 deletions(-)

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
index f94f1da8a..ba0edb42c 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
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

