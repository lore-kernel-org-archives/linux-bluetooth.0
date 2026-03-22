Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38123644C1
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215092; cv=pass; b=PPo2sTTo/1eWryqoJIsjbnTX2VhM9yKlhtvH26ihWDTOaHOfZ82NH3LbbFfqlcpNWu/Kv3WDj/L6kuFxtNpRd/+hWFWU8/IpXbIpG+kqSkjmdqj6dqSWW9vfyG5HkAl/NHjz2+D+7MhqEMs32ZaPI4vWfs+h/ugYadXLYG83tgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215092; c=relaxed/simple;
	bh=D3AKgI9QFiI7I1LHB0w8ngrIJ2qXJuLs/unUKBU+y1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qN9DhkXRIYknw2DXpe7XfQK87GZclDmlzs39Z8CUKZIXYo4mTlXrwxhGNGLxw3f4p5PlznHLqYalsE9MJz4dEMNOKrLesoNWQr6P84QUu4NPRMFv4+bjfKTmTBR40NNWgCRumaBXPHxU3i1NEd6jLV9o1Js9O9fajT5+/qwUIfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=WcfUZ8DG; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="WcfUZ8DG"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ff8cx0lvjzyvm;
	Sun, 22 Mar 2026 23:31:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774215089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JuJcXVmjl8AzCI6olyS7oWBWIBPdIhTAWqvX26R544M=;
	b=WcfUZ8DG/rvtRHswrDpauAOddLIwaPqJvF8b6+ql2qSDCyib6mOJmYhiYFuPpt51/O42wL
	YRYUkryyl+G4u2FavFZDQvpy2+yHb4qF7oOV3VrgkNz7wrrGFaNkiPXpgbqwAJWhMytsaU
	dOtu7z4oTVRSd+SCkKx5zjRh3QDq0YY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774215089;
	b=TCYi6NMRvyAdnNuq6MkxcpwyEG5SJ4G75MQMzVu21rErG0ILtLLWrcBy7L8urj+vBdiU+Q
	09oM2s+w6TqJVMZXXE1hXBaFvA/mj9eypMSczBgWJJXAhSyY3hlI2rjcAo67f6mHQE8vWw
	HkJlhznoTawAV5eCX/9zANR81+UuJsw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774215089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JuJcXVmjl8AzCI6olyS7oWBWIBPdIhTAWqvX26R544M=;
	b=l4QHWUK0X1poDVZ1tCG/C820SJdlKJwp9aT1BGdslDg06WDkUeoe55cBpfWiPx/nA9rZb7
	4cc6RDru0LKAuwQTZlaGXJd+eze9PJZfPJEWuo+KvN6ypSXF8BqZNxA7kUlNTHyXqp7dZB
	MU4X7fQ15DuaMF2wWpXo8YC4Z2aMSoQ=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 19/20] test: functional: warn on kernel warning/bug messages
Date: Sun, 22 Mar 2026 23:31:19 +0200
Message-ID: <f5b21a21789b73bff88c52ef57a5d3c546f9b637.1774214693.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774214693.git.pav@iki.fi>
References: <cover.1774214693.git.pav@iki.fi>
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

