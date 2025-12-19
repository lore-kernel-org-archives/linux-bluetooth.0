Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5FA1B85F8
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154551; cv=none; b=tq10sxbG2ABRfe60TAx8qdCLcFC/507HUVUJmKNQTpc36eqD88oOAyH1ptDDdMv7an8iJnFdlC79L308V0r/4VksBRkRNqBHagbqiCa7GANUMGvZYrQ2zQVdowxcvBUcE8D3LNnLo9VUNLGpDLM57xvdkgfwtyyc2i1RjDho1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154551; c=relaxed/simple;
	bh=HrNVwnI3h+JE98zMgyY1XLkm+vyYhg/mlLwxiO6uwgc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U8g9A11FgGC8rjiy62UYcujhQ+zzhJkf7G6aLm85+fdvyp/JJhRp5zokSsx/w4sz5rHX4JCERPpG2AuWeNZZp4h4P6Lr+MZo0gSDwvyCvjC/xXWzlTHi4eBu1X5hECiFo93DPnEQr8nIgu2DT1+uBSyFMx87EXd9Xi+YnXM00a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qbj3rF3F; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qbj3rF3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1766154547;
	bh=HrNVwnI3h+JE98zMgyY1XLkm+vyYhg/mlLwxiO6uwgc=;
	h=From:To:Subject:Date:From;
	b=qbj3rF3FnXD3T7zsJwFTAZYLj6nz7XgwAPbC9DV3+CDggyedh7YcbwQ9gvGX9xUsN
	 hj04O9uB6wefkzJ7kP38w3f/Pw0sqk5lmxtT+5uWEqiEwdNZRZBcZ+c1oQY8MsrKay
	 FgU8OvW3c4lGUKepFJS5syyZH60/1Xd5f2NG1ap+ZvIl4NqkjzthsdUxtR6j920TvI
	 FZVIzwwlef409+cgZcS2G+WmfILvgSZnYqMuaESBqzBKetpDMzQ6V0TqLAfaTgzCRM
	 vx8K0+nE3Baq+mrQjlnEbmC323pAvFh54smd8FWHwIjfGUpqpNF9t5gl1T+s/nkY3D
	 VINpC5FneW1TQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-2e1C-31AC-4A84-8c5a.rev.sfr.net [IPv6:2a02:8428:af44:1001:2e1c:31ac:4a84:8c5a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D5F0D17E0184
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 15:29:06 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] audio/hfp-hf: Add Operator name support
Date: Fri, 19 Dec 2025 15:29:00 +0100
Message-ID: <20251219142902.559714-1-frederic.danis@collabora.com>
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
 profiles/audio/hfp-hf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index d25cda389..384480c9e 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -108,6 +108,13 @@ static void hfp_hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
 	}
 }
 
+static void hfp_hf_update_operator(const char *operator_name, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	telephony_set_operator_name(dev->telephony, operator_name);
+}
+
 static void hfp_hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
 							void *user_data)
 {
@@ -125,6 +132,7 @@ static void hfp_hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
 static struct hfp_hf_callbacks hf_session_callbacks = {
 	.session_ready = hfp_hf_session_ready_cb,
 	.update_indicator = hfp_hf_update_indicator,
+	.update_operator = hfp_hf_update_operator,
 };
 
 static void hfp_disconnect_watch(void *user_data)
-- 
2.43.0

