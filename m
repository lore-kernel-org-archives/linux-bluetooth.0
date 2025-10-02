Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84E5244679
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421491; cv=none; b=tTXa0BObofg7FxiXcJS2GpAfoy1rzQlPGq7oUN7NVavkp7mDZhGRoRWYKWZq/9PIsRB/THPPrhAtwxFJflScrQAMV2r379xOQ5xFqAPoUDMaBhsW7xYUnVuDkkwXexr0zZjK5cdJLDZUZYF/QAiQd5zLqS+fb+TqmOSkv0flTa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421491; c=relaxed/simple;
	bh=nU5P5BNeSHEbtPSkX2qcSJ8KdYhGJm0vl57dus2hV+Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CEZnQQziHtEjMhi1h3YTLffv3nBTmIlFLA6yRVKO7hSR6H617BYKn2DwWAwZzhIgHWNf1nLZ5lKG0DzoLPyQzp9Y0N7bjn71lJewfYVJ3idrEow60WQ+oA3bryIJZ330t2Wu6wtIBHTvLe2XvW0FeUPQ7XMsNqwyNzPd36C8968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mkU9MlPn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mkU9MlPn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759421487;
	bh=nU5P5BNeSHEbtPSkX2qcSJ8KdYhGJm0vl57dus2hV+Q=;
	h=From:To:Subject:Date:From;
	b=mkU9MlPnnYDqm7AHWH8DU2NW4Ovbcu0UtDxyNKHdz4Qy5LL3Xg0wa61yQTduqwnXm
	 Bd7F8L+E+/B/nYKv1kcbYUMDNn1M23GF0DFHNvnqpQDRRPEiC1ACG1t0skrzuJiauq
	 Kwmh8RhP18tiri7zAcMXdmIgkiZPJAZTH9UPUlLLbMzDqX4ej98IxguWMrlwL30QUp
	 VVgoI1ooKT5NiRyQ6rjVjlAFHqCMpbEz16KN1m5Ipku9bOnnSLSEzTY/qROK14bDLD
	 qsWUsBWfuFaZsapF9lTeWHEApgj4zGJkPPbg9hzgcTCSUXBL6+XYdmsgpbpO7OrzKc
	 m1DZtGQYlUY2w==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-2772-9836-E14c-d5b5.rev.sfr.net [IPv6:2a02:8428:af44:1001:2772:9836:e14c:d5b5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8B47E17E12BB
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 18:11:27 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/hfp: Fix issues found by codacy
Date: Thu,  2 Oct 2025 18:11:19 +0200
Message-ID: <20251002161119.937608-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Move debug string after check of hfp pointer.
Add missing argument in debug trace.
---
 src/shared/hfp.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 133bff248..94adccada 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -2391,11 +2391,11 @@ bool hfp_hf_session_register(struct hfp_hf *hfp,
 
 bool hfp_hf_session(struct hfp_hf *hfp)
 {
-	DBG(hfp, "");
-
 	if (!hfp)
 		return false;
 
+	DBG(hfp, "");
+
 	if (!hfp_hf_register(hfp, slc_brsf_cb, "+BRSF", hfp, NULL))
 		return false;
 
@@ -2407,15 +2407,15 @@ const char *hfp_hf_call_get_number(struct hfp_hf *hfp, uint id)
 {
 	struct hf_call *call;
 
-	DBG(hfp, "");
-
 	if (!hfp)
-		return false;
+		return NULL;
+
+	DBG(hfp, "");
 
 	call = queue_find(hfp->calls, call_id_match, UINT_TO_PTR(id));
 	if (!call) {
 		DBG(hfp, "hf: no call with id: %u", id);
-		return false;
+		return NULL;
 	}
 
 	return call->line_id;
@@ -2427,11 +2427,11 @@ bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
 {
 	struct hf_call *call;
 
-	DBG(hfp, "");
-
 	if (!hfp)
 		return false;
 
+	DBG(hfp, "");
+
 	call = queue_find(hfp->calls, call_id_match, UINT_TO_PTR(id));
 	if (!call) {
 		DBG(hfp, "hf: no call with id: %u", id);
@@ -2440,7 +2440,7 @@ bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
 
 	if (call->status != CALL_STATUS_INCOMING) {
 		DBG(hfp, "hf: %d not in incoming call state: %u",
-							call->status);
+							id, call->status);
 		return false;
 	}
 
@@ -2453,11 +2453,11 @@ bool hfp_hf_call_hangup(struct hfp_hf *hfp, uint id,
 {
 	struct hf_call *call;
 
-	DBG(hfp, "");
-
 	if (!hfp)
 		return false;
 
+	DBG(hfp, "");
+
 	call = queue_find(hfp->calls, call_id_match, UINT_TO_PTR(id));
 	if (!call) {
 		DBG(hfp, "hf: no call with id: %u", id);
-- 
2.43.0

