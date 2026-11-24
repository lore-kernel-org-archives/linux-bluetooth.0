Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512532;
	b=ifkRgMaJEavLQa3EB0gxf35F8n5YqaA0YxQ4XnDtBxAk2s7x3aZO/Y9jY2i3hKjz1wd0
	 elhhlkgGnn6f61ELj/P8NdlUTcC8pK7uwupIzX68NsAUj14vw6inoq5kfF09Zwe5c879D
	 Y0QPHP3P7kEiZ4LL3k/BtecUHJaNsv8nwSgeb3T1Ue7THzx6rllIA5ekEw95XUYt/bbqI
	 ZPoHMHn7CmHmTze/LDbeMycDy9DO1G0ccJQ6pooqZe9faCbykXiGlJTXwISsWLIVlA9du
	 BCQAvqTop1iv/BJVBnhbSHFQQ0ovqaftLP2NSktLbpH7/OeMw3JLVFRSM6L3H7Utr0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g7+1Hz8H6Dxc9el5Vh0+kGzx45RhyLUMF157DeLaodo=;
	b=F2XN4afB5ZWhiFNOmG61PZj1lb+vHCJVpN4nhaLFPpL16cC72gM45rHLhtTK9ez+fDVk
	 coYLrbTXZO41x3jKeyuDKQPDMbrlRkbE/KPWCmpttxTWkJq/DUO/X0dERMI+THCjZAHN0
	 eDD7ejSrcRT6BDnbwCx3qJ41hveKX3pliUnwD8MS62ibD8pBdsI37FhdjhQM0eE3f0bsA
	 NEWWFKnOFBW9Tcm2InCuQut1k66aEYf0e6rsd5cdGF3kvzWcEDV1waEIqhRSGRPfulUQd
	 4TQzeQ7pHngHMPHw0yQFVFOlPK5ydqWJz3XN+18exPnhf+xrf3stxT9DLDUI7o0mTWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=EQ4nzYYO;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09106606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 09:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09106606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=EQ4nzYYO
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so36234625e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 01:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795512530; x=1796117330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g7+1Hz8H6Dxc9el5Vh0+kGzx45RhyLUMF157DeLaodo=;
        b=EQ4nzYYOPL+KG41/SC1RHtWsYCTfdJX3B1LoLkSi+NV2i32l568Kd+/9BubXfLQnvR
         Sc6E+3nGSZcNejFemDoq4qkqdRBCLroiv064U3gkvN8lTuyowtHhM7FavX4sxIDPaWNu
         /rSIl/JabrAHYR7EONA0t8fIX9awXgBtRYImY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795512530; x=1796117330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g7+1Hz8H6Dxc9el5Vh0+kGzx45RhyLUMF157DeLaodo=;
        b=IX3RKDKvLSBRZ2qWKhexbnnsoqPs3rB+Tev89VfrVxMs6Lw88pNyFNHWWU64eclLWC
         Ks4Y0X+l0eY34iqKIxcQjRDXJIf+pRypsZ1SxDgoHdbNbJYECmwiouyhHCmMregTmu86
         06LZxcR/kFP6lbiqkJC5VBT7dhlRSXhn2V3Fp3nK0V2UdcLYq8q53LnbMQIZadX2ErnH
         fVZUtMnBorgfjrcH6Kh9Idda784+FAWplj1tDcZXSsssBlRixWjIpy8r7e6n5WfOX8Ok
         UsHhju47MzEDIc0Te7ic2aLSeOjh4xTLpbZDkvq6wXhbm2Jv5Y46kV7KtAnNQ2TxbJ0n
         t+eQ==
X-Gm-Message-State: APuU4Z+0iy9gua9rcN555dIsiqEZ1eWOQFu8EJB1C/U37x9z4QiPO8Ih
	yj7+t/0j8sWDBTQeAw3Y1onU3430uUoYmRrXayhrUbCcdsM3Zhb76i8C+TP7AmoDFEOn02+UIK1
	07039
X-Gm-Gg: AZFdTZf8uHCxCHF1FvAE2t+nTje90FEmjsBd9QmAkn4QGCCxxITv7bXFdLeHz93Xqhl
	dlJgnuvOGtPWi2z+vKZAtBtBxVR04b31hNDlQ1ha6qQar/uvkTBgUHc8aV5lf/lfGz/wSYo+vPi
	hMPNavMeGThBxJT64v5GJoIzmR891oyoGRxjwvs0gRaZaDm4soWnLbqzfXyGNy0ITkUwRpjNU4s
	DeKpiltStzH51pQkeVPhtmwHRCcbboc3VstItXTkLYRfiCyZ+7KHNtb+DaPc1vyKty7ZN1J24WY
	EH1n8/oLKOI1rIk4w7GICQZ6JXa8HCeF4YvTbMGZU3a0UX5NeGs233IoGuP0lhd3hJKpMCXfbjC
	SYTqo2mFvJwms8cuqholD+miLnbPM0l6scMwfIRH9rsqXXDfcRes1cwKE5i8Uwu+gEymbIRIm2E
	/CxqqCINy8XZFIDRgRuElhQ74+BGmfR0OcQkVGVV6hKb0kdPbkYey+yJAeT2IyweApPL5x2HBgw
	eLsa2E5sMv55+rbmvqdvBM+Yg+ii//1dkjSOlFTzKy6yPI3+bvvZlA3NDroqpLw5HyM47OzmJ40
	ZJdc+qwtXM88C/EtLnwfoJrtisJGgTXKzSRND/ZmSTWKn3/elA==
X-Received: by 2002:a05:600c:1389:b0:4af:83ad:8f70 with SMTP id 5b1f17b1804b1-4bb88924f66mr282676195e9.35.1795512524976;
        Tue, 24 Nov 2026 01:28:44 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm27870362f8f.59.2026.11.24.01.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:28:44 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 08/10] avrcp: Fix NumberOfItems set from a reply for another folder
Date: Tue, 24 Nov 2026 10:28:31 +0100
Message-ID: <20261124092833.1191053-8-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
References: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GetTotalNumberOfItems reply does not say which folder it counts, and
the client may change folder or player before it arrives. The reply then
sets NumberOfItems of whichever folder is current by then.

To reproduce, change folder to /Filesystem, to another folder and back
to /Filesystem before the replies arrive: the reply for the other folder
sets NumberOfItems of /Filesystem.

Keep the player and directory path each request was sent for, and drop
the reply when that directory is no longer the player's current folder.

Fixes: f17d3a2c3b0d ("audio/avrcp: Add support for GetTotalNumberOfItems")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c   | 65 +++++++++++++++++++++++++++++++---------
 profiles/audio/player.c  |  6 ++--
 profiles/audio/player.h  |  1 +
 unit/test-media-player.c |  9 ++++--
 4 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index f65d394e8..796ab917e 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -252,6 +252,13 @@ struct avrcp {
 	bool pos_changed_supported;
 	uint8_t transaction;
 	struct pending_pdu *pending_pdu;
+	GSList *total_items_reqs;
+};
+
+struct total_items_req {
+	struct avrcp *session;
+	struct avrcp_player *player;
+	char *dir_path;
 };
 
 struct passthrough_handler {
@@ -3554,50 +3561,66 @@ static int ct_add_to_nowplaying(struct media_player *mp, const char *name,
 	return 0;
 }
 
+static void total_items_req_free(void *data)
+{
+	struct total_items_req *req = data;
+
+	g_free(req->dir_path);
+	g_free(req);
+}
+
 static gboolean avrcp_get_total_numberofitems_rsp(struct avctp *conn,
 					uint8_t *operands, size_t operand_count,
 					void *user_data)
 {
 	struct iovec iov = { operands, operand_count };
-	struct avrcp *session = user_data;
-	struct avrcp_player *player = session->controller->player;
-	struct media_player *mp = player->user_data;
+	struct total_items_req *req = user_data;
+	struct avrcp *session = req->session;
+	struct avrcp_player *player = req->player;
 	uint32_t num_of_items = 0;
 	uint16_t uid_counter;
 	uint8_t status;
 
-	if (operands == NULL)
-		return FALSE;
+	session->total_items_reqs = g_slist_remove(session->total_items_reqs,
+									req);
+
+	if (!operands || !g_slist_find(session->controller->players, player))
+		goto free;
 
 	if (!avrcp_pull_browsing_header(&iov) ||
 			!util_iov_pull_u8(&iov, &status))
-		return FALSE;
+		goto free;
 
 	if (status == AVRCP_STATUS_OUT_OF_BOUNDS)
 		goto done;
 
 	if (status != AVRCP_STATUS_SUCCESS)
-		return FALSE;
+		goto free;
 
 	if (!util_iov_pull_be16(&iov, &uid_counter) ||
 			!util_iov_pull_be32(&iov, &num_of_items))
-		return FALSE;
+		goto free;
 
 	player->uid_counter = uid_counter;
 
 	if (!num_of_items)
-		return FALSE;
+		goto free;
 
 done:
-	media_player_total_items_complete(mp, num_of_items);
+	media_player_total_items_complete(player->user_data, req->dir_path,
+							num_of_items);
+free:
+	total_items_req_free(req);
 	return FALSE;
 }
 
-static void avrcp_get_total_numberofitems(struct avrcp *session)
+static void avrcp_get_total_numberofitems(struct avrcp *session,
+							const char *dir_path)
 {
 	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 1];
 	struct avrcp_player *player = session->controller->player;
 	struct avrcp_browsing_header *pdu = (void *) buf;
+	struct total_items_req *req;
 
 	memset(buf, 0, sizeof(buf));
 
@@ -3606,8 +3629,20 @@ static void avrcp_get_total_numberofitems(struct avrcp *session)
 
 	pdu->params[0] = player->scope;
 
-	avctp_send_browsing_req(session->conn, buf, sizeof(buf),
-				avrcp_get_total_numberofitems_rsp, session);
+	/* The player and its folder may change before the reply */
+	req = g_new0(struct total_items_req, 1);
+	req->session = session;
+	req->player = player;
+	req->dir_path = g_strdup(dir_path);
+
+	if (avctp_send_browsing_req(session->conn, buf, sizeof(buf),
+				avrcp_get_total_numberofitems_rsp, req) < 0) {
+		total_items_req_free(req);
+		return;
+	}
+
+	session->total_items_reqs = g_slist_prepend(session->total_items_reqs,
+									req);
 }
 
 static int ct_get_total_numberofitems(struct media_player *mp, const char *name,
@@ -3631,7 +3666,7 @@ static int ct_get_total_numberofitems(struct media_player *mp, const char *name,
 	else
 		player->scope = 0x01;
 
-	avrcp_get_total_numberofitems(session);
+	avrcp_get_total_numberofitems(session, name);
 
 	return 0;
 }
@@ -4552,6 +4587,8 @@ static void session_destroy(struct avrcp *session, int err)
 	if (session->position_timer > 0)
 		timeout_remove(session->position_timer);
 
+	g_slist_free_full(session->total_items_reqs, total_items_req_free);
+
 	if (session->controller != NULL)
 		controller_destroy(session);
 
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 07f4d4f78..9802e52bb 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -758,11 +758,13 @@ done:
 }
 
 void media_player_total_items_complete(struct media_player *mp,
-							uint32_t num_of_items)
+						const char *dir_path,
+						uint32_t num_of_items)
 {
 	struct media_folder *folder = mp->scope;
 
-	if (folder == NULL)
+	/* The scope may have changed while the request was in flight */
+	if (folder == NULL || g_strcmp0(folder->item->name, dir_path) != 0)
 		return;
 
 	if (folder->number_of_items != num_of_items) {
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index dcd7df286..ee8c40a67 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -108,6 +108,7 @@ void media_player_change_folder_complete(struct media_player *player,
 						int ret);
 void media_player_search_complete(struct media_player *mp, int ret);
 void media_player_total_items_complete(struct media_player *mp,
+						const char *dir_path,
 						uint32_t num_of_items);
 
 void media_player_set_callbacks(struct media_player *mp,
diff --git a/unit/test-media-player.c b/unit/test-media-player.c
index ef2d5dff3..ba10e5175 100644
--- a/unit/test-media-player.c
+++ b/unit/test-media-player.c
@@ -142,10 +142,12 @@ static void number_of_items_reply(DBusPendingCall *call, void *user_data);
 
 static gboolean complete_total_items(gpointer user_data)
 {
+	const char *dir_path = user_data;
+
 	if (context == NULL)
 		return FALSE;
 
-	media_player_total_items_complete(context->mp, TOTAL_ITEMS);
+	media_player_total_items_complete(context->mp, dir_path, TOTAL_ITEMS);
 
 	call_get_number_of_items(&context->pending2, number_of_items_reply);
 
@@ -158,7 +160,7 @@ static int test_search(struct media_player *mp, const char *string,
 	return 0;
 }
 
-static int test_total_items(struct media_player *mp, const char *name,
+static int test_total_items(struct media_player *mp, const char *dir_path,
 							void *user_data)
 {
 	struct context *ctx = user_data;
@@ -166,7 +168,8 @@ static int test_total_items(struct media_player *mp, const char *name,
 	ctx->total_items_calls++;
 
 	if (ctx->check_total_items)
-		g_idle_add(complete_total_items, NULL);
+		g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, complete_total_items,
+						g_strdup(dir_path), g_free);
 
 	return 0;
 }
-- 
2.43.0

