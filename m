Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2081748F824
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285211; cv=none; b=WL2+ijm4mNlyUtUxZ7L4LV1Y2V05nJyDQinZAu8rTqix/mYcmiM6tSbMq2uvO90nPLhs7uVDZazO01n8hg56i752Hk+DS+Lr+XpVbTqcu9FlUzOQ8NB934t7mdzQGTwjmf/P9MDSRHqLhTUcF+MYPKkJHJMlIKJkAz53oHjuC7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285211; c=relaxed/simple;
	bh=xhKG5kfILqqIblKIClGBCcjzVoL8DkL3BfICKBHwDFo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNkIfOs6NtwG/o3x05jlTVkA57NZhBdHkNQ4soQBU0LnDr86JuyE5seM+HK3UhzxhHvfhS/975UWaMXuk55cScjrURi/fS7qXl7ctTVAh9DODX3j4zwFNbh4mAZ1B1Pmgb4x35vyfa9PVuuReJT2zkQx6E9vGVvEmINZyFOm+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsRAjgxc; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsRAjgxc"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bfa6766cf6so115868e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788285208; x=1788890008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4Gyf653BbXeFlJzvSXIOGn0SSetT4VhMkDfH+lUfnys=;
        b=NsRAjgxclQBR/YXl6wk1vmYbVEglpZb2P9BN70zc9+tzkiY1O4DRiOZVs+wI1lV627
         tuzJ1hjL1VzW3pzuposLNCKwrY7/GrtXWrk4YwF+BUme1Pio6zzk/coAakfUUO+B5snO
         FZVcTJLfRbLt+/ZaeFf85mG8Y/UZdC/5/KjJ96MYvkA+q9nkmPEBepyDDssIS/9uXggA
         sQ+d1c+DtgnI6iqqPK3ntUnewGYDrEmdIH31cSa/dXdRvbKTBmRnETABZUpsz3ry+PNN
         GcXYFPySVW77nrT912sQ2OmmXKTTYTEVy2+IrV4adDpVgcgd9VBUZtR6mDsDigEREvks
         R0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788285208; x=1788890008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4Gyf653BbXeFlJzvSXIOGn0SSetT4VhMkDfH+lUfnys=;
        b=q2UpbGlvkEwYLaFEt05u0CPlJr3gh4Kxbfa8Rc20hngcvPLYbC/b0ckolT5tB0qeVF
         jfumBZujKHfyKjynK8fTLgObrwZ6QNqaY6v+wDCGYUyNkT8+YbG1FoZwcbtniVwVFKfW
         Ls2aJa8rtABRC/wmWkI2EenJYV2RM8tGdgOacLUiQG9R+QreMZi/ixh3IgG5GEPPwZxA
         dnfyIYN+UzSUu2OFscEFzZHP3thcYhsvKfF6KJx9JjPSiBz1c5GEhRsP3dwh+3GZlRYx
         gTBZjFXbyO3HR3rzXxuXSUMyJ9Re35wR6A4pIaxo6s/OXzbJbbAfxWtx9NDYzVuuuW0X
         GSMg==
X-Gm-Message-State: AFuF++l9s0VTQ4OvV9pL9BFuIbzV5lc1r+OOpL596rtNCjHZcuOLdMyD
	Tp1aXKa9wPlc5q9ygzySvsSuQbONrxbVfqgFt6af9XOM02RDcdLmgauk7Qj8hNBN
X-Gm-Gg: AR+sD12/ZSOK30uwX9viAVLhRm9X9nfOKTgr0OsbkJFbXEEWqkOEsOjtEtpgct/KdBz
	oUqlKCD+Hny2C8y+KTZk2wuzLkp5cFWoOt0wp1G6IuRWRtGAmAp3BNdncPLhBU6KnBmjnFzmXq9
	xxoJ8DLXKPmr0MoeRE7nCyks32OHHnv8NIteaUesjO5+H6+YSbJZSZjSLmzguFa/ftXPz3HJzbr
	1Zqfes/OGL+u+ID+yrzxfRNzFO7dXKxSKQygpG8bUh9SqZ3PGe6ynRCqXUTOl22hzIQMRpK/mfy
	Q4mjvw1IN3dsBRPIbwTqtRVC/d19HPrKO0iZRF5Di88MNixpA6yIBH7isJvdYsCL3OS5nAm93GV
	XRYrkKoUgerXCaPpOpTAUphoGb84+AuBWCgYtYt/sJXbD86m58UIacFFFKellFAYy7+Achl+fqe
	3rLsCkbTJxICsUTqoAVr/ffsJ+t4NEy/9FPPe2rzGqRqKWMukeh7CJ9lBE8WV81ywS0pYXbgpsY
	aAGWG47QFWofEeztdESWaAVhCQbw9KNDlkvKuMczNB6jR7ZRKhGrPM=
X-Received: by 2002:a05:6122:32d6:b0:5c6:6da6:7ce with SMTP id 71dfb90a1353d-5c7cf34eef3mr73304e0c.3.1788285207740;
        Tue, 01 Sep 2026 10:53:27 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7cd94646csm254265e0c.18.2026.09.01.10.53.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 10:53:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/5] avrcp: Use util_iov helpers to parse responses
Date: Tue,  1 Sep 2026 13:53:13 -0400
Message-ID: <20260901175315.1348621-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901175315.1348621-1-luiz.dentz@gmail.com>
References: <20260901175315.1348621-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Every controller side response callback parsed the PDU with hand
computed offsets into the operands buffer. None of them validated the
declared parameters length against the number of bytes actually
received: unlike commands, responses do not go through
handle_vendordep_pdu(), so nothing did it on their behalf. Several read
past the end of the receive buffer as a result, for example:

- avrcp_get_capabilities_resp() read pdu->params[1 + count] for a count
  taken from the response itself, with no length check at all, and then
  shifted by the resulting event id without bounding it.

- avrcp_player_value_rsp() bounded its loop with

      if (pdu->params_len < count * 2)

  comparing a big endian field without byte swapping it, so on little
  endian the check passes for practically any value.

- avrcp_get_play_status_rsp() only checked params_len, which is supplied
  by the peer, and read nine bytes on the strength of it.

- avrcp_set_browsed_player_rsp() indexed folder names relative to
  pdu->params but bounded them against operand_count, which also spans
  the browsing header.

Add avrcp_pull_header() and avrcp_pull_browsing_header(), which pull the
respective header out of a struct iovec and check that the length it
declares matches what was received, and convert the response callbacks
to pull their fields with the util_iov helpers so the remaining length
is tracked as it is consumed.

Since the receive buffer is reused between packets, the bytes read past
the end of a short response were the contents of an earlier PDU, some of
which were then reported over D-Bus or echoed back to the peer.
---
 profiles/audio/avrcp.c | 329 ++++++++++++++++++++++++++---------------
 1 file changed, 207 insertions(+), 122 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index f9d0841ef2d5..aff3b5ce21a2 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2260,6 +2260,52 @@ static const char *status_to_string(uint8_t status)
 	}
 }
 
+/*
+ * Pull the AVRCP header out of iov and validate that the parameters length
+ * it declares matches the number of bytes actually received, leaving iov
+ * pointing at the parameters.
+ */
+static struct avrcp_header *avrcp_pull_header(struct iovec *iov)
+{
+	struct avrcp_header *pdu;
+
+	pdu = util_iov_pull_mem(iov, sizeof(*pdu));
+	if (!pdu) {
+		error("Invalid AVRCP header");
+		return NULL;
+	}
+
+	if (be16_to_cpu(pdu->params_len) != iov->iov_len) {
+		error("Invalid parameters");
+		return NULL;
+	}
+
+	return pdu;
+}
+
+/*
+ * Same as avrcp_pull_header() but for the browsing channel, which uses a
+ * different header layout.
+ */
+static struct avrcp_browsing_header *avrcp_pull_browsing_header(
+							struct iovec *iov)
+{
+	struct avrcp_browsing_header *pdu;
+
+	pdu = util_iov_pull_mem(iov, sizeof(*pdu));
+	if (!pdu) {
+		error("Invalid AVRCP browsing header");
+		return NULL;
+	}
+
+	if (be16_to_cpu(pdu->param_len) != iov->iov_len) {
+		error("Invalid parameters");
+		return NULL;
+	}
+
+	return pdu;
+}
+
 static gboolean avrcp_get_play_status_rsp(struct avctp *conn, uint8_t code,
 					uint8_t subunit, uint8_t transaction,
 					uint8_t *operands, size_t operand_count,
@@ -2268,22 +2314,24 @@ static gboolean avrcp_get_play_status_rsp(struct avctp *conn, uint8_t code,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
-	struct avrcp_header *pdu = (void *) operands;
+	struct iovec iov = { operands, operand_count };
 	uint32_t duration;
 	uint32_t position;
 	uint8_t status;
 
-	if (pdu == NULL || code == AVC_CTYPE_REJECTED ||
-					be16_to_cpu(pdu->params_len) != 9)
+	if (operands == NULL || code == AVC_CTYPE_REJECTED)
+		return FALSE;
+
+	if (!avrcp_pull_header(&iov))
+		return FALSE;
+
+	if (!util_iov_pull_be32(&iov, &duration) ||
+			!util_iov_pull_be32(&iov, &position) ||
+			!util_iov_pull_u8(&iov, &status))
 		return FALSE;
 
-	duration = get_be32(pdu->params);
 	media_player_set_duration(mp, duration);
-
-	position = get_be32(pdu->params + 4);
 	media_player_set_position(mp, position);
-
-	status = get_u8(pdu->params + 8);
 	media_player_set_status(mp, status_to_string(status));
 
 	return FALSE;
@@ -2330,35 +2378,41 @@ static gboolean avrcp_player_value_rsp(struct avctp *conn, uint8_t code,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
-	struct avrcp_header *pdu = (void *) operands;
-	uint8_t count;
-	int i;
+	struct iovec iov = { operands, operand_count };
+	uint8_t count, status;
 
-	if (pdu == NULL) {
+	if (operands == NULL) {
 		media_player_set_setting(mp, "Error", "Timeout");
 		return FALSE;
 	}
 
+	if (!avrcp_pull_header(&iov))
+		return FALSE;
+
 	if (code == AVC_CTYPE_REJECTED) {
-		media_player_set_setting(mp, "Error",
-					status_to_str(pdu->params[0]));
+		if (util_iov_pull_u8(&iov, &status))
+			media_player_set_setting(mp, "Error",
+						status_to_str(status));
 		return FALSE;
 	}
 
-	count = pdu->params[0];
-
-	if (pdu->params_len < count * 2)
+	if (!util_iov_pull_u8(&iov, &count))
 		return FALSE;
 
-	for (i = 1; count > 0; count--, i += 2) {
+	for (; count > 0; count--) {
 		const char *key;
 		const char *value;
+		uint8_t attr, val;
 
-		key = attr_to_str(pdu->params[i]);
+		if (!util_iov_pull_u8(&iov, &attr) ||
+				!util_iov_pull_u8(&iov, &val))
+			break;
+
+		key = attr_to_str(attr);
 		if (key == NULL)
 			continue;
 
-		value = attrval_to_str(pdu->params[i], pdu->params[i + 1]);
+		value = attrval_to_str(attr, val);
 		if (value == NULL)
 			continue;
 
@@ -2398,23 +2452,14 @@ static gboolean avrcp_list_player_attributes_rsp(struct avctp *conn,
 	struct iovec iov = { operands, operand_count };
 	uint8_t attrs[AVRCP_ATTRIBUTE_LAST];
 	struct avrcp *session = user_data;
-	struct avrcp_header *pdu;
 	uint8_t len, count = 0;
 	int i;
 
 	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED)
 		return FALSE;
 
-	pdu = util_iov_pull_mem(&iov, sizeof(*pdu));
-	if (!pdu) {
-		error("Invalid AVRCP header");
+	if (!avrcp_pull_header(&iov))
 		return FALSE;
-	}
-
-	if (be16_to_cpu(pdu->params_len) != iov.iov_len) {
-		error("Invalid parameters");
-		return FALSE;
-	}
 
 	if (!util_iov_pull_u8(&iov, &len))
 		return FALSE;
@@ -2526,11 +2571,9 @@ static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
 	if (code == AVC_CTYPE_REJECTED)
 		return FALSE;
 
-	pdu = util_iov_pull_mem(&iov, sizeof(*pdu));
-	if (!pdu) {
-		error("Invalid AVRCP header");
+	pdu = avrcp_pull_header(&iov);
+	if (!pdu)
 		return FALSE;
-	}
 
 	/* Abort fragmented responses as reassembly is not supported */
 	if (pdu->packet_type == AVRCP_PACKET_TYPE_START ||
@@ -2539,11 +2582,6 @@ static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
 		return FALSE;
 	}
 
-	if (be16_to_cpu(pdu->params_len) != iov.iov_len) {
-		error("Invalid parameters");
-		return FALSE;
-	}
-
 	if (!util_iov_pull_u8(&iov, &count))
 		return FALSE;
 
@@ -2856,23 +2894,28 @@ static gboolean avrcp_change_path_rsp(struct avctp *conn,
 					uint8_t *operands, size_t operand_count,
 					void *user_data)
 {
-	struct avrcp_browsing_header *pdu = (void *) operands;
+	struct iovec iov = { operands, operand_count };
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
+	uint32_t items;
+	uint8_t status;
 	int ret;
 
-	if (pdu == NULL) {
+	if (operands == NULL) {
 		ret = -ETIMEDOUT;
 		goto done;
 	}
 
-	if (pdu->params[0] != AVRCP_STATUS_SUCCESS) {
+	if (!avrcp_pull_browsing_header(&iov) ||
+			!util_iov_pull_u8(&iov, &status) ||
+			status != AVRCP_STATUS_SUCCESS ||
+			!util_iov_pull_be32(&iov, &items)) {
 		ret = -EINVAL;
 		goto done;
 	}
 
-	ret = get_be32(&pdu->params[1]);
+	ret = items;
 
 done:
 	if (ret < 0) {
@@ -2900,41 +2943,47 @@ static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
-	struct avrcp_browsing_header *pdu = (void *) operands;
+	struct iovec iov = { operands, operand_count };
 	uint32_t items;
 	char **folders;
-	uint8_t depth, count;
-	size_t i;
+	uint16_t uid_counter, charset;
+	uint8_t status, depth, count;
 
-	if (pdu == NULL || pdu->params[0] != AVRCP_STATUS_SUCCESS ||
-							operand_count < 13)
+	if (operands == NULL)
 		return FALSE;
 
-	player->uid_counter = get_be16(&pdu->params[1]);
+	if (!avrcp_pull_browsing_header(&iov) ||
+			!util_iov_pull_u8(&iov, &status) ||
+			status != AVRCP_STATUS_SUCCESS ||
+			!util_iov_pull_be16(&iov, &uid_counter) ||
+			!util_iov_pull_be32(&iov, &items) ||
+			!util_iov_pull_be16(&iov, &charset) ||
+			!util_iov_pull_u8(&iov, &depth))
+		return FALSE;
+
+	player->uid_counter = uid_counter;
 	player->browsed = true;
 
-	items = get_be32(&pdu->params[3]);
-
-	depth = pdu->params[9];
-
 	folders = g_new0(char *, depth + 2);
 	folders[0] = g_strdup("/Filesystem");
 
-	for (i = 10, count = 1; count - 1 < depth && i < operand_count;
-								count++) {
+	for (count = 1; count - 1 < depth; count++) {
 		uint8_t len;
+		void *name;
+
+		if (!util_iov_pull_u8(&iov, &len))
+			break;
 
-		len = pdu->params[i++];
 		if (!len)
 			continue;
 
-		if (i + len > operand_count) {
+		name = util_iov_pull_mem(&iov, len);
+		if (!name) {
 			error("Invalid folder length");
 			break;
 		}
 
-		folders[count] = util_memdup(&pdu->params[i], len);
-		i += len;
+		folders[count] = util_memdup(name, len);
 	}
 
 	player->path = g_build_pathv("/", folders);
@@ -2971,7 +3020,6 @@ static gboolean avrcp_get_item_attributes_rsp(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->controller->player;
 	struct iovec iov = { operands, operand_count };
-	struct avrcp_browsing_header *pdu;
 	struct media_player *mp = player->user_data;
 	struct media_item *item;
 	uint8_t status, count;
@@ -2981,23 +3029,13 @@ static gboolean avrcp_get_item_attributes_rsp(struct avctp *conn,
 		return FALSE;
 	}
 
-	pdu = util_iov_pull_mem(&iov, sizeof(*pdu));
-	if (!pdu) {
+	if (!avrcp_pull_browsing_header(&iov) ||
+			!util_iov_pull_u8(&iov, &status) ||
+			status != AVRCP_STATUS_SUCCESS) {
 		avrcp_get_element_attributes(session);
 		return FALSE;
 	}
 
-	if (!util_iov_pull_u8(&iov, &status) ||
-					status != AVRCP_STATUS_SUCCESS) {
-		avrcp_get_element_attributes(session);
-		return FALSE;
-	}
-
-	if (be16_to_cpu(pdu->param_len) != operand_count - sizeof(*pdu)) {
-		error("Invalid parameters");
-		return FALSE;
-	}
-
 	if (!util_iov_pull_u8(&iov, &count))
 		return FALSE;
 
@@ -3086,9 +3124,12 @@ static gboolean avrcp_set_addressed_player_rsp(struct avctp *conn, uint8_t code,
 {
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->controller->player;
-	struct avrcp_header *pdu = (void *) operands;
+	struct iovec iov = { operands, operand_count };
 
-	if (!pdu || code != AVC_CTYPE_ACCEPTED)
+	if (!operands || code != AVC_CTYPE_ACCEPTED)
+		return FALSE;
+
+	if (!avrcp_pull_header(&iov))
 		return FALSE;
 
 	player->addressed = true;
@@ -3372,24 +3413,31 @@ static int ct_change_folder(struct media_player *mp, const char *path,
 static gboolean avrcp_search_rsp(struct avctp *conn, uint8_t *operands,
 					size_t operand_count, void *user_data)
 {
-	struct avrcp_browsing_header *pdu = (void *) operands;
+	struct iovec iov = { operands, operand_count };
 	struct avrcp *session = (void *) user_data;
 	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
+	uint32_t items;
+	uint16_t uid_counter;
+	uint8_t status;
 	int ret;
 
-	if (pdu == NULL) {
+	if (operands == NULL) {
 		ret = -ETIMEDOUT;
 		goto done;
 	}
 
-	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 7) {
+	if (!avrcp_pull_browsing_header(&iov) ||
+			!util_iov_pull_u8(&iov, &status) ||
+			status != AVRCP_STATUS_SUCCESS ||
+			!util_iov_pull_be16(&iov, &uid_counter) ||
+			!util_iov_pull_be32(&iov, &items)) {
 		ret = -EINVAL;
 		goto done;
 	}
 
-	player->uid_counter = get_be16(&pdu->params[1]);
-	ret = get_be32(&pdu->params[3]);
+	player->uid_counter = uid_counter;
+	ret = items;
 
 done:
 	media_player_search_complete(mp, ret);
@@ -3437,19 +3485,25 @@ static gboolean avrcp_play_item_rsp(struct avctp *conn, uint8_t code,
 					uint8_t *operands, size_t operand_count,
 					void *user_data)
 {
-	struct avrcp_header *pdu = (void *) operands;
+	struct iovec iov = { operands, operand_count };
 	struct avrcp *session = (void *) user_data;
 	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
+	uint8_t status;
 	int ret = 0;
 
-	if (pdu == NULL) {
+	if (operands == NULL) {
 		ret = -ETIMEDOUT;
 		goto done;
 	}
 
-	if (pdu->params[0] != AVRCP_STATUS_SUCCESS) {
-		switch (pdu->params[0]) {
+	if (!avrcp_pull_header(&iov) || !util_iov_pull_u8(&iov, &status)) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if (status != AVRCP_STATUS_SUCCESS) {
+		switch (status) {
 		case AVRCP_STATUS_UID_CHANGED:
 		case AVRCP_STATUS_DOES_NOT_EXIST:
 			ret = -ENOENT;
@@ -3567,23 +3621,32 @@ static gboolean avrcp_get_total_numberofitems_rsp(struct avctp *conn,
 					uint8_t *operands, size_t operand_count,
 					void *user_data)
 {
-	struct avrcp_browsing_header *pdu = (void *) operands;
+	struct iovec iov = { operands, operand_count };
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
 	uint32_t num_of_items = 0;
+	uint16_t uid_counter;
+	uint8_t status;
 
-	if (pdu == NULL)
+	if (operands == NULL)
 		return -ETIMEDOUT;
 
-	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 7)
+	if (!avrcp_pull_browsing_header(&iov) ||
+			!util_iov_pull_u8(&iov, &status))
 		return -EINVAL;
 
-	if (pdu->params[0] == AVRCP_STATUS_OUT_OF_BOUNDS)
+	if (status == AVRCP_STATUS_OUT_OF_BOUNDS)
 		goto done;
 
-	player->uid_counter = get_be16(&pdu->params[1]);
-	num_of_items = get_be32(&pdu->params[3]);
+	if (status != AVRCP_STATUS_SUCCESS)
+		return -EINVAL;
+
+	if (!util_iov_pull_be16(&iov, &uid_counter) ||
+			!util_iov_pull_be32(&iov, &num_of_items))
+		return -EINVAL;
+
+	player->uid_counter = uid_counter;
 
 	if (!num_of_items)
 		return -EINVAL;
@@ -3812,44 +3875,46 @@ static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
 						size_t operand_count,
 						void *user_data)
 {
-	struct avrcp_browsing_header *pdu = (void *) operands;
+	struct iovec iov = { operands, operand_count };
 	struct avrcp *session = user_data;
-	uint16_t count;
-	size_t i;
+	uint16_t uid_counter, count;
+	uint8_t status;
 	GSList *removed;
 
-	if (pdu == NULL || pdu->params[0] != AVRCP_STATUS_SUCCESS ||
-							operand_count < 5)
+	if (operands == NULL)
+		return FALSE;
+
+	if (!avrcp_pull_browsing_header(&iov) ||
+			!util_iov_pull_u8(&iov, &status) ||
+			status != AVRCP_STATUS_SUCCESS ||
+			!util_iov_pull_be16(&iov, &uid_counter) ||
+			!util_iov_pull_be16(&iov, &count))
 		return FALSE;
 
 	removed = g_slist_copy(session->controller->players);
-	count = get_be16(&operands[6]);
 
-	for (i = 8; count && i < operand_count; count--) {
+	for (; count > 0; count--) {
 		struct avrcp_player *player;
 		uint8_t type;
 		uint16_t len;
+		void *data;
 
-		type = operands[i++];
-		len = get_be16(&operands[i]);
-		i += 2;
+		if (!util_iov_pull_u8(&iov, &type) ||
+				!util_iov_pull_be16(&iov, &len))
+			break;
 
-		if (type != 0x01) {
-			i += len;
-			continue;
-		}
-
-		if (i + len > operand_count) {
+		data = util_iov_pull_mem(&iov, len);
+		if (!data) {
 			error("Invalid player item length");
-			return FALSE;
+			break;
 		}
 
-		player = avrcp_parse_media_player_item(session, &operands[i],
-									len);
+		if (type != 0x01)
+			continue;
+
+		player = avrcp_parse_media_player_item(session, data, len);
 		if (player)
 			removed = g_slist_remove(removed, player);
-
-		i += len;
 	}
 
 	g_slist_free_full(removed, player_remove);
@@ -4025,15 +4090,20 @@ static gboolean avrcp_handle_event(struct avctp *conn, uint8_t code,
 {
 	struct avrcp *session = user_data;
 	struct avrcp_data *controller = session->controller;
-	struct avrcp_header *pdu = (void *) operands;
+	struct iovec iov = { operands, operand_count };
+	struct avrcp_header *pdu;
 	uint8_t event;
 
-	if (!pdu)
+	if (!operands)
 		return FALSE;
 
 	if (!controller)
 		return FALSE;
 
+	pdu = avrcp_pull_header(&iov);
+	if (!pdu || !iov.iov_len)
+		return FALSE;
+
 	if ((code != AVC_CTYPE_INTERIM && code != AVC_CTYPE_CHANGED)) {
 		if (pdu->params[0] == AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED &&
 				code == AVC_CTYPE_REJECTED) {
@@ -4140,12 +4210,18 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
 					void *user_data)
 {
 	struct avrcp *session = user_data;
-	struct avrcp_header *pdu = (void *) operands;
+	struct iovec iov = { operands, operand_count };
 	uint16_t events = 0;
-	uint8_t count;
+	uint8_t count, cap;
 
 	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED ||
-			pdu == NULL || pdu->params[0] != CAP_EVENTS_SUPPORTED)
+							operands == NULL)
+		return FALSE;
+
+	if (!avrcp_pull_header(&iov))
+		return FALSE;
+
+	if (!util_iov_pull_u8(&iov, &cap) || cap != CAP_EVENTS_SUPPORTED)
 		return FALSE;
 
 	/* Connect browsing if pending */
@@ -4155,12 +4231,17 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
 		avctp_connect_browsing(session->conn);
 	}
 
-	count = pdu->params[1];
+	if (!util_iov_pull_u8(&iov, &count))
+		return FALSE;
 
 	for (; count > 0; count--) {
-		uint8_t event = pdu->params[1 + count];
+		uint8_t event;
 
-		events |= (1 << event);
+		if (!util_iov_pull_u8(&iov, &event))
+			break;
+
+		if (event < sizeof(events) * 8)
+			events |= (1 << event);
 
 		switch (event) {
 		case AVRCP_EVENT_STATUS_CHANGED:
@@ -4728,14 +4809,18 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
 					void *user_data)
 {
 	struct avrcp *session = user_data;
-	struct avrcp_header *pdu = (void *) operands;
+	struct iovec iov = { operands, operand_count };
+	uint8_t value;
 	int8_t volume;
 
 	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED ||
-								pdu == NULL)
+							operands == NULL)
 		return FALSE;
 
-	volume = pdu->params[0] & 0x7F;
+	if (!avrcp_pull_header(&iov) || !util_iov_pull_u8(&iov, &value))
+		return FALSE;
+
+	volume = value & 0x7F;
 
 	/* Always attempt to update the transport volume */
 	media_transport_set_a2dp_volume(session->dev, volume);
-- 
2.54.0

