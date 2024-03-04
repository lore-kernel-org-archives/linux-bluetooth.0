Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86048627E2
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575924; cv=none; b=POBGf6o9sgTpE+4X85eYY/WD+PjxA7wbyUHLl/nyrDek1wM/Hb3ul1mGWFI5ClWIaKYQEzvr0vA5uxH5I5jljUPk0FcPz4WrwN6wMwEN+XmfT3f3jEJdXQZHIK7nN044coM3GlvOHXi6IjE3TOhFjokVP4W44VMr8P8hSxGjL0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575924; c=relaxed/simple;
	bh=WhIj9/lBuauUvRwX2XgJEIA3Mh+ozkOsXC8KzrQc/0I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QyUL42rEf5WvpZZ0vLGWU0t+PmOU605IE8DkjXih9w8hAHQ0ABfz3mx6+PeWlomP+1ineFtJdBADAdTP2qLnuY3tqMVqgu4aL4K3KeC3HBp8dQObv8tyzhSUnxpteiEYhgjKrrqymkyeO/IOgpDJTfUAV8yH5+077j1pG2DlR+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLve0O2f; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLve0O2f"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d5bbbe592dso2720443241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Mar 2024 10:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709575921; x=1710180721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YNZrRAUzN5MGr9s/8qpbckxWtvLECJmp99x9D5PzTZ0=;
        b=kLve0O2fMjsY4mgGmzM4lN3YU4rM7JHOuX7ZS316g0kpqNeJgSeUMX6mmaHxcsMxrJ
         Fk9ihgwfryw3T0K00UyGi8aSbJlBil9NQh/IPvzhkCcbLDYFfTZ+qNfW6r0TyEav7JOx
         uAqtMQ6/RQQQPxXsjirY5fF+J+njvPVei6tIn4TakayJk2I6EaisJC3+bpYBqEvJdwwa
         xC6PrFNs1/SS8ndqNrXkKgJ45/+QEeiQ1eRRm8+5bkOB95xaxBPsqKw2ywA88OanxofW
         UsT/Y1o9M0jvrLdhG0HhyzbOSoyzT7lhnDMe12EOwvFGqRkGWrHw3awS46eYND7Dt8qH
         cWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709575921; x=1710180721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNZrRAUzN5MGr9s/8qpbckxWtvLECJmp99x9D5PzTZ0=;
        b=nG37S2lIX8BEqNlYl2CUvS/efoERA9Ubdrp5qDAzcSdW49DDiaVgdKwH8OXfumJFiH
         bjwVVlfFtJC7KPMWte5NudWPpg00lQTQJJzpXsPuGmlOLqlOD8V7i5r+/YUm06vEUkAP
         WGT3g0ickMQF5OBElGl4+9ZRsoN7pvTNCFUPP7Nuuv0WthK2FmCGjr4XAwGiXDoDR8aF
         GBb8L0O5U8UWzBJnny2Bq7+hqo41uPkaX7Dj/dYS1Q3fcLM6cTdr3nu2iFV8W76JFUca
         IHZe5WUabs8mAJXE2sI5Kk4cvepk/PPu2S5PYuaK/mpXCx041cXkHJeaNyq3vOV4H2KV
         HPWQ==
X-Gm-Message-State: AOJu0YwIa698u3ifDfFiOgKA42KvPnYGeSlh72Zzrz28ofKwGGxij5+I
	fvMJvha5K9iZRaAHSF5oAgBYB+oJkie3yhGd3a0Jt1a9M6LW7scFwfXvlqes
X-Google-Smtp-Source: AGHT+IHSydA8gcY2JDCguDIXwJttLrvGKqzNKDrgcYXEm4KGYFBkgzocdwJSTb3vJs/RU7AJMgtIRg==
X-Received: by 2002:a67:ad17:0:b0:472:a0f3:9c71 with SMTP id t23-20020a67ad17000000b00472a0f39c71mr5602079vsl.25.1709575919358;
        Mon, 04 Mar 2024 10:11:59 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id bq9-20020a056102534900b0047064bd643csm1539656vsb.11.2024.03.04.10.11.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:11:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] build: Fix distcheck
Date: Mon,  4 Mar 2024 13:11:57 -0500
Message-ID: <20240304181157.3170287-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following errors:

/usr/bin/mkdir -p '/backend'
/usr/bin/mkdir: cannot create directory ‘/backend’: Permission denied
make[3]: *** [Makefile:4768: install-cupsPROGRAMS] Error 1
---
 Makefile.tools | 6 +++++-
 configure.ac   | 8 +++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index c17244677673..27a753762d1c 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -539,7 +539,11 @@ endif
 
 if CUPS
 
-cupsdir = $(CUPSDIR)
+if CUPS_SERVERBIN
+cupsdir = $(CUPS_SERVERBIN)/backend
+else
+cupsdir = $(libdir)/cups/backend
+endif
 
 cups_PROGRAMS = profiles/cups/bluetooth
 
diff --git a/configure.ac b/configure.ac
index af0e9900e732..6552154a86dd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -247,7 +247,13 @@ AC_ARG_ENABLE(cups, AS_HELP_STRING([--disable-cups],
                 [disable CUPS printer support]), [enable_cups=${enableval}])
 AM_CONDITIONAL(CUPS, test "${enable_cups}" != "no")
 if (test "${enable_cups}" != "no"); then
-   AC_SUBST(CUPSDIR, `$PKG_CONFIG cups --variable=cups_serverbin`/backend)
+	AC_MSG_CHECKING([cups directory])
+	cups_serverbin=`$PKG_CONFIG cups --variable=cups_serverbin`
+	AM_CONDITIONAL(CUPS_SERVERBIN, test "${cups_serverbin}" != "")
+	if (test "${cups_serverbin}" != ""); then
+		AC_SUBST(CUPS_SERVERBIN, ${cups_serverbin})
+	fi
+	AC_MSG_RESULT([${cups_serverbin}])
 fi
 
 AC_ARG_ENABLE(mesh, AS_HELP_STRING([--enable-mesh],
-- 
2.43.0

