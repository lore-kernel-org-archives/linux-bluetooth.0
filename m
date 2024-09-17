Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCF9F4F1
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726554652; cv=none; b=gYKEzQAsHfkYmaWJSXB9TfPRBdmwqGkjXdc7HJFKixfflIujAP3EdAzxdY3iBF5s+d6WBSZcCU/fwL68wFp76j8N1hEeQv81YHd/KacgMuHrNFmt2A83ytIy6zZfAvVVcrUAdI43Z/Rx+WVlMIUasVEh9KsaZ+Q3QpApanpS+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726554652; c=relaxed/simple;
	bh=WxdHFgq3bm2qkpI6TzgTKVPjRM3m3qzAirmUFrYxspw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QmZ4ILyM8JL9oHnV159luZePh1ltZsdj3MW+yW70drTwYItLQ0eQY5TFiW3frW0QWjIeU4gl9KocclZvJnqPGrmhS7DBn09Ciw63c+NU3b1gAcbFYEygbdGEPrnygjGlVX0ibu7lgk1gqLX6GqRE+JKKyTbhYJUm7NTIMlUO/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lldD6O2t; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lldD6O2t"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-206bd1c6ccdso37523855ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 23:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726554650; x=1727159450; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V83jlawy91OKGm7/g7rM5oS1/5JioFapBo8pVHl5tiU=;
        b=lldD6O2tHyPugPlMJfHk0Q+JI1q4FM5sS0kAa7jYlOrwmFIuk/aJjFOT5y/Co+WtSm
         Y9Ee8XLpnOFDMWyYoyd8yni5cA0wp011rcsCaZEj+qqZgPgIeFLw2YClcfwQpw36zShN
         DBJMC8Tq+5ENvZzGwnNnhuYucngUBeJz0x3Z1tNAbIb9vwUQIVKVj8P06v0o9ODRDNwK
         uodfOAfj5lLtLq3Ac/jfnOsajd+yZD9+gjT7x1JSEnMcj8LdNx544mnIZsHODTNpteEW
         O0QyGKjhODwabHFc/t+dVtI9JyuUotOJsoum3uJKXM+ewt1VR+i+HBeHtHkxCRN9hYOM
         A4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726554650; x=1727159450;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V83jlawy91OKGm7/g7rM5oS1/5JioFapBo8pVHl5tiU=;
        b=Pp2jkSEkgc9XMFIJCLm0qUk2lh3vF1i9J3VQoPw0fZGSvlLNZmWlsY3L7Drg1ZvQ5+
         d4AzDbfLqo4IZUqvTPw90+Y2WXyZKnnOZgPO8GdRB8yFO3VhKuPbp/nhcPbeXhJ0ZOUB
         92OdnfdQqulqIjkEn+Q/Q/12bzdHVWmLO/wi38svvDjgtgosnApFO6n/vQ7y123bgKTo
         R09XM3RcqgRkeET77nPdieZXy7IDI61hCj9qOHpdq25dykxTryL7x7Aori5/LYy3Mwyd
         dCCtJk6NGR4Sv0/P36JVzxM0Yiptn/z1+pr9Vm0UMlOIWF2F3kETx2ZJ/1WMZY7CSqAo
         oYCA==
X-Gm-Message-State: AOJu0Yx3CXbqvaQXvpyHxTRNSrYGdZWq7GlYOpDdIdhkj2xldf8SKDry
	uGv5OfWlcyMy+ldMkAp7OZ8uKvgl0suPnV9hmvnwjXz+bG8SmPLVZDa6HZU0lMU=
X-Google-Smtp-Source: AGHT+IFldn29KeFxW7yofSv0k24dAfPoJ1dbN2QNLWwpwV01Mf3fiAqvgwfdN5iba2qCmglF0uyZZQ==
X-Received: by 2002:a17:902:e54a:b0:1fb:93d6:9fef with SMTP id d9443c01a7336-2078296b28dmr155292135ad.38.1726554650339;
        Mon, 16 Sep 2024 23:30:50 -0700 (PDT)
Received: from localhost ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794767862sm44943805ad.307.2024.09.16.23.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 23:30:49 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Date: Tue, 17 Sep 2024 14:30:46 +0800
Subject: [PATCH bluez v3] monitor: fix buffer overflow when terminal width
 > 255
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-fix-log-buffer-overflow-v3-1-26fd441bb7df@gmail.com>
X-B4-Tracking: v=1; b=H4sIABUi6WYC/4XNyw6CMBAF0F8hXTuGvkBc+R/GRQtTaALUtFIfh
 H+36YqNcXln7pxZSUBvMZBzsRKP0Qbr5hT4oSDtoOYewXYpE1YyUTZUgLEvGF0PejEGPbiI3oz
 uCY1SEiuKKPWJpOu7x1TN8pXoccEPuaXxYMPD+Xf+F2le/qUjBQo1560Wxpiq5pd+UnY8tm7KZ
 mR7R/52WHKMrrRkqu6EZntn27Yv54X7xQ0BAAA=
To: Bluez <linux-bluetooth@vger.kernel.org>
Cc: Celeste Liu <CoelacanthusHex@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1958;
 i=CoelacanthusHex@gmail.com; h=from:subject:message-id;
 bh=WxdHFgq3bm2qkpI6TzgTKVPjRM3m3qzAirmUFrYxspw=;
 b=owJ4nJvAy8zAJfY4pvNJRPo6U8bTakkMaS+VxPYYmOUkb7Vpd89ZFBCfHpO95RKvfY9cRuBWn
 icbwgVmRnWUsjCIcTHIiimyiO18+npZ6aMPy3hNZsDMYWUCGcLAxSkAE/nHwsiwb2eWWA5DkctU
 o9LIy4e3q9Q4McstnOO1Kaole/rOf4FaDP9MtvdmXb0jvfeS4JO9nxfZCc4/HcxUUXGyLFNOimd
 Gfh87AFSrR44=
X-Developer-Key: i=CoelacanthusHex@gmail.com; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

In current code, we create line buffer with size 256, which can contains
255 ASCII characters. But in modern system, terminal can have larger
width. It may cause buffer overflow in snprintf() text.

limits.h provides constant LINE_MAX.

    {LINE_MAX}
        Unless otherwise noted, the maximum length, in bytes, of a
        utility's input line (either standard input or another
        file), when the utility is described as processing text
        files. The length includes room for the trailing <newline>.
        Minimum Acceptable Value: {_POSIX2_LINE_MAX}

Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
---
Changes in v3:
- Use constant LINE_MAX in limits.h instead dynamic heap allocation.
- Link to v2: https://lore.kernel.org/r/20240915-fix-log-buffer-overflow-v2-1-fb6b52a7d4b2@gmail.com

Changes in v2:
- Add free() forgot in v1.
- Link to v1: https://patch.msgid.link/20240914-fix-log-buffer-overflow-v1-1-733cb4fff673@gmail.com
---
 monitor/packet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index c2599fe6864ab44d657c121fcc3ceecc1ebc52a6..32a440bbea6888ab6321e973dbb23d9728864557 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -26,6 +26,7 @@
 #include <time.h>
 #include <sys/time.h>
 #include <sys/socket.h>
+#include <limits.h>
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
@@ -376,7 +377,7 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 					const char *text, const char *extra)
 {
 	int col = num_columns();
-	char line[256], ts_str[96], pid_str[140];
+	char line[LINE_MAX], ts_str[96], pid_str[140];
 	int n, ts_len = 0, ts_pos = 0, len = 0, pos = 0;
 	static size_t last_frame;
 

---
base-commit: 41f943630d9a03c40e95057b2ac3d96470b9c71e
change-id: 20240914-fix-log-buffer-overflow-9aa5e61ee5b8

Best regards,
-- 
Celeste Liu <CoelacanthusHex@gmail.com>

