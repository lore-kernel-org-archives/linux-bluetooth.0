Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535617;
	b=AgeMfRtstHHv6zYJuaNrdCC3Y3KTXQmUl5g3DC7Yk1RDcyzhKsYZk9ISh31qyN99aivc
	 m1Wj0+7rCbRDGDH5s2Ux9NxyXdHw0ummAKMI6iYu6wsUbnWGG1rdFHRiptx5OVfEBs8Cj
	 lkocqYBxgVGfCHrmAfyj9cfsjB+Q7NHQAcvTU1V38/kjL6RbeXjwlW3wLjLr5758kximB
	 XEH7Des49gRHjTml5C1sPP4h98/W0euq18kRcbnJk9ptdh9iCozRehWwTF0AJBnLPvJwk
	 BJOBcjs1/9GtZ95PE1hgY23gcYLYvtadJt7og3vU6aPyq9o+Ltp+Fm6xq8j/MhVWgLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535617;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=/F0Bq8h7euZ0UEQdQTeCPzW4FqdEcwq0hx0zNTngeQM=;
	b=WDRuIV/8jCcmzTPpIJrZOOAVTa0GqKGQ5UC27eBnRh3n0oEM9idgj0v0xgILbBzhQfZ6
	 pa0540aAXsVFOwuNw1jXGTMhB7C0Fdim17MyRNy5SGhlNUQAf+qkG7IeXe1bupSQKG8EX
	 U/6psSwhrD24pdVTI1LL6HiCJC9ff+2CPAn4u1XTz3De3MBVyAyrs1cpIAQLOt8Kwdk3L
	 HjotPKZpdiUn5/nVJ381D+y+WCXSdbZxAkZrjdjdFsFL6F6Muv6DiSkXUurhJQ2TbYEgS
	 j4z2fM0r3M8iHjairyrxd6rFCGM7qoahH6A16wdVzI6E79g2d07fJxO+eFVDdtrhcRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hadess.net;
	spf=pass smtp.mailfrom=hadess.net;
	arc=none smtp.remote-ip=217.70.183.196
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFFD606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DFFD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B18113F59B
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:29 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v11 09/14] unit: Make gobex-transfer tests run concurrently
Date: Tue, 24 Nov 2026 16:50:40 +0100
Message-ID: <20261124155319.1752879-10-hadess@hadess.net>
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
X-GND-Cause: dmFkZTGkBQPJBgyPp3EQcm81e1o6okEqvhg68CbVpV7cswzi9J34puYBUcRJblDMvhLWDqHk0B4IQEOuTrP0jemR+UlnuQBF6s+RQBIrWF2me6rXh4X0IfiZxsBBo+5ja+bxgJ1w3dPYvN60ahlXEBHvwwxXhfROQqxR8oh7NaBuAdTnR99qN9ElNArhTI5/fEBObzxTBYDDRV90DTrZYWVQrlqYQtDFdCVW5Q86cZ8Z7EYd8vUecONBX0RUZTpzr+cvizy+EUgnBDezhvgi7gaTx+eiUjngG2Cw9BthUGRuc7RRbx74AqH5NLJBGm64XpJK6j+rQiyyg19+JNOPFsqhIjMFeblOgABvtX66QIuOpaAK+U/MOCBnEttlEUyaHgCa/84kwXMQsTJUvjx1tI0ttldE4lfGeV+uoD9gmqsOzR09uwAFlz0XbRodohmjAKn7YWj7USsSSCmLlZWKuW3BPH/54IGiPn7PWH26YDlYWgL3JQWDkL3Y2vIq8IquiW2sDbK7brF3f2z5N25y/+J/5vR+rx5RVsa5mAacRRpZEHHBP/wc9EH7OKaH1+8QcTsntPIrKke7ozTBXSOGL5cGF97zFERLchHNjP4w20q9XPd8jYs8BNyjBJhyiM3rxyl+Z1DmzsGdCp/vLrmCe+TC4sSAbGiEZJls1jb3clhf9xkMzg
X-GND-State: clean

---
 unit/meson.build | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/unit/meson.build b/unit/meson.build
index 973fa82a24f8..018bfd33dfa9 100644
--- a/unit/meson.build
+++ b/unit/meson.build
@@ -66,15 +66,18 @@ tests3 = [
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
@@ -88,6 +91,22 @@ foreach t: tests3
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
2.56.0

