Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837FF2EC574
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270252; cv=none; b=HTawGaMj3/eIadi/phcOP7nkn/+IWujaEOvUV0R6JLh9LgZ7gHDSUZoTHKSm3envIGx98ERba75ntjFpv4DfISfyU+0Mji+PUhXey9GZ2RrQ42PPzVv9Hatr0ua5Vx07bTJbWnvvS1Uy9XkBA8JnUJt+0AboGbDxljml8dpJjEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270252; c=relaxed/simple;
	bh=ILiTp9MT40P/I7SY6LoUgwpbksRtRkHuaa+LsxPLf90=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=iu8ZJlOtZ2KpY0YKG+4EEfp08CcFDLUqrvqIO+bHwNATugZBZN13A6ldCpNzcR3uquiwTqIzbV48Mt4p8Ck0Ts589ZqImGp99L1G/Y31NLQAwMDMh5uNGSjOeEm4ZLPr7b9nvpKWEC+r+oScRTQE+OYyjJ3fPdFfYdxBvSGM3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lZFgViZ4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lZFgViZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758270248;
	bh=ILiTp9MT40P/I7SY6LoUgwpbksRtRkHuaa+LsxPLf90=;
	h=From:To:Subject:Date:From;
	b=lZFgViZ4LwoBpByPbkW+cYgqfZYT64Es1pnjnIkVY/8xSaO1Azt/trs+vmaWVZZVQ
	 D1vc/ZVBVNa1ldoIfaJZw5h0+qFBkX0yOiZTtoKv7glNAT1PExNXRoehnDyjXwWZy3
	 0JDZnMc/nvavkoQlvVFhnZllr5v39oNvPT5I1NE4I1M0BpU3/mFIzRcJ5cu+ljlOIg
	 A3WVbkqBU0B3Uw8NK5dcXYZ6+FLDxWNfMsunYg+KmKCVhRNo5bMMTQTFLGrbIj5vBI
	 OyI1C3cU9duOM3qeQQ4te0eQzEXM4f+HN7CymIYg8zpeiYHG0GPrzM9Vn8a6+MiWnE
	 DWR8lyDR82iBg==
Received: from fdanis-ThinkPad-X1.. (unknown [IPv6:2a02:8428:af44:1001:17f0:5da3:acf8:a3c1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 57F8317E0202
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 10:24:08 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] shared/hfp: Add Call answer support
Date: Fri, 19 Sep 2025 10:23:30 +0200
Message-ID: <20250919082334.1443310-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This also manage the +CIEV:<call>,… event to create, remove or update
calls.
---
 src/shared/hfp.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/hfp.h |  4 +++
 2 files changed, 83 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 29b467ae3..7e35f239a 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -1651,9 +1651,36 @@ static void ciev_service_cb(uint8_t val, void *user_data)
 							hfp->callbacks_data);
 }
 
+static bool update_call_to_active(struct hfp_hf *hfp)
+{
+	const struct queue_entry *entry;
+	struct hf_call *call;
+
+	for (entry = queue_get_entries(hfp->calls); entry;
+					entry = entry->next) {
+		call = entry->data;
+
+		if (call->status == CALL_STATUS_DIALING ||
+			call->status == CALL_STATUS_ALERTING ||
+			call->status == CALL_STATUS_INCOMING) {
+			call->status = CALL_STATUS_ACTIVE;
+			if (hfp->callbacks &&
+				hfp->callbacks->call_status_updated)
+				hfp->callbacks->call_status_updated(
+					call->id,
+					call->status,
+					hfp->callbacks_data);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static void ciev_call_cb(uint8_t val, void *user_data)
 {
 	struct hfp_hf *hfp = user_data;
+	uint id;
 
 	DBG(hfp, "%u", val);
 
@@ -1662,6 +1689,32 @@ static void ciev_call_cb(uint8_t val, void *user_data)
 		DBG(hfp, "hf: Incorrect call state: %u", val);
 		return;
 	}
+
+	switch (val) {
+	case CIND_CALL_NONE:
+		/* Remove all calls */
+		queue_remove_all(hfp->calls, NULL, hfp, remove_call_cb);
+		break;
+	case CIND_CALL_IN_PROGRESS:
+		{
+			/* Find incoming, dialing or alerting call to change
+			 * it to active
+			 */
+			if (update_call_to_active(hfp))
+				return;
+
+			/* else create new already active call */
+			id = next_call_index(hfp);
+			if (id == 0) {
+				DBG(hfp, "hf: No new call index available");
+				return;
+			}
+			call_new(hfp, id, CALL_STATUS_ACTIVE, NULL);
+		}
+		break;
+	default:
+		DBG(hfp, "hf: Unsupported call state: %u", val);
+	}
 }
 
 static bool call_outgoing_match(const void *data, const void *match_data)
@@ -2367,3 +2420,29 @@ const char *hfp_hf_call_get_number(struct hfp_hf *hfp, uint id)
 
 	return call->line_id;
 }
+
+bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
+				hfp_response_func_t resp_cb,
+				void *user_data)
+{
+	struct hf_call *call;
+
+	DBG(hfp, "");
+
+	if (!hfp)
+		return false;
+
+	call = queue_find(hfp->calls, call_id_match, UINT_TO_PTR(id));
+	if (!call) {
+		DBG(hfp, "hf: no call with id: %u", id);
+		return false;
+	}
+
+	if (call->status != CALL_STATUS_INCOMING) {
+		DBG(hfp, "hf: %d not in incoming call state: %u",
+							call->status);
+		return false;
+	}
+
+	return hfp_hf_send_command(hfp, resp_cb, user_data, "ATA");
+}
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index fec63c150..c623e48e6 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -236,3 +236,7 @@ bool hfp_hf_session_register(struct hfp_hf *hfp,
 bool hfp_hf_session(struct hfp_hf *hfp);
 
 const char *hfp_hf_call_get_number(struct hfp_hf *hfp, uint id);
+
+bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
+				hfp_response_func_t resp_cb,
+				void *user_data);
-- 
2.43.0

