Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DEA612E5
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573710; cv=none; b=pErPZ16DRirZCD/KB7TZ7woSt80n/pc1rj1aMvcalEsR1mtzgP/IBnzxDBM0O+dxcKdbiOcd4gTa1quzQ2QT589xpn/jvnC4tk779/WKNt4iQp2Ev451s2sm/vxlihqrm5XDjsMIlAjTzqcyEkkbvuMlck5ioUb5yayG1RxrQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573710; c=relaxed/simple;
	bh=/z9v8eBdWdGmU2u3pv3BuX4cSaS43B8/i6spOF4/YdU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i/NFW2pnKjiZuW2GWgNy2yOv0ImyJKtUr1AjGlO4+PdjeW0ASl8427+8qwixfKhjFyqesE04m9mNRDo/Fz7pFzS3Wv8IcW5rvT42slG3FTDsv4bBxmS7dfg48gMtFgSW5rVxANXzVX6N/8KrD37JJ7tagq9K7GxhFW1DrNMTTNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/Poyer1; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/Poyer1"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d5c2502ea2so2661167241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Mar 2024 09:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709573706; x=1710178506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYab5m4OXA57pexUD1TfE2T0LALDdnYNTrFBJzZzJZI=;
        b=m/Poyer10qmwW30hn+CUUI9P7BEGTxYQ0TpQzDvaKDoqvDF6jbxXy8MH3nlmbKMwS/
         y/RE3nA36xVVY7oyQK8XvDnxZhZBhu7dYAJxjRlxedM2w2sipAR1OeNfUk9cNtVuMLKr
         I0hw9tKb8D/q2sr1YbQDGjaTCW5Cyiu6WbMbNmTRvtgxdbhrwcN2d0Jik9pQbNu3xeEJ
         8iE/9siPne6cncnW5WD91iuzOtvrPHAidA02sFxUwh8DUyAs/pF6UlHB8tnmu+KKsG+Y
         OTbmHCcJsghJQFeAr4ynul00asGweXFjR/PBF4Np1J7iUJxjT8HxWcnVebPlI+1bwMXl
         h5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709573706; x=1710178506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYab5m4OXA57pexUD1TfE2T0LALDdnYNTrFBJzZzJZI=;
        b=JhqQiCFUJSw0h9Ba0wmVDzSA5YkD1plA2aCjqztKvRf45G8XkXpQ4meo38sN3s8gaY
         OhZuNyQtZ8XEHvwoIwz1SOh+EpsZzPwUBrp6BHYOxRR7BglHLwLDUL4y1BUKBqDdGQT/
         C79Qcp6onfNrTgQl7UWBhmtFJlCGEof8FI+hPi2OxFkoRXQQmQZl0Trq4UCMIHJxP1ty
         As0YV1UrewDE3pG8WZrEnDmZWK5KXxW9h4dQwWA39bhR5zDR18lPvaoQC4vbON71Rdpb
         qP2vZE5bRWzACnRQmuAn076G5GfyxudKURDwPe5YvNcD4dB7y/xrdYdWvQA5lTU+F5yz
         vhxA==
X-Gm-Message-State: AOJu0YznEy6GVNlJ+n6z0PAp7u5FEvhQpDt6Wr9uRa3kK0FtCR/T2wCS
	6n2W2HIUdhGY42UccBNM0zf8NMFcSocld6Fo/ZmQaSwA4XOyQmG4jyXLqVDL
X-Google-Smtp-Source: AGHT+IGsxOh8hCh4Xq2pL/oLfiA8OJUGeeRtXk/Km0w9UcQJiV7vqX35V43pJHGYHcZYY+xxvFk3xw==
X-Received: by 2002:a05:6122:917:b0:4d1:34a1:c892 with SMTP id j23-20020a056122091700b004d134a1c892mr7549648vka.13.1709573706130;
        Mon, 04 Mar 2024 09:35:06 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id h8-20020a05612201c800b004d13bb918c4sm1136024vko.33.2024.03.04.09.35.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:35:05 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] build: Fix distcheck
Date: Mon,  4 Mar 2024 12:35:03 -0500
Message-ID: <20240304173503.3049383-1-luiz.dentz@gmail.com>
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
 configure.ac   | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index c17244677673..d887bfb12e40 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -539,7 +539,11 @@ endif
 
 if CUPS
 
-cupsdir = $(CUPSDIR)
+if CUPSDIR
+cupsdir = $(CUPSDIR)/backend
+else
+cupsdir = $(libdir)/cups/backend
+endif
 
 cups_PROGRAMS = profiles/cups/bluetooth
 
diff --git a/configure.ac b/configure.ac
index af0e9900e732..244c50a9f7de 100644
--- a/configure.ac
+++ b/configure.ac
@@ -247,7 +247,9 @@ AC_ARG_ENABLE(cups, AS_HELP_STRING([--disable-cups],
                 [disable CUPS printer support]), [enable_cups=${enableval}])
 AM_CONDITIONAL(CUPS, test "${enable_cups}" != "no")
 if (test "${enable_cups}" != "no"); then
-   AC_SUBST(CUPSDIR, `$PKG_CONFIG cups --variable=cups_serverbin`/backend)
+	AM_CONDITIONAL(CUPSDIR,
+		test `$PKG_CONFIG cups --variable=cups_serverbin` != "")
+	AC_SUBST(CUPSDIR, `$PKG_CONFIG cups --variable=cups_serverbin`)
 fi
 
 AC_ARG_ENABLE(mesh, AS_HELP_STRING([--enable-mesh],
-- 
2.43.0

