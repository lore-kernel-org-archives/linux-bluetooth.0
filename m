Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74052951C9
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869897; cv=none; b=JImdccenMvMgOSp8DvDEpxzJu724Rkuxs5jSZbuaXbNpP7MGlY4jk+hkthn8/QjbGBYJXQXq+b+fSVY5w7TWHzsnWkcENi0oOYJCghUnTrcPHsLkIE1r7oCEW+vEieuJGSF2vdb4rIFxP+V0CXCz/rtbEnv6HKf6671C+WsxikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869897; c=relaxed/simple;
	bh=ZiUpzfTJrz53vAUDud9dcxIYBvSvKSP+4hBqH46Gcwk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVKQs8EIN1iNrVvnLdi9YHae/148cNUepJpkKEANn0x/d18BG0u9BaZSPpczDJd/fiwf7kxAaG4Cdw98Gdxi37p16gFy0fWR2v0BT3FlxdPdEqqPEdeoyq6uEa/Fu4fXsgr0LEn6Qk2zPUy+0ZjK0hHoHdMZmHoxSoZP8KLk9lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVOWCvvJ; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVOWCvvJ"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-527b70bd90dso2177983e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 12:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745869893; x=1746474693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/H1Vtpx2DHWeRgA7B2h/gDRzSIkoRvnLxoWcDny+xw=;
        b=CVOWCvvJZ+N7apOucHgoIrzX6pB0hDuLk75EaswkVSlMJEcSkpDPuIDp9EHkUwsA+r
         a2aU1bbKsHLuFPbT99ba/Q2MVWKPQRk7004etTstjGJdwQyKImzaZSTy6eCzvYDzxB/W
         hjEKEsMGF5p08MG3oUZ3VhR/QDFc+UwuGWwGxwnLGP8MPAWPdgZkqez7T+BtbhuTXKP7
         SjrSq74AoFX8BMws1dZopt/K4Z9GrgcWxo1GpObm1r/UYe4psk3osEN9K3eS9o7W1Gc8
         QO5HlIcXR1gKgGhmEsWVc6okWW72IUwQ8d/CC+5WbSjMFBSjAEb0BxTbloeGvq9rVMIS
         eAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745869893; x=1746474693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/H1Vtpx2DHWeRgA7B2h/gDRzSIkoRvnLxoWcDny+xw=;
        b=iJqlLJwhZfLv/PC+276h9bjXsduj+38n7dvPI4PYgcAq3VD9Pus6vtb73BeBosmiST
         /dCdj8whJ9LXjpUMOlpWShvrAPpMdytPN9pXyMNr0uqj/RARGyqDSNO3Xs6Ct5lI3LI6
         PEVmRY44X+MEs6dNiP6ShwnVZOx57NgV6BIv9OCd1sHf2DxBRhKBVF/zftVCIt+wQx1C
         BLF00pKczhRtvY+8/zBkTCXi/xJ//p4emNQY2jA/rnWF7kRVRzVPE8YARGVpLmPtK1Tr
         7WfCK+zHco+dO/NEXU5t8q5d6v4w0HUC8Nrcx05SjBmca9BNZs01dCdutb0vbVSO95e4
         UDug==
X-Gm-Message-State: AOJu0YwlJSrqn+SS2AU0TUveC93mTC7IBlsl/POA9QbLXOLW3rHtM6mJ
	lugSWaPOsevnequcNDpVXn7ERKBsJy5ccRfUxGhx09Nwh9VT992UP+joCCAnuEY=
X-Gm-Gg: ASbGncsszG+P45QbwTXgTDVOohz9JSco8AF1a1oVOC15ctJkUQZAeIInRF1a2zCSGHe
	9HlPeuNI4DIYZv30N6LWTWwuipTJMvBB1dfIakzuQ/6JyG/M7ik2PDaHWJgEVaKqMSkUZgC3D/U
	0AF8/83Rcjhz7lLXgpfaCLwVc2k+tAmG6tlRsbC2yF4MTLomJ9Zym8/HqGyMVdIMdbkS7DCzfZd
	uqMymA45zFIRHU5I0K2H5XN1JQMazbGPTxIIwFXO+MoxrPgJUzBBGbTDdywA90pQHEMaqj/XSGQ
	pGBwu1Ifc6yzSnsR5vByLq73fatCizDTTXQdO/V3Fc6138GP9jQrqyCJaMaKYI/dkJv0LdfHGkF
	hJeEKsxdYZQ==
X-Google-Smtp-Source: AGHT+IFGu+CUEN1qoemhPKCDgcD+7vYuhQd9ZqubM3PANdukBMmqjEjASIlPyWveQPCJC2jpfG6k/A==
X-Received: by 2002:a05:6122:1ace:b0:52a:93fc:e93d with SMTP id 71dfb90a1353d-52abf09f86amr645118e0c.5.1745869892886;
        Mon, 28 Apr 2025 12:51:32 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52a99279c2dsm1067669e0c.27.2025.04.28.12.51.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 12:51:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/5] client/mgmt: Fix potentially overflowing call to snprintf
Date: Mon, 28 Apr 2025 15:51:21 -0400
Message-ID: <20250428195122.2000808-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428195122.2000808-1-luiz.dentz@gmail.com>
References: <20250428195122.2000808-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The return value of a call to snprintf is the number of characters that
would have been written to the buffer assuming there was sufficient
space.
In the event that the operation reaches the end of the buffer and more
than one character is discarded, the return value will be greater than
the buffer size.

Fixes: https://github.com/bluez/bluez/issues/1216
Fixes: https://github.com/bluez/bluez/issues/1217
Fixes: https://github.com/bluez/bluez/issues/1218
Fixes: https://github.com/bluez/bluez/issues/1219
---
 client/mgmt.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/client/mgmt.c b/client/mgmt.c
index 86b5879db8b0..faa97a159e3c 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -316,9 +316,17 @@ static const char *options2str(uint32_t options)
 	str[0] = '\0';
 
 	for (i = 0; i < NELEM(options_str); i++) {
-		if ((options & (1 << i)) != 0)
-			off += snprintf(str + off, sizeof(str) - off, "%s ",
+		if ((options & (1 << i)) != 0) {
+			int n = snprintf(str + off, sizeof(str) - off, "%s ",
 							options_str[i]);
+
+			if (n < 0 || n >= (int)(sizeof(str) - off)) {
+				str[off] = '\0';
+				break;
+			}
+
+			off += n;
+		}
 	}
 
 	return str;
@@ -372,9 +380,17 @@ static const char *settings2str(uint32_t settings)
 	str[0] = '\0';
 
 	for (i = 0; i < NELEM(settings_str); i++) {
-		if ((settings & (1 << i)) != 0)
-			off += snprintf(str + off, sizeof(str) - off, "%s ",
+		if ((settings & (1 << i)) != 0) {
+			int n = snprintf(str + off, sizeof(str) - off, "%s ",
 							settings_str[i]);
+
+			if (n < 0 || n >= (int)(sizeof(str) - off)) {
+				str[off] = '\0';
+				break;
+			}
+
+			off += n;
+		}
 	}
 
 	return str;
@@ -4490,9 +4506,17 @@ static const char *adv_flags2str(uint32_t flags)
 	str[0] = '\0';
 
 	for (i = 0; i < NELEM(adv_flags_str); i++) {
-		if ((flags & (1 << i)) != 0)
-			off += snprintf(str + off, sizeof(str) - off, "%s ",
+		if ((flags & (1 << i)) != 0) {
+			int n = snprintf(str + off, sizeof(str) - off, "%s ",
 							adv_flags_str[i]);
+
+			if (n < 0 || n >= (int)(sizeof(str) - off)) {
+				str[off] = '\0';
+				break;
+			}
+
+			off += n;
+		}
 	}
 
 	return str;
@@ -5429,9 +5453,17 @@ static const char *phys2str(uint32_t phys)
 	str[0] = '\0';
 
 	for (i = 0; i < NELEM(phys_str); i++) {
-		if ((phys & (1 << i)) != 0)
-			off += snprintf(str + off, sizeof(str) - off, "%s ",
+		if ((phys & (1 << i)) != 0) {
+			int n = snprintf(str + off, sizeof(str) - off, "%s ",
 							phys_str[i]);
+
+			if (n < 0 || n >= (int)(sizeof(str) - off)) {
+				str[off] = '\0';
+				break;
+			}
+
+			off += n;
+		}
 	}
 
 	return str;
-- 
2.49.0

