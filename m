Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C478367282
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981417; cv=none; b=akveSF8rojwgrPb1Bxy/01CdIbBT0ffXt5d0QJlNBQOClboJJYq7giWzTTR0urs+sneakKUbUGYkkKKiqXQ8DnhFzD87+YF8CsPmbrCgTDl23MO4sNxNQrFMea+agv+XYIoeThC/oeUZp8380rHLISdYQlhDeMjLZndB16T+qGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981417; c=relaxed/simple;
	bh=kuP1rFcOsf673xo8sl2/r4MKL8JKfCLV30WpFZ/95X8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDaOu/r51YUBciqVRKKegtysEmngSlOoliKxeqqR190jxTNt9Zpr8yE7IshyZ7rPhYNPTAluIbton0U2jwUXuskhrfXPsGjfSak6nZ8w8TWByv/7Obtp0J9Kao1W9HTxfZry7VKiYulUXivQPXZY0sWv9zneE1XDRDNj/om3AcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DGIFJMlk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DGIFJMlk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782981411;
	bh=kuP1rFcOsf673xo8sl2/r4MKL8JKfCLV30WpFZ/95X8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DGIFJMlkx/2SPIUKC7I4UfLYvFesUn0+GlW3kAJ3S49kvpKESPUvsdHwnMawpKU+s
	 iC9/9YyVAioTatXgMXOd5v4KWu1oaC/xPn5ow24WQ7ucLSuw11ZBDjAg9d7BD4r91O
	 9TBiBWfhU7ekdd9oHmFFRps3q0uoP0vs0q1BeTFFGFjRG9EiIf2Ucdfc7m5TRirapd
	 Cj2paYtzpWmP+svg0DDGCeyMqAeibLkAZV/FEZ7r9Tw6yonDOiOhxTiBbe4NNj0qum
	 txVfl8q7vBvq+aHl88SlLi/TAdXK0wUebyc20SfLaQBkLbjOQX7XQnUMNCUvzRzevD
	 pe3h61bkGq3og==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7099617E0FAA
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 10:36:51 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/7] plugins/admin: reapply allowlist on policy updates
Date: Thu,  2 Jul 2026 10:36:39 +0200
Message-ID: <20260702083641.378994-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702083641.378994-1-frederic.danis@collabora.com>
References: <20260702083641.378994-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Invoke adapter allowlist reapply after SetServiceAllowList updates
so runtime state follows policy changes immediately.

Assisted-by: GPT:GPT-5.3-Codex
---
 plugins/admin.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/admin.c b/plugins/admin.c
index 6c5c8d97f..07bd0bf3d 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -203,6 +203,7 @@ static bool service_allowlist_set(struct btd_admin_policy *admin_policy,
 
 	free_service_allowlist(admin_policy->service_allowlist);
 	admin_policy->service_allowlist = uuid_list;
+	btd_adapter_reapply_allowed_uuids(adapter);
 
 	return true;
 }
-- 
2.43.0

