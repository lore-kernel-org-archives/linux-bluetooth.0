Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A555349DF
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889051; cv=none; b=q/INDKNZ+khbuAWdJByovm0+Uc+yFR4jyqjEFS/2aeS9Eu8GuCOh6vPccikCSTr0cIsHxL3ejHkbFnaOKnNk38a4FsU9fIe4z8OqO53WksoaU8cX9Jc3a6dHgKODTr9XT/GWl1NNqa7gXGOtp7b0ASop9jcDmHMcsoTAY78RPmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889051; c=relaxed/simple;
	bh=3WbsBuWX9kzUKk930jwYrDpqMNBw9HmdqNg97VL2PhE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKRj2fhDBZgJNmpAlpxNjxreEwa7awCd6TzgZ/agU5+2+GuIIyEtfE8hfoBdPYzeGtO47nPNgqJnNWOAavWuXFsuDYZjPrptopHrB5+kUTkriFIQfQHI3z34Xh6rvbp1CtlJUSJjRxvMlkOu/tSFY3fyjavL69ji1TrVvh/yNFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T1zW23Y+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T1zW23Y+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790889042;
	bh=3WbsBuWX9kzUKk930jwYrDpqMNBw9HmdqNg97VL2PhE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=T1zW23Y+JyBe1ZQOBVFEe3PTyRucaRwXmipS1Qh1Xb+FiSGUCXYC6TRrXFHKMJ+TR
	 7GdrGSonRB81Ez+t+1RuRlmClWw/C6GhDp/Yvwk0saWqQsoFhlv+GJS07zaEvhtUIL
	 rDvhqeWYTFid9eTl15rQ7KgeVqA6Ma4FulLkWSTXeuFmakUdlL5Z79jBwy+JTtVRb1
	 vvmQLBTzH7Bkq8EyXXeR9RmjetDw3Bv32wqH+afMCTzIkcsAaVIh3iw3qJsoyIdv9l
	 0MdlGkZR3t49ig9g/F2NsRCrEGVhhSyu09qT6VY9HbSAxZUpZ6qUT7mzsTYrYBIc4O
	 yZEG0pqn5MCcw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3804A17E0667
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 23:10:42 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 04/12] shared/hfp: Add hangup all calls support
Date: Thu,  1 Oct 2026 23:10:28 +0200
Message-ID: <20261001211036.1760396-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001211036.1760396-1-frederic.danis@collabora.com>
References: <20261001211036.1760396-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis.oss@gmail.com>

This releases all calls except waiting calls. This includes
multiparty calls.
---
 src/shared/hfp.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/hfp.h |  3 +++
 2 files changed, 50 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 59e09f80e..f9fa53ae4 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -2970,6 +2970,53 @@ bool hfp_hf_swap_calls(struct hfp_hf *hfp,
 	return hfp_hf_send_command(hfp, resp_cb, user_data, "AT+CHLD=2");
 }
 
+bool hfp_hf_hangup_all(struct hfp_hf *hfp,
+				hfp_response_func_t resp_cb,
+				void *user_data)
+{
+	bool found_active = false;
+	bool found_held = false;
+	const struct queue_entry *entry;
+
+	if (!hfp)
+		return false;
+
+	DBG(hfp, "");
+
+	for (entry = queue_get_entries(hfp->calls); entry;
+					entry = entry->next) {
+		struct hf_call *call = entry->data;
+
+		if (call_setup_match(call, NULL) ||
+					call_active_match(call, NULL)) {
+			found_active = true;
+		} else if (call_held_match(call, NULL)) {
+			found_held = true;
+		}
+	}
+
+	if (!found_active && !found_held)
+		return false;
+
+	if (found_held && (hfp->chlds & HFP_CHLD_0)) {
+		if (!hfp_hf_send_command(hfp, resp_cb, user_data,
+							"AT+CHLD=0")) {
+			DBG(hfp, "Failed to hangup held calls");
+			return false;
+		}
+	}
+
+	if (found_active) {
+		if (!hfp_hf_send_command(hfp, resp_cb, user_data,
+							"AT+CHUP")) {
+			DBG(hfp, "Failed to hangup active calls");
+			return false;
+		}
+	}
+
+	return true;
+}
+
 bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
 				hfp_response_func_t resp_cb,
 				void *user_data)
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 201777605..77ada40b6 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -258,6 +258,9 @@ bool hfp_hf_release_and_accept(struct hfp_hf *hfp,
 bool hfp_hf_swap_calls(struct hfp_hf *hfp,
 				hfp_response_func_t resp_cb,
 				void *user_data);
+bool hfp_hf_hangup_all(struct hfp_hf *hfp,
+				hfp_response_func_t resp_cb,
+				void *user_data);
 bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
 				hfp_response_func_t resp_cb,
 				void *user_data);
-- 
2.43.0

