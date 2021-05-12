Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0389C43460
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 17:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E0A61166
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 17:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbhELR5Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 13:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349175AbhELRkR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 13:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620841148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1KAfXKElgHhT36l1+i02i+FIJspBADobSGjGdhm6lak=;
        b=Y8dNLZGOQ8PTFilikAwFyei6ZOyR/4hAqWaaGRyLXL3rHu2pu50dBTxF1bDHKkPRaLNfkg
        /KCdOVWZPndapDVYmjFue2qNIBb7i6X08ql28laRbKkqX12l2jwrIbWgC9gxMuhkXOHADr
        /YSmvk8ZtZZIn900A1KeSYhU87ctTwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-_8z0oPj4NBOKITDdCkp19A-1; Wed, 12 May 2021 13:39:07 -0400
X-MC-Unique: _8z0oPj4NBOKITDdCkp19A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 421961007467
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 17:39:06 +0000 (UTC)
Received: from ivy-bridge (ovpn-114-125.rdu2.redhat.com [10.10.114.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1CF560CE6
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 17:39:05 +0000 (UTC)
Date:   Wed, 12 May 2021 13:39:32 -0400
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] Fix various memory leaks
Message-ID: <20210512133932.4e2b4bd0@ivy-bridge>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I was checking the code via static analysis and found a number of
leaks throughout the code. This patch should address most of what
was discovered.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
---
 mesh/rpl.c                     |  4 +++-
 obexd/plugins/filesystem.c     |  2 +-
 obexd/plugins/ftp.c            |  8 ++++++--
 obexd/plugins/messages-dummy.c |  1 +
 plugins/hostname.c             |  3 +--
 profiles/audio/avrcp.c         |  4 +++-
 src/main.c                     |  1 +
 src/shared/shell.c             |  1 +
 tools/mesh-cfgclient.c         |  2 +-
 tools/mesh-gatt/gatt.c         |  1 +
 tools/mesh-gatt/node.c         | 12 +++++++++---
 11 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/mesh/rpl.c b/mesh/rpl.c
index ac0f6b6f2..c53c6fbfd 100644
--- a/mesh/rpl.c
+++ b/mesh/rpl.c
@@ -143,8 +143,10 @@ static void get_entries(const char *iv_path, struct l_queue *rpl_list)
 		return;
 
 	iv_txt = basename(iv_path);
-	if (sscanf(iv_txt, "%08x", &iv_index) != 1)
+	if (sscanf(iv_txt, "%08x", &iv_index) != 1) {
+		closedir(dir);
 		return;
+	}
 
 	memset(seq_txt, 0, sizeof(seq_txt));
 
diff --git a/obexd/plugins/filesystem.c b/obexd/plugins/filesystem.c
index 09bff8ad0..44e3cf3d2 100644
--- a/obexd/plugins/filesystem.c
+++ b/obexd/plugins/filesystem.c
@@ -415,7 +415,7 @@ static void *capability_open(const char *name, int oflag, mode_t mode,
 			goto fail;
 		}
 
-		object->buffer = g_string_new(buf);
+		object->buffer = buf;
 
 		if (size)
 			*size = object->buffer->len;
diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
index 259bfcae2..4b04bab06 100644
--- a/obexd/plugins/ftp.c
+++ b/obexd/plugins/ftp.c
@@ -386,8 +386,10 @@ static int ftp_copy(struct ftp_session *ftp, const char *name,
 	ret = verify_path(destdir);
 	g_free(destdir);
 
-	if (ret < 0)
+	if (ret < 0) {
+		g_free(destination);
 		return ret;
+	}
 
 	source = g_build_filename(ftp->folder, name, NULL);
 
@@ -424,8 +426,10 @@ static int ftp_move(struct ftp_session *ftp, const char *name,
 	ret = verify_path(destdir);
 	g_free(destdir);
 
-	if (ret < 0)
+	if (ret < 0) {
+		g_free(destination);
 		return ret;
+	}
 
 	source = g_build_filename(ftp->folder, name, NULL);
 
diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
index 34199fa05..e37b52df6 100644
--- a/obexd/plugins/messages-dummy.c
+++ b/obexd/plugins/messages-dummy.c
@@ -488,6 +488,7 @@ int messages_get_messages_listing(void *session, const char *name,
 			int err = -errno;
 			DBG("fopen(): %d, %s", -err, strerror(-err));
 			g_free(path);
+			g_free(mld);
 			return -EBADR;
 		}
 	}
diff --git a/plugins/hostname.c b/plugins/hostname.c
index f7ab9e8bc..1a9513adb 100644
--- a/plugins/hostname.c
+++ b/plugins/hostname.c
@@ -213,11 +213,10 @@ static void read_dmi_fallback(void)
 		return;
 
 	type = atoi(contents);
+	g_free(contents);
 	if (type < 0 || type > 0x1D)
 		return;
 
-	g_free(contents);
-
 	/* from systemd hostname chassis list */
 	switch (type) {
 	case 0x3:
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index c6a342ee3..58d30b24d 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3508,8 +3508,10 @@ static struct avrcp_player *create_ct_player(struct avrcp *session,
 	path = device_get_path(session->dev);
 
 	mp = media_player_controller_create(path, id);
-	if (mp == NULL)
+	if (mp == NULL) {
+		g_free(player);
 		return NULL;
+	}
 
 	media_player_set_callbacks(mp, &ct_cbs, player);
 	player->user_data = mp;
diff --git a/src/main.c b/src/main.c
index c32bda7d4..94141b1e4 100644
--- a/src/main.c
+++ b/src/main.c
@@ -795,6 +795,7 @@ static void parse_config(GKeyFile *config)
 
 	parse_br_config(config);
 	parse_le_config(config);
+	g_free(str);
 }
 
 static void init_defaults(void)
diff --git a/src/shared/shell.c b/src/shared/shell.c
index c0de1640d..f05fb2820 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -611,6 +611,7 @@ void bt_shell_prompt_input(const char *label, const char *msg,
 		prompt->user_data = user_data;
 
 		queue_push_tail(data.prompts, prompt);
+		g_free(str);
 
 		return;
 	}
diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 1eeed2a1a..49069674f 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -914,7 +914,7 @@ static void cmd_import_node(int argc, char *argv[])
 
 	/* Number of elements */
 	if (sscanf(argv[4], "%u", &req->arg3) != 1)
-		return;
+		goto fail;
 
 	/* DevKey */
 	req->data2 = l_util_from_hexstring(argv[5], &sz);
diff --git a/tools/mesh-gatt/gatt.c b/tools/mesh-gatt/gatt.c
index b99234f91..c8a8123fb 100644
--- a/tools/mesh-gatt/gatt.c
+++ b/tools/mesh-gatt/gatt.c
@@ -525,6 +525,7 @@ bool mesh_gatt_notify(GDBusProxy *proxy, bool enable, GDBusReturnFunction cb,
 			notify_io_destroy();
 			if (cb)
 				cb(NULL, user_data);
+			g_free(data);
 			return true;
 		} else {
 			method = "StopNotify";
diff --git a/tools/mesh-gatt/node.c b/tools/mesh-gatt/node.c
index 6afda3387..356e1cd1a 100644
--- a/tools/mesh-gatt/node.c
+++ b/tools/mesh-gatt/node.c
@@ -396,8 +396,10 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data, uint16_t len)
 		uint16_t vendor_id;
 		struct mesh_element *ele;
 		ele = g_malloc0(sizeof(struct mesh_element));
-		if (!ele)
+		if (!ele) {
+			g_free(comp);
 			return false;
+		}
 
 		ele->index = i;
 		ele->loc = get_le16(data);
@@ -412,8 +414,10 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data, uint16_t len)
 			mod_id = get_le16(data);
 			/* initialize uppper 16 bits to 0xffff for SIG models */
 			mod_id |= 0xffff0000;
-			if (!node_set_model(node, ele->index, mod_id))
+			if (!node_set_model(node, ele->index, mod_id)) {
+				g_free(comp);
 				return false;
+			}
 			data += 2;
 			len -= 2;
 		}
@@ -421,8 +425,10 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data, uint16_t len)
 			mod_id = get_le16(data + 2);
 			vendor_id = get_le16(data);
 			mod_id |= (vendor_id << 16);
-			if (!node_set_model(node, ele->index, mod_id))
+			if (!node_set_model(node, ele->index, mod_id)) {
+				g_free(comp);
 				return false;
+			}
 			data += 4;
 			len -= 4;
 		}
-- 
2.31.1

