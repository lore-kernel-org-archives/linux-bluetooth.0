Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A952561A2
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958523; cv=none; b=JUZaKP0sQBCj1Ioi/DT3o9Z8mPgiJ+g4zQVNAU9fcyHEl6YOoxdlJfrBiAYOiysp09MSTtKC8q0xmf7xfx1DepNK/IDxFyjgbo9+U2zaJQqkn/c8aur0DhppVirvFYOfReZ8PzWcF0bLzGb6w4i1YYF3jdsVUNjN8JxcU7ezAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958523; c=relaxed/simple;
	bh=oRyypm7Es/n9buPgTAMR+IkfesQXaaGSP0olbgPJi+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LY3t1AOzUeJhbKCMWWi2MdfH7PyuQ2M4psD2tWu8V8whLp2fdzxd18TFxNi9X0+e2A4fWUAVQOXGfAAKtrcx6ei8JJTICfPQGwLfN16oH7n5Dem78m0z6xAAUklRPJtUfcsfLpVYw1/bFRxvkvWUdvchyIKJ0T9jVTKgq98Db1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PaM+vwke; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PaM+vwke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751958520;
	bh=oRyypm7Es/n9buPgTAMR+IkfesQXaaGSP0olbgPJi+A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PaM+vwkejtZsES6lycLbsI3POJtkNHM2ncVtSbys0jLMDVsGkKCZhryziHmE36U5X
	 3CIEgtPN20btcta7NJx5yltH08r/+SdBPE5L3Q+RYLO9e8BYM7Mtb3bCcqou4AxYhS
	 8LnBKu1Jp97/o8vl4HTIIucVgsVul6h3rLeuhZqwFKlHPg4UuNxNB+cD8bMUYeFWY/
	 JBxTcGMxvpAZTWcJOihnbdJB+3yyAmCjgXu1kNizN2rQvyUl56MUHg/FUFy+Xgpq4/
	 nZKcWcgRruYwr7D1nWcjFa68r0pWf6ry+VbbVNgdLsN4ChGtQ1Vt3yXXQcDT9NT2lZ
	 YTb9ezICb6nPw==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-A903-AfF7-D14E-7699.rev.sfr.net [IPv6:2a02:8428:af44:1001:a903:aff7:d14e:7699])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D480617E1136
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 09:08:39 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/5] audio/gap: Use strtoutf8 for GAP device name
Date: Tue,  8 Jul 2025 09:08:21 +0200
Message-ID: <20250708070822.185375-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708070822.185375-1-frederic.danis@collabora.com>
References: <20250708070822.185375-1-frederic.danis@collabora.com>
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

