Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8FE3D45D5
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847524; cv=none; b=PMBXhiaec4jjb89m+fdpDwP13ofp5H1xMJzJzYMNbzmDqKuraI4FiDPZweiacVDgUjyu0yCjpIODQRsBs7Y7iY2hvf0XT0EGp0CvoZ7EAlttWDS6XV2szxd6/Sp5F0dVwydey4y2KmptlZhz5Lc4/4/OVaalZmIg62VQdlbV11U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847524; c=relaxed/simple;
	bh=4uTaAq/vc21q98jBtlHLPm/pc2I7APHHZHBbEBQf13A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFzv4o7lwfzm+XsVfBXaBQ8o5qjUXRPVCeLFrH30C9eHhUnRvPvcWxuAcf1ufPGzU0sy2/RuZtJU+JNegWXttfyhrPTQRlEig6l4FMYjj4XOafR0YSajFZXGkfaoemRzB3oRH98pEyh1vV8tmiT/7rQ2dUg2F+yrDKI+0rOtbIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D38003ED4A;
	Tue,  4 Aug 2026 12:45:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Elman Shahbazov <shahbazovelman97@gmail.com>
Subject: [BlueZ 3/3] avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing
Date: Tue,  4 Aug 2026 14:44:50 +0200
Message-ID: <20260804124511.2212066-3-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804124511.2212066-1-hadess@hadess.net>
References: <20260804124511.2212066-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGkNgIp5rJedV+62E+6uPUTVGQ4JjZZz7SXztVtyFpdW5b/CCoqIv1nXhFBqFK8vpKGkVGnlNCZzAtOE4Dwbystc9HAzXLdBCIbQ2wM/kgxIFyh2qFpzMJ3wRzypABCNsRaiOMLXtrPVSU0AXyZHRfuWrHDJNba2wYsUm1cavNw1hG8OwowBUvTpoynXjWRqcjn5sX15wnPNIPoKHsGAx5P5feIfhPWZPpAdUj4esE1XYnXgLdxC1oMZUQwnP0d6LUjpXcEmNE0Cd0MNgl/2TYpC4UdvU7xUccND9Y+PXSTbFTSBu0QhwksGmYtF/MPmQg1k7gHHzOynhsMPUzkrn25NEAKAR+wKOg7YksLA7OQp7rJb2FUskjBm4hplVQcL2vYSeQfM/06VZhz9A/J1av5tiaxBm8VsU63WNGJSf7vCI44LSSKoC4gR9QXIbiWrnDw/oaOZ7rnMMOiCUjC20F8nAQmqbhBMCInVqv9+QyrFp1v+clznZCPXv7h25GYvDRm0jN6KwtDxuTXlWmNkR1QOzeLqwK5p6zZW58M3zdGdfSFT/HlDMxv/7ro2GMombX58bW3uhYO+iCBVgcYbRdRHO/2tmW7wz4GnQQu7gcnQ4Dw1WLQ6v3FP47vSM8EtuXW5XW19FEqFc6myBcqYcXk+6ofhnWTmHDBNZ6gPQ4cAA

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

