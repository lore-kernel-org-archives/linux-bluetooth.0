Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25A925A35F
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610414; cv=none; b=HQdA6mom2d5Vo+SDM9JSnbYahxEToCzlcD1oQROq3ByCIIHRRBBjkbQ/+i34+7t1DhDmh8qVKxNSUushOOHGPYd8kTWRWgVkwxP9TA1YLWoN4oR460ecSZkfn57DN88tdw6B+cJ7jhk0FOCfahv9+RChPAg8hQ22pwjUDlOTrZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610414; c=relaxed/simple;
	bh=8UW4DjKzCN7/KUXqEwp8ZOVxhJmlFicKxfNPHFok9iM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/yRK0K+dGvmb79QtOzPbQtLZ8rg2zvEdOJxN4Gz358R19ulWIxmsPxfMciRcBIFX+ZFQJU16NLJN5huQ5Uk1gF/i7IUB4oLRsJDYPtRxM7a/3BSRA9gk+q7dAKANcnTlgGMGemDE5gdhq3d8sGzU5XKkkqTcxJ6O0MO4pbnWtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XBRrl1yl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XBRrl1yl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755610411;
	bh=8UW4DjKzCN7/KUXqEwp8ZOVxhJmlFicKxfNPHFok9iM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XBRrl1ylGOZcYETVQoTe0gYkf29ygIERxr4sFD8c2bu7ZFeqhFHy5u64TnoqczTOU
	 tm+ytFvLcgJyyiwJEhJr06cV7g1nNRtb+m6XZv7QsPJFeaIMD7/TZQWorksOH6kX+K
	 7P/x2vndZENzhKxnGPhQvEI7wt4lnamXrQog30y2K86TRp1fYFTgC2KXnmpUj0pnKh
	 a4/XbsdwXObvcTI1qgHUll7YQalLtyIqg0b46vT6ZLM7Hr+4cEcb2RBW/1uKqpY/2Z
	 BsAHI/d1sWpgBk0xDIqTFw+dWSElJNWNv5gAobYTMijec4IvEsqC2BSz6TO/nMgntV
	 qj/d2U2HeIJzg==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-aF44-1001-110B-4649-b903-4EDe.rev.sfr.net [IPv6:2a02:8428:af44:1001:110b:4649:b903:4ede])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D56DA17E120D
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 15:33:30 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ RESEND 3/4] shared/hfp: Add +CIEV event support
Date: Tue, 19 Aug 2025 15:33:20 +0200
Message-ID: <20250819133321.382279-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819133321.382279-1-frederic.danis@collabora.com>
References: <20250819133321.382279-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Register +CIEV handler on SLC completion to call the update_indicator
call back on unsolicited events.
---
 src/shared/hfp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index c1bcb61cf..71f193f83 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -1694,6 +1694,22 @@ static void set_indicator_value(uint8_t index, unsigned int val,
 	}
 }
 
+static void ciev_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+	unsigned int index, val;
+
+	DBG(hfp, "");
+
+	if (!hfp_context_get_number(context, &index))
+		return;
+
+	if (!hfp_context_get_number(context, &val))
+		return;
+
+	set_indicator_value(index, val, hfp->ag_ind, hfp);
+}
+
 static void slc_cmer_resp(enum hfp_result result, enum hfp_error cme_err,
 	void *user_data)
 {
@@ -1709,6 +1725,10 @@ static void slc_cmer_resp(enum hfp_result result, enum hfp_error cme_err,
 	if (hfp->callbacks->session_ready)
 		hfp->callbacks->session_ready(HFP_RESULT_OK, 0,
 						hfp->callbacks_data);
+
+	/* Register unsolicited results handlers */
+	hfp_hf_register(hfp, ciev_cb, "+CIEV", hfp, NULL);
+
 	return;
 
 failed:
-- 
2.43.0

