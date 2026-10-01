Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689714A0F1E
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889051; cv=none; b=uODoKNpd0dkDLxGXxHWUj1uJSkHMXOl0R6AugAnBSX3Mq++CyWXg5xRp2VQOEXWlKlvlDKiuAzBC9mrXa+8XFvgrvt0pOYC7bN/1N7BuivTDMgPeNgXwP5U6telRaNrSjzi4C8M7xe2ahgoQGs79V4qTQh1c3rlHcfyP7JLq0SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889051; c=relaxed/simple;
	bh=6B4ynbXhoUl7TiJf6mtShB5ZL2W4HtfxWPE+bf50Ivw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrxM8yKikuZdOm1YR8px5b8UO7cIYz0hbM3BI4WYrv2FHMnqUqpzlR+IVIqCnDXWKaeHeaJNHxbfAZN/eYeLD5SqQilpIvab6/f8qMA6VKPUB2oV0UfaC6cMqTfbDio8viKFOUIcIw39Bo/8V8lcmK/A9nZzbKzqQHhdEhOxd9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ljkwhe3R; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ljkwhe3R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790889042;
	bh=6B4ynbXhoUl7TiJf6mtShB5ZL2W4HtfxWPE+bf50Ivw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ljkwhe3RrwJUFXpUB4iv1g91ylcdz8l0d13F8vpDXsBeY+YQ8V7eh2JS6hBCN5BUl
	 09Zhc3H7kIPsxJ/VLKicIAilSvKsRbiYYdTgXoHBAyRbx3o0WXEqetu4/2YDzKPqYx
	 perEMddna57dezqzRnfTzMy8LKv8ISgp+A/7Wg21jOXmbZ0zGg4464rChmIyrKkFd1
	 ZC3bwItuik1ta1HwQVEXmm1zJh7+NKgHTgTfNtApz/y8vN/C1NwZFEWgpVHLT3sMx6
	 rHahDpcZJaWmvryOvYa5ze3UhV3tgZjZDKEHH4iCVG1lBaBJGtSeemnwj+3k4eaeNA
	 FexM7SF6ZUFfA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F29F617E056B
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 23:10:41 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 03/12] client/player: Add MediaEndpoints for HFP HF codecs
Date: Thu,  1 Oct 2026 23:10:27 +0200
Message-ID: <20261001211036.1760396-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001211036.1760396-1-frederic.danis@collabora.com>
References: <20261001211036.1760396-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis.oss@gmail.com>

Assisted-by: Claude:claude-sonnet-5
---
 client/player.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index ae2ce66f0..88221076c 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1363,6 +1363,18 @@ static const struct capabilities {
 				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 26,
 					240),
 				UTIL_IOV_INIT()),
+
+	/* SCO CVSD:
+	 */
+	CODEC_CAPABILITIES("hfp_ag/cvsd", HFP_AG_UUID, 1,
+				UTIL_IOV_INIT(),
+				UTIL_IOV_INIT()),
+
+	/* SCO mSBC:
+	 */
+	CODEC_CAPABILITIES("hfp_ag/msbc", HFP_AG_UUID, 2,
+				UTIL_IOV_INIT(),
+				UTIL_IOV_INIT()),
 };
 
 struct codec_preset {
@@ -3069,8 +3081,10 @@ static void endpoint_free(void *data)
 	if (ep->msg)
 		dbus_message_unref(ep->msg);
 
-	queue_destroy(ep->preset->custom, free);
-	ep->preset->custom = NULL;
+	if (ep->preset) {
+		queue_destroy(ep->preset->custom, free);
+		ep->preset->custom = NULL;
+	}
 
 	if (ep->codec == 0xff)
 		free(ep->preset);
-- 
2.43.0

