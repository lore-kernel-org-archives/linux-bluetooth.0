Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C993E4A2071
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342747; cv=none; b=lPIiONpcviT0J6lvbyN/OrbDzcAaiK9EdYx1NR8mDjZ97uehlMBxg8OUohhNzGV31BZ6sHj+oNDo8DHYsyEKClwf7EF8+2C7IX0qmnbk9xbcoNZ0OVRXdqXe5WQX0fstyOtQSNPWZB0DlwzB00PFob4/dQ7iLmNEuRIPyWe4D4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342747; c=relaxed/simple;
	bh=3WbsBuWX9kzUKk930jwYrDpqMNBw9HmdqNg97VL2PhE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7tls63jsIhqz+1l4AE9y1qtNbbxFLG/Cuot24y8cXE4U9Sor4Jbyzuo8lPeJkqwY+ijTf3+s+cfnrXAYvBfp0rw5MFltFH0eock5rxoCydb0lANzUrsuh+fvdsbpCkBwvji06N2A+fj4ogJ0Orlyg2L2HREwrQxYE57b/2Eszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WlR8Musa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WlR8Musa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790342736;
	bh=3WbsBuWX9kzUKk930jwYrDpqMNBw9HmdqNg97VL2PhE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WlR8MusaFl2S5IV/lV+FCQErkAug5FFTzfIN2YxLp1B3c9eRzrOmJP+K+ifrW/chj
	 yZSdlWc5BTeCtihkvE1WVXuJJiRj3Q4TZKaFXvm9Zaw1yFxL/0xWnAHSppzkBxtCMa
	 a+6yjoPYl3s7h6ISfgUOmTCvcNCvGsFLG5N8PVbvlh8Fj8CqInlUhF0DG3/KjPMwzt
	 KeAIZR/FlZsqbsw5mr3xHatBgAn88eRyAF8SfbT+dBLqax/1v+OcRM/Ee3K2SZMFmj
	 bPxKFoghR6RdwWOrZho2CL/y0WXJbyttmQdjuzzhag4MQIzNTTWydJiO3tlgd7XTLt
	 F/Y8xqwt6NkMQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B6E2F17E018B
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:25:36 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/12] shared/hfp: Add hangup all calls support
Date: Fri, 25 Sep 2026 15:25:20 +0200
Message-ID: <20260925132528.3361517-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925132528.3361517-1-frederic.danis@collabora.com>
References: <20260925132528.3361517-1-frederic.danis@collabora.com>
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

