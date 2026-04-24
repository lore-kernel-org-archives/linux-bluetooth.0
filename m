Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CB1386C05
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022024; cv=none; b=YjoNd6w5fZuTwdT9kZb2Sya8rGfCY0lfR/ktld5C6Jejqp/xeRAEcPcUwQka4NQplsS729PSZnF8KxtN86dako+ESR2UV4SgGzyI3zKFdqVQBnbtkLwHiZ9enBYe7JsywHl/1grbcqAeOhdnVY57l2zC63ZsLwIr+FI77uDiCSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022024; c=relaxed/simple;
	bh=0xhzk7Nr3ERu/fdQX6yeV0gSO379U+LCJw59dzjym3g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S59fqUdtrhONW3mXp/Jx44Ala2KBsZpovsvsr3umh1oAkqEHktqZLk99AkvvOpFCqZpvz87G45bzmtpTou3mqFwhMc9nZ/NoFDOjUaqzhci0WlaN7aegAqlJeu22TzJL3KOM5Eyq/MGDHvsNUDZ6UHKuV9+aYdKn/B8QJNe9SRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B32E3EBDE
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:35 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 09/15] unit: Make gobex-transfer tests run concurrently
Date: Fri, 24 Apr 2026 11:11:12 +0200
Message-ID: <20260424091324.3097084-10-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424091324.3097084-1-hadess@hadess.net>
References: <20260424091324.3097084-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTE4fwvglj1stUpqbfNOHgbX9pBEbBFXfBn+DQ4MiAAA6Q5/kgmY6sH9Wwik1ceYLp6ZNgfTynQHBkQ4N55lyQu4yW7V3nHJyk/iilnZtTxZrqQt0GkMVUUvcdSDhQ/I4N0PSGb4UvWo71F8G+un+/Zry4Qu718gJ7Tc1UFESpRs/KnFyu+QdCxtlRBx+YBGSmskVeXbdXm6PlGkslt6AZjsbtBecG/FMoAlwgc27KEpaEMzn5WZDvunlzCnmcJc3y7KTB1b/TPjvmtdlfkTY0qe3MmA5mFjVST1KD1dS2cnveNKU91CrDhd4MGiADuFUUUingjVS7GXUQtIFa0rmXsTEdZrXfPxTQ9GjGs3bXnvOS81u1r8UJsnSfteBTIEcq/4wsJSPc2nBGC4zdMgb7tkJcqc+n7uLUXqObXqJLUY+DVC2BYfCf6Aby87hzFeAbky3XGspcaKYDIHbymT91Uzz0u5xaHScCGDd2Gjz1c1nZ1hvlaAmE1Slfdpxxyxq4HD8fGnnak5PFzRRptTihcSuFP1XrIXqdqBZtOpHVanZLKalZopkBZEeVGoRR+Aen7wUjdpzbuQOskjO0xv1Pocm6v4Py9pGoTgGA8XbHr42OAiCmDLFq13vVtCV3q5CUp27AX//Xq8u21W3Hby39J+atA9rHQgDV2Qyu3micdDQw
X-GND-State: clean
X-GND-Score: 0

---
 unit/meson.build | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/unit/meson.build b/unit/meson.build
index 1bd3b7a85992..92e1c6f66caa 100644
--- a/unit/meson.build
+++ b/unit/meson.build
@@ -71,15 +71,18 @@ tests3 = [
   [ 'test-avctp.c', '../src/log.c', 'avctp.c' ],
   [ 'test-util.c' ],
 ]
+tests4 = []
 
 if ical_dep.found()
   tests3 += [
     [ 'test-gobex.c', 'util.c', gobex_sources ],
     [ 'test-gobex-packet.c', 'util.c', gobex_sources ],
     [ 'test-gobex-header.c', 'util.c', gobex_sources ],
-    [ 'test-gobex-transfer.c', 'util.c', gobex_sources ],
     [ 'test-gobex-apparam.c', 'util.c', gobex_sources ],
   ]
+  tests4 = [
+    [ 'test-gobex-transfer.c', 'util.c', gobex_sources ],
+  ]
 endif
 
 foreach t: tests3
@@ -93,6 +96,22 @@ foreach t: tests3
   test(test_name, exe)
 endforeach
 
+foreach t: tests4
+  test_name = t[0].substring(0, -2)
+  exe = executable(test_name,
+    sources: t,
+    c_args: [ '-DSTORAGEDIR="@0"'.format(storagedir) ],
+    include_directories: '../lib',
+    dependencies: libshared_glib_dep
+  )
+
+  r = run_command(sh, unittest_list, t, check: true)
+  unit_tests = r.stdout().strip().split(' ')
+  foreach ut: unit_tests
+    test(ut, exe, args: [ '-p', ut ])
+  endforeach
+endforeach
+
 exe = executable('test-gdbus-client',
   sources: 'test-gdbus-client.c',
   dependencies: [ libgdbus_internal_dep, libshared_glib_dep ]
-- 
2.53.0

