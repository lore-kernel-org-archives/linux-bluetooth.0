Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB53344D83
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638557; cv=none; b=oz7OCv+nTqMFqo9usPeKLB+uafR4o9WE/G980S2wVsF37YbfE/j0KkG0YDIUKM9foSNBPV00SY5Zgi1LvLYII7TTymylwvsYd+b+RhtcA+V1Da3uOXwboe7mttjKr5jz2JD82i/I8RgfOJa4fIvdC5QO7W5OmKKrBDl+CToRcBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638557; c=relaxed/simple;
	bh=XMidsdx3VRwha/rmd90G2l5eNbhb9ruZgdZIflldr58=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLG1mZgsWdHOVOF93S0MPS9p1rXKH1RjDwMSmR8NHZeAejMevVNk8ATO2lOAINbUOEZcTXssh8KX+I4UHDu0+by+Ji4HXj4QP4SyjsdnRsAVakkGyIUxezBVL2DC+Pr+qHXJtAVG4rWIhRf5PdvPqe4Vhy3eCJPw/AipMUAU7E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4195044408
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 22:15:47 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 10/16] unit: Make gobex-transfer tests run concurrently
Date: Wed, 28 Jan 2026 23:12:00 +0100
Message-ID: <20260128221536.2319084-11-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128221536.2319084-1-hadess@hadess.net>
References: <20260128221536.2319084-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeggeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeegudelhedtgeeggedtkedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean
X-GND-Score: 0

---
 unit/meson.build | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/unit/meson.build b/unit/meson.build
index b74a67541e99..9acae732d495 100644
--- a/unit/meson.build
+++ b/unit/meson.build
@@ -70,15 +70,18 @@ tests3 = [
   [ 'test-avdtp.c', '../src/log.c', 'avdtp.c' ],
   [ 'test-avctp.c', '../src/log.c', 'avctp.c' ],
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
@@ -92,6 +95,22 @@ foreach t: tests3
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
2.52.0

