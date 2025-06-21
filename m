Received: from smtp6.goneo.de (smtp6.goneo.de [85.220.129.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C243AA8
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Jun 2025 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750503172; cv=none; b=hfg8f5PKkQrcs/UG2r8vcO6ARqDfgqwy4wjowqOBUKZFi2rMlkyPdYOZpp999M4UPuLr0hKbR0+ttTEAT29k853xexAJVSBPu7R4AdnzjbYzUmggD415mDrNld99sMIVUKFebL02Z0e5jKsPTyO/5Eu3Vi9xECFx3kIc3s6U6/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750503172; c=relaxed/simple;
	bh=LVQ3rKNZ/9T7Nhtl2RkSzWI0MeHvAmAexLdc6W+M5pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spZJW5FvJZRC4og1XaCCrmRQDaOvS6VKZ4k9x/u0+7Hlrd6ItiGDJz25A1MGxvNBmqY3y5P19/xVKi4NDZv/ZXl6Vhwwy3FAJc1sivjt9AmlT9Hakn0JwHwiheOtuRLwZo2qbO1pNt96Sk/4eOHaLAJEFvzAI1T09/romqKHlQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=tYEtukEx; arc=none smtp.client-ip=85.220.129.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="tYEtukEx"
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp6.goneo.de (Postfix) with ESMTPS id 80D44240DD0;
	Sat, 21 Jun 2025 12:44:39 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id E56782402EB;
	Sat, 21 Jun 2025 12:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1750502677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xqIeDF/Snihdx30vJaGAzjLFf6KNL5tW1AcENHJ3fEg=;
	b=tYEtukEx4r+MvFnPMUH1Cr8R5hLSXUkPIp3OpY9P75jIwAwz/vv4Ub7dmT9UQwlDzz6FHI
	B+xoMyGgj16dWLxOUWuPfcd0GYvdEscwvlZw/KROSIShZJoD55PlNlRN04zQVDZmHVWucE
	j2RY5tNgUTmqFXUvJipDEH3dvjT/VHoEeaLTPGB4UtzERRVFMCHAXXrGEvgS1R2MlfT/7m
	+COBlkOTkPfpPSzJCj3iEIB2jB9z1CMDD7AhP2zT7FguQjJ1NXmlu/mFgRgrBgxkfUo/La
	2fXQSOGxDz2dN8GMbLmRxcJznUc6Z5Zffgh6lldUfc7b8LqbV/ZvqSelFiC9tQ==
Received: from Til-Notebook.lan (dslb-084-063-142-151.084.063.pools.vodafone-ip.de [84.63.142.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id C9EB0240283;
	Sat, 21 Jun 2025 12:44:36 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: linux-bluetooth@vger.kernel.org
Cc: Til Kaiser <mail@tk154.de>
Subject: [PATCH BlueZ] configure.ac: check for stdarg.h
Date: Sat, 21 Jun 2025 12:44:15 +0200
Message-ID: <20250621104415.63416-1-mail@tk154.de>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: bbb8be
X-Rspamd-UID: 5dd69a

Currently, there is the following compile error while
building with -std=gnu23, which is now default for GCC 15:

src/shared/shell.c: In function 'rl_cleanup':
src/shared/shell.c:1435:9: error: too many arguments to function 'rl_message'; expected 0, have 2
 1435 |         rl_message("%s", "");
      |         ^~~~~~~~~~ ~~~~
In file included from src/shared/shell.c:29:
/usr/include/readline/readline.h:410:12: note: declared here
  410 | extern int rl_message ();
      |            ^~~~~~~~~~

This adds a check for stdarg.h inside the configure script so that
HAVE_STDARG_H gets defined and the correct prototype is picked
from readline.h.

Signed-off-by: Til Kaiser <mail@tk154.de>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 07aeb46ca..ad03a45e0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -70,7 +70,7 @@ AC_CHECK_LIB(pthread, pthread_create, dummy=yes,
 AC_CHECK_LIB(dl, dlopen, dummy=yes,
 			AC_MSG_ERROR(dynamic linking loader is required))
 
-AC_CHECK_HEADERS(stdio.h string.h linux/types.h linux/if_alg.h linux/uinput.h linux/uhid.h sys/random.h)
+AC_CHECK_HEADERS(stdarg.h stdio.h string.h linux/types.h linux/if_alg.h linux/uinput.h linux/uhid.h sys/random.h)
 
 # basename may be only available in libgen.h with the POSIX behavior,
 # not desired here
-- 
2.50.0

