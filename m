Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CE686324
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687773; cv=none; b=tlUzIZ7wfpOINk3/jmtqVT1USM9yfT05oYe47je9t3F9zbUJRbIhb0BBFCltnbHTH3zVNqmmNaiPUjP1ggKmvWKmcpAEF82ES3oUAuOP9n5iOgAVpgU1m+9O+6bUWhYevfK84std45rxtu8y3iSuZbAZlSZW6ICFG/rT/k0CP3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687773; c=relaxed/simple;
	bh=upTUEYgi3Bc0dmHwfJ48FfVI/S8fU0UWg+pVapn9qYk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d3HJbGmpskSordE3JUR8NoMdP/fNclnH//F3ONQfH4AOovUPCSyf2at5SJjF942uDIbFKgb+efIW818IDYiVJDmzFCRFAmgleUM2cZBpocriYnkh5cQIz0qeH+rtzLzacsujSPbShtwj1rqBWZJJjQUflJxNvHlGSVVeM//bAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yq2DV8zg; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq2DV8zg"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4afd56903b7so1661039137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Feb 2025 08:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738687770; x=1739292570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eyuYFEDWxuhacMEFvXwWTqu2P14xhbOG68F/IZKS9g0=;
        b=Yq2DV8zg+38qJOb8YjycIfouL73C6heolkaJ7+3cqsZv9RkzYk8gxF8UGkGYuALxBs
         KgATUamQzI98lZGP/k5xkVMAL7bL+R3a5qp7hxhAFtRriXnFOW819VJhGRQrpEr10LBf
         j3vmrfyqN/L/t9guW/smd5F+ut/WZi4BtWyBox5/W0UJp3CXMsmv+A4V4VilKM5mB7uZ
         XduQm8FUb/wIGEj3UcOhtkSuUQGswZtTeTd8Dv88b3KQ8QGUsAp5w15Er/VrYHLggNmV
         Yg6AIGGqiG9vVoMiDKIVTL4M86mJJrrWQGtKyAUThQSjvU9y675ftQacbaJJ4/k1gZzs
         AG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738687770; x=1739292570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyuYFEDWxuhacMEFvXwWTqu2P14xhbOG68F/IZKS9g0=;
        b=qOzOQD26esFiC0gxKljMNkxIaGAq/xxV/SWCnL0nUXuCJr0KUPPK8GbyNw6/Kn7jmq
         WojOJoGXyp7sna39zouf1dZLnV9NnmCQTe5pmkvzhy27ULURR7gq1HNMlMYXIJtnMdT/
         cPiRGbOuu4xC7fNq3V+B/eUI48833iEOHxHLu6111/1bOqQymCXJsFZvPWPHnHZ+zwmr
         6Ih/LqCpeW9OwBnu7BhP/C3ExGySe6qEuzK8XeGyxouGtk1F5uYttIcyYDrqcEd/L1iT
         yqOvvlnmSu5/kMmQt0D4ATGVB1U43gDLjVfa9DU+Rlk5kX6O88wd12zrm0oMpaMVkzm1
         j6Qw==
X-Gm-Message-State: AOJu0YwtEkOyDv0vkcED00KZg8EJ96XlNV+OI0s62G1dw7oiBnSAAkjI
	PsNG5HczXrBa78JWH9s8ejWdfTFCNgB7RByvSZfTGR3u54AQZU6GHo6BuR5F0Nw=
X-Gm-Gg: ASbGnctg1cZFVGr0VMgfwOBzr0wCnF7LTVhVJmsn1eoxqXAcV3n6p443GNA8vqgRDcj
	sT8X/9dsHa9+M9qnZWFcVX6OZU0os2c9T2Uq8pNgAPcgk8zkm1NUBQtUZcY0TnGQSooBQu91Ek1
	KlvLACehWQ4zuvDvJ9Fe5qWg31PedJcUkNtIrFh3BZQ2zV8v2v/uTeL123+7yMnIjd4qSXdVhj6
	CIvALS15cjo2SdQRxjtSbN2KPQcinUtgq8+a2A2b0Dol03xMHbZBcQCCUrBj7QOMqFz/5Ovyjtj
	Mcxf1T6Ug2e+UA2lRGxuGfCaayFwCfwUzoHnJW789USbwEqkUscqE/XzfiBt1G0=
X-Google-Smtp-Source: AGHT+IELV0h0G+TXQPVNQTYrgtHbxTrnbRG3icB6UREJ5d0sC64kaRNMhds8cGTEz00YXE9ryxVlbQ==
X-Received: by 2002:a05:6102:3e15:b0:4af:ba51:a25f with SMTP id ada2fe7eead31-4b9a5233a2bmr20397034137.20.1738687769642;
        Tue, 04 Feb 2025 08:49:29 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-866941f13c6sm1991882241.33.2025.02.04.08.49.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 08:49:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] build: Enable -Wstringop-overflow and -D_FORTIFY_SOURCE=3
Date: Tue,  4 Feb 2025 11:49:26 -0500
Message-ID: <20250204164927.2839802-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables -Wstringop-overflow compiler warnings:

  'Warn for calls to string manipulation functions such as "memcpy" and
  "strcpy" that are determined to overflow the destination buffer.'

Along with -D_FORTIFY_SOURCE=3 so the errors like the following can be
captured:

In function ‘read’,
    inlined from ‘serial_read_callback’ at emulator/serial.c:90:8:
/usr/include/bits/unistd.h:32:10: error: ‘__read_alias’ specified size between 18446744073709490177 and 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Werror=stringop-overflow=]
   32 |   return __glibc_fortify (read, __nbytes, sizeof (char),
      |          ^~~~~~~~~~~~~~~
---
 acinclude.m4 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/acinclude.m4 b/acinclude.m4
index 4b73a5bfc38f..7f8e28d0bdaf 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -61,9 +61,11 @@ AC_DEFUN([COMPILER_FLAGS], [
 		with_cflags="$with_cflags -Wcast-align"
 		with_cflags="$with_cflags -Wswitch-enum"
 		with_cflags="$with_cflags -Wformat -Wformat-security"
+		with_cflags="$with_cflags -Wstringop-overflow"
 		with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
 		with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_28"
 		with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_32"
+		with_cflags="$with_cflags -D_FORTIFY_SOURCE=3"
 	fi
 	AC_SUBST([WARNING_CFLAGS], $with_cflags)
 ])
-- 
2.48.1

