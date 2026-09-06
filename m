Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8EB3B71B3
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713434; cv=pass; b=BH6PQC0Y9sqDQ1BbsYqE2pjawuxS5nnn3cL7i+nOJ5El3HG0noNpN2vQFHCozsLBzI6qqlx9jBRBut/WySI2wQMw8DvCbT8YD1SXd9uPBs4iS339gVxjN6Dho96T5iA/YXHzHqeclF1eiE/0CbsrPeeDKe60X910fwYn0uUUbSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713434; c=relaxed/simple;
	bh=dJFlfU7Qc4RgNpJdS4zOKMSHCfaPVIbfVvWOLnpu20Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsM222NXlTDFpTCHc1pohg8se1fVj+IbefQrAOPCEicDM7zCBLPI1kzYgJW4ulCMemujzUjMzV7SkatywsVQVm2mVjuTa6X1E2GPS4cCZGadNp9NGWR0Vj9bxSZ1SjItxjD1nPvr2yPZOSVOeRElfvSQN5vKc4sNFVr5WNDSxOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Ri4/6BeT; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Ri4/6BeT"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hdGQz2x8WzylX;
	Sun, 06 Sep 2026 19:50:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788713419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IbO9GAiwcUJfSE/dMK6BM1xc3MOBXTT+HN/WZ9qClw=;
	b=Ri4/6BeTT+zuV+YLTFmXxcMAuv49N8x0YWOD6RaEJwxRzl7ZDngCGI9PV9BVrkJwBxTG5b
	lTCisvCWzlD9gwFGHY8R6n+5MgqVAsbMhwyrssNyhD0zIWc3YkqgZ7GRelEhRLQBejWNeB
	4iWPJvL2DTY3SCq+zwlkcdagVB5Yg9M=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788713419;
	b=vWK51C9eBjSE4TwUVB17NjsYv6Tw6N/JcKZyTwKrgLeMYJj0T5trlhSYOaqllCPEbjpris
	msDIBYhIjw4IGx+JXuALh375NiyZRuxiMnqcuLtDx914J7t9Gmdg+BeNeyW4HZqqb+EwGS
	BA0D2WlbbMQKe0AwkZdLPRNKtOpBN/4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788713419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IbO9GAiwcUJfSE/dMK6BM1xc3MOBXTT+HN/WZ9qClw=;
	b=W6O9FhP0vriZ5rApydn4uso5BQstAYijVmySX5wW1qJ14CFnAxuY9odorPKoEUzx2fGX6/
	P4CN45JX7Gu1gDrhVUFLPWtRrLMDV3WftkVQvZBKcXxLlj1cF8A84bRClPceUc3ifEbE0v
	hzkEGHPVC6N9ZJJHviMfWxpjeSmbUX0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 5/9] test: functional: add some Agent1 interface tests
Date: Sun,  6 Sep 2026 19:49:47 +0300
Message-ID: <b1206d92064a1f45e2adad2b0049ce240b070b20.1788712996.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788712996.git.pav@iki.fi>
References: <cover.1788712996.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test

test/functional/test_agent.py::test_agent_pair_bredr
---
 test/functional/test_agent.py | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 test/functional/test_agent.py

diff --git a/test/functional/test_agent.py b/test/functional/test_agent.py
new file mode 100644
index 000000000..f2ce34576
--- /dev/null
+++ b/test/functional/test_agent.py
@@ -0,0 +1,47 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for bluetoothctl using VM instances
+"""
+
+import sys
+import re
+import pytest
+import subprocess
+import tempfile
+
+import time
+import logging
+
+
+from pytest_bluezenv import host_config, Agent, wait_until
+
+pytestmark = [pytest.mark.vm]
+
+
+@host_config([Agent()], [Agent()])
+@pytest.mark.parametrize("success", [True, False], ids=["accept", "reject"])
+def test_agent_pair_bredr(hosts, success):
+    host0, host1 = hosts
+
+    host0.agent.adapter_method("StartDiscovery")
+    host0.agent.expect("org.bluez.Adapter1.StartDiscovery:reply")
+
+    host1.agent.adapter_set("Pairable", True)
+    host1.agent.adapter_set("Discoverable", True)
+
+    wait_until(host0.agent.has_device, host1.bdaddr)
+
+    host0.agent.device_method(host1.bdaddr, "Pair")
+
+    confirm_0 = host0.agent.expect("org.bluez.Agent1.RequestConfirmation")
+    confirm_1 = host1.agent.expect("org.bluez.Agent1.RequestConfirmation")
+    assert confirm_0.passkey == confirm_1.passkey
+    host0.agent.reply()
+
+    if success:
+        host1.agent.reply()
+        host0.agent.expect("org.bluez.Device1.Pair:reply")
+    else:
+        host1.agent.reply_error()
+        host0.agent.expect("org.bluez.Device1.Pair:error")
-- 
2.55.0

