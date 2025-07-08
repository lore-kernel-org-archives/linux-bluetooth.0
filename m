Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B562E264F
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989401; cv=none; b=Z2oC4lHzA4BcQuNs7DRaddQOxXOecYf3ImBW0hltoxV63SR8NtBoz1yoc5L8BkHhaX4QCdvykV8S6nFRRGiQUMn27seUUOwTtcPnAUHsKJfyWNY6WQKJ8gNr1yhUnVpTDs9hKJwku0x04Hk0MO+6tSLKNYb7xKghFCLMBoFcn8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989401; c=relaxed/simple;
	bh=iKbb/0VhsEjq4xSN3eH9pkLAA+Twkoab/rMPto6+VxA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qj7W3hx2t2fYwcUWTQ+QbFVgsNjZOlKEtlPVRX60+LsBExQNPkN5p2uwDwMlBecQXW4k9ZLuQ0Cdg/8IBkOUtm8IK5QgZ6B+dZQicp2UtX5fNh7+H2xhJQBE7V+qhdCT35dBsQf2k4xx2cve2GZK51c4lhEYDF8GpMtrmtORtqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IkTtnPSI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IkTtnPSI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751989394;
	bh=iKbb/0VhsEjq4xSN3eH9pkLAA+Twkoab/rMPto6+VxA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IkTtnPSI0SQscp6W0e2l2MifmIDnnURj0y06AgKm1QQ7zaWfA0PS+kAwKpK43D9x0
	 SZXaq5TsAchk4y0s8NO/Wh6XHLvVgwVCJZOgIVD0JQ6wRVlr7Sdl7Adkj00wa8vTxa
	 GNIXyVeG9LKm6eVSclenW30k2VUPxxWhfn1VMoUyt/3HwGCMy2qfvMjG8S8Y52zVdl
	 AnRHcEOSCTJ4SbvPttU3DI7JpxWGKTQTYMuIMiaNpu0UzCMVLvyJPPmty6wAFuhwoM
	 4u3ZolYrqImEdD5/BgaLhbuKwXBhCUD+e5kOb1xlzaoaOkCQvPv9PA7pNNDHE1NnNT
	 9QWUI9U5OoBGg==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-a903-aFF7-d14E-7699.rev.sfr.net [IPv6:2a02:8428:af44:1001:a903:aff7:d14e:7699])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AA81717E11EE
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 17:43:14 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/7] eir: Use strtoutf8 for device names
Date: Tue,  8 Jul 2025 17:43:05 +0200
Message-ID: <20250708154308.238963-6-frederic.danis@collabora.com>
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
 src/eir.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index 28b09653c..1e1f76952 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -127,19 +127,10 @@ static void eir_parse_uuid128(struct eir_data *eir, const uint8_t *data,
 static char *name2utf8(const uint8_t *name, uint8_t len)
 {
 	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
-	int i;
-
-	if (g_utf8_validate((const char *) name, len, NULL))
-		return g_strndup((char *) name, len);
 
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

