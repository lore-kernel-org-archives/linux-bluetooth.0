Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D93DBD4E
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960104; cv=none; b=Qfzh1lVCvjTvme0M7D0Yy1kbRMWhQzLbZ+x2sPHIIm3JShVpHlwtDHn4CRGJfdqDV2tDNvtRS01AH4UWhl2SMlIzo9HC5DEukLk7jk+QDOVIELReqF22V9NyzndX/0U/u/xwWO5F6Ok4m/p0bNPqO0IRin9f7e49yLhgpCUjEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960104; c=relaxed/simple;
	bh=iF9/tWxfqvdGaFVpZS3k/NflBBQJaFTv8/G5QLR6cXc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=THUxcP/Ak/xuo2wG98PaT0cYBboNjihaFxi2SrzTIw9CJqfFXJ7HWYF7gKTAV5IKkBR+0rcJvGCq6o1lerB8MC7ra4hHPeWUuTvsENbvZvarsd/U2w/RJLZy0DOXlEwdOhbNH+uXZd6eIvaPYpeoXxDhwp5+X7GxKqyA/45xDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 99F1A5810FA
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 08:23:31 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A5C33EB8D
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 08:23:23 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] avrcp: Fix media/folder name not being set
Date: Mon, 17 Aug 2026 10:23:07 +0200
Message-ID: <20260817082315.4090729-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTEbJE7C6TLHekb0lap7nTPMocurNW+PCa5hWTUDLADWiTXglouif3W62RZzI1NmhEn/QZULn0B/uQSMUjVX3tx3t+Edr4mtzahTFrq2RbaAbix55yJ93CPz5Ld0YedUOJMjMVeDeJK2Z2dRYjBm+ayceubBREd3PBbaumzjqQcrFXudfbfpc14RiE8aKxRHOSZfOoj7EQdKr1SiFfE7UNnBwidys4asRP61vm1x0LttwFeo2hhx4cyrNDNqCSRGMup4VfvIm0UHhWSe7ZM+dZ/LtMEFKQyWzbR2+j4JrpS/ZA8oU29TpE1menR5/4FHuNkDpxF+rNZALukTeXL+I3iydJVElVrycdqLBU81XUHEx5H+C99zTGPgddFoz3IUpA9YEHRbhqlXRhwuMC/dhyHTKJo10ynxP44s7JIGnISoL80+d9dkFV2/nB1x2SvK7BR0hqec7mcwrpK00xZ1aNfsSNnWdw9dqaOt4tsahcqKfUT8NhiFWmdeORLtLqwEeRvYNyzdoWHTP8TFCjdD5Hc2ThGHZzn2hX3jgdDgtgKQ/IQhG9pGZdhIIjLfDW1U3m3Cx93nCBtb1cbO3oFjytL24JSBuU056KOA6Cwi1IT3X5kfQLkSh7kYSUi/DNOFpTM4ZG2iNhPjpQ2DR2O0HLgAm0GNOXH2RY6V25KanE7WHQ
X-GND-State: clean
X-GND-Score: 0

*namelen was used before being set.

Fixes: bd8989620ed6 ("avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing")
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 23e959c76917..028c1c254b82 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2623,7 +2623,7 @@ static gboolean parse_media_name(uint8_t *operands, uint16_t len,
 	namesize = MIN(get_be16(&operands[name_len_offset]),
 			len - name_len_offset - 2);
 	namesize = MIN(namesize, NAME_MAX_LEN - 1);
-	if (*namelen > 0) {
+	if (namesize > 0) {
 		if (len < name_len_offset + 2 + namesize)
 			return FALSE;
 		memcpy(name, &operands[name_len_offset + 2], namesize);
-- 
2.55.0

