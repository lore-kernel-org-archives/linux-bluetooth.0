Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D40386C37
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022024; cv=none; b=aL95FLXjnWAbTe8YvvxT33dHco5aMPwTOwpk0TdkmYI8jN/35vIaqH7+1r+IzJ/NWcMWipwyU4Nr6LF2+x2go0TqMFX+f5s/Jv0CUisGgxoPzZTlJwMre0TCiF3Wjxam/vgixtB/IWx7AhkPqQfxVSncyQ+3Ul5hHvDgYIDd/OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022024; c=relaxed/simple;
	bh=CD4hX4GqaDlBy/qBEN4xPe2MRkNAnJiPO5SaZmS5i1g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAN4NUKrFkLwr77JBJfJA6xpV22W0zhRcu0XnALy9Qu852GxbaRn0hft2gB2LaV6GAjcnkGTd64E3PiHZ6f774LJZ4gcJ+hMmWvMm4OHGtoG43SSx5ZxYDaecFpdPBHsLRQW2YiXYvyiHkHd4Me+A+4VD08RhsGpRvJLEzQhrmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23BAE3EBDD
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:35 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 08/15] unit: Run test-bap tests concurrently
Date: Fri, 24 Apr 2026 11:11:11 +0200
Message-ID: <20260424091324.3097084-9-hadess@hadess.net>
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
X-GND-Cause: dmFkZTE4fwvglj1stUpqbfNOHgbX9pBEbBFXfBn+DQ4MiAAA6Q5/kgmY6sH9Wwik1ceYLp6ZNgfTynQHBkQ4N55lyQu4yW7V3nHJyk/iilnZtTxZrqQt0GkMVUUvcdSDhQ/I4N0PSGb4UvWo71F8G+un+/Zry4Qu718gJ7Tc1UFESpRs/KnFyu+QdCxtlRBx+YBGSmskVeXbdXm6PlGkslt6AZjsbtBecG/FMoAlwgc27KEpaEMzn5WZDvunlzCnmcJc3y7KTB1b/TPjvmtdlfkTY0qe3MmA5mFjVST1KD1dS2cnveNKU91CrDhd4MGiADuFUUUingjVS7GXUQtIFa0rmXsTWcSluDSne0b8eEwB5VJcsnNFtr1hnjGmOy92cawNrHgkAlWeJM0OwzYWZZUJQTpqjFPEALxJWKUric3rx+mQ3mjyMhJUyW8X+sD+1mGTXZ+434luHrNTKXSpQIimLXudwV3bJpamSkDaHW4GuyFNtbShvaZMaca2RYbvmAigvVn0+GYADN5t8Vh7AMteKJ02B9RWfAO7rZ3ROarX83PMLewXkHTrD9jTLp6AjdzCMIKoD5L41yh9rQM7skDAm0jBV+nhhIu8jV5VZkrwy6kAQ0aORPlSRBfOzExUgkhmKYO9BAQOQHiAuTXddHWKnAdfGYW8AOWUH3YQ16Ye+3lLfQ
X-GND-State: clean
X-GND-Score: 0

---
 meson.build           |  2 +-
 unit/meson.build      | 25 ++++++++++++++++++++++---
 unit/unittest_list.sh | 15 +++++++++++++++
 3 files changed, 38 insertions(+), 4 deletions(-)
 create mode 100644 unit/unittest_list.sh

diff --git a/meson.build b/meson.build
index f716eae1f063..586b69459d8a 100644
--- a/meson.build
+++ b/meson.build
@@ -285,6 +285,7 @@ endif
 if rst2man.found()
   subdir('doc')
 endif
+sh = find_program('sh', required: true)
 if get_option('tests').allowed()
   subdir('test')
   subdir('unit')
@@ -292,7 +293,6 @@ endif
 
 # Fix permissions on install
 install = find_program('install')
-sh = find_program('sh')
 if get_option('daemon').enabled()
   meson.add_install_script(sh, '-c', 'install -dm755 ${DESTDIR}/' + configdir)
 endif
diff --git a/unit/meson.build b/unit/meson.build
index c8198574147d..1bd3b7a85992 100644
--- a/unit/meson.build
+++ b/unit/meson.build
@@ -7,7 +7,6 @@ tests1 = [
   [ 'test-avrcp.c', '../src/log.c', 'avctp.c', 'avrcp-lib.c' ],
   [ 'test-lib.c' ],
   [ 'test-gatt.c' ],
-  [ 'test-bap.c' ],
   [ 'test-micp.c' ],
   [ 'test-bass.c' ],
   [ 'test-vcp.c' ],
@@ -39,6 +38,26 @@ foreach t: tests1
 endforeach
 
 tests2 = [
+  [ 'test-bap.c' ],
+]
+
+unittest_list = find_program('unittest_list.sh')
+
+foreach t: tests2
+  test_name = t[0].substring(0, -2)
+  exe = executable(test_name,
+    sources: t,
+    dependencies: [ libshared_glib_dep, libbluetooth_internal_dep ],
+  )
+
+  r = run_command(sh, unittest_list, t, check: true)
+  unit_tests = r.stdout().strip().split(' ')
+  foreach ut: unit_tests
+    test(ut, exe, args: [ '-p', ut ])
+  endforeach
+endforeach
+
+tests3 = [
   [ 'test-textfile.c', '../src/textfile.c' ],
   [ 'test-crc.c', '../monitor/crc.c' ],
   [ 'test-crypto.c' ],
@@ -54,7 +73,7 @@ tests2 = [
 ]
 
 if ical_dep.found()
-  tests2 += [
+  tests3 += [
     [ 'test-gobex.c', 'util.c', gobex_sources ],
     [ 'test-gobex-packet.c', 'util.c', gobex_sources ],
     [ 'test-gobex-header.c', 'util.c', gobex_sources ],
@@ -63,7 +82,7 @@ if ical_dep.found()
   ]
 endif
 
-foreach t: tests2
+foreach t: tests3
   test_name = t[0].substring(0, -2)
   exe = executable(test_name,
     sources: t,
diff --git a/unit/unittest_list.sh b/unit/unittest_list.sh
new file mode 100644
index 000000000000..c478edc9d3e4
--- /dev/null
+++ b/unit/unittest_list.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+if [ $# -lt 1 ] ; then
+	echo "Usage: $0 FILE..."
+	exit 1
+fi
+
+TESTS=$(grep '^[[:space:]]*define_test[_a-z]*("' $* | cut -d \" -f 2 | cut -d " " -f 1)
+if [ -z "$TESTS" ] ; then
+	TESTS=$(grep '^[[:space:]]*tester_add("' $* | cut -d \" -f 2 | cut -d " " -f 1)
+fi
+if [ -z "$TESTS" ] ; then
+	TESTS=$(grep '^[[:space:]]*g_test_add_*func("' $* | cut -d \" -f 2 | cut -d " " -f 1)
+fi
+echo $TESTS
-- 
2.53.0

