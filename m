Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D40C3D6CA5
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971481; cv=none; b=VGM025YimWu1kbwrkDmWlD3teSgJvjuwEIXdhr+qlx+Zzsmg9W1atkWdKvVVQlTUjE1NJ76Tn2e9fS4ofTtMT9xL//JazZKLAT0HLtYTTm1VDxhXNLiyZGx840JtMJYBpgEQGVD6IrenEGRO9R4kND4alSVw9P42GCtpC13Wnp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971481; c=relaxed/simple;
	bh=aM9wgmhsghttld+g769Sk49sNBLjHrtS5YEn3ao56y0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByspnMVHCD6Xy2M3y2makVPAwmk8q5L4WEjlpLcQ9zPYIqfArq8z7vo8MKsfuEMEwNxI3DLS7LZias4tet9uraFELL43Hk6SH9uE2M4Sf2TkboBF4jixZDxPWGUGYiFEUPtal585276XzGaIitOysu9lw9i7u0jN713Sg7ZGZos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24AD63EBCA
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:52 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v10 10/16] unit: Make gobex-transfer tests run concurrently
Date: Tue,  5 May 2026 10:45:16 +0200
Message-ID: <20260505085741.2497401-11-hadess@hadess.net>
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
X-GND-Cause: dmFkZTF7m1kdtbVHsZr2LXd0j4SaLCDeEFbauGG+fBV8q/Lb0JtuMjsr5muOTSEAf7igQM0Bnw8BHYljvnxFnsAmHOLly4+52VorB9b4KAmDSVF4GGxfoa10KOzkkk0FZ/iH7EudoHjCU3lQOFMf08hNxPB0Om5CXgN/JaXrD8vR0QFR6vK+BgL2HzcSZsu+faoyhdo4a67AVWTy2kRkYaFGckVGbBf8TVfzXT8T3W71rhL99sA17fK9wNykeLee1lk/s3PuiKITlPDUhdt/XRmi48jSPOFu1u+d/gMtvWUS3SjNATRBgl/nHvW2jk6XZ5zgKwUZHQGjWGUUgyPiGRUQZieqHgwvoBVE5OVYUsVEjzINiptj15iShtAfbPubW4dlz6Aa1jZ2Hdt5ESLr2wPcpMrOH84G6uSc+kKc8TTnL2GspvcIbZ2PiQnRsUw85BxE2HOtPpmGpRpCBkChvEtrDcJCkbuYm7QlTybvhhBC46m7oovJTuzSljqyHVc7DHdo+YVaMGxJ0GcQroyiX39qnCLb0St4hZ4k4OyIahHaI8sZCgsHzGhlkRZQHbHFsD1EDCm3JVL1b4fPml1aCjiXwdcsOpklkBa7jc0P+EHl4X0tdaTqD/YR01jnV73lh8l9xcxWyWCVNP2vAwew//ltCoALcfykADhzku8/YeH/vlK/5g

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
2.54.0

