Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA7F3BF694
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150637; cv=none; b=DdoDODYdVZHDqxdTsB+M5LobanMxc55kxpHcr7x/dE6Tk7eW0tTmhC69EWPtaJLDcKMORM5M93t9g51sl3TkEOnl6dWoRgoFmCBomcpGsEXpNuHQ7hOU1Nu51h+wvG3zXZxteoYg3LIWQaeDzY+zh2u4iVRBSYLjiOb/7pKs39g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150637; c=relaxed/simple;
	bh=kuP1rFcOsf673xo8sl2/r4MKL8JKfCLV30WpFZ/95X8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMlDqm4zIQ8/SuDfXE7UOLyYClnM3eidAQ3obEtaGY/svNjRlGKnjSjIegtcegGyVkCVSu4VtNfjYIktkst28pR1TahdP9B9Hz/DZyWbokgzhjpcgjOble43EfLjhdra7WDuFUeCKJpR3FNBm5iDhRiOeRUD/PZj0rNuts7sZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hYIbNpAE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hYIbNpAE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787150628;
	bh=kuP1rFcOsf673xo8sl2/r4MKL8JKfCLV30WpFZ/95X8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hYIbNpAE1KhhjYyYZ37/LTLLX4ZtlloZaOZuxWwbNhERf7m279loYI0mP62rVYMJd
	 D0Fb7RvcmPoHolaqnxGA/wRgOE5/8cxJ7keBah8im2kSDV80kbkPz3sizKnyKjOxkH
	 C9LfCQZtmNIQQuxQ1aYkQyb6D8nA1AFgRfTIXbXR0cVhEwWVY2g4Zc3XY+HyRURSgW
	 Zf3CzYaQrll2p19sONHJIIY8G1B9sOq+3Amj8kpLeBU5125JwxTvYfGDVxSGWorpkf
	 jr85BkqSuS4H45hxm8STARZ2/tF4rzvTEk9tPMr4Kb8bYJrQEk1XqphYsy7Nu2nRNJ
	 Yk8lFB9R92+9g==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A5BF17E0CBE
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 16:43:48 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/7] plugins/admin: reapply allowlist on policy updates
Date: Wed, 19 Aug 2026 16:43:34 +0200
Message-ID: <20260819144337.889893-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819144337.889893-1-frederic.danis@collabora.com>
References: <20260819144337.889893-1-frederic.danis@collabora.com>
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

