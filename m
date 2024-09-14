Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B291E4AD
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726330173; cv=none; b=b7+Iin3uABpB15kBhYkx+loSxolDC43hQmVOGsgsMwNX3natUhoDCR9jH5wry0EpKmWxxZ1+NPdbhXKq68eEyxEkBs3/RL3eYdUrfyK4XEDt2eJfSJX9qdRtKl3HL9KQJtgZT1csY26RfunvmQzJ5Mt+n5zaxlZm8S6zwTqhyZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726330173; c=relaxed/simple;
	bh=jjOlCE967+CV/mcToD3IrLkrfYTekeDJdAvXkaJF3Xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BEKAFiMY6apFlXrIh7kFLZfA7+ajDVlgoLxNKKhZu2HdLphX8L0rZtFBxdd4ld1ILdmt0nQ7pS59pomhCSomkI/MEIUStVh6000cjtB5odFJJj4zAK9l4/5I/V46paONFbLHHJD9gLI6KqOCx+VpgMCOvu38aLjsAa80HN0rV/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKHoALIc; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKHoALIc"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20696938f86so26549845ad.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726330171; x=1726934971; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iApZeigucloW/bJEb7THQPRwNtKHBp/lao+DOhYZHes=;
        b=eKHoALIcyD/cwBYjo+8CyW5l8tgR34Owb/YhpW6gfPWEkp+sCJYbUIPWk4f21FZIaL
         DXzRETWIDm9E/BUOPf1Waawt3CuF8w0UvjM9CNpksiTzSunuM2zfiHrEqm27yuPYAzTU
         k/G2DcFB80Tl1f0D99wgOJ2CBLwEgQd5Dnbppd0We6d8Xfu2NNQv8M7m3F6ZyF47DtA0
         4fKFcEQGnAlyCqd2icZIhSVRXX8KLYqDO9TMq5VHnjGs4BZFLrUjfo8lSW5uqKb/Ja2o
         hy847i1km7PKfY2cbET8ALtBojLZ0PEYz4FbtYSheIL+3J1rdsHrkmSBKPnK4LOiETZm
         QpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726330171; x=1726934971;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iApZeigucloW/bJEb7THQPRwNtKHBp/lao+DOhYZHes=;
        b=oa0TyzIE0ux1MBrLQlnt659xuJOS6vLw06Ul9OCQmyjC3ZnHftJdm2lJEpiy0XRi0p
         sNt9lPi4m30cfhO3FdSA00UA/jMeTc87pD0PQgyaOkqnaDvuFXznj+iVdvCVEU5rEZN1
         hFud4qsC1oi05vCSFBJnOiJOucSDdaUryOq5QVb0UgbbuOl1XIOIqmipYAR4XF8+l25G
         mBCpZsueJHRug699VDcDOTym9iyOS0Myqh6TC7JyiSWFpDjEhw+KAnLFIMEodHqy0juf
         ETDAsg8fJ2dahb0B1o2fqs2BPEOQG/7r0DSakCCxTI1oKkIFlGUBz9cFNrzsLOQVJ4Pk
         /gyg==
X-Gm-Message-State: AOJu0Yw/RNF3D7aM58odCBYiCNyQq6OFG4ms5KxwqIL8ywwzhxU9EdhV
	JKhxuFyjgLN4znR2fVGmDfOyXlFFnWIOJpFm9EjRj67fM3HTz6kJ
X-Google-Smtp-Source: AGHT+IFHGwQBP1792Ea1zr9z14C3J2Ysjd2mavEo4xUwQsbLq2EkSf5zOYhA9c/Qrh4h1XBJJY4lsA==
X-Received: by 2002:a17:903:1245:b0:1fd:9c2d:2f27 with SMTP id d9443c01a7336-2076e36d91bmr140957385ad.24.1726330171139;
        Sat, 14 Sep 2024 09:09:31 -0700 (PDT)
Received: from localhost ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d1691sm11033505ad.151.2024.09.14.09.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 09:09:30 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Date: Sun, 15 Sep 2024 00:09:24 +0800
Subject: [PATCH bluez v2] monitor: fix buffer overflow when terminal width
 > 255
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-fix-log-buffer-overflow-v2-1-fb6b52a7d4b2@gmail.com>
X-B4-Tracking: v=1; b=H4sIADS15WYC/4WNSw6CMBCGr2Jm7RjKU1x5D8OixRmYpFDTSn0Q7
 m7DBVz+r+9fIZAXCnA5rOApShA3J5EfD9CPeh4I5Z405FleZq0qkeWN1g1oFmby6CJ5tu6FrdY
 V1YqoMmdI64enVN3JNzB2oS90yR4lPJ3/7H9R7eFfdFSosCmK3pTMXDfFdZi02FPvJui2bfsBj
 RGkj8UAAAA=
To: Bluez <linux-bluetooth@vger.kernel.org>
Cc: Celeste Liu <CoelacanthusHex@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895;
 i=CoelacanthusHex@gmail.com; h=from:subject:message-id;
 bh=jjOlCE967+CV/mcToD3IrLkrfYTekeDJdAvXkaJF3Xs=;
 b=owJ4nJvAy8zAJfY4pvNJRPo6U8bTakkMaU+3mt/L7bnuV7O5MG/pY3EZKxkJ+5UF4qzr+9dfX
 vD54WL/D/wdpSwMYlwMsmKKLGI7n75eVvrowzJekxkwc1iZQIYwcHEKwESkXjMybNbe6+Mwuy2g
 dBaThIDDgZg//11fvZQTiep0nzxxbrhsNyPDsj0znkUvuVbCeH9le1cTe8S0Z8atiip87gY/rvU
 uOfGdCwAYGUu0
X-Developer-Key: i=CoelacanthusHex@gmail.com; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

In current code, we create line buffer with size 256, which can contains
255 ASCII characters. But in modern system, terminal can have larger
width. It may cause buffer overflow in snprintf() text.

We need allocate line buffer with size which can contains one line in
terminal. The size should be difficult to calculate because of multibyte
characters, but our code using line buffer assumed all characters has
1 byte size (e.g. when we put packet text into line buffer via
snprintf(), we calculate max size by 1B * col.), so it's safe to
allocate line buffer with col + 1.

Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
---
Changes in v2:
- Add free() forgot in v1.
- Link to v1: https://patch.msgid.link/20240914-fix-log-buffer-overflow-v1-1-733cb4fff673@gmail.com
---
 monitor/packet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index c2599fe6864ab44d657c121fcc3ceecc1ebc52a6..bef55477a221b6cb43ff224454ac3fa593cd8221 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -376,7 +376,8 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 					const char *text, const char *extra)
 {
 	int col = num_columns();
-	char line[256], ts_str[96], pid_str[140];
+	char ts_str[96], pid_str[140];
+	char *line = (char *) malloc(sizeof(char) * col + 1);
 	int n, ts_len = 0, ts_pos = 0, len = 0, pos = 0;
 	static size_t last_frame;
 
@@ -525,6 +526,7 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 		printf("%s%s\n", use_color() ? COLOR_TIMESTAMP : "", ts_str);
 	} else
 		printf("%s\n", line);
+	free(line);
 }
 
 static const struct {

---
base-commit: 41f943630d9a03c40e95057b2ac3d96470b9c71e
change-id: 20240914-fix-log-buffer-overflow-9aa5e61ee5b8

Best regards,
-- 
Celeste Liu <CoelacanthusHex@gmail.com>

