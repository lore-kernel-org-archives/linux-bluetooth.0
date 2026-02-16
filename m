Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E382737F2
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771260697; cv=none; b=RuYTdEZ6pah4u/lU3C7bguykgx7A2uAVC1dm7Rd+3CEqc8F5ZuQEk1e8pV+jQCTKcQILCI8XARJNpdMqxeDuRqHHk7MXEb1bAEOizy0RWUejG2V+ll+MONuGZww5nCgxzw0w7pqVPTjlIxlsDOVAWE+p1a/z7Z7WmRYUzYj67eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771260697; c=relaxed/simple;
	bh=tCfMOSeVHKMlN5tfwaCoya3sUE+TCmWQVHCUi39DOcU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mXXGYniFuN9IMTndVrYkfsLp3dFjy7WnIug94tvzQqLeL7x7RjibO/ygIthJ0gww8tnopcGzcfYhEEogWwXhWG/irtIWDXiN7aEHsozdFGdEWVkz68aA3PMP+50H7CEFadIHyy8LPiOI14MF+QpFH27EFn5jPb+I/7QvwSoPsI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C6N2BOw/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C6N2BOw/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1771260693;
	bh=tCfMOSeVHKMlN5tfwaCoya3sUE+TCmWQVHCUi39DOcU=;
	h=From:To:Subject:Date:From;
	b=C6N2BOw/jDnYa1Y6aRCmKzxS/2kTPOcufDUreMo2NCHmGiE6rN1gwYuQ8O5er0QNp
	 7JjXush7wlpYgmxRv04O8rG4cCsQAb4wj/xZ7MI4DGWVlIL7ePrxOEtDgFduMIc2Ld
	 ryjfqWQ0RqkPVAjQEYgJzutU6/n3ta+17TG5mNz/CcSYwJZcFbeHaRdw3zwlW60o7n
	 AMoCkMPZ9MdflVVx6MELC1tD+Fu+7J4J7liEmuyNVQV9KGYUGOIgYrR7NVfuyBy2hf
	 bJ2xXJg9PEC8BUNYq3kcVFrHUxCLWEX+VJ4XoufN8FrAu4vRU7Hbh6DU8yb+Tw/R/n
	 TtbpzkLV7P2WQ==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-Af44-1001-4c10-12D9-233c-cfc3.rev.sfr.net [IPv6:2a02:8428:af44:1001:4c10:12d9:233c:cfc3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 477AC17E00A3
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 17:51:33 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] tools/btpclient: Move btpclient to client/btpclient directory
Date: Mon, 16 Feb 2026 17:51:25 +0100
Message-ID: <20260216165127.110686-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This prepares the split of btp services in per profile files for
easier maintenance.
---
 .gitignore                                 |  4 ++--
 Makefile.tools                             | 13 +++++++------
 {tools => client/btpclient}/btpclient.c    |  0
 {tools => client/btpclient}/btpclientctl.c |  0
 4 files changed, 9 insertions(+), 8 deletions(-)
 rename {tools => client/btpclient}/btpclient.c (100%)
 rename {tools => client/btpclient}/btpclientctl.c (100%)

diff --git a/.gitignore b/.gitignore
index ea895c064..71ef28e1e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -133,8 +133,8 @@ tools/btattach
 tools/btconfig
 tools/btmgmt
 tools/btsnoop
-tools/btpclient
-tools/btpclientctl
+client/btpclient/btpclient
+client/btpclient/btpclientctl
 tools/btmon-logger
 tools/bluetooth-logger.service
 tools/mpris-proxy.service
diff --git a/Makefile.tools b/Makefile.tools
index 4f4ee88de..edfb5282c 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -583,14 +583,15 @@ test_scripts += test/bluezutils.py \
 		test/test-gatt-profile test/test-mesh test/agent.py
 
 if BTPCLIENT
-noinst_PROGRAMS += tools/btpclient tools/btpclientctl
+noinst_PROGRAMS += client/btpclient/btpclient client/btpclient/btpclientctl
 
-tools_btpclient_SOURCES = tools/btpclient.c src/shared/btp.c src/shared/btp.h
-tools_btpclient_LDADD = lib/libbluetooth-internal.la \
+client_btpclient_btpclient_SOURCES = client/btpclient/btpclient.c \
+				src/shared/btp.c src/shared/btp.h
+client_btpclient_btpclient_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-ell.la $(ell_ldadd)
-tools/btpclient.$(OBJEXT): src/libshared-ell.la ell/internal
+client/btpclient/btpclient.$(OBJEXT): src/libshared-ell.la ell/internal
 
-tools_btpclientctl_SOURCES = tools/btpclientctl.c client/display.c
-tools_btpclientctl_LDADD = src/libshared-mainloop.la src/libshared-glib.la \
+client_btpclient_btpclientctl_SOURCES = client/btpclient/btpclientctl.c client/display.c
+client_btpclient_btpclientctl_LDADD = src/libshared-mainloop.la src/libshared-glib.la \
 				lib/libbluetooth-internal.la -lreadline
 endif
diff --git a/tools/btpclient.c b/client/btpclient/btpclient.c
similarity index 100%
rename from tools/btpclient.c
rename to client/btpclient/btpclient.c
diff --git a/tools/btpclientctl.c b/client/btpclient/btpclientctl.c
similarity index 100%
rename from tools/btpclientctl.c
rename to client/btpclient/btpclientctl.c
-- 
2.43.0

