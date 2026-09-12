Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D447B436
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789237133; cv=pass; b=Da81BgCVZ2Sa+Lq5TUobs5pY2rsOFLHSGZQ4BnygxQvaUmBgrYUf8VJ4d1vxK9+9yBbVpMkxpHRHn9dDg2YnlsQjQKWvb2V1+lNULtJXxWx/nXydkkykHCEoJexg+sK4mJ3w0f8gJoNvg6ocPJpzwWJrGWzUNIb7TYA/vaQpOfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789237133; c=relaxed/simple;
	bh=HNcnBlts8TtO3XpXPvTc95sfJWEH8sIrnkpDm5jDpS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDqUjKz1EyV3oxCkIzINTntzl7+hDqiylJ7N1b9BRekEzH+e7KwnGtvcTAG326196xzPJTd5aXAtRso9X6HYrMBm5HuF35T+ImloRjMeKOSfqr6xaJ+fxVeapySkgehHctpNSRMjyMDLFCce4WA16DtAZdDSirWkb6X0sbFCrwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=iwFyDOgU; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="iwFyDOgU"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:5:f011:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hj06F6FGPzyc2;
	Sat, 12 Sep 2026 21:18:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789237126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGAZ6vqkc9tOUtIEyhjYmVgEEG5sdiIv/wvhUYiot2g=;
	b=iwFyDOgUFiS5X8E3RnWJ9A43Rod2IFFDeH0MDnbnAOUqBkhqzFNmd16Fjjynz1jDgOe31p
	zdnvUj4hESq+2ynKAfYkqVpdROL1MwIM6yEl1CsktG3+Vv3SsA1DyGCKxvTnJEW6RF9NiD
	L1bGsMUAxj+ZuOkge3KvOzoOJ2f7OjM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789237126;
	b=DBT9BIq2zhXrtz6rjM+ty1Iq0k+s2JgC29c/04uK394kYiaIGflVgdFTjfysm4WCP0aCSS
	7UDr8+MPco6FKvvB6J6d5rrztFGQ221odqem7kAzTurdmNCexJDOioY9sT0fSf5PxO0qV0
	GTRzeRZrDegnQUhfs7mefMv1qvZh9uE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789237126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGAZ6vqkc9tOUtIEyhjYmVgEEG5sdiIv/wvhUYiot2g=;
	b=t1oI85po5QWInm60Wz8f79elAz6ZCKFY4IxWC2DWlKqXZH3edO/24qkcExJNjQwKoyntS0
	DhFz4G0ExPqhW0kh7iNXuGoD+D7iHe0ml2jA7aUGUN1e5qbPaN4bt5gYrlk5G1t9jeCCAN
	47z+U2hWpdY5AM8z9QG+iFL8NMH7b/U=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 4/4] tools/test-runner: Fix CPUID register clobbers
Date: Sat, 12 Sep 2026 21:18:23 +0300
Message-ID: <6d899871b19ba198dba6e24483a5ca4073532cdc.1789237077.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789237077.git.pav@iki.fi>
References: <cover.1789237077.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPUID modifies EAX, EBX, ECX and EDX, but the inline asm clobber list is
incomplete.  Use the __get_cpuid() intrinsic instead.

Fixes rootfs_setup(r, argv) crashing due to impossible r != &rootfs due
to clobbered registers.

Assisted-by: qwen3.8-flash-next  # finding the bug
---
 tools/test-runner.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 9eaf39d35..2de05e26d 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -33,6 +33,11 @@
 #include <sys/param.h>
 #include <sys/reboot.h>
 
+#if defined(__GNUC__) && (defined(__i386__) || defined(__amd64__))
+#include <cpuid.h>
+#define HAVE_GET_CPUID
+#endif
+
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/hci.h"
 #include "bluetooth/hci_lib.h"
@@ -306,12 +311,10 @@ static char *const qemu_envp[] = {
 
 static void check_virtualization(void)
 {
-#if defined(__GNUC__) && (defined(__i386__) || defined(__amd64__))
-	uint32_t ecx;
+#ifdef HAVE_GET_CPUID
+	unsigned int eax, ebx, ecx, edx;
 
-	__asm__ __volatile__("cpuid" : "=c" (ecx) : "a" (1) : "memory");
-
-	if (!!(ecx & (1 << 5)))
+	if (__get_cpuid(1, &eax, &ebx, &ecx, &edx) && (ecx & (1 << 5)))
 		printf("Found support for Virtual Machine eXtensions\n");
 #endif
 }
-- 
2.55.0

