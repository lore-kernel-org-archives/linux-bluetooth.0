Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A3385529
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076345; cv=none; b=r00AQ9XPQL/asKzuasn/ALlzVOGOGNMbmMf4gLjrnA71lNwxd1sIlgM0rrneuCpprD3ntv9FJ3m/xXLr2Oq1D3pHPMGfGlz+lcVU5pV0Q54U8eRSkUn7zDRXVeJyrytC2EjOl5QsBxngeAL0Z+G2Ds9SPiAYFk4JoUfJHA8/zz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076345; c=relaxed/simple;
	bh=EbX9UO5hdUbUa1XPWME/t/GaH/opGbetADZufM0DWSI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BgbD6a4d7kBs3cwGBL2hhki21/R34WgWNmtIHJmFuPNKqkmp2OEHIeWzNsaJzEWIg4kaf+ZRXD1/2RTTE6tro5lSWBsfyP9Oa5nYzVANcvuf9m1YDTlR29dJjubI+00S85ybH9KWkUhDZ7nVi5CMtYcDLhEM2uPyr4ccPYBVVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DDB820D56
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 20:45:35 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] unit: Add unit test for new MIN/MAX macros
Date: Wed,  1 Apr 2026 22:45:05 +0200
Message-ID: <20260401204527.148077-1-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
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
X-GND-Cause: dmFkZTE7ssuRHBNTKJRevbw5qZ4XG6zSInVNWTNRPwAYRInNCOO+z4B0VwoZDeLJRt7y7q0CvGbWjdDdz2Q3VDpD+l5sCLeu2OvOJmNVzL0OrYU7w7zSwuc8gA+3E92kE3GeWr6sKGWKivAH5TNrY9ZCUy8laJyGW6zXJH8bhaJIotAsQzXHOXg8cKdC33RXMqWgpn5nNHx9jams1+p/iB/abXF6Q6BEETscdRmvSp16IvBk/7Xmstnz57M+Jw369FIlcPC/4s3YESYZhFR9hVT375jJLSB89W+BiBqfcssyZ5TjM5VCqY1uuyMupOIbl56wOQUuADCR4ckG3FjBAG2gY3tgtsMRQ1ZbSDZCtTIj5lvgTcNsSvtboCvFgdpKNvv8cgtUsZfE2jGUjnnKNhZ4aV1PVWwTj3aAjToErmD64Vivb8n5vtxrcKJ8UBmw9zhmIe9dYXQmLH3rWMM/zIe0pwTvPPcakKMTwBdnbfkio5RXDizc6IpDw5InJqMvWnCAM59/1exqIFmDM5Z/gNMdCD0BifYxghmpws71K1ixh+AiWiHRUVyIXUAiyB16YWJaqI1W55RGS/IEvEQJB5sfYf0jVoSm3q5xJ+VynssohB1UZY3DU5Rj1LVE2nakxwaJZczQLeijTolPCPr+4c+vI9ckHw9RP4DWhi5I9JICURer1g

---
 Makefile.am      |  4 ++++
 unit/test-util.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 unit/test-util.c

diff --git a/Makefile.am b/Makefile.am
index 2cfb884f1851..d9de71d587d8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -696,6 +696,10 @@ unit_test_lib_SOURCES = unit/test-lib.c
 unit_test_lib_LDADD = src/libshared-glib.la \
 				lib/libbluetooth-internal.la $(GLIB_LIBS)
 
+unit_tests += unit/test-util
+unit_test_util_LDADD = src/libshared-glib.la \
+				lib/libbluetooth-internal.la $(GLIB_LIBS)
+
 unit_tests += unit/test-gatt
 
 unit_test_gatt_SOURCES = unit/test-gatt.c
diff --git a/unit/test-util.c b/unit/test-util.c
new file mode 100644
index 000000000000..8ab16cc083ba
--- /dev/null
+++ b/unit/test-util.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Bastien Nocera <hadess@hadess.net>
+ *
+ *
+ */
+
+#include <assert.h>
+
+#include "src/shared/util.h"
+#include "src/shared/tester.h"
+
+/* XXX glib.h must not be included, or it will clobber the
+ * MIN/MAX macros */
+
+static void test_min_max(const void *data)
+{
+	assert(MIN(3, 4) == 3);
+	assert(MAX(3, 4) == 4);
+	tester_test_passed();
+}
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	tester_add("/util/min_max", NULL, NULL,
+			test_min_max, NULL);
+
+	return tester_run();
+}
-- 
2.53.0

