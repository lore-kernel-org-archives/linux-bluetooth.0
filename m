Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4177B352934
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766587555; cv=none; b=GvFecjtHUz6QNtDd7USAOmXUl064gNY4ojEXxbYtwDl3HhbzAlGx6ZCVjoV7Qq3iRQz3tsaiQyD8E83JwWzDRoemYTazL28NHggYunv2OIuvGb93qvfzzAlV4gSzTZ3N4OELtecli4aNclBMaxdqwZADTUAiBJI8RUC6SxZpMWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766587555; c=relaxed/simple;
	bh=2bT+wEVrDUL2GWmz7idb+AIu7JMfWm/bu6eqyLMOw60=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vBytc2YWNi1tnW0cQZS7wIbtMTOdXp/6stSWLPl+l0G2TC+s9cIa1XkJJ2K0v5+qo2ENe1/2PeQpegLy+4ACTp7OevKrpL8sJ+pAtgyJ8RtnuhdQO3QxKWo48xBcBsgsvRHAkcopgJceP5ovSve0Xfn+mdlIe5QHvj/CBLm6al4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lBAxQ1P6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lBAxQ1P6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1766587551;
	bh=2bT+wEVrDUL2GWmz7idb+AIu7JMfWm/bu6eqyLMOw60=;
	h=From:To:Subject:Date:From;
	b=lBAxQ1P6stTW0czKyqkJVi2uAmazPo+AfCfqBjxKrv4paXGzNR2ltYYJgbxEROIuZ
	 t9ZnG5+abnCUo8A5V4uJjLacZqZHQYea4WhDfCzH4Q0ITfARQl5J8Qeq3ldV0699u4
	 0b3XJPPVW+7+xlJB41hqjdnqOCA8dzX/MmW4Q0g1YzxM1BzNlh9IOFFlzAukShyZe6
	 LAYyaaUAKYnVGgL25rdPRFUolXM08uT3A0/1zenxH5tmbsSH24UtH1cM0qY1GkhV0i
	 lWjFqyf57tA+VAcVBSJkWN4Y7AKsX0/oVgJBR3Kwkg2xWd9DDujJaexASnO+0xfQv9
	 4sXJRuxFRAMVA==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-aF44-1001-0593-56E9-3f4c-22E6.rev.sfr.net [IPv6:2a02:8428:af44:1001:593:56e9:3f4c:22e6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2ED8B17E0451
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 15:45:51 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/hfp: Add function to get multiparty call status
Date: Wed, 24 Dec 2025 15:45:44 +0100
Message-ID: <20251224144545.211533-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 src/shared/hfp.c | 20 ++++++++++++++++++++
 src/shared/hfp.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index e4f5161b6..59e09f80e 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -2874,6 +2874,26 @@ const char *hfp_hf_call_get_number(struct hfp_hf *hfp, uint id)
 	return call->line_id;
 }
 
+bool hfp_hf_call_get_multiparty(struct hfp_hf *hfp, uint id, bool *mpty)
+{
+	struct hf_call *call;
+
+	if (!hfp)
+		return false;
+
+	DBG(hfp, "");
+
+	call = queue_find(hfp->calls, call_id_match, UINT_TO_PTR(id));
+	if (!call) {
+		DBG(hfp, "hf: no call with id: %u", id);
+		return false;
+	}
+
+	*mpty = call->mpty;
+
+	return true;
+}
+
 bool hfp_hf_dial(struct hfp_hf *hfp, const char *number,
 				hfp_response_func_t resp_cb,
 				void *user_data)
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 045e1f7ab..201777605 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -247,6 +247,7 @@ bool hfp_hf_session_register(struct hfp_hf *hfp,
 bool hfp_hf_session(struct hfp_hf *hfp);
 
 const char *hfp_hf_call_get_number(struct hfp_hf *hfp, uint id);
+bool hfp_hf_call_get_multiparty(struct hfp_hf *hfp, uint id, bool *mpty);
 
 bool hfp_hf_dial(struct hfp_hf *hfp, const char *number,
 				hfp_response_func_t resp_cb,
-- 
2.43.0

