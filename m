Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F18F1CD1F
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Aug 2025 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756066180; cv=none; b=SJVbwwAHIUmOEE4rvFslfjIDYl2/aiaQSWf4vXUf6lUZcjD78VeJ07hXa3ItBJdxwDNZHYf7K8v9H0Jp/yAHZA+R+GTAD0iKeEBE2EOsnoX4cshp6ZxTObr8+bfGLqL9GVOOqe1EMqNxD0R3YpUjcfNFcMV82cbGarBu1DmJbVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756066180; c=relaxed/simple;
	bh=NGiU4CzXU+dgsjrtZAdCgLALN/ywOHzHztMSIQn0w+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LixTl+VvFVRjVQjvkM0oM0Bs6joYQXdtX8vgtgT0UewvUdc6+ANg5aNXjkDJ/MyFbZE0GLFmKyoBVitnQ6LdIBahjMSJFC9DnNg94XpmNitAPwW0xZFQzNYvGPuZaZEG+oFUb6KZoyCpXZYYEcKWIZX+KqLPM7lt8xtHGMA+fQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3dCnYeh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3dCnYeh"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb78ead12so500618666b.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Aug 2025 13:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756066176; x=1756670976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSYpTf1YoXmWMzpmlrdy6dEei4GcnfOQCr9CHGyEX8M=;
        b=B3dCnYehOs6BWGSwlFbVVF/F2sPTMqs8YvJNO81Jc3kZwlOTFCNMGcXqWPMmMdmL9V
         X/p4//R1mLrv5jmYuf57ivWKa/4uN7Z/WJvNEAvSddmtf4hVPf6UOdhuMyJ3RTLFR71j
         5cCOn/4jgUpzjoBZaYJcIFpAXHX4u1y/rlrvI9Ht78fE83SD1wo7duXEPJ05GpYFajFP
         2ZNktXv3noioAGC7Nu/ffc7BA1kaK9Av3h27e0DslMMIM8WN1Y6VB7KDY4w2NlBJPA2V
         ALTLB2Amex2pLtRQlCpeuMaR9agUwSBTSgGaim5OEbLyqOyfTwjnL/h9HaJOVEIPhE2m
         wvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756066176; x=1756670976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSYpTf1YoXmWMzpmlrdy6dEei4GcnfOQCr9CHGyEX8M=;
        b=xLor0pzOF5zs9LHAHQqvcI+CQ19QkAdsjPkiWTrTXR9+8OTQViALOJ9MgGSJZsJGV4
         /v8vIUt3mqsosV526oW1QEl/Gptrtx87E9bU4dH+HtUIpTXoT2zlT/rRirRj45Xrhq+T
         rfkiQXkIxLOy7SAM1dUGNchofBxTZCFRQv0d9lHZC7m7kkaH970tyfaCUMCrSyN3CuKo
         ZwK8DbwDTojEWtgS1Q/COdEwrXhJ/LN+pV6fo4QypR9LzXvhHzwCjlb/1znkFC1PmOxz
         DHKCmwXCfvASju2cS+Qlhdf8YMqUDJbQMOr586pDqHrEafwzCHDeg68sJxuLTFpQCSMK
         eSig==
X-Gm-Message-State: AOJu0YzvaMiWaEATucJqP5ZJDD3SvIkHmV/dA0y8tta5y7nXCWt+O1MD
	7/2Re/4XLXVzo+UdABd9V3YTOBETk1VxCNxxD/AG0tJOP5ZwVvt4VU6fXImHRQ==
X-Gm-Gg: ASbGncvKNssEv8otqCjqZSdpR8q5uMiC1oAq8Y0RkQknU3gv2MEn5XwGIgJXhsUf8nh
	63S4qKRuh+GmSsWHUz4JN3+VK6idbb0r1VJ9pdqtRIZgMN4wvTbu64RChWpl4ypWOpga7NhxUs7
	N8PTKEjQN4kE3pP+Df2z4F3BP6W9/hWj5K188SEzAcIOH8sCGGTFmlUP0dAnsUAyCVxqSAeaX6n
	FJdlf7VTD6UBEIX+aZjg3qCc9an8ITEYMTxa9Zl7HL7Z4FewnUBDk8SWlUUu/B5ImQK8HPN72pt
	vcWQpNSfJltqhChm3HEw9J8yGcmdkYT5jNtqmE45wq1Y9b5gUD6nkOkDKLvGiSZRE+FW3cDpN8U
	30Dt8siCwzmZ0rFd3TMGNyfYP1sJh064rLCbxWEIJxJV/mpqKlVuM02XdiQqZOFH1XaXOf8oQ5o
	Oj3fc6/RkKffFMi9+PFg==
X-Google-Smtp-Source: AGHT+IE5gHhLtFDPxx5PJj53hAmHRUvuBGnB+6fiy2pnZDne/474/uGltJSOvLJtl8YAH/WvYW6KEQ==
X-Received: by 2002:a17:906:4fd2:b0:afd:d994:cb3 with SMTP id a640c23a62f3a-afe294d3edamr815510466b.65.1756066176120;
        Sun, 24 Aug 2025 13:09:36 -0700 (PDT)
Received: from localhost.localdomain (46.205.200.232.nat.ftth.dynamic.t-mobile.pl. [46.205.200.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49310e9asm425492766b.81.2025.08.24.13.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 13:09:35 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ 1/2] lib: Fix out-of-bounds write when concatenating commands
Date: Sun, 24 Aug 2025 22:09:19 +0200
Message-ID: <20250824200921.308503-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes the hci_commandstostr() command by writing new line
character in place of trailing space when wrapping long lines. Previous
approach was to append new line character to existing string, which
caused buffer overflow when there was more than 9 lines in the output
string.

Also, the last trailing space is removed in order to return
trailing-spaces-free string to the caller.
---
 lib/bluetooth/hci.c     | 25 ++++++++++++++++++-------
 lib/bluetooth/hci_lib.h |  2 +-
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/lib/bluetooth/hci.c b/lib/bluetooth/hci.c
index f9feaf185..a1eccaf1e 100644
--- a/lib/bluetooth/hci.c
+++ b/lib/bluetooth/hci.c
@@ -604,18 +604,26 @@ char *hci_cmdtostr(unsigned int cmd)
 	return hci_uint2str(commands_map, cmd);
 }
 
-char *hci_commandstostr(uint8_t *commands, char *pref, int width)
+char *hci_commandstostr(const uint8_t *commands, const char *pref, int width)
 {
 	unsigned int maxwidth = width - 3;
 	const hci_map *m;
 	char *off, *ptr, *str;
-	int size = 10;
+	int size = 1;
+	int pref_len;
+
+	if (pref) {
+		pref_len = strlen(pref);
+	} else {
+		pref_len = 0;
+		pref = "";
+	}
 
 	m = commands_map;
 
 	while (m->str) {
 		if (commands[m->val / 8] & (1 << (m->val % 8)))
-			size += strlen(m->str) + (pref ? strlen(pref) : 0) + 3;
+			size += pref_len + strlen(m->str) + 3;
 		m++;
 	}
 
@@ -625,9 +633,7 @@ char *hci_commandstostr(uint8_t *commands, char *pref, int width)
 
 	ptr = str; *ptr = '\0';
 
-	if (pref)
-		ptr += sprintf(ptr, "%s", pref);
-
+	ptr += sprintf(ptr, "%s", pref);
 	off = ptr;
 
 	m = commands_map;
@@ -635,7 +641,8 @@ char *hci_commandstostr(uint8_t *commands, char *pref, int width)
 	while (m->str) {
 		if (commands[m->val / 8] & (1 << (m->val % 8))) {
 			if (strlen(off) + strlen(m->str) > maxwidth) {
-				ptr += sprintf(ptr, "\n%s", pref ? pref : "");
+				ptr = ptr - 1;
+				ptr += sprintf(ptr, "\n%s", pref);
 				off = ptr;
 			}
 			ptr += sprintf(ptr, "'%s' ", m->str);
@@ -643,6 +650,10 @@ char *hci_commandstostr(uint8_t *commands, char *pref, int width)
 		m++;
 	}
 
+	if (ptr != str)
+		/* Trim trailing space. */
+		ptr[-1] = '\0';
+
 	return str;
 }
 
diff --git a/lib/bluetooth/hci_lib.h b/lib/bluetooth/hci_lib.h
index baf3d3e12..2cb660786 100644
--- a/lib/bluetooth/hci_lib.h
+++ b/lib/bluetooth/hci_lib.h
@@ -146,7 +146,7 @@ char *hci_lmtostr(unsigned int ptype);
 int hci_strtolm(char *str, unsigned int *val);
 
 char *hci_cmdtostr(unsigned int cmd);
-char *hci_commandstostr(uint8_t *commands, char *pref, int width);
+char *hci_commandstostr(const uint8_t *commands, const char *pref, int width);
 
 char *hci_vertostr(unsigned int ver);
 int hci_strtover(char *str, unsigned int *ver);
-- 
2.47.2

