Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997515D756
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925825; cv=none; b=WoBHyrLJX+RtvDfUXB6zdl6+qPoYiawe6wMCxDJyXhfsfxLbpFB82ROZ7r+c4CHSsamRyzN0lT0W9qIHwD+B9BMV4e3/yArGLmRMj1AjASL+o0dUpRVz63ds/ys0bR+9hBJ89XWR3JjgcW9AklevL83X+RJ1mjlXcP7qoSCXyko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925825; c=relaxed/simple;
	bh=psgHiDWoWf4d13ZMr0l3KOrHNhzri0WGmnL595a9QhY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LGfIPdpBT0enz5JsQMng5nJpieLRQA4xpeiAR6Drs/q+VRySz37C0sa3rkRcMlHRFjMHKD/6rvmQLIiz6Alujq4iNhqJom35HWkGpBoxz7TDbSBhbrtnAr+qpkF3t/IgghEQPDAcTiwp7mSs8tDZLa3ub/nbq5KhqqeheMG2YMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67934240008
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 15:50:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [[BlueZ] ] mesh-gatt: Fix JSON files missing from dist
Date: Wed, 14 Feb 2024 16:50:13 +0100
Message-ID: <20240214155019.325715-1-hadess@hadess.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Moving EXTRA_DIST into a conditional means that if the dist isn't made
with the deprecated tools enabled, then files will be missing from the
distribution.

Fixes: 1f6553edd8a5c ("build: Deprecate meshctl tool")
---
 Makefile.tools | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 044342e29bc6..4178940bf066 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -378,9 +378,8 @@ tools_meshctl_SOURCES = tools/meshctl.c \
 tools_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				lib/libbluetooth-internal.la \
 				$(GLIB_LIBS) $(DBUS_LIBS) -ljson-c -lreadline
-
-EXTRA_DIST += tools/mesh-gatt/local_node.json tools/mesh-gatt/prov_db.json
 endif
+EXTRA_DIST += tools/mesh-gatt/local_node.json tools/mesh-gatt/prov_db.json
 
 bin_PROGRAMS +=  tools/mesh-cfgclient
 
-- 
2.43.0

