Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB2A2E1754
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989397; cv=none; b=tPMZb0oxeJW9BR2U/Ojnb1yX6tN+w3dn3rQ/fFqYy1WhHfWclc32W99B2NRwj3k+PguYoIfcUa1U6YQVmar+LZzIIlVnVXo07KOZ4pA4BdZ7iLK2NUBtd3vIj5HBioihPM/6vtyPbZomLXZWb59VMlTQJkeN4nO3KLWvo3DFXS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989397; c=relaxed/simple;
	bh=STdYxHGkc/8zY4rJGotLZnM4XL5k+1Sq4X3YIqUALxQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEjl5mgiTQ/Soe23GXVeSR8OdsY2COsYGf+Y+RHnskA5i0kTzMe7Dl/BBvggW2rIohAlh63h77hU9LHWJBpUYStjQo1ECmrmRVWUTJc+bFyppnt0R9/aRY5fzrW2Gsx5PNAysNGbxEg8qQd1oDUaZFabNl7qd16keSjIBuEvLPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=o/vgeEkT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o/vgeEkT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751989393;
	bh=STdYxHGkc/8zY4rJGotLZnM4XL5k+1Sq4X3YIqUALxQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=o/vgeEkT/uxBwkdCt6a2JKzJFywS1HONFKl11UpIAkEAhvfII+6SeMw/dPXgsCHmJ
	 qTDPjU1Svs0smSoLtZ6sOZVnUa/oU21NP1JM8QBUslUMUymKYbwtX5XW62ljWudb2R
	 MxISaI5MvwZV56XUihXODqFEQ2HimaFYsYJQuQQg7PSpitxCRoRuK9PkTotasV6rs1
	 JwMw3XyBCEVHsVxPH41TPZ9WcYN7fs0fuyvb3i0QnwFBLuKeAQ28S/VceL3XBFxr6S
	 lZCc5Dm2PwHG+YBk7c+hiyGKNRgEnFxy16ZwEXJlAc1DgxWnReyg6otI9ofRWSNDBb
	 JpNMlzSfsb2nA==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-a903-aFF7-d14E-7699.rev.sfr.net [IPv6:2a02:8428:af44:1001:a903:aff7:d14e:7699])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7928717E0F34
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 17:43:13 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/7] shared/util: Add strtoutf8 function
Date: Tue,  8 Jul 2025 17:43:01 +0200
Message-ID: <20250708154308.238963-2-frederic.danis@collabora.com>
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

This adds the strtoutf8 function that truncate a string before the
first non UTF-8 character.
This truncation is done in place.
---
 src/shared/util.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 src/shared/util.h |  1 +
 2 files changed, 43 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 5d3a14d96..5262458cb 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1959,3 +1959,45 @@ bool argsisutf8(int argc, char *argv[])
 
 	return true;
 }
+
+char *strtoutf8(char *str, size_t len)
+{
+	size_t i = 0;
+
+	while (i < len) {
+		unsigned char c = str[i];
+		size_t size = 0;
+
+		/* Check the first byte to determine the number of bytes in the
+		 * UTF-8 character.
+		 */
+		if ((c & 0x80) == 0x00)
+			size = 1;
+		else if ((c & 0xE0) == 0xC0)
+			size = 2;
+		else if ((c & 0xF0) == 0xE0)
+			size = 3;
+		else if ((c & 0xF8) == 0xF0)
+			size = 4;
+		else
+			/* Invalid UTF-8 sequence */
+			goto done;
+
+		/* Check the following bytes to ensure they have the correct
+		 * format.
+		 */
+		for (size_t j = 1; j < size; ++j) {
+			if (i + j > len || (str[i + j] & 0xC0) != 0x80)
+				/* Invalid UTF-8 sequence */
+				goto done;
+		}
+
+		/* Move to the next character */
+		i += size;
+	}
+
+done:
+	/* Truncate to the longest valid UTF-8 string */
+	memset(str + i, 0, len - i);
+	return str;
+}
diff --git a/src/shared/util.h b/src/shared/util.h
index dd357fb93..6fc02a9dc 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -92,6 +92,7 @@ int strsuffix(const char *str, const char *suffix);
 char *strstrip(char *str);
 bool strisutf8(const char *str, size_t length);
 bool argsisutf8(int argc, char *argv[]);
+char *strtoutf8(char *str, size_t len);
 
 void *util_malloc(size_t size);
 void *util_memdup(const void *src, size_t size);
-- 
2.43.0

