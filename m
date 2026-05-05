Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFC03126C4
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971481; cv=none; b=gmj3SG3dNiqoylSgl2eoB/EoTu2vHH23LgdoG8Q1CNpTeBbonJ4cl4llPVFwFtdWWVK+Ey3sKcZ3VjAkjCd9DnQMVPG2MU9msHxyKgaJRL3TcrGrUDNziFan/oTIfpNNFugKtPzvz/naCskl7M1ev5p/XWj2Z3PZJwnA5Ad0Wsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971481; c=relaxed/simple;
	bh=lQsnJPjNRrOfnq4xed4iu1ETPJR4JfIMOoYb/xfQNv8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ey261wbZAEr5Ciwqrifr449kOFfMlGcnPKmDjpj8mFsvOWEITNtIySv2x4aTsaeM63WsqCoI3eTXWu/LfTuB23/YABMX9iyyGUQcA064iT4fR1H/yLflLjCE6e9PfvP44LMUH5YimsBJMMZpdlk3pT6OgYENKp1aLgT++dxryL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E7A893EB8D
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:51 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v10 09/16] unit: Run test-bap tests concurrently
Date: Tue,  5 May 2026 10:45:15 +0200
Message-ID: <20260505085741.2497401-10-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505085741.2497401-1-hadess@hadess.net>
References: <20260505085741.2497401-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTF7m1kdtbVHsZr2LXd0j4SaLCDeEFbauGG+fBV8q/Lb0JtuMjsr5muOTSEAf7igQM0Bnw8BHYljvnxFnsAmHOLly4+52VorB9b4KAmDSVF4GGxfoa10KOzkkk0FZ/iH7EudoHjCU3lQOFMf08hNxPB0Om5CXgN/JaXrD8vR0QFR6vK+BgL2HzcSZsu+faoyhdo4a67AVWTy2kRkYaFGckVGbBf8TVfzXT8T3W71rhL99sA17fK9wNykeLee1lk/s3PuiKITlPDUhdt/XRmi48jSPOFu1u+d/gMtvWUS3SjNATRBgl/nHvW2jk6XZ5zgKwUZHQGjWGUUgyPiGRUQZieqQ+tvqs+fOJbNZLIQrJqgPG+VzG6eKfIjbdkXSMfM2JqfIuEx5zLEiQdB5ZcBvKSeIEPeK6geaeYlY/cKpwS3b8IL97fPvkLeomQRsweX+2VjHmHw9zSA1OrfFRRhGybDC0xjOU09aPcvrbNMiHEE0PtLqya2nXPoDnnlVFbkba2peNcWDMEpWLc56951J/Sybl8xsiKssRrVl12CitVlC/Un5rKQM7OutjbgXDtkImFouZ1lDJDF3gHDUcPGzqPCilvgHZCXsJZVychKl80y2WcryC7a6pbBu8xhSPXPShMq9bqZyHSaOg8bzLpuiZFrQUxnlS94PKbvfmoAbrSq+Q

---
 meson.build           |  2 +-
 unit/meson.build      | 25 ++++++++++++++++++++++---
 unit/unittest_list.sh | 15 +++++++++++++++
 3 files changed, 38 insertions(+), 4 deletions(-)
 create mode 100644 unit/unittest_list.sh

diff --git a/meson.build b/meson.build
index c26dd5740488..391cba6962bb 100644
--- a/meson.build
+++ b/meson.build
@@ -291,6 +291,7 @@ endif
 if rst2man.found()
   subdir('doc')
 endif
+sh = find_program('sh', required: true)
 if get_option('tests').allowed()
   subdir('test')
   subdir('unit')
@@ -298,7 +299,6 @@ endif
 
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
2.54.0

