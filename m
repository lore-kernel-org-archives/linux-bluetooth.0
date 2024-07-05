Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C13146A96
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179656; cv=none; b=AcWidG7u2yL7Nt1yKp6rRMS19sEXa2hh6oR8GESLjXzIu/hKpY0XGyLmWXCL6ZJoQcLEIenORutoCo3zCtN8hCGoJkUDeBxYBhb63VRBhoSsvyat3mm99/a6my2b3vzB/4H6AGfgFYC5fSifdpBjly1SMvUwiO4YSzl+tfbQw80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179656; c=relaxed/simple;
	bh=bu8e5ynP8GhvsXyXYYlTTq5t5322WnEBdEM9r61teyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XU1LTIA/NJQIPr3mbV682qqqBYemXVzUgUWwkyynl1oSMkHkOOzzUXoVSE+LOeqCBXgvlXCzqJ/ai7h+w0oR+7GWpkKZtkQyMIv3zQIuK7wKBDQqIJ/ol2uDWg1VPL0b03Z5C6LR4FKwpI4s14SVf1tSmHWo9MSJ9VlyhoC4Ydw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J06St853; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J06St853"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58b447c51bfso2017245a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2024 04:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720179653; x=1720784453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zwctzJoSxwnBvDVuL4LjMKarRieR39diL23web6GE5Y=;
        b=J06St853hLyioEeixqEEXCTKTAwl5TTBy+goPrtomyUw+UqnqvfGxe2SDrddNB/b24
         8uSt/26Ilq5NRe0DezUaP1c6WIu60BmUgHQYxSKN/uHlAUXFBOvT3/ID2937hB4OpLyu
         6Z8eUt6M0HtOkTxJcTL5zsiXGfwEfQxkD4JZp0iRoku85VP/scqHAL/Zo5/D4ETF32pR
         QUB4JX/1ksw/kUYqbpjIZiHwGvWtZMiHRB8ch1aC/xkXaIU201vpdsY+OHyBKkTcZRBU
         qefisJHLny0O/p23iKFUnaom56aeylHnuDYJcAtXrKuHsjwgxrNxCSm3W1UxWilhFOnt
         Uu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720179653; x=1720784453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwctzJoSxwnBvDVuL4LjMKarRieR39diL23web6GE5Y=;
        b=sYKWc0APEBggYk/FW+zXszFeLaUrnFrksauiB/pENLlRpMJ+xT187Kdxrf2W9JJfbl
         AjY7uFfA3ykF9ym5PXQzvd3ada8AzhbukylTxrSPM6ajR+fTyVyrA+LorsSYBhSY5wue
         hKNyEk7SsVx43mQiyOdM889JKRm4lYWJGWBySRX6JXiD+cjxj7dac7oyynOReaSQaagk
         cJa1Tq57XyIX3yidkL3/GB3dJR6yzChvjR0lGCn5BM3hiBUGbZEE80EBI3/f2VnFNX7c
         jIPqujmUlxzE+PxVhgUaj9Is/cg8UCOZdsv5AIyhaEAGf8+NIEETsMyCSTTx8wuDIIa4
         CtlQ==
X-Gm-Message-State: AOJu0YxsnR4X6GOqpy5d98m+PAwntMchDvHPRslvUi4CiRTWq3P73epe
	0e0R7J/kd2oRn4G3YbbZWwtgU0U5sWpGb2mLa+dkE60M90dD+ICVH8WirQ==
X-Google-Smtp-Source: AGHT+IEOMGDqHkMuM8ygc5/2PZ0L0hgMS8XC8M1QDk+1zXnL07Fy4ZAtvE4UURrphk3YV0TZ8K50qQ==
X-Received: by 2002:a05:6402:40c8:b0:58b:d7f2:eef3 with SMTP id 4fb4d7f45d1cf-58e5965a9femr3235401a12.12.1720179652823;
        Fri, 05 Jul 2024 04:40:52 -0700 (PDT)
Received: from Firmware-Linux-VM.nox.noxmedical.com ([213.181.99.234])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58bffed021esm4320575a12.89.2024.07.05.04.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:40:52 -0700 (PDT)
From: =?UTF-8?q?Gu=C3=B0ni=20M=C3=A1r=20Gilbert?= <gudni.m.g@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Gu=C3=B0ni=20M=C3=A1r=20Gilbert?= <gudni.m.g@gmail.com>
Subject: [PATCH BlueZ] configure.ac: Fix --disable-cups
Date: Fri,  5 Jul 2024 11:40:44 +0000
Message-ID: <20240705114044.553551-1-gudni.m.g@gmail.com>
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

