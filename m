Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B553E6DCE
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106151; cv=none; b=L4LViHTFfyiFSLKt3ojYF3a35zOcZGvknsLeED73rx4i6ZjJ+Bc79KJvxdcvT08m+o8Wmpt1E5G6nSZ9Bcatg66G1OQEy5a+pD+9QssVyPwAX2gOMaA8VZ5R0FqkwsVBTM9CkKW3wGd3UzGCy034ZkaXiqOwsMIvwCs/JxReoSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106151; c=relaxed/simple;
	bh=kuP1rFcOsf673xo8sl2/r4MKL8JKfCLV30WpFZ/95X8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQt5fh+JHihgTeN42CdkGpoEitpq/n/spWCsPZMq8htuFTILr+bW+01ZcoSe5ttnnU1IciwZDYZ8VW5fR4E2NCkPpONMISL8j4weVygq5TULD+49xO5Tes8t9e/LF+3xtO048xsDey9BDiZKupwZA1DpV5a/HFJDqvFxUPQrkQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZVveK/qe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZVveK/qe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784106135;
	bh=kuP1rFcOsf673xo8sl2/r4MKL8JKfCLV30WpFZ/95X8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZVveK/qeX9H4bylA7qpnfBDXbfEt1BEx4IPtlB9Nw+iSz8rHz7TaVguVW+y4jcqJW
	 4s3IqiwFcsOAjJV6SzQLvw7rlZeAxdV6Xf5rFiqUsF+eaXeMf/QoRTaYcfiNsOxaMT
	 YXkdr1jGARtnq9ElfS+wDKyKPqoUcxaYXlIOGsV6uOvVdiOR3ntUYPWrswEkPozsY3
	 urgaOHbYG9bzA8rHq9xXigz7R7IPA/DM4lyh9QoGW7bxs6o1melS0JWNd++Vu0NGdZ
	 feXZnZdc6F1XVTk57xqIR4XwJDb/F7aUcBkVhoBMJV+CmMxXufebtsOaDdjYBfFblS
	 Q82Cq8oAH2doQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ED3C717E0E3F
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 11:02:14 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/8] plugins/admin: reapply allowlist on policy updates
Date: Wed, 15 Jul 2026 11:02:03 +0200
Message-ID: <20260715090206.212130-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715090206.212130-1-frederic.danis@collabora.com>
References: <20260715090206.212130-1-frederic.danis@collabora.com>
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

