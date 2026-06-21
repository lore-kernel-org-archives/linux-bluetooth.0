Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A713314C5
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782046489; cv=pass; b=jzY0V84B8gClkl814P2LfWj5gN+cFlp2sls3jOSG6ehNoAvdAet/Tzd+K9wmi7m1cRYdtkZr/tzALSuR3wB7Z1GveePqS0UxmtanQm8TrgDTou59VUlB0BcW3knhBqviR55oAyYr5RnHHuJYokpTYiZZvZ8ytj0eOVUgsS5DoSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782046489; c=relaxed/simple;
	bh=OAJSpQsNxQX7H+Ale7b424lwFgaVC0dfJPiP0vd6p+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qg5zIQB3et9GgaWg+RlPkKxiMLDdnDC0G6+Ff6LETfo6ys43732oYTsKQLvI3hsw58EvbVv+H6eP9fkjDCrtrwuQSuW3xHKOU04TGtq9l0oxt8zxwoG8kIj3lPpi/og8KjtlYBL8fJSNbuLFLQGJ/JtZ48VSjRTVzvz+Z0B7gK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=hSc9IFtY; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="hSc9IFtY"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gjrrZ2Z6QzyPw;
	Sun, 21 Jun 2026 15:54:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782046479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J/01VLXMAahxLd8+EnGivaaEOsCkeHt2DTpBs9sZBjk=;
	b=hSc9IFtY4KprpU+fiXHNSntj1wuQyydmPoMpibwAzT7YewrhaVYJTQ4lZiZmE+g++lzee2
	Irr5FBjS53r3yvn35dEuttmReNwWlBhdBb1vRCcOYlGlHs6Y9ACvzJPXXp1fHLpksGp+25
	is/ijiIpdE0k5Ne+W3UrvDx3nzIXpNc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782046479;
	b=AkO4TD6rftbMafDQFYkgOcXco2J6abV/wTYsikA5+8Yz5cM5gSgYfnSDQ3BKB+uLLch/Rm
	uJR6IQyTFaWhlvvaHRp6VE8VtrV32axVcWPXbQeedGZ+6Phe8gJjEarbNF+O+/6qvi4K+j
	aLWbeZmgM7Dvb9i/B5GMrjpJQ7MHRAI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782046479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J/01VLXMAahxLd8+EnGivaaEOsCkeHt2DTpBs9sZBjk=;
	b=MEra9Mk5onwCc3HCd4IesAX+0YzL32YSt0NG1ptaYu7iGosOqBzjqc/lImzT0mgIg2Uj9d
	hUY/ruhKEts9vftoSf3uVz0RQ6wD93wuukkitLh9cwIKoL5dFqMWon0hoVtKv5yYuL2iqR
	CkkwFz9qhfR2CgX9DgN28TtHKv8SVgs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] unit: test-bap: disable optimization to speed up compilation
Date: Sun, 21 Jun 2026 15:54:34 +0300
Message-ID: <e0650488e684f464f69cf013d1654f46bb862d46.1782046466.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compilation of this file with optimization takes 12 min with ASAN, 1 min
without.  This is too long, and the -O2 doesn't serve purpose for unit
tests.

Disable optimization to reduce to 30 sec with ASAN (5 sec without).

autoconf puts global -O2 in CFLAGS that cannot be overridden eg. with
unit_test_bap_CFLAGS. Use pragma instead.
---
 unit/test-bap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 318b405a7..4e89ba6af 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -13,6 +13,12 @@
 #include <config.h>
 #endif
 
+#if defined(__GNUC__)
+/* Speed up compilation */
+#pragma GCC optimize ("O0")
+#undef _FORTIFY_SOURCE
+#endif
+
 #define _GNU_SOURCE
 #include <unistd.h>
 #include <string.h>
-- 
2.54.0

