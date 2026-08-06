Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D483318EC9
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022566; cv=none; b=T4a1x6Vk+YwJv7hN9SLCC0Ep0QGMozeFuwRBEublw2YcQQoG7jid9P+TjXpbcoKmwGFvfB5yXcm6PptEbtKkTCCDcJBEBeRKb41yQcHyhjE5cIbqjU/bMZVI2UI8ZhQ2lVaMy5EUZJjNBMpA+IVYC3BtMs9kK++dTdhNPiqrkhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022566; c=relaxed/simple;
	bh=4uTaAq/vc21q98jBtlHLPm/pc2I7APHHZHBbEBQf13A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsXRveHrcKTGnxiT3COD6OZz24vbCwYhKNrXf3x6/oV3TcbRJiMmh7koZR/hfXp+8AcCwjiMv5UOAEUz9JbzPoy1oKsMsNBQw3a/nx9/Jyf0qHoWP/UvvXsw+olFx4t4iqsG3Nc5eeLmYWMliY7enMBtvr5w+AmxQkZojZz9CCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9321D3F4F9;
	Thu,  6 Aug 2026 13:22:41 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Elman Shahbazov <shahbazovelman97@gmail.com>
Subject: [BlueZ, v3 5/5] avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing
Date: Thu,  6 Aug 2026 15:21:06 +0200
Message-ID: <20260806132231.3052523-6-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806132231.3052523-1-hadess@hadess.net>
References: <20260806132231.3052523-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTExch6bGo9l+F+n8sWi19Tdp5I+JHuPU4b4FC3pRSRTSdDWqDXtBA3BgWCtk2JbCRjP+dM+NsZ86mVZl088WvtADKxh7M4lUpzCDjar8B+R7Hlg9qjBk2zMO26fY1RnZ8biX1NnpTgbwSH+2sf6o23tWaf9gfXzV9BckuSJO1rv8bZqQ27Xgg82IyetnXphbsHmmVTxo1szBTUYz4KekaoZ086g+nbGOHUMPXkYqxuVAfBOuM5QhrOtGu+nUhw2AT1dnN/j/VSoqMQXMw/7h7iewvJLLeQs+D3uujuUs0djzQnI0MzXah2j9MXkAJ0OpQ7VPxJVTdaoWGhMZU31W//Zdw1Z1P2ZS4xNZHbt2K4zbmkcxguvJSQ2Et8rhPbZhk9bNqlmhToR3vKfGZ79KKPwX79uQPHz4CBjd4A/0HsXOcTE++RXkadQ2eOFKJ38FNBeLqa7PquRGG24NM8yrk/61J4CtjuyOlGijRIhHWqNxDG89/MlmZBKx9yusGE4w+/cb6ZmJd/cK5PYvUTDXU9SrElgyWn1OlZ/5ZBztPtMXarMaOPMofIUastr5XPAdh0WBWJqmGeJMfxPEkWhrIh0tzf8Pxouqp4cChhSYoiRMX1kuXD409gUS+gYCjtvHKaDg8ZdLXS3BPCWB9F8BEjPp1cIaxcMC8DZ1TgWBYXkDA
X-GND-State: clean
X-GND-Score: -100

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

