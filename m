Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561793FD96A
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781365745; cv=pass; b=m35nY+CXqN+oVamrm0kMVVyl1j7e4SHQBsOWQ4PYZCM2xBxy21T4wUZKQxGGivgkRKemXvMYOk8zmPAJCmlE/thgsB7sgjfqZ20JbOBQp95beuMXjd0HvPQQVWfCXuvRGpYJrPfZ/QmpfYtixvaa4XUrIThky2lLdA/xLVx8FB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781365745; c=relaxed/simple;
	bh=LFxyv2Ch/23gZDICsE8gD4EfxhHBYO3lbppzsYp07d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XubfY+prsBGrYddrYknRcUQDFOSkUEklT2gfSZ5STtQhc/hNGBN5InDEA2smylCAa5Mggk0DlSmfV5V+j7Ua54EsRyJ3Lx/GXbxNUBLI3zUV5asN7zJUn7kWR1t+efVvMK2iShSc5UuUdWQRgARYF0xeTLVe70YdDxyc0KSipEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=GEGhzVOm; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="GEGhzVOm"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gd15T63jbzygf;
	Sat, 13 Jun 2026 18:49:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1781365742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzKlevh4vyrEza8vi1odFWj9tp8/ZJEwJEYAzmyvuXg=;
	b=GEGhzVOma+CNj/hyYSTJaCqAVkqfdOPSuTQ2S6b++dWMV1NjMGOGmy8dD1/ahPP7MRkS0o
	q7PtuZcFD42PmMHcXOukqs4V0oSLFE6L4dmGPYMZYPl2dAGxWaF3ycKaeJvkVxExztV47p
	ZnGvVrsQDE+GfZ+QU9H4PyJMJNiNUn4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1781365742;
	b=GOhvrgmm3dyEn8vOizs0I3dGSIvKwrLUKSYioUbf+PTKaHIn1TzrTKalPbRifU3uMPTIjO
	hlRv2N+9CF5G3z/zn5KarPTCG0H3hyY3de0giLsBYxAfYc+qogO3PJ0xRv0SP+TUWN66Vl
	mgIRisyjH2VWcnkCWw5PBFSX/ywI7wU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1781365742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzKlevh4vyrEza8vi1odFWj9tp8/ZJEwJEYAzmyvuXg=;
	b=f/s5+5Pr7/LRfxeHAjFwtPwAU+BDY3IIH4+ctrYo0sz5qiLdQDE979Z3NqMeguB+KiohLY
	mG/DZtCCd4yJHX+j5X4EdUUvOoiQxD0p8IJHazf+QDZecQciPaoyVIP6dWpUmBnrrhw4dL
	1Di85pBwjYwIHjenlSS2n2LtuA3QqJ8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v6 5/6] test: functional: add some Agent1 interface tests
Date: Sat, 13 Jun 2026 18:48:51 +0300
Message-ID: <a6a66d21237963459bbb5b8d95f62fe319c5a20e.1781365708.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781365708.git.pav@iki.fi>
References: <cover.1781365708.git.pav@iki.fi>
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

