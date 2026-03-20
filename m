Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8D35836B
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041140; cv=pass; b=UUeUGYiKwmAspIQI3Pea8AEy8k/UeqXoKmNQNxSks3Cs0vbJeMy0RBNfAMiZX7mkLvX04AuXgkKOBjsMMrUqro4uiZp3s/FB4taBIqAsUToGpRmn3b3AGFyZWfnbd79REzP27IsBvNFim0cF+8ddDiSzEU9ad2ynI7Yb1k8+Who=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041140; c=relaxed/simple;
	bh=pd72V/ZP6fZrB49iq9eUProQiUelSIMVh0RX4zYvUdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9gpQ1O3Hk91ZjqxuVLLNVlLe/QBrtYJbCpdQCsCBIFSrcrZ5as2EJ38dWCvYbwbQdWFITgwLtwNFnXj3VdTB7Z4Ww7oZIcbd+oo8jtuEhA51zQ2z0A8tYxqrIcDaqbbNELwpNlaLCYPzw3xy+SqsZ+m36DMlzAoaeT4+pQzERY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=P2c9Gte8; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="P2c9Gte8"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fcwHj2Kjxzyvd;
	Fri, 20 Mar 2026 23:12:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774041137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FreRdvAGW3g4mdia3qfgTZRE67OMsG6Bkn85LL5IKCY=;
	b=P2c9Gte8kka1W+/iPvB9s05BapvGEvbHdA8B3MCuaykewp6MMclBtf0YYqc58JmVXiy0n5
	TtP9yeU1ZmZurF3CsMv9kQfUMuRyg9m6BxbBsXde8oeMGuDSNkumAkBYFYGRCJVXLpYUra
	8cwND+w4U4ou9rh6v3F4DkzUmSXGTZU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774041137;
	b=EAjkYCRN7YsAzw9ssDDTmwlTaQssR8CZx35UkAanuICEQLcIUPaDC5++G4a7BzI+jQR+lY
	twysJGykfYA/BiCBChU8ucehWC6s43dAkCX1jgqTJupVK+Q5f14ykpTanQ2kNXpGeW5pPj
	8La47b9hCWjMEzCWLZv3IVSuzZaXh/E=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774041137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FreRdvAGW3g4mdia3qfgTZRE67OMsG6Bkn85LL5IKCY=;
	b=emW2DYgmDsvF+Wgks3wUGzFicGInuTn0cJio5VCoWFPQkM4m2v2URPX7ctp04oy84U6evz
	hngbLyoW33UMT2g4qJdebn9b7q4T1F4M15T9jjtWMWUZeChJKG7Ef/APN17Z/6DTZTh3Kr
	vFLhWRFUmKNIw4BFyn20lBsGRxgjHZo=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 19/20] test: functional: warn on kernel warning/bug messages
Date: Fri, 20 Mar 2026 23:12:06 +0200
Message-ID: <36e33789e0da25a142120cf72d1f94a93f2e2c66.1774041047.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774041047.git.pav@iki.fi>
References: <cover.1774041047.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emit warnings if there is a WARNING/BUG message from kernel.
---
 test/pytest_bluez/env.py | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/test/pytest_bluez/env.py b/test/pytest_bluez/env.py
index c4605d8ee..f7fff18fe 100644
--- a/test/pytest_bluez/env.py
+++ b/test/pytest_bluez/env.py
@@ -562,8 +562,8 @@ class Environment:
             if not success:
                 raise RuntimeError("Error closing hosts")
 
-    def _add_log(self, *a, **kw):
-        f = utils.LogStream(*a, **kw)
+    def _add_log(self, *a, cls=utils.LogStream, **kw):
+        f = cls(*a, **kw)
         self.log_streams.append(f)
         return f.stream
 
@@ -713,7 +713,7 @@ class Environment:
 
             host_names.append(f"host.{ENV_INDEX}.{idx}")
 
-            logger = self._add_log(host_names[-1])
+            logger = self._add_log(host_names[-1], cls=_HostLogStream)
             self.jobs.append(Popen(cmd, stdout=logger, stderr=logger, stdin=DEVNULL))
 
             # Start log reader
@@ -752,3 +752,22 @@ class Environment:
 
     def __exit__(self, type, value, tb):
         self.stop()
+
+
+class _HostLogStream(utils.LogStream):
+    """
+    Log streams that parses kernel BUG:/WARNING:
+    """
+
+    def __init__(self, name):
+        super().__init__(name)
+        self._warn_re = re.compile(
+            rb"^(BUG:|WARNING:|general protection fault|Kernel panic)"
+        )
+
+    def _do_log(self, line, anc):
+        super()._do_log(line, anc)
+
+        if self._warn_re.match(line):
+            fmt_line = line.decode("utf-8", errors="surrogateescape")
+            warnings.warn(fmt_line)
-- 
2.53.0

