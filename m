Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645E5199246
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598461; cv=none; b=ZCWyu1CfGb6SvJ7K4nP5mgJMnv8cJSw1/A0ImLcQPyc+GC3iR9ObbqhE0LqkoKd708Rr5pFwboQmI+gMCz8RgYhyPQbhQgAkJKkMamU4ni/OFV8UXDfkgYwGngteAE7snRIhPOxIi/EiVuXXKJDwE2BotxvdNMGgGgC4Vw1nZzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598461; c=relaxed/simple;
	bh=8TYtxj8RCuYcQ+6mpbMkTfqD/80RbkhK9oPnRW/Hk+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ft1m2UhC37Fnt1Jiu8yaaqWKQaXTGJuQ9TDMQKrbFzHo0gr20+gGkpOBCOMlXw3reMosafrd7U6au72I2/hSSb58GH3cTYR7kLtX+58OqcDVMv7qQvIF6OpaHSc6K1dqb5U8X9Q9I0tPrsoTJO+8q4LfmpR8z9HcF18tROv3y1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DBB11C001F;
	Tue, 22 Oct 2024 12:00:51 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 1/7] configure.ac: Update requirement to glib 2.34
Date: Tue, 22 Oct 2024 13:58:31 +0200
Message-ID: <20241022120051.123888-2-hadess@hadess.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022120051.123888-1-hadess@hadess.net>
References: <20241022120051.123888-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Update build requirements from 2011's glib 2.28 all the way up to 2012's
glib 2.34. This will allow us to use g_clear_pointer().
---
 acinclude.m4 | 4 ++--
 configure.ac | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 4b73a5bfc38f..d0bfe6ccb2fa 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -62,8 +62,8 @@ AC_DEFUN([COMPILER_FLAGS], [
 		with_cflags="$with_cflags -Wswitch-enum"
 		with_cflags="$with_cflags -Wformat -Wformat-security"
 		with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
-		with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_28"
-		with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_32"
+		with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_34"
+		with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_34"
 	fi
 	AC_SUBST([WARNING_CFLAGS], $with_cflags)
 ])
diff --git a/configure.ac b/configure.ac
index 7093e41ff714..14bd15293918 100644
--- a/configure.ac
+++ b/configure.ac
@@ -81,7 +81,7 @@ AC_CHECK_DECLS([basename], [],
 				 ])
 
 
-PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28)
+PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.34)
 
 if (test "${enable_threads}" = "yes"); then
 	AC_DEFINE(NEED_THREADS, 1, [Define if threading support is required])
-- 
2.47.0

