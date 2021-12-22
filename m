Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9A5C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 23:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242162AbhLVXmI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 18:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241962AbhLVXmH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 18:42:07 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978F0C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 15:42:07 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 200so3351556pgg.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 15:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cDHiNrmydCfr5T91Wwz5jua8SYnbjMFMmQ++gdgbbME=;
        b=clpGgErrXDzluJ86U5tQEbXfszMJyJNwPbQ8C3fX3N4DWC6SHbNPp+GRrChdGs7U/f
         X4+gMVNgIdYIPJ0QhysiOFAlV5smFx+01NxYvsPYtZPwQ2LXjFd78gNIQbhJJIRQv/7E
         B1TFAcqF6mPLmKoHNF4Wsx+fkDFuVSfgHwU+PHx0cMsRZoOtI7OqbkKT9IoDkj7VaQn7
         lGsQGhgvFL7K9WOR9sse9nyGU71IN+tEu8JoQBqmnbWBxrUnGdQiO7UatFJsfxtvbVtl
         VaTfp6e/KQBTdYP0b4hBflj++MfzWLiNsXF9bEGj5lUSSHMmgYCrA5L3pVk3RWfp6Z4/
         OwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cDHiNrmydCfr5T91Wwz5jua8SYnbjMFMmQ++gdgbbME=;
        b=CzGjO5s4iRuU6xA3hjcWH8wojo0F5bdatKjb2xwUy1hOG9I2NHOjJoPN0ycaCTM42M
         aTVivXq8IiUuBDOa2e5fFzfYYkvjc12Hcz2qrGvGQKsGkGVExUPCBNEVAKKLziYY6ZQf
         t9bM0zQeA9can7bY2UFMH8gXtvpvydbHWCwaOH9e2jOD4vRZTRHiAAn48ZDemv0178nH
         iJslHV6WqfpVz18HgOjrQBeUSPAU+nwb32g/Zqouu+/zQnKBqXH2V9AoU/MvOqXjJIN1
         GzzM/a7Y52g/jG4jrbyTkeCPjjkzo6sdP9uUK46fx0dt3WAwmpbbCh/bQrKRUf6IzHPv
         Gvzg==
X-Gm-Message-State: AOAM530r7x0zDaInVqTb0FNAQt2c42gC4Uqe94Ss7or1TS+Avwn1xIxG
        jSMTggI0WbUgeFUUR2pEmvnjePNy1+s=
X-Google-Smtp-Source: ABdhPJwQPcsyElhAysps+mYNeEXRHVuh+5L7P4cx4pViRKy2NHnGOS0Q07IVTvsxVxNuzy0drXshWQ==
X-Received: by 2002:a63:a18:: with SMTP id 24mr195pgk.100.1640216526712;
        Wed, 22 Dec 2021 15:42:06 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r10sm3563666pff.120.2021.12.22.15.42.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 15:42:06 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/4] build: Fix build when sanitizer are enabled
Date:   Wed, 22 Dec 2021 15:42:02 -0800
Message-Id: <20211222234204.1455901-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222234204.1455901-1-luiz.dentz@gmail.com>
References: <20211222234204.1455901-1-luiz.dentz@gmail.com>
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
 profiles/network/bnep.c  |  4 ++--
 src/shared/gatt-server.c |  2 --
 tools/mesh-gatt/util.c   | 11 ++++++++---
 tools/test-runner.c      |  2 +-
 7 files changed, 18 insertions(+), 11 deletions(-)

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

