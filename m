Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA11218D
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741049411; cv=none; b=Dl6RhAjeZsfRlXxoD6Z3UhHMC/Pm0xH8ssyAGCOccx4bTNBEDKMOqvu2tigSTdts5AmBAE+sS2bXIEl6ixvIll7pIQwjPaZtznnYb5gE943+W/sGB/b8GnmE9CP5CUGzDOH3Pan4UNM4fBBzonrwqWijQytE4Po6aOJsMndtleo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741049411; c=relaxed/simple;
	bh=EoJ7pkFxrIXhQsrbnJ+D/iCMw4YYph0kohWues2huyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csC8ZOnYeRTyyrNkPRUMnYXxjsKTwsRMaDZNM8uFOgJT+NNFDC4eVn6NLwYVOBU/VJwJ8FSrajsl9wJzwRzqR6Gpsyi3Hc3/qKBEOOISE3zC7hX16n+OCapinqHt6JW6Cm6yI13ZmEl/j6xDLADT3cmEfLMRbXF8zkf0mIsF7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=fCZzxifs; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="fCZzxifs"
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4Z6HCM6jdxz9sWx
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1741049408; bh=EoJ7pkFxrIXhQsrbnJ+D/iCMw4YYph0kohWues2huyc=;
	h=From:To:Cc:Subject:Date:From;
	b=fCZzxifsYEsrtJqccgLsVffgRUKwbL5Z7mJgAnzygWXoy+/ikYJUIyRPTTGiU4n4M
	 EK7ZAOVcWyVOWku0PTNcXzo8Pwk7wQTE2wO4j3rpjC+P4pWnyWMyO2ofYfL8G6oB+n
	 ifxtLIkqEQpfhe60hpl2kwp0KmpC6MzbNg7zztvY=
X-Riseup-User-ID: 67B4E0ED25FC51B71D9ECA4BF70CFCCCCEAE1999C8F1EF61E23439813C1DCE93
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4Z6HCM4XrkzFphJ;
	Tue,  4 Mar 2025 00:50:07 +0000 (UTC)
From: orbea@riseup.net
To: linux-bluetooth@vger.kernel.org
Cc: orbea <orbea@riseup.net>
Subject: [PATCH BlueZ 1/1] configure.ac: check for stdio.h
Date: Mon,  3 Mar 2025 16:50:06 -0800
Message-ID: <20250304005006.32322-1-orbea@riseup.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: orbea <orbea@riseup.net>

This fixes a configure failure for readline.h with slibtoolize which
depends on HAVE_STDIO_H being defined. With GNU libtoolize this check is
implicit and with slibtoolize it will fail instead.

  error: unknown type name 'FILE'

Since bluez depends on stdio.h itself there is no reason to not check
for it explicitly.

Gentoo-Issue: https://bugs.gentoo.org/950467
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 6a19487f6..32e0a7876 100644
--- a/configure.ac
+++ b/configure.ac
@@ -70,7 +70,7 @@ AC_CHECK_LIB(pthread, pthread_create, dummy=yes,
 AC_CHECK_LIB(dl, dlopen, dummy=yes,
 			AC_MSG_ERROR(dynamic linking loader is required))
 
-AC_CHECK_HEADERS(string.h linux/types.h linux/if_alg.h linux/uinput.h linux/uhid.h sys/random.h)
+AC_CHECK_HEADERS(stdio.h string.h linux/types.h linux/if_alg.h linux/uinput.h linux/uhid.h sys/random.h)
 
 # basename may be only available in libgen.h with the POSIX behavior,
 # not desired here
-- 
2.45.3

