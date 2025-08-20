Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628EB32778F
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696832; cv=none; b=nWhKiWqenXu9dTeRCLoaGJRtnogfIXbratuaTDaqkf9A/AgTL1VNyG3iHBJcwJhrq4OvwmCb4IvkS/qGi/3EQ97QV4nkTooJ95pkUQxOclRsQYbF6XqgyxtIfKRnfEBQ8cD9sADu/592J5r1PLZsTSlC/gtIuOtbKU4tyuFSvmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696832; c=relaxed/simple;
	bh=8UW4DjKzCN7/KUXqEwp8ZOVxhJmlFicKxfNPHFok9iM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKM39lfmiIji25erfmTKCpuHForPS2AxxOVtYX7A/U5dgFJ2nMhSpERTbkTdrxjiiHIcTKY/p0lfrg3vfHJKv/gnxSIcIutqnppFZKwlQumQc+bKi4rn6Db6PDc8o5YZpRfk1prj4HNvMElzJsMTW5T8PyNUR6ltAsVMK+KgUYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bSeSodfJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bSeSodfJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755696828;
	bh=8UW4DjKzCN7/KUXqEwp8ZOVxhJmlFicKxfNPHFok9iM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bSeSodfJanO2M3A0tNumbg/6tgrJcUB5lOLM64qVh9PL6hSMysrKnDT72m+HfPAZd
	 yP7D5Fn3Zx9PrM3Sas5OKfb3gXrHQ923yuI9Mdqrz+RFrsETvukHEdCAtKq7I8DWCQ
	 1JM/DWpNP6DSfCwgXSJL5c0zTbm/HOKUq7xX0TYea9DljyHUTJWXGf/ayrihWzqxAD
	 Wce1X5MyA51ZYI0DVcKKQL6JVivQRTu1OHaNHVi/pGYsgsnO1ys7Va4R141pueVL0h
	 hmRgjOXMbzkeOIji1Bc5JHB+i8EHe4glV0mRztHxdZHvdYEV6m7/NlhbwsK89PmmYs
	 kubBi6JKKIZkA==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-e86C-1c83-BFB8-e1aE.rev.sfr.net [IPv6:2a02:8428:af44:1001:e86c:1c83:bfb8:e1ae])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 851EB17E12FF
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 15:33:48 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/4] shared/hfp: Add +CIEV event support
Date: Wed, 20 Aug 2025 15:33:37 +0200
Message-ID: <20250820133338.1158203-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820133338.1158203-1-frederic.danis@collabora.com>
References: <20250820133338.1158203-1-frederic.danis@collabora.com>
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

