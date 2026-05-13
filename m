Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB7391E66
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689130; cv=pass; b=lHTh9Z6GtMxfSr00FwOZvrHb8WThqOwEZQC3ttQVDCJaJMJyB2D9l4kHJcgMmc2kUg0OR/TKTIQZO0OFB+ASzCBW7lofXocT+C2/h1caqJV6GPcLw8J3s2p+DSVmAtsrikbFXWhTIQDWJfGhk/UJ9uvFtsr9At5EncqWDME43CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689130; c=relaxed/simple;
	bh=LFxyv2Ch/23gZDICsE8gD4EfxhHBYO3lbppzsYp07d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArGydJAE0AwYflearOH/PAO4vLm1kscbWcWGvdmIkmVCl1KlqLaU7vgfdQjLAa1+r+UK3ArHFebRWkIVEJszSItOUr2sTjMxD6FxWajSix8MePGrhrNp13G07zbJgSYfpyiwrA0q31bbF6Z8cSDHv8x0knliahKiWbgocll4apg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=fu4wgSYT; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="fu4wgSYT"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gFzD56sWCz10PX;
	Wed, 13 May 2026 19:18:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778689126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzKlevh4vyrEza8vi1odFWj9tp8/ZJEwJEYAzmyvuXg=;
	b=fu4wgSYTuxIYJ2EHYRdvWYdbywdfVurcyc9ulgGen960MuDhZbJD42QmQj/1RwRJ02qHQg
	hL3aO8HLRt/4e7Zlcb73xfHTESweX74s9VAolA7pVCi6qGS+MV6aurn2N2rByqerH5sYu2
	abmqGg9qqa8xeVKfiI2UZnZ4dHkdacE=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778689126;
	b=NGhVWsvgeUSZ4DibIzFOavolBzwMil8giyPUJbSQIUTPn2u/6ouShwmpau8KTnU2rjD6Zn
	xMOe9mqIl9VL0GQuM6p9uY3S/gcNa+fm/anPaXyRk9lA651qZydSSTUqDjM8TkFFI+j06w
	7pSznpK9wsEpDTXaxERfBYau0q2GGN4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778689126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzKlevh4vyrEza8vi1odFWj9tp8/ZJEwJEYAzmyvuXg=;
	b=VoeocE9u1hpgD36+7QJbyELBWBTh1UPSUtidLLacs8d82aUyYmQV/etd44T3lzQcrfa5x7
	Az9jVW6dlXg+kbWUVCiOpelaKW+57L8fs5SU/gUaMbzmyedqK2q3Ok72R/jCSsETZl1GeW
	YorvJBie8kvN4H4nwnWE8hR8/l73UZM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 15/16] test: functional: add some Agent1 interface tests
Date: Wed, 13 May 2026 19:17:32 +0300
Message-ID: <68ee9a3acfab589ae78e3a7107969ee2e4cebf60.1778688966.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778688966.git.pav@iki.fi>
References: <cover.1778688966.git.pav@iki.fi>
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
 test/functional/test_agent.py | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 test/functional/test_agent.py

diff --git a/test/functional/test_agent.py b/test/functional/test_agent.py
new file mode 100644
index 000000000..24593090b
--- /dev/null
+++ b/test/functional/test_agent.py
@@ -0,0 +1,46 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for bluetoothctl using VM instances
+"""
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
2.54.0

