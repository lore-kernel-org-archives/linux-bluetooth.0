Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915BF3F3268
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853491; cv=none; b=mWCTvdNC6gTSsLm08jJpOMqh+i1umrYWaGMHXytlAvTMJBH7iapx4CmA/5L20Bb+k2UhGyu0YIxzcHKa8uwlLlT8X5K1d10xeQt9ialwwLo9XTUJAjy2JkyxrczNDglWmt27U2+oXDR56I0t9xFDoA+/4vJYBJmXfX4+KhKMX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853491; c=relaxed/simple;
	bh=4uTaAq/vc21q98jBtlHLPm/pc2I7APHHZHBbEBQf13A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KseZmpnbX7fG0CEpGRF70X/VFMZ/PZ9pjOgT6iklNKvDMfun7khkVX7ALu5oKjyuT/ZAA34b2D7c4jUU8EAzBU0700enNd1kB87RWrqiv2YLFFwWEgIYbZGQSGNcAQpoofPZ58OM1U9XoZ+Efhy4sUpNfMat9LVEiCjovJXw0nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B6153ECE5;
	Tue,  4 Aug 2026 14:24:28 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Elman Shahbazov <shahbazovelman97@gmail.com>
Subject: [BlueZ, v2 3/3] avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing
Date: Tue,  4 Aug 2026 16:23:32 +0200
Message-ID: <20260804142419.2274153-4-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804142419.2274153-1-hadess@hadess.net>
References: <20260804142419.2274153-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: dmFkZTGmriTdrOOSHa91FgEaZhDWZHEK1vhojQJYFjJc4pif93boyH4pA/pIanvNHwp8mC0TwFBfPEzOT7RAUVYsxyBI81f8zDBE+OAfi2DRQ6Z8qlbS3/cQJ+I97mu/15XnR+2uNa45Tuhsj64ij658+IpIDvRi4su1un65CrNajDT/DUyiUKv+Q9E6hQ0jxDWSWeRmhf/gB/R5Bn59TSK6fDHaxckdwyPN9QPMfNXU1KVjjkqSM6RtGLqy7raL9yygVGsvqw0ZEqOD4z6fOJdKIGZilWC9OeRk24TyEtOiQyAvcrnHiUpnG4Yt4kTL6fMAH1AWIuFjZeuAtOUW/pHf2DFcZbVnGx8QyOs1jxP7RXcqlZlHd5cS9AabHzhIxSezSb8KfRnjEzip47Ri38al5zZszDD8IZBP5KGNye+6JRPaw5/MtwdbOfHxNJfpZwDaY4KxERLGbhIIcZ0Px3gTEd2mcVz1vXG6lGeit9zbYmP+qgpQkdTq/Jrbb+/cs6n+q78NctvX2RVCDskt8gJmBe7+ihiepsQOvnkcCx6O3XlVWz+8J1y06B3YDqVCC2J1xps16BVyMhjdKyuLREJ+euO0o4V0a4UXAUq5CojYaJHGw6PQyuRIkko/wRe9G3mWUX/hUYQY2clavQYWdOSlQyJi3xccSIbeb0jY5xzBDwGlnA
X-GND-State: clean

From: Elman Shahbazov <shahbazovelman97@gmail.com>

Co-Authored-by: Bastien Nocera <hadess@hadess.net>
---
 profiles/audio/avrcp-parse.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp-parse.c b/profiles/audio/avrcp-parse.c
index d3d0a070a4da..251580fd9c55 100644
--- a/profiles/audio/avrcp-parse.c
+++ b/profiles/audio/avrcp-parse.c
@@ -20,8 +20,12 @@ gboolean parse_media_element_name(uint8_t *operands, uint16_t len,
 		return FALSE;
 
 	memset(name, 0, NAME_MAX_LEN);
-	*namesize = get_be16(&operands[11]);
+	*namesize = MIN(get_be16(&operands[11]), len - 13);
 	namelen = MIN(*namesize, NAME_MAX_LEN - 1);
+
+	if (len < 13 + *namesize)
+		return FALSE;
+
 	if (namelen > 0) {
 		memcpy(name, &operands[13], namelen);
 		strtoutf8(name, namelen);
@@ -39,7 +43,8 @@ gboolean parse_media_folder_name(uint8_t *operands, uint16_t len,
 		return FALSE;
 
 	memset(name, 0, NAME_MAX_LEN);
-	namelen = MIN(get_be16(&operands[12]), NAME_MAX_LEN - 1);
+	namelen = MIN(get_be16(&operands[12]), len - 14);
+	namelen = MIN(namelen, NAME_MAX_LEN - 1);
 	if (namelen > 0)
 		memcpy(name, &operands[14], namelen);
 
-- 
2.55.0

