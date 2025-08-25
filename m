Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1972FB988
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135638; cv=none; b=dB44uBKk5kmppovWt6Iv0Ox9TI99thkMY2OCKT+rB6xHnb97rOV5Lu/PsZ8sHnVPB+fbSWOl8aiyj6+GU20qYnx3+Hm/lia58Z9MBpiORgT5Q/oZaxV/R9cTHgVbO8CcAdKxiXbUTCr+jAnoonmnzbpOLHGUvDywdLs1kilaJrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135638; c=relaxed/simple;
	bh=olNv68s3aKChHsrCnZ2om7gajfsN5tl+KDQ3rC/Z02k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITttNI18xyBYjDmGdk3v1BwZYPeJXuMdVCEHizUogUXQu69Yb1pv8CZh6L+hkJ0eSjKFky5z54XPQCPsaZAZoltocPnORUldfrJVaFo1vH8uwpT9Z+79HFkG66ZFfBakJgb7tZ6DHcjTUQpzGtzmcTDreCLHIlTb22x/x7//p4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThSxL3PX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThSxL3PX"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb6856dfbso835745066b.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756135634; x=1756740434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVNl+anVsBlLlrFA9JnI+Fw9GURypYzz4twA0lAjpAs=;
        b=ThSxL3PXS60ICA25I5T8ichK7sMGtCgCVBOEcHPatUnrZcfbm3q5mrTKacTNwkIm8Y
         wtGSulE4IWPdlLMjaSzffBYx1wE/Re0nfx+r+OWoeBmWW4FH1xmFTJ+WeLOKhhXjSJZG
         mvcesNyzLt1Y9E9R7tVyuR52UM4xivlrzH3nL/t3EC/2RN6ESIIo2xPv73mfqDKncTAX
         k5rXkfeamhIpF7Kbp6L3shqrfgF5lwKPE/jhkuAognghGJW+bUj7rVDbmZvySkpr/zPv
         LcAJDMwKXlBWjxMxVuM6x1Wyvy+WlgsKMCkTdBLOMxbty2OWZT7VdL7vdqa0TfpYiNfG
         O1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756135634; x=1756740434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVNl+anVsBlLlrFA9JnI+Fw9GURypYzz4twA0lAjpAs=;
        b=S26DGe//uTEy7VeI+tuPue2aE3FGJ/MNLOD7A4mdgi/tUvYweElpfKn653zY770kMr
         g3O2Qb35HpvIp5O946aqyp2xijtqPNMBCzaeXwhSD7UbG4hnPGuMWlzGiT0iOH009dny
         T7C2JT19a1P0QVXLVy07kVo7AFjihvHmalRNfbgiA5ZeiDinC99Pf20boAyJv2YaPkSW
         Xgg5ZiysrMe4Ud3zRNGzf2BHiBLd344fu6bLCvvWlmkLgp/JD+yFJWXqQWG8YEAB5HBl
         tH19kaKmSD5Jjfs5DGSeZVef9/dcIOV8cTgSyFUQzg5X2UK2kypXN5V0jWnVNQE8i5pU
         +Rng==
X-Gm-Message-State: AOJu0YzXTWsLYkLmHNdCzwfhfLzSgggd3TuX0w5F6/3uuzZZurgAn5bi
	XrwcD4lIbGmgeU7z9geFkQjxFbl9ao72+ggCQWUCljcb7wDGCEZEwlI7fmc1KFBA
X-Gm-Gg: ASbGncu3+xznbMi6iDxt4QjoKyeHKuBePUnwtmgRqdRtllN8/rqTzCE/k+xHcO7gEQh
	r58EY5DH//pK+MEpWYOztX+G/bNLk7u9Iays/GUGha2UyjY68hbfzDxf8dCw7f9UNi/jPtxA3bF
	/fq6DbZoBWJRLjn6InRUS2JImbvMKDVBj9NhhHwe7Y9X4UIFSixqEXd/HntX1CyqfStxFXNKEIi
	xlQC2rZdSKM4hLEMb9PslpU8aOmBnP3tBEDt+Ly2IfOJiO5slrNFfYDANrrQ8ovZ2b3nloiAWDX
	boa27msXIq+sKxMxERsYO5iyxm+LserxcvIBSJtTIC6mJXYiqRNrPWiPLA1QbreB8Pz9OSJj06c
	6/osRUbo3Eaczf1W2lFAW6Gq9+/8ZsNGghHwi026nhySNgbs9dsBYkdcgljx10HsjfLde9p/BbV
	8qR98sMUKuTtg0sp4d1i0VLIPG2A5F
X-Google-Smtp-Source: AGHT+IH3VcwGXAtBlq5PEF91jbovNFIDfbtaRLrJ39ti1RQuzBOlywxB09BoT3KkwkCJYJI2NGCz7Q==
X-Received: by 2002:a17:907:6e9e:b0:af9:a381:aee1 with SMTP id a640c23a62f3a-afe9c7ffff9mr7337966b.0.1756135633744;
        Mon, 25 Aug 2025 08:27:13 -0700 (PDT)
Received: from localhost.localdomain (46.205.200.232.nat.ftth.dynamic.t-mobile.pl. [46.205.200.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c877af155sm378305a12.49.2025.08.25.08.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 08:27:12 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ v2 1/2] lib: Fix out-of-bounds write when concatenating commands
Date: Mon, 25 Aug 2025 17:27:06 +0200
Message-ID: <20250825152706.327235-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250824200921.308503-1-arkadiusz.bokowy@gmail.com>
References: <20250824200921.308503-1-arkadiusz.bokowy@gmail.com>
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
 lib/bluetooth/hci.c     | 27 +++++++++++++++++++--------
 lib/bluetooth/hci_lib.h |  2 +-
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/lib/bluetooth/hci.c b/lib/bluetooth/hci.c
index f9feaf185..fa5a454e5 100644
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
 
@@ -625,17 +633,16 @@ char *hci_commandstostr(uint8_t *commands, char *pref, int width)
 
 	ptr = str; *ptr = '\0';
 
-	if (pref)
-		ptr += sprintf(ptr, "%s", pref);
-
+	ptr += sprintf(ptr, "%s", pref);
 	off = ptr;
 
 	m = commands_map;
 
 	while (m->str) {
 		if (commands[m->val / 8] & (1 << (m->val % 8))) {
-			if (strlen(off) + strlen(m->str) > maxwidth) {
-				ptr += sprintf(ptr, "\n%s", pref ? pref : "");
+			if (ptr != str && strlen(off) + strlen(m->str) > maxwidth) {
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

