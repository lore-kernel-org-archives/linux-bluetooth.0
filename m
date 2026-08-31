Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31623B71A1
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 06:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156734; cv=none; b=Bi/RaW5GJuZnGF90OXTYnLKTIV5oPCQaaPRhU49Lr22aMB+9KA+C1azA6hmVxEvNrPP5UbpFmUAgUkHjPlMENLziq2XpgyyX+CX+1lxRMslVBCRVEcH3zzE3emsXqQcjxOVYRCFbsfkLWSqmG9f/RNL19KFqWQz/qd3/hmovFhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156734; c=relaxed/simple;
	bh=OOAUM33/SBM070+ClP79NceeZjbkXn6N4EY2GdbwgWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHpvvOLFX4BA8lFIYU1Rd8UZda8W5H89nbw0TuhScanc/Mv6Nz99iiMIpzmV6MHHKZBGh8oDEcqNg/gyL6dUzQdgXHh/+/2rsgnB5eAw0l4YU1YpIMvZjG4C7l2cmgbCO11/+s5Acfx986XSy2NTVckdRi+tqGPa3jhlRcvcjns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VhLp5ajm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VhLp5ajm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788156728;
	bh=OOAUM33/SBM070+ClP79NceeZjbkXn6N4EY2GdbwgWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VhLp5ajmom0B1uTSbS9peuS7gIXbfmM5JjUZjEXKqRNw/eTcZlbaEQCZeMgI+RmKJ
	 0M9YpZv4hoeQ6egB9sa4fkK/7t7/x8oRW2ct1aoNa1K5SMmSsZ7FY7WkrLZfiHuu/0
	 cD2wUsfV2b83pAFkHjXYuLSbzLrz+muPg2sT7+Q0WlB93QKmH2mgx2F6EwKKHowb4e
	 n+BS+RAHMfpzS3/foq2bmaog4Nvhb4oG94g8/7iGZl1ESIoQ83TPgjmdxQO1KI5A0w
	 eSsTxlO0AdizKkQTUaueO530S+VZudZfMJ6hujebnKcxIzogND9A9tTNP/rbXhCdsB
	 qGX2udNVmCPJQ==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C22F17E0177;
	Mon, 31 Aug 2026 08:12:07 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [BlueZ PATCH 2/3] profiles/audio: Support MCS track position writes
Date: Mon, 31 Aug 2026 11:41:43 +0530
Message-ID: <20260831061144.7767-3-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831061144.7767-1-raghavendra.rao@collabora.com>
References: <20260831061144.7767-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

This is needed to Pass PTS GMCS/SR/SP/BV-02-C test.
---
 profiles/audio/mcp.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index 4df388a22..fc9d2dc73 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -835,8 +835,24 @@ static uint16_t mcs_playing_order_supported(void *data)
 
 static bool mcs_set_track_position(void *data, int32_t value)
 {
-	/* TODO: add support to setting position in org.bluez.MediaPlayer */
-	return false;
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+	int64_t position = value;
+
+	if (!p)
+		return false;
+
+	if (value < 0) {
+		int32_t duration = mcs_track_duration(mcs);
+
+		if (duration == BT_MCS_DURATION_UNAVAILABLE)
+			return false;
+
+		position += duration;
+	}
+
+	return local_player_seek(p->lp, (position * 10 -
+				local_player_get_position(p->lp)) * 1000);
 }
 
 static bool mcs_set_playing_order(void *data, uint8_t value)
