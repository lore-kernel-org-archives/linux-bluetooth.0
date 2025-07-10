Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679662F198F
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167927; cv=none; b=VquYyK83VP1/eMeoGNOsjDhqy9ngTmPpja6Bkq23pFGSl8d3MiRCx8jG1NdAWRTus+k5Spw/HfhcWpyiyX9IwAjHfTqGm6djZSaErS2oElXW0nVJ1dyiwiL37d20+r8Am9QBrsQJjwFFEl/Cs7fPiaeMMhSFwSXhJ/pPwEGEGiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167927; c=relaxed/simple;
	bh=8UW4DjKzCN7/KUXqEwp8ZOVxhJmlFicKxfNPHFok9iM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bimw3xLaiqboXu3pu4VFztftVK/qhTGy1WRuy+b11iiQN3ggW/59NB8wodixLqz7o7yIWDnlp8uXOCWO63Kh4UNA+8FP2HwkDEVniDPUJxcvibwfoL4BshplC9Q53Qgi7fNeQvIf5SgHTOcp/Blya5ihoNuX0QlVYLOfTBiiEhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aTyw2o6T; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aTyw2o6T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752167923;
	bh=8UW4DjKzCN7/KUXqEwp8ZOVxhJmlFicKxfNPHFok9iM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aTyw2o6T5XT+3NsnI3gyOQEMcQn7J81j7lG9gYr/l3vKo+r/gYr3a2mSDtqhWqKCd
	 64mtKbfn+Ct3rt8QJDZiOQ6ur1OE+o5Eobm6jdmF47D7pzlZ5ebtOo9BICsEZVfFDa
	 zP7Nr8IzE/HTxOre/hgCLxqgAYc5OaUrgTF+y5m0bI2HsAw2k3bnoq0sWaWYMLg3Vj
	 AUJZ07J0cCCClTjeIqE2ghzqoq0Lf7SUDJw0HGTAHVZmR6WDhryjaYuOdxQfUFw93+
	 edRaLLpKw7wmllCrmh82SEXzqC1eG3xTe8L54BKey2VjjoDyp7RS9J/dECX0F3M1ux
	 uJ/pz5dqtpjVw==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-Af44-1001-9be2-7429-4d2E-B935.rev.sfr.net [IPv6:2a02:8428:af44:1001:9be2:7429:4d2e:b935])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 672BD17E08E3
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 19:18:43 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] shared/hfp: Add +CIEV event support
Date: Thu, 10 Jul 2025 19:18:37 +0200
Message-ID: <20250710171838.949803-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710171838.949803-1-frederic.danis@collabora.com>
References: <20250710171838.949803-1-frederic.danis@collabora.com>
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

