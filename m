Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74FF27466A
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933835; cv=none; b=A56g2P0apzIkyOKfcaRzM0l5dC4LoDBfLeqOvHM6ReE0D1/gIeC6w0n/33G2DNYxXB02Vb7UdfCfqimXiKRq7X9wE6itgiL3Dyx5c0Yqty31H8VFacJZHV4YUCM2gc480dXRmkOLWhmyzon2aaPGEcbcA266Wo5VRjw8Wrh5urQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933835; c=relaxed/simple;
	bh=Fvc62Y9WsKCqPPLIc5i8Ld4l9w5GuB8nZ79v10+7/wU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqxNCWnL+YRkOZwJ5OjCZpT+b1BX8rLosWNNvcbdV/6rtf968M5QberW47AocbF6E9WoWG2hBZgtAWKSnjs+BUspEJxueG3h6bRqx/UgESD1ANWK8H4JTjjRlRMV3D9QkzRA5NxeyeabKSRZGCmLd50OO5HOOK7tQ1sxrCe4SP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s9jhd9Dy; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9jhd9Dy"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-746d77537f8so772280137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787933832; x=1788538632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NUNeyToNadW0LkJqykJmQ36PYWBT3RVE1yTIONt1Rwc=;
        b=s9jhd9Dyl+HN28yLCc8oytdLl4xi/YovRUhlcpaLy5LqWnToKmVxg8OgXk/FwI5/Jk
         TeK7JRXlRue5dm9YY0Z5ROd6l0kyd5PSt0ioq03MZycsr3u3MH5rSsoOmtBsXot/1l8d
         o+EuTNz5e01ahqPoAH7n6Pb2+mwec/meBG99J8PBlsxDGX+9cBDj6MicQWud4hxxhW4G
         L0J5eqGU+rA79yKqoVmnr/7nDvrus2SXeh+cL/qqo8D1LGk/LzrSqops8F0ej1P5T6Kb
         Y8alQS6w0PVAR3SIyZQN0RssrrtLu6FuXye6ofIEawRx/uR07GEM2eILIvAcdsxTf79T
         NEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787933832; x=1788538632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NUNeyToNadW0LkJqykJmQ36PYWBT3RVE1yTIONt1Rwc=;
        b=CYk+4ZaXRfHDcIEgUebzym2Ni69xhyjIQ0+AksKBZeRwO07Qw+S5XTGce8xM9vae0Q
         4dqGfaMyQYik9z9GsUPH0r/F2iC+2ERBvkT0R0qSq3cfl8n2rFVVFJW2e7GmDPTt0Rm5
         CMOFrjrrMT7aoQYPtEDZ2647uMkf542b6pqz1Q0xxkhHsIcdr+0S8QhtQNRAlJjGDm1M
         G3VHZ2fzeZ9cv1FulLuCLUzsBqaz1YUsptmBzropX9GgEbgrmc4VppoBerWCpjNYhIxi
         xKnHq4oLizkEw0GM+ZWHAm/cKg4+ueS3TaHBUGZ+QrBuvPNnYFo3PARVB0fPGzAlgoOD
         XFZA==
X-Gm-Message-State: AFuF++nmlMTnX31DmHOj4WERPmLAgUae0WcOxWmwIvrEnaY4NQnC3eaq
	bLF71PPxbYMtUVR2I89EYqEd7CUS4bkbza4SxymB3qais9g6pMNqqO/hMOg/Y5jZ++c=
X-Gm-Gg: AR+sD12AkEiWs5KyqLiXW0ago0Hb06m1STgy10y39myOS39z/sD/VFuf8VJ8mKRkMcb
	I/wXk/5/u71S3CO6pMbsQ9vYzZuerWECTeAkSu689/4F1FXvjxIkDUlwBzPCNHVFzpgQdAKAO+O
	0yMpSqwW1LCi+7DefSNjFbakMfUBfk75fQcAr/leOycUkx5uq/BFjpRRikh2hL6UkWfSxC71+yi
	vzTZXhK45t11fp3uHi/h0jObQC1gDXmihtoqguh9e7d7hcRYwpFEGIPfSY+OaGmpehpyE/6N5nK
	r5kSTdUWzFV7gWmXTgBM/MySIH28dzrBjpJhFuhmDDVLufQRq9TsNOtAK0+JMP6AjMrIoqX4nbi
	KP2qboS3lbRPDMeSpP2EdL+N2Hx5zktV4Rc81RwwWThDzqsj0pjwVNO1+gXhlilgHbLcctM7Tbj
	3fIa4qUigzeuUprUFK81/lpD1zg2sHPdObTZs1v7uJbsk17Fkq/jOBnMj0BkXYln4sLBORAKja4
	X+PVfZ617dYk3X/sKJhmqkkKrrq7bPbDE/emJ01wikW6IZM4ulpnDU=
X-Received: by 2002:a05:6102:374d:b0:778:4fe0:8297 with SMTP id ada2fe7eead31-7859956f84dmr3011942137.11.1787933832125;
        Fri, 28 Aug 2026 09:17:12 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-785f532aa2fsm1431750137.2.2026.08.28.09.17.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 09:17:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] avrcp: Fix out-of-bounds read parsing attribute lists
Date: Fri, 28 Aug 2026 12:17:01 -0400
Message-ID: <20260828161702.519421-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828161702.519421-1-luiz.dentz@gmail.com>
References: <20260828161702.519421-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

avrcp_parse_attribute_list() received only a pointer and an attribute
count, with no indication of how many bytes were actually available. For
each attribute it read an 8 byte header followed by a 16 bit length and
that many bytes of value, none of which was bounds checked.

The callers only validated the fixed portion of each entry:

    if (be16_to_cpu(pdu->params_len) - 1 < count * 8)

which says nothing about the variable length values that follow, so a
response declaring a single attribute with a value length of 0xFFFF
would read far past the end of the receive buffer and pass the result to
media_player_set_metadata().

These are response callbacks, so they do not go through
handle_vendordep_pdu() and params_len had itself never been checked
against the number of bytes received. avrcp_get_element_attributes_rsp()
also cast the operands to an AVRCP header without checking that a full
header was present.

parse_media_element() had a related off-by-one, reading the attribute
count at operands[13 + namesize] when parse_media_name() only
guaranteed that 13 + namesize bytes were present.

Parse all of this through a struct iovec using the util_iov_pull_*
helpers so the remaining length is tracked as each field is consumed,
and validate params_len against the bytes actually received.
---
 profiles/audio/avrcp.c | 134 +++++++++++++++++++++++------------------
 1 file changed, 77 insertions(+), 57 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 906f93424872..f9d0841ef2d5 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2462,34 +2462,31 @@ static void avrcp_list_player_attributes(struct avrcp *session)
 
 static void avrcp_parse_attribute_list(struct avrcp_player *player,
 					struct media_item *item,
-					uint8_t *operands, uint8_t count)
+					struct iovec *iov, uint8_t count)
 {
 	struct media_player *mp = player->user_data;
-	int i;
 
-	for (i = 0; count > 0; count--) {
+	for (; count > 0; count--) {
 		uint32_t id;
 		uint16_t charset, len;
+		uint8_t *value;
 
-		id = get_be32(&operands[i]);
-		i += sizeof(uint32_t);
+		if (!util_iov_pull_be32(iov, &id) ||
+				!util_iov_pull_be16(iov, &charset) ||
+				!util_iov_pull_be16(iov, &len))
+			return;
 
-		charset = get_be16(&operands[i]);
-		i += sizeof(uint16_t);
-
-		len = get_be16(&operands[i]);
-		i += sizeof(uint16_t);
+		value = util_iov_pull_mem(iov, len);
+		if (!value)
+			return;
 
 		if (charset == 106) {
 			const char *key = metadata_to_str(id);
 
 			if (key != NULL)
-				media_player_set_metadata(mp, item,
-							metadata_to_str(id),
-							&operands[i], len);
+				media_player_set_metadata(mp, item, key,
+								value, len);
 		}
-
-		i += len;
 	}
 }
 
@@ -2520,7 +2517,8 @@ static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
 {
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->controller->player;
-	struct avrcp_header *pdu = (void *) operands;
+	struct iovec iov = { operands, operand_count };
+	struct avrcp_header *pdu;
 	struct media_player *mp = player->user_data;
 	struct media_item *item;
 	uint8_t count;
@@ -2528,6 +2526,12 @@ static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
 	if (code == AVC_CTYPE_REJECTED)
 		return FALSE;
 
+	pdu = util_iov_pull_mem(&iov, sizeof(*pdu));
+	if (!pdu) {
+		error("Invalid AVRCP header");
+		return FALSE;
+	}
+
 	/* Abort fragmented responses as reassembly is not supported */
 	if (pdu->packet_type == AVRCP_PACKET_TYPE_START ||
 			pdu->packet_type == AVRCP_PACKET_TYPE_CONTINUING) {
@@ -2535,18 +2539,19 @@ static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
 		return FALSE;
 	}
 
-	count = pdu->params[0];
-
-	if (be16_to_cpu(pdu->params_len) - 1 < count * 8) {
+	if (be16_to_cpu(pdu->params_len) != iov.iov_len) {
 		error("Invalid parameters");
 		return FALSE;
 	}
 
+	if (!util_iov_pull_u8(&iov, &count))
+		return FALSE;
+
 	media_player_clear_metadata(mp);
 
 	item = media_player_set_playlist_item(mp, player->uid);
 
-	avrcp_parse_attribute_list(player, item, &pdu->params[1], count);
+	avrcp_parse_attribute_list(player, item, &iov, count);
 
 	media_player_metadata_changed(mp);
 
@@ -2628,46 +2633,46 @@ static const char *subtype_to_string(uint32_t subtype)
 	return "None";
 }
 
-static gboolean parse_media_name(uint8_t *operands, uint16_t len,
-				size_t name_len_offset,
-				char *name, uint16_t *namelen)
+static gboolean parse_media_name(struct iovec *iov, char *name)
 {
-	uint16_t namesize;
+	uint16_t namelen;
+	uint8_t *namebuf;
 
-	if (len < name_len_offset + 2)
+	if (!util_iov_pull_be16(iov, &namelen))
 		return FALSE;
 
+	namebuf = util_iov_pull_mem(iov, namelen);
+	if (!namebuf)
+		return FALSE;
+
+	namelen = MIN(namelen, NAME_MAX_LEN - 1);
+
 	memset(name, 0, NAME_MAX_LEN);
-	namesize = MIN(get_be16(&operands[name_len_offset]),
-			len - name_len_offset - 2);
-	namesize = MIN(namesize, NAME_MAX_LEN - 1);
-	if (namesize > 0) {
-		if (len < name_len_offset + 2 + namesize)
-			return FALSE;
-		memcpy(name, &operands[name_len_offset + 2], namesize);
-		strtoutf8(name, namesize);
-	}
-	if (namelen)
-		*namelen = namesize;
+	memcpy(name, namebuf, namelen);
+	strtoutf8(name, namelen);
+
 	return TRUE;
 }
 
 static struct media_item *parse_media_element(struct avrcp *session,
-					uint8_t *operands, uint16_t len)
+							struct iovec *iov)
 {
 	struct avrcp_player *player;
 	struct media_player *mp;
 	struct media_item *item;
-	uint16_t namesize;
 	char name[NAME_MAX_LEN];
 	uint64_t uid;
 	uint8_t count;
 
-	if (!parse_media_name(operands, len, 11, name, &namesize))
+	/* Skip the media type and character set */
+	if (!util_iov_pull_be64(iov, &uid) || !util_iov_pull(iov, 3))
 		return NULL;
 
-	uid = get_be64(&operands[0]);
-	count = operands[13 + namesize];
+	if (!parse_media_name(iov, name))
+		return NULL;
+
+	if (!util_iov_pull_u8(iov, &count))
+		return NULL;
 
 	player = session->controller->player;
 	mp = player->user_data;
@@ -2678,14 +2683,13 @@ static struct media_item *parse_media_element(struct avrcp *session,
 
 	media_item_set_playable(item, true);
 
-	avrcp_parse_attribute_list(player, item, &operands[14 + namesize],
-					count);
+	avrcp_parse_attribute_list(player, item, iov, count);
 
 	return item;
 }
 
 static struct media_item *parse_media_folder(struct avrcp *session,
-					uint8_t *operands, uint16_t len)
+							struct iovec *iov)
 {
 	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
@@ -2695,12 +2699,15 @@ static struct media_item *parse_media_folder(struct avrcp *session,
 	uint8_t type;
 	uint8_t playable;
 
-	if (!parse_media_name(operands, len, 12, name, NULL))
+	/* Skip the character set */
+	if (!util_iov_pull_be64(iov, &uid) ||
+			!util_iov_pull_u8(iov, &type) ||
+			!util_iov_pull_u8(iov, &playable) ||
+			!util_iov_pull(iov, 2))
 		return NULL;
 
-	uid = get_be64(&operands[0]);
-	type = operands[8];
-	playable = operands[9];
+	if (!parse_media_name(iov, name))
+		return NULL;
 
 	item = media_player_create_folder(mp, name, type, uid);
 	if (!item)
@@ -2755,6 +2762,7 @@ static gboolean avrcp_list_items_rsp(struct avctp *conn, uint8_t *operands,
 
 	for (i = 8; count && i + 3 < operand_count; count--) {
 		struct media_item *item;
+		struct iovec iov;
 		uint8_t type;
 		uint16_t len;
 
@@ -2772,10 +2780,13 @@ static gboolean avrcp_list_items_rsp(struct avctp *conn, uint8_t *operands,
 			break;
 		}
 
+		iov.iov_base = &operands[i];
+		iov.iov_len = len;
+
 		if (type == 0x03)
-			item = parse_media_element(session, &operands[i], len);
+			item = parse_media_element(session, &iov);
 		else
-			item = parse_media_folder(session, &operands[i], len);
+			item = parse_media_folder(session, &iov);
 
 		if (item) {
 			p->items = g_slist_append(p->items, item);
@@ -2959,33 +2970,42 @@ static gboolean avrcp_get_item_attributes_rsp(struct avctp *conn,
 {
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->controller->player;
-	struct avrcp_browsing_header *pdu = (void *) operands;
+	struct iovec iov = { operands, operand_count };
+	struct avrcp_browsing_header *pdu;
 	struct media_player *mp = player->user_data;
 	struct media_item *item;
-	uint8_t count;
+	uint8_t status, count;
 
-	if (pdu == NULL) {
+	if (operands == NULL) {
 		avrcp_get_element_attributes(session);
 		return FALSE;
 	}
 
-	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 4) {
+	pdu = util_iov_pull_mem(&iov, sizeof(*pdu));
+	if (!pdu) {
 		avrcp_get_element_attributes(session);
 		return FALSE;
 	}
 
-	count = pdu->params[1];
+	if (!util_iov_pull_u8(&iov, &status) ||
+					status != AVRCP_STATUS_SUCCESS) {
+		avrcp_get_element_attributes(session);
+		return FALSE;
+	}
 
-	if (be16_to_cpu(pdu->param_len) - 1 < count * 8) {
+	if (be16_to_cpu(pdu->param_len) != operand_count - sizeof(*pdu)) {
 		error("Invalid parameters");
 		return FALSE;
 	}
 
+	if (!util_iov_pull_u8(&iov, &count))
+		return FALSE;
+
 	media_player_clear_metadata(mp);
 
 	item = media_player_set_playlist_item(mp, player->uid);
 
-	avrcp_parse_attribute_list(player, item, &pdu->params[2], count);
+	avrcp_parse_attribute_list(player, item, &iov, count);
 
 	media_player_metadata_changed(mp);
 
-- 
2.54.0

