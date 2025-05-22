Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6CC33F7
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747926254; cv=none; b=cJrOSnZAKyjLlNH7cG70YIjoZFV8N/rtUSg3LN8WTl42oyLrh9CvnTCagxNG79x1OuqKVOI+BoUKh9AXSeKxizOK2wfZ7ZkhRNcvxG5Jhht55y7AhGuoctkkQOfxCcT86HOW0ssmD9lq+Q6RT9h+9J/oMcfZXIY3G4Ndud3FMb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747926254; c=relaxed/simple;
	bh=1l3BkDIKbk7l8LtNRRLbjfq/hrRamPyh6PqbNe8ahfg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DWbwSleVbGLg1kLBE0a04gfxo3yhuA2h2KokvW3TtXIXCK4id0e0ooj7KE1ezpddDCwL5wyBHT7Vn46m768ARGjKxpk1IDp3HKbOLKhNW5L/IF9rjoXy4jtcq4g2iyBQ1unTY0oBMgzj7I5cUwsE8BBN15ikd+tKxZm0dUjrhbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WZc/quna; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WZc/quna"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747926244;
	bh=1l3BkDIKbk7l8LtNRRLbjfq/hrRamPyh6PqbNe8ahfg=;
	h=From:To:Subject:Date:From;
	b=WZc/qunahRGghPBk1PzyJthLLCN+i5kh3SfheAEYR5N+rlt0Eiw61624ZVhJE82bV
	 /uQVffActqOIGz4WPXGkWjcx+UfQuNK3VB30e6AAyahHOu2Fg/oaye3gsoU/WYL+y1
	 V0odEiSfqvp/x74YzYZYKO7rQr2ryxRvYQsCPa6fGCu/4mYB8ttLBS2doa9tW1BZFX
	 Wd8MohnIoHCYHgldgCc10W8TvNyNw3aZPP3Uhgn/+DZcV6xT+4T2eqnKYyCjnbdA7/
	 LSyKa7gsfORbWzJUTYwBSdV8k0TnEDF6xVjtcjc5ca6ZqyjpRZgKdVksWmtEAU+9uI
	 1xmS0hR999BkQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-aF44-1001-c115-20fF-2911-21D4.rev.sfr.net [IPv6:2a02:8428:af44:1001:c115:20ff:2911:21d4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F2E4F17E0FB8
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 17:04:03 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/avrcp: fix crash when NowPlaying changes while list_items is in progress
Date: Thu, 22 May 2025 17:03:59 +0200
Message-ID: <20250522150359.634879-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: George Kiagiadakis <george.kiagiadakis@collabora.com>

The media_item objects are owned by the player and while we keep
temporary pointers to them in pending_list_items, clearing the player's
playlist destroys them and we will end up crashing in the next call to
avrcp_list_items_rsp(). The crash is racy and can only be observed
when skipping tracks very quickly in an Apple Music station (where the
playlist changes on every next song)
---
 profiles/audio/avrcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 8d1e03b93..7296ac164 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3879,6 +3879,14 @@ static void avrcp_now_playing_changed(struct avrcp *session,
 
 	DBG("NowPlaying changed");
 
+	/* reset the list_items operation, if it is in progress
+	or else we will crash because _clear_playlist() frees the items */
+	if (player->p) {
+		g_slist_free(player->p->items);
+		g_free(player->p);
+		player->p = NULL;
+	}
+
 	media_player_clear_playlist(mp);
 }
 
-- 
2.43.0

