Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34F224B00
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989397; cv=none; b=JvR3HkZzJsrBtfpJSsiqqZqcDcuc3HMy2cJgzU2bouYvVfP61YqFceJZHIlNgoo71CiYV5KmiiM8bUYDafgUAflfP/9J4UJoZfkIjmSayE8pSX8OboMTkizhMZWJEGvcQZNjx4NlcV+2BedHkQgyst5pIZZ655Su06Bdqy42k0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989397; c=relaxed/simple;
	bh=1ES1jRYLfkvRe4K8iITGRVa2kr1ixFCVXXhwWe50ioY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MoizID88Wlsrk2areSSe5N3i5rQWiq8ad8POcHaPmwC2ZGg1mgcnHqm51SsVdcGXKkZBgdtWBhNgKtkC049wGqApUhe2VKazjsH7ay1GdQNRgcFNmAckfQ4ZHPPauZWUopsppP5XFyszxXvk//FY+N3EgJuZuhvK3fvfoQzczac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L/5CG7D1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L/5CG7D1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751989394;
	bh=1ES1jRYLfkvRe4K8iITGRVa2kr1ixFCVXXhwWe50ioY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=L/5CG7D1iNoMHxIXM4CmxakA6xuMV8ymG5u+AzfG9OvltDZjYKvdmoijML7E/tDnT
	 nVOHagBKt+41OwmA4hcDBV3BaW4/zh+vbgI0a7jEnsv1C/DR1bh5Q9rylhmaN1zQ0f
	 Q/ent7lmCWb+EYFUX2ghuDXy9PIdBsJ5AjdvV5ubrUElTACc4MRm8ZFFrOgc9FxqDq
	 TDSSFMq4ZNhFCe1sy0nKkzxtGwsMSaoPdkEitv701i69zqu8b6Wild5pVSpWss4Ysw
	 G8UsigDUQGSpqnSsty/Be4BSaelJ44nqV8FZVAQ6l1x3lo/CtXmD7KajR40L8zFoW2
	 HXWKEEX+VnI1w==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-a903-aFF7-d14E-7699.rev.sfr.net [IPv6:2a02:8428:af44:1001:a903:aff7:d14e:7699])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 18EA617E11EC
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 17:43:14 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/7] audio/mcp: Use strtoutf8 for player name and track title
Date: Tue,  8 Jul 2025 17:43:03 +0200
Message-ID: <20250708154308.238963-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708154308.238963-1-frederic.danis@collabora.com>
References: <20250708154308.238963-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Truncate the string to first character before invalid UTF-8 one
instead of replacing non ascii characters by spaces.
---
 profiles/audio/mcp.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index d3ccb97c5..5fe7ef82a 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -72,21 +72,12 @@ static void mcp_debug(const char *str, void *user_data)
 static char *name2utf8(const uint8_t *name, uint16_t len)
 {
 	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
-	int i;
-
-	if (g_utf8_validate((const char *) name, len, NULL))
-		return g_strndup((char *) name, len);
 
 	len = MIN(len, sizeof(utf8_name) - 1);
 
 	memset(utf8_name, 0, sizeof(utf8_name));
 	strncpy(utf8_name, (char *) name, len);
-
-	/* Assume ASCII, and replace all non-ASCII with spaces */
-	for (i = 0; utf8_name[i] != '\0'; i++) {
-		if (!isascii(utf8_name[i]))
-			utf8_name[i] = ' ';
-	}
+	strtoutf8(utf8_name, len);
 
 	/* Remove leading and trailing whitespace characters */
 	g_strstrip(utf8_name);
-- 
2.43.0

