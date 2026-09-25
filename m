Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D252846D0A0
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342754; cv=none; b=XNBj529bkgW+mrgl3BRrwY59c8MLVMNDLR5Kyx4E4jrnrdJlJyfCZRWdd8n/A6WD12lb3Z3Wyr2oCAPHQJKx16vLFFsKMLUlmVDejSuvBwoAP5tfo0gNML7kMGATx4rh9wsFOfBBc5DyqxDlOqSBPP+PjBR/5ssz/T2KaEiUSbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342754; c=relaxed/simple;
	bh=5ULnzBgz+HZtBkQhgUVKE9M2B2Uufb8BFdMV5IEzfOM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQRbtrYucwtxXCOVZ6hMlzwpYc8DzNRhg2+xcQaWYY0/zf12VsfD7ca8hI1innWzJrxcgzOIMkF1c76SML6dYbEPq4ZeQmi38xHPvfGbLNlTHGE/qPPW9wvhT7c6g7lDSpluvFdF7RE3Bla++E5V3gdP8VWu+UBEByW83du5JzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ql6wN5/d; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ql6wN5/d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790342737;
	bh=5ULnzBgz+HZtBkQhgUVKE9M2B2Uufb8BFdMV5IEzfOM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ql6wN5/dmhvCMjeP4UqqzdgD6AjWvsO56nZYeVdUpMS5XRKWp/1EQaMOF6qUuX9hr
	 NXU0L9u7u/irx6xPWHZEBepvIAFjcKloEd3SqhFxtAMajOflsN2JBLvnXZBzsBFa70
	 ZNOLRpLwcC1vF2EvuLKMby8EqdBEh3GeZmBe9aiUueaGv7/FVrIb5CekMMRQtolo3K
	 /ajYUC255+DlD+F+8gAZxYUgeIxFI7XUMBq/tw9aglocs85vgjO687OpArD+mZgnlK
	 AJ3Pw/fpN8NgVD7X4tNo+BT4sIv5FavDQG/43119f45ql237RxfVhD5b8GR1xDvf25
	 FHTQwfQU9qDjw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4A5EA17E0D7E
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:25:37 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/12] shared/hfp: Add send tones support
Date: Fri, 25 Sep 2026 15:25:22 +0200
Message-ID: <20260925132528.3361517-7-frederic.danis@collabora.com>
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

---
 src/shared/hfp.c | 18 ++++++++++++++++++
 src/shared/hfp.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index f9fa53ae4..dffad6fee 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -3017,6 +3017,24 @@ bool hfp_hf_hangup_all(struct hfp_hf *hfp,
 	return true;
 }
 
+bool hfp_hf_send_tones(struct hfp_hf *hfp, const char *tones,
+				hfp_response_func_t resp_cb,
+				void *user_data)
+{
+	if (!hfp)
+		return false;
+
+	DBG(hfp, "");
+
+	if (!queue_find(hfp->calls, call_active_match, NULL)) {
+		DBG(hfp, "hf: No active call to send tones");
+		return false;
+	}
+
+	return hfp_hf_send_command(hfp, resp_cb, user_data, "AT+VTS=%s",
+								tones);
+}
+
 bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
 				hfp_response_func_t resp_cb,
 				void *user_data)
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 77ada40b6..11610018e 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -261,6 +261,9 @@ bool hfp_hf_swap_calls(struct hfp_hf *hfp,
 bool hfp_hf_hangup_all(struct hfp_hf *hfp,
 				hfp_response_func_t resp_cb,
 				void *user_data);
+bool hfp_hf_send_tones(struct hfp_hf *hfp, const char *tones,
+				hfp_response_func_t resp_cb,
+				void *user_data);
 bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
 				hfp_response_func_t resp_cb,
 				void *user_data);
-- 
2.43.0

