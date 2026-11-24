Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535617;
	b=ppUpSyElCVb7Tj767y489Rv6rNtGn0jd+msK0T109gzy2Dj1AJNxvNkOXSZqKZYrtUKb
	 fkct5qIkiG7PeGSCyssEwARTs/IEQln2SUbkQAkbIqf1JeNKQwFOcqIYeBQi0sqmR4Dp4
	 nlRWo3g8nVhhfZnoNswALsoznWk45LNF2C7VvyQiNcB+c6Ci9znoLbYOncXrc9kemCeRV
	 0f2KpziNGfUdizpGUCnrt8R4rgg+Y6oeykGlOOdYN3YLSWD9ug48i1tTC3sx7X2IS/Q6k
	 ssWjcLaIAYi2YL7yqPnN4x6io56Ie7VTcE2LkUIouHc+E4LqWmp1fIq7EfFMC1k9+5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535617;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=oLhuBWB1fveiuneAduTYVH4PELK5wBNbaDamEgtkWS4=;
	b=tRObsgrBu02y57FpnG9YcWSPGKefQPbajeq2xCUMYDsg13bu6fCVkv4YV9DWOxFRPxg6
	 t9mCAIMlBJNkBDkoQ5cUitYe4QCg2a7aUAX/UVLk3ZTfUOUXZUvBszc3Ou7aIrQx9/w2g
	 ieSFPgzUyADw+fy2dkGsNwgylC7D2QyFGyHYYY6SSIDNTCF/wasSzRqZrJGU8Cd19vTnm
	 q0mO3KJEepHTxOYek/cu58WCfy8FZPVC5QjuKmDe1jr+saN6HqRhSJFazr93qINYcCFAM
	 Z59/l8j7O1RGdRcTyZ0MZ6yvd9XPaExG0K1GY9zGJh5rmGj8CsSW2vCdO/DlrJnl1xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hadess.net;
	spf=pass smtp.mailfrom=hadess.net;
	arc=none smtp.remote-ip=217.70.183.196
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C53606A334
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50C53606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 792483F5AB
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:29 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v11 08/14] unit: Run test-bap tests concurrently
Date: Tue, 24 Nov 2026 16:50:39 +0100
Message-ID: <20261124155319.1752879-9-hadess@hadess.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124155319.1752879-1-hadess@hadess.net>
References: <20261124155319.1752879-1-hadess@hadess.net>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTGkBQPJBgyPp3EQcm81e1o6okEqvhg68CbVpV7cswzi9J34puYBUcRJblDMvhLWDqHk0B4IQEOuTrP0jemR+UlnuQBF6s+RQBIrWF2me6rXh4X0IfiZxsBBo+5ja+bxgJ1w3dPYvN60ahlXEBHvwwxXhfROQqxR8oh7NaBuAdTnR99qN9ElNArhTI5/fEBObzxTBYDDRV90DTrZYWVQrlqYQtDFdCVW5Q86cZ8Z7EYd8vUecONBX0RUZTpzr+cvizy+EUgnBDezhvgi7gaTx+eiUjngG2Cw9BthUGRuc7RRbx74AqH5NLJBGm64XpJK6j+rQiyyg19+JNOPFsqhIjMFjNW+2Zys7eu36MavaS/wrQHJJ+KgofwhNYILkrzbifFGBlyh+/tCf+CzDNeWgHMraQI7EAlZHDmDYaGKT0MbXoMbD2sONjKH1DPjoaejc7N749qBOVHqB5xq/ItLGn+Lg2VMCAZ1Hq751vfPjDMCaf+a+bClfunJPRgbS5y4TgVgDAnJGBn5ES0TrqXB51TM7zVvKJ20QcZUAIj6cwYJiENLK63xRIFNmb9W+bgovU0ZFcL+IEob77pz6SG6r6tVzgdn0ael1/4DoAXVXnRM8vmoY2zLPPsury20obwiNYceKo0SKzREshjpDY8G/3l96E5Wswf/K06S6NDm8foC0w
X-GND-State: clean

---
 meson.build           |  2 +-
 unit/meson.build      | 25 ++++++++++++++++++++++---
 unit/unittest_list.sh | 15 +++++++++++++++
 3 files changed, 38 insertions(+), 4 deletions(-)
 create mode 100644 unit/unittest_list.sh

diff --git a/meson.build b/meson.build
index d8ded120bb7d..d3cd76c1032b 100644
--- a/meson.build
+++ b/meson.build
@@ -297,6 +297,7 @@ endif
 if rst2man.found()
   subdir('doc')
 endif
+sh = find_program('sh', required: true)
 if get_option('tests').allowed()
   subdir('test')
   subdir('unit')
@@ -304,7 +305,6 @@ endif
 
 # Fix permissions on install
 install = find_program('install')
-sh = find_program('sh')
 if get_option('daemon').enabled()
   meson.add_install_script(sh, '-c', 'install -dm755 ${DESTDIR}/' + configdir)
 endif
diff --git a/unit/meson.build b/unit/meson.build
index 317f138b97d9..973fa82a24f8 100644
--- a/unit/meson.build
+++ b/unit/meson.build
@@ -8,7 +8,6 @@ tests1 = [
   [ 'test-avrcp.c', '../src/log.c', 'avctp.c', 'avrcp-lib.c', '../profiles/audio/avrcp-parse.c' ],
   [ 'test-lib.c' ],
   [ 'test-gatt.c' ],
-  [ 'test-bap.c' ],
   [ 'test-micp.c' ],
   [ 'test-bass.c' ],
   [ 'test-vcp.c' ],
@@ -34,6 +33,26 @@ foreach t: tests1
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
@@ -49,7 +68,7 @@ tests2 = [
 ]
 
 if ical_dep.found()
-  tests2 += [
+  tests3 += [
     [ 'test-gobex.c', 'util.c', gobex_sources ],
     [ 'test-gobex-packet.c', 'util.c', gobex_sources ],
     [ 'test-gobex-header.c', 'util.c', gobex_sources ],
@@ -58,7 +77,7 @@ if ical_dep.found()
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
2.56.0

