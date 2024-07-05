Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D47A146A96
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179763; cv=none; b=MEsrL/pk6Pgsam69Kc4dTZL33hiV4BYUvaPsjk2FY0bBa6nmPMV5P8iz22uFmmbPNh2QpXnr/0ZMcO0ZGQL/NW5eU9mHgiE1N67sJ7C2uo9DFl5v+fC0aGLJwfGFydHIKEOESa0oRIm+C2vQUl9SUGV9tiIL90dJcEjOIObPv6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179763; c=relaxed/simple;
	bh=bu8e5ynP8GhvsXyXYYlTTq5t5322WnEBdEM9r61teyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNlF1+wqJFmvc4V9VBD005mspTI9uBsuiZdWpMceoikaPvNC7Dffe6S5NkE+0bRj3EHEyhvbkO2jRBlxLBePeJv+wMyd19fNXFx6g2iuvIKVsdO+IJyJcmbhIGK8GbS//PZzYYgmRepsquixOMmRU8Ih9MBxbsAcZeTEi76izPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2j6ZLDV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2j6ZLDV"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-585e774fd3dso2124875a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2024 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720179760; x=1720784560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zwctzJoSxwnBvDVuL4LjMKarRieR39diL23web6GE5Y=;
        b=E2j6ZLDV6hB2/7oBHT7RBOCJX4LaAZ0VK5MvCGQGE4k20U7PhzTIqwBQqpAM2xi6Zp
         eh9nh9Spt4Ug3k3ezpqwTsMZ0Fd+SFLq1hE9bj0TBQvIuknT8oLIcDKbF/HN5H+81pG9
         qgv8ocl0TGziwwW8GJ3a0sw0x8LZSFfULEi6QI5MJMVk6J9QNejbd0RN6KCX9bIM6XUU
         pw4/JkOCxjupf7IU+AOEO/6K7egjLRFp4QavHrrrjWaUWeTBnU5zL/A0D53CvQynZnMa
         vDaCwv3xe6MVPfph5dlc5u4Z7z42TlRE+t5Urj8/c+5rF9Qy4rS1PefsWZhzXGoctYgN
         AVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720179760; x=1720784560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwctzJoSxwnBvDVuL4LjMKarRieR39diL23web6GE5Y=;
        b=CcWjHYfx9Z9k83nwNctiE2rMKkRasN0iSH1zIkn/26/mQSkFmqo5Lu6Oe5P+RmBPru
         IZaG8yKwFMErMJwQ1El0ZkX5J9lTVqu6XVu5xQCXLDyQY6DwBO65wz/v7xP1yo8pPV3n
         Yw5tnYc4X6sozeEvdIJ1h0Dn2JUxrbeNzDUTInpaOxXp//+MNo/fdtH774DGC5n0V8To
         uX9CXd5CGckLOAYRerLTvj80zYIIToDsbfD2+gkkgoIvVihMBmKDa2ZAALhzG4q1kLQ6
         jrXWpUgvhzb+1m7tUlGMRwRZ25gKlOqVgHVPqGShX9maxvDmQDEI+Dk4ii2vWOKKyVRD
         jLBg==
X-Gm-Message-State: AOJu0YyLNUT87wYf+L1iadZwYHkGbhvaMOULcHosVwdXMZsgLft6jrXT
	LhNtVV+Dh59AMkWPkP75pRuSFrZAATI3IvG36yTxdB21edzxtGQa5rIH8g==
X-Google-Smtp-Source: AGHT+IFExIx3RrvOh6gMUIJR3xFTiM3Ek09bCj1aKTtTefo9XndBIBrZ5I1TJMHgbxfP3POMvmdB4g==
X-Received: by 2002:a05:6402:26cc:b0:58d:9b90:e0a8 with SMTP id 4fb4d7f45d1cf-58e59d3aba2mr3428778a12.22.1720179759639;
        Fri, 05 Jul 2024 04:42:39 -0700 (PDT)
Received: from Firmware-Linux-VM.nox.noxmedical.com ([213.181.99.234])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58614f3d3e1sm9538416a12.80.2024.07.05.04.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:42:39 -0700 (PDT)
From: =?UTF-8?q?Gu=C3=B0ni=20M=C3=A1r=20Gilbert?= <gudni.m.g@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Gu=C3=B0ni=20M=C3=A1r=20Gilbert?= <gudni.m.g@gmail.com>
Subject: [PATCH BlueZ v2] configure.ac: Fix --disable-cups
Date: Fri,  5 Jul 2024 11:42:35 +0000
Message-ID: <20240705114235.553566-1-gudni.m.g@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

or else we get:
  configure: error: conditional "CUPS_SERVERBIN" was never defined.
  Usually this means the macro was only invoked conditionally.

Fixes: https://github.com/bluez/bluez/issues/773

Credits go to Lars Wendler
---
 configure.ac | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1d88daa0b..5619edf4b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -253,12 +253,12 @@ AM_CONDITIONAL(CUPS, test "${enable_cups}" != "no")
 if (test "${enable_cups}" != "no"); then
 	AC_MSG_CHECKING([cups directory])
 	cups_serverbin=`$PKG_CONFIG cups --variable=cups_serverbin`
-	AM_CONDITIONAL(CUPS_SERVERBIN, test "${cups_serverbin}" != "")
-	if (test "${cups_serverbin}" != ""); then
-		AC_SUBST(CUPS_SERVERBIN, ${cups_serverbin})
-	fi
 	AC_MSG_RESULT([${cups_serverbin}])
 fi
+AM_CONDITIONAL(CUPS_SERVERBIN, test "${cups_serverbin}" != "")
+AS_IF([test "${cups_serverbin}" != ""],[
+	AC_SUBST(CUPS_SERVERBIN, ${cups_serverbin})
+])
 
 AC_ARG_ENABLE(mesh, AS_HELP_STRING([--enable-mesh],
 		[enable Mesh profile support]), [enable_mesh=${enableval}])
-- 
2.43.0

