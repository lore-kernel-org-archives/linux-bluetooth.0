Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CD72F290B
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971479; cv=none; b=ZNFEvUl84vmftwORFlzD4MViMuYrXMKiTlb9C/GIeM2ETaDGKMAfloNeX2RwZ3cSGoDJmid2tdE+W99DomgBmRgjeJ4ff9UobykBZ33XqinSTUaayuavexpvHLxCJpRhzTpdszVok5ZW6qtvXWmVE5kJ+tEWDf2ARyW8lX6rVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971479; c=relaxed/simple;
	bh=YtSt8e+2yEHLAGEVQIIObM2VNoxYt1OKrAhUsHAC74w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrjT8GNJXuUdA8t90ntbA3jHLTyOoTMPZCLrWqC4PY8FQIi8vw4OuAiP88zxoFnpH79Qn6V6xY9vIClKVN6VdscnPVXubzz5d+AYbWvIcUv2yrRgPV4myCdkKKWq/wbmpMOAJgd0zwNmOAaAAaAeW1N4nq+XSanZBDMX82rYWg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6835E3EBD2
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:51 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v10 07/16] emulator: Install the emulator if built
Date: Tue,  5 May 2026 10:45:13 +0200
Message-ID: <20260505085741.2497401-8-hadess@hadess.net>
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
X-GND-Cause: dmFkZTF7m1kdtbVHsZr2LXd0j4SaLCDeEFbauGG+fBV8q/Lb0JtuMjsr5muOTSEAf7igQM0Bnw8BHYljvnxFnsAmHOLly4+52VorB9b4KAmDSVF4GGxfoa10KOzkkk0FZ/iH7EudoHjCU3lQOFMf08hNxPB0Om5CXgN/JaXrD8vR0QFR6vK+BgL2HzcSZsu+faoyhdo4a67AVWTy2kRkYaFGckVGbBf8TVfzXT8T3W71rhL99sA17fK9wNykeLee1lk/s3PuiKITlPDUhdt/XRmi48jSPOFu1u+d/gMtvWUS3SjNATRBgl/nHvW2jk6XZ5zgKwUZHQGjWGUUgyPiGRUQZieqS/Jtagce6KsibFJdExOsonbw8sOyJsFPhtGT7awaedtGdyw1bc+bHNBBLudu7pmVzjqsz7sfPrwQ3+epOAGqtVOr+VZnScRLlpgBRvzmyZEiH6RS1F2oIdk3VowWpqUNPywwIyTPvnACP1u1XI9ULLtsRG5NCmk7NfQTKlCKnjWIo+JZbCT/VNnLdGOzqyMRLsyp0jhM0CQlJRITUxYFHNpGmmQfkkBSydi/lxla791oQRh9gJ1QrmVCB5kiTn0OzeOTmuUXyzaRq3S6mDRGVlF4eeEcxxXM3SjeSt0jx1c7o4+uHZdLmkMa6Qj3qlEot2iYd7XQw4EsKCTJU59cQw

It's useful for testing.
---
 emulator/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/emulator/meson.build b/emulator/meson.build
index 40544567e4e4..5ed734c5d69d 100644
--- a/emulator/meson.build
+++ b/emulator/meson.build
@@ -17,7 +17,9 @@ if get_option('tests').allowed()
       'smp.c',
       'phy.c',
       'le.c' ],
-    dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep ]
+    dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep ],
+    install: true,
+    install_dir: pkglibexecdir
   )
 
   executable('b1ee',
-- 
2.54.0

