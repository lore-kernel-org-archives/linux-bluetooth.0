Received: from thorin.yenya.net (thorin.yenya.net [83.240.55.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C63019DC
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.240.55.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725742; cv=none; b=eW0PJATCJ99f1Mo1UZDSvPNBpVYHbl6nnTOlkL9lZZihdfPPchA8k3c8DVvO02DKaXYwdEo6WwdTavuvpVnGKiNUPp/Ekv0X54WfqvFr/NMLVY1pG6ww28Ay23WRougueuJ8EdtSm1wb77VOO8t1Iby+ebVZUuWRrmu8uoM5LAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725742; c=relaxed/simple;
	bh=u7891+HzIpHj6Uy5duTk7tLiZX5bX+iQkXJHsfj0P2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eiqaw6aX8PXXYSvJ+orLy8+JC5fJRse77DFa+XKRzamJ9wZonHmrGFBWXYtii8MJbs8DAvQ2mvtBXM2YR30zQv4is1v1TLL83RWFRGzIJptVxXpBjQ+n3S7xk9aiKyHjwcKbu/QJ29to9dflm2t4PGfR1YujkO5Jk4QVXGDGTM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yenya.net; spf=pass smtp.mailfrom=yenya.net; arc=none smtp.client-ip=83.240.55.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yenya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yenya.net
Received: from nevin.yenya.net (unknown [10.0.0.19])
	by thorin.yenya.net (Postfix) with ESMTP id ABE682EAFB29;
	Wed, 22 Jul 2026 15:08:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 thorin.yenya.net ABE682EAFB29
From: =?UTF-8?q?Iva=20Kasprzakov=C3=A1?= <iva@yenya.net>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: xrabek1@fi.muni.cz,
	xkasprz@fi.muni.cz,
	=?UTF-8?q?Iva=20Kasprzakov=C3=A1?= <iva@yenya.net>
Subject: [PATCH v2] Bluetooth: fix BT dependency for submodules
Date: Wed, 22 Jul 2026 15:08:49 +0200
Message-ID: <20260722130849.7813-1-iva@yenya.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The modules rfcomm (BT_RFCOMM), bnep (BT_BNEP), hidp (BT_HIDP), and
bluetooth_6lowpan (BT_6LOWPAN) are dependent on the bluetooth module
(BT, tristate) only transitively through the boolean BT_BREDR for the
first three and through the boolean BT_LE for the bluetooth_6lowpan.
Therefore, the modules can be selected as built-in even if the BT=m.
The combination of BT=m and =y for the said modules leads to the kernel
build system silently ignoring those modules, without ever compiling
them as built-in or as loadable modules.

Add BT as a direct dependency to the Kconfig of rfcomm, bnep, hidp, and
bluetooth_6lowpan. The modules set to =y when BT=m will default to =m,
rather then getting silently ignored by the build system.

Signed-off-by: Iva Kasprzaková <iva@yenya.net>
---
 net/bluetooth/Kconfig        | 2 +-
 net/bluetooth/bnep/Kconfig   | 2 +-
 net/bluetooth/hidp/Kconfig   | 2 +-
 net/bluetooth/rfcomm/Kconfig | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index d250e94e90eb..1cda01614efe 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -76,7 +76,7 @@ config BT_LE_L2CAP_ECRED
 
 config BT_6LOWPAN
 	tristate "Bluetooth 6LoWPAN support"
-	depends on BT_LE && 6LOWPAN
+	depends on BT && BT_LE && 6LOWPAN
 	help
 	  IPv6 compression over Bluetooth Low Energy.
 
diff --git a/net/bluetooth/bnep/Kconfig b/net/bluetooth/bnep/Kconfig
index aac02b5b0d17..f8087e2d2c00 100644
--- a/net/bluetooth/bnep/Kconfig
+++ b/net/bluetooth/bnep/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config BT_BNEP
 	tristate "BNEP protocol support"
-	depends on BT_BREDR
+	depends on BT && BT_BREDR
 	select CRC32
 	help
 	  BNEP (Bluetooth Network Encapsulation Protocol) is Ethernet
diff --git a/net/bluetooth/hidp/Kconfig b/net/bluetooth/hidp/Kconfig
index e08aae35351a..ba52c7296f18 100644
--- a/net/bluetooth/hidp/Kconfig
+++ b/net/bluetooth/hidp/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config BT_HIDP
 	tristate "HIDP protocol support"
-	depends on BT_BREDR && HID
+	depends on BT && BT_BREDR && HID
 	help
 	  HIDP (Human Interface Device Protocol) is a transport layer
 	  for HID reports.  HIDP is required for the Bluetooth Human
diff --git a/net/bluetooth/rfcomm/Kconfig b/net/bluetooth/rfcomm/Kconfig
index 9b9953ebf4c0..e7af2d565cea 100644
--- a/net/bluetooth/rfcomm/Kconfig
+++ b/net/bluetooth/rfcomm/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config BT_RFCOMM
 	tristate "RFCOMM protocol support"
-	depends on BT_BREDR
+	depends on BT && BT_BREDR
 	help
 	  RFCOMM provides connection oriented stream transport.  RFCOMM
 	  support is required for Dialup Networking, OBEX and other Bluetooth

base-commit: c1cec2bbbeb5922d42d28c6af1707c4f3f8647e3
-- 
2.55.0

