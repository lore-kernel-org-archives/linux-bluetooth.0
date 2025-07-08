Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E77B2DC35E
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989398; cv=none; b=VU5czfX9kOy5Ef0MQIsPaVRCEbiO8h9NCZfgVcLzYD1rY45DneZgt3DwgBXHvZlflUUXOwHkFxeLaCeHET2VoQ6kp7/ONlpQYZ7Ipeu7lt2XiDa7ndtcKSsWgii3GmImyhMUdg0jh0dbw0kNOreg+g4i1lchTsWs1X12AHw4qV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989398; c=relaxed/simple;
	bh=oRyypm7Es/n9buPgTAMR+IkfesQXaaGSP0olbgPJi+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3w1KYq9ZrFTeHZ8BNH83Q6lD55KDOLfgI/hE7Wv0FQdsLw3eztPnQSBkjpODdKjMJoti8NP22cqKtyycH6naR6A6YI1a0ApCv+7BJSdZcgMmqnJ694rtH8n0pqvj6E6F/ncylp8ogWb9so9zclFeQBGPKRyLjMrRd9Si1EZnIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iYVo8AjA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iYVo8AjA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751989394;
	bh=oRyypm7Es/n9buPgTAMR+IkfesQXaaGSP0olbgPJi+A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iYVo8AjAgRNVy+lxIIOVmRxn4o33Fi6NQX+BxiwU1fhWtdKQKq8N8a5Vl4zHyoJlQ
	 1hPQOmEjdDywYf+sQpQJb9fphtJHXwL36TFPUPy/Ilrv81Rt2cKgHThYyWT/3LBnxP
	 7oINq5i7nOolnCIo20+WUIAtNtbCRc2BEZid/Rf9fpbkitYk+zwmA3Gdl5H0drbj7Q
	 ndINq/mAPThYCiLZFTOwxvPXCOAtY4xL36HMZqZyqnSfsso30pBgNrDWYSTLwuE12l
	 wB/N4HqGmbf6y+bRJrjsgL1xFuiQxn4iGmhM/1x+/ibmSxXgFmzAxJpHesbg8LeFJ7
	 gisxPN376tNFA==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-a903-aFF7-d14E-7699.rev.sfr.net [IPv6:2a02:8428:af44:1001:a903:aff7:d14e:7699])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6320317E11ED
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 17:43:14 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/7] audio/gap: Use strtoutf8 for GAP device name
Date: Tue,  8 Jul 2025 17:43:04 +0200
Message-ID: <20250708154308.238963-5-frederic.danis@collabora.com>
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
 profiles/gap/gas.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index 08aaf19cb..74dabf41f 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -69,21 +69,12 @@ static void gas_free(struct gas *gas)
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

