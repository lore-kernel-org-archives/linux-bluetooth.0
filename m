Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B8221B905
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958523; cv=none; b=pV4Bx2n70o8ynnCOQwE6ejalRTjwjk2tidD+FkXbVyvImws8TKQajkB5zPcUn37D1xJ3NUwmWqXdwciZ02KIVbg/q5wct94PUYtbLZDuq1Mek2Er9lFjEKR+zY6xz4D7UgbbJe8YJxyS1Dvsg9eAqIGtYEFzonwgoM62QdvRLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958523; c=relaxed/simple;
	bh=STdYxHGkc/8zY4rJGotLZnM4XL5k+1Sq4X3YIqUALxQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4t4Yw6iqmz2GRX5h1G397o5gV3TfKrxDCSowXTfaf2xRm7WjOhruw8szU67qCs03qmoM5LoFPSdQU71bqIYZ2GBCtBXiwOAiayW7s2zLTwaZ/Y2nsy8LwMnLwHjaUZ/1XGg7SyQHgGqMOiTOnXdPKB2y4q9kgdpJ2r0/ChtkYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SRpSw0ko; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SRpSw0ko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751958519;
	bh=STdYxHGkc/8zY4rJGotLZnM4XL5k+1Sq4X3YIqUALxQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SRpSw0kowMtbVlWL48Ni5ws8WpEzETXZYDr9yOT5IB4oofMAXLH0ySwDUeqcJsvIZ
	 JVj8Gj04aAaqF7loI41VVH4n/7DEK/mAYOJ6MgeZlIb0nJFAJ3YmZWsWwNghMjGguX
	 UhOuOdYeA+Qi8+uTra+URu6CjypM1VXDsULIYVti5IcK5dlm9ZzlHiWKiEgjHGNBWd
	 pgk2xRLw3RYSPvmMeV2AUVjBRDo/bln7912UhzWeaGCl4vfPQ8A9gFRAlMPsC5JI/3
	 9QzXdbYLE2PbALiZJ9XbEzpWjQCHscNKgOnHER/x45gZA8FXPRNiA3kj67QakTFWcN
	 9dzQkYY9VC5Cg==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-A903-AfF7-D14E-7699.rev.sfr.net [IPv6:2a02:8428:af44:1001:a903:aff7:d14e:7699])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ECFDD17E088B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 09:08:38 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/5] shared/util: Add strtoutf8 function
Date: Tue,  8 Jul 2025 09:08:18 +0200
Message-ID: <20250708070822.185375-2-frederic.danis@collabora.com>
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

