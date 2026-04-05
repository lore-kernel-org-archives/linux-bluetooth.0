Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FE02749ED
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392897; cv=pass; b=tMn18CsNs/mrfrRbRXiNvmd676YeKeMpQPiKHJC4gOZb1SVRsTRIYAi3JdRDaTej1vqZ/jdKidNSZVGMUA9vMezZmh7xojItb77twS4LxcuHniFPeuOqxPNtX+BooC2VlHBLhDYzvTi2CloEh8xiLIljDULqY+CH7y9mNgrUR6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392897; c=relaxed/simple;
	bh=D3AKgI9QFiI7I1LHB0w8ngrIJ2qXJuLs/unUKBU+y1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0MWbx7Q39+y696JCPhICTAx47wh0p3bLf5KqTJajmAm7fS2n5dlzwLAOCsnl9a+B/uknuK6hmUaogFpZs3ygwNPmUBL3fHoHOaSYBF4M2lQyxz+64SZjNqU+rwq1qxOD74TjpzJjcG+VUac9QE0axPkJgysPWF8VUpyBfjcN80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=OmgPMERb; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="OmgPMERb"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpXBy5T1WzyxD;
	Sun, 05 Apr 2026 15:41:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JuJcXVmjl8AzCI6olyS7oWBWIBPdIhTAWqvX26R544M=;
	b=OmgPMERbAcAiyl8bKhAnL3l7RcoEdACXaxWjcqqPOienb5AGu6WTsx01rUyBgE666hi8dO
	JJrsL0OYfntG0JDT8P+t2yzfcZlEc72E8dfMXophQMWQH4jKcj36aMS7xDCO3q3ejHRJga
	1VzUXOt146kSRSWXN0AmnuXWX8F+N9k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JuJcXVmjl8AzCI6olyS7oWBWIBPdIhTAWqvX26R544M=;
	b=vWqWr5iAff2lDUbl+rq5QSyw8aut8jVynp4Xae3c2DR49U87AUDYYLLz5vVgrS+s1cZM9c
	vZd71sPQXyXNo3VYz6FWDJH2S8yMQxDBwXqESw00ZgceT3E9wvNy+4M4TMvb0+Y8OmxIdE
	LPnZ72vchPCWj3mG3Y4PsmEnKcUFwb0=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392891;
	b=Tgoqd7Aq1u83SqMy+yy7j8e2nRTG6VzI8G5m3YjgUIaTfv9dXKusFHUMXQVyJ6b2ZjGpHC
	D4xHk+7b1Z7a50eN/BL7v5nQlkGwDy4UKPpi1HMIV0GSNtqlwvNmynJqdfa76pk4FZzScZ
	+G0oImJcZs90c3CBg2cWW7nIZTqeGe0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 19/20] test: functional: warn on kernel warning/bug messages
Date: Sun,  5 Apr 2026 15:40:00 +0300
Message-ID: <997e0fb9b555556de27258139a196b009371f7aa.1775392680.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775392680.git.pav@iki.fi>
References: <cover.1775392680.git.pav@iki.fi>
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
index cb920e714..eb7a6069f 100644
--- a/test/pytest_bluez/env.py
+++ b/test/pytest_bluez/env.py
@@ -581,8 +581,8 @@ class Environment:
                 errors = "\n".join(errors)
                 raise RuntimeError(f"Errors closing hosts:\n{errors}")
 
-    def _add_log(self, *a, **kw):
-        f = utils.LogStream(*a, **kw)
+    def _add_log(self, *a, cls=utils.LogStream, **kw):
+        f = cls(*a, **kw)
         self.log_streams.append(f)
         return f.stream
 
@@ -743,7 +743,7 @@ class Environment:
 
             host_names.append(f"host.{ENV_INDEX}.{idx}")
 
-            logger = self._add_log(host_names[-1])
+            logger = self._add_log(host_names[-1], cls=_HostLogStream)
             self.jobs.append(Popen(cmd, stdout=logger, stderr=logger, stdin=DEVNULL))
 
             # Start log reader
@@ -782,3 +782,22 @@ class Environment:
 
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

