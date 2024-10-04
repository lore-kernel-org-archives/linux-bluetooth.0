Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3292B212EFD
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052855; cv=none; b=ALc04/uv6rJpF4H1CB/vR4CmOzo2ijgHwIJvslWSFCHCapIYzIRMuTwdb3yNehErAxGrHekxmD58x1B18ohpNuwunXW/MfT1CuBKVRHrsloMKY4im1S/lwIqvITkeO0PxebjVSklRdKAiuhLYtZMDHeso3zR+JnBFt83fHyo2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052855; c=relaxed/simple;
	bh=GZGYIac7uutGvNXI79cYaUYhXRq6HIhwcjCz/K7iogQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqdafPZrUUKVsO1nG6I8diMkoGtCuNOb2+h8O/G4d2RsrR/rwQxOmb7As5I9G88RSKISudkE9iKEWvsVNaPbLBq+r5kVmAtiB2Ed8biC4eczsP3TRa2oUaefDNIJLKOYl8UdUMHwvhcLdor4OQbqWTRNXumwMgGZO6C/bogy/Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YA1A0jMh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YA1A0jMh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728052850;
	bh=GZGYIac7uutGvNXI79cYaUYhXRq6HIhwcjCz/K7iogQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YA1A0jMhZKWA9gVhOjur6DaGkkAKPVL9aRSsttkjaZuaeM4ET/K2cjAkl+Ga4grCl
	 gvT6fIL/BDdJAJPp9HZPqgop42wNe8ANj9UOEs5WFBh9/Ju0ndV6/GeidWLD0H0Qv4
	 MoIQa3ZIqDkIKbGv1ZXefRrWwL70iutYpzPTr9UesDo86dprw2yLfQB4pE8PTpQOq8
	 auweQKQgnYhSFlSTRD1QYLnM4nYU4YoBRvwmNGDcxoVnZczW6OEPgilTtfzZWQzOlP
	 W9XlHarggbZJpFPRo73cMQtmx4S7fkNpum73lAJEVJUyX8DJtQ0xgvLrMbin7VeiZh
	 1ASdfdrPVmItA==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 74AD517E35FB
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 16:40:50 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] audio/player: Fix media_player_set_metadata item destination
Date: Fri,  4 Oct 2024 16:40:41 +0200
Message-Id: <20241004144043.419832-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004144043.419832-1-frederic.danis@collabora.com>
References: <20241004144043.419832-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Use item provided as parameter, or mp->track if NULL which is used
by MCP.
---
 profiles/audio/player.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index b3a6920fc..5bb3bc1a9 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1438,18 +1438,19 @@ void media_player_set_metadata(struct media_player *mp,
 				void *data, size_t len)
 {
 	char *value, *curval;
+	GHashTable *metadata = item ? item->metadata : mp->track;
 
 	value = g_strndup(data, len);
 
 	DBG("%s: %s", key, value);
 
-	curval = g_hash_table_lookup(mp->track, key);
+	curval = g_hash_table_lookup(metadata, key);
 	if (g_strcmp0(curval, value) == 0) {
 		g_free(value);
 		return;
 	}
 
-	g_hash_table_replace(mp->track, g_strdup(key), value);
+	g_hash_table_replace(metadata, g_strdup(key), value);
 }
 
 void media_player_metadata_changed(struct media_player *mp)
-- 
2.34.1

