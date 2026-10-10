Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126BC45C715
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791630900; cv=pass; b=VzL4Uo56dbcmGkvfrLs493Qef3vM0kkYGDKNThTG/L4aV3SDXvlFKZ+8dpBpYfWtTP1np0bQdLiI/QT/gPj+eFIe7u93e1aPRfTPr4ZPbUrvtFoWf59xh+hGw7zdp8OiF2jXkbiHXcd4bLOUfZ+Uj2bAwN+aXCkVXxDmDB94fbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791630900; c=relaxed/simple;
	bh=ryTbbDO0PctQ5vQDxETOTsc71pG/zt9vXYk56w80TLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZYlXgm2FnvhINH8AaKRnNz3YONVM4j/HSpV10vD+daj7cDZJZViIE0qHyc3KtiMc57M26fkEOoP5ySuZQwyw8ZRCdEASQobrmBh7IcunwsIVIcN6v039dG7qemlh5epwCjFrpCh5tO/YbVE0xLfZRPCoyXwpjeMCVfiwK4ACipU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=LEeo2kVV; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="LEeo2kVV"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::d101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4j21N56dkNzySX;
	Sat, 10 Oct 2026 14:14:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791630886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E+KSU1to9ebilJCc7WSXhGGwIMBlu7je591NS84tht4=;
	b=LEeo2kVVKhA0xvxS3NnQc0JMk9EpMeZec9SpowaxkSa2yIrfMWONrFGoHVOLQePY5w03Jj
	LQcNTzOh6qcLQ0DLU4E+YVNeCu+8pWqW4Kl56DXdk3yF4l7Npen/Kk1o5P+bXhnGzZpIQk
	H+39Izsvk+pvhQvHBcjITntVSyTYNPk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791630886;
	b=mUhIkKI81Vz4K1OCRmJED4s23SLQTe2OtOOM+twB5q+2yMIO1zrc6VEhmQ+RzYBWTIAyzH
	FNXvu0YL6cQwUqFYgkD8tCBQoknJgMmTr94iiWYAfajl3SanXt2f2mbHpZ44MqsqxOoLJO
	twMx1Ejyy4VTHVcNOIkRjVvoUxXdeYI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791630886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E+KSU1to9ebilJCc7WSXhGGwIMBlu7je591NS84tht4=;
	b=t0R1OHptxR2EcQw/z0zyFYmdF4hoUPv8ZStBazXe9nRk7IbWR2CT0mkzvZO3SQQFpdmx71
	tHQsGLhGo6Zb/yBgVq4Ic9+9v+D3+yfCSvDxuSnCsjMpvi1B6iP9XiwF3b+/VoxhjZ4Bn+
	lHiF3TcTyt9fWngzUizTJw0PXmyHl24=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] unit: test-rap: disable optimization to speed up compilation
Date: Sat, 10 Oct 2026 14:14:42 +0300
Message-ID: <ba9d7cd83367a994657de01f124f1fee19f7485b.1791630862.git.pav@iki.fi>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compilation of this file with optimization takes 4 minutes with ASAN.
Disable optimization to reduce to 2 sec.

autoconf puts global -O2 in CFLAGS that cannot be overridden eg. with
unit_test_bap_CFLAGS. Use pragma instead.
---
 unit/test-rap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/unit/test-rap.c b/unit/test-rap.c
index b05edf203..338f0babf 100644
--- a/unit/test-rap.c
+++ b/unit/test-rap.c
@@ -9,6 +9,12 @@
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
2.56.0

