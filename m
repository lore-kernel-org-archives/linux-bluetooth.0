Received: from thorin.yenya.net (thorin.yenya.net [83.240.55.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2632E25A2BB
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.240.55.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560701; cv=none; b=tbSjsEekIv8IHbKPnQTKPVdXCQrTvJWLETYv1ps+sWpZvD2QfWm4WOiTeOi3huR0QfslfLRTc4Eg80k6IzmQ1vlyC1bNUtqYf8uQbZChJZJxJ7M+mc2SsfzUCQ3Nsexl47b70Dt2GvQwht2kcz0UnIW6eOX5b6a8Sgz1dFvdAik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560701; c=relaxed/simple;
	bh=WAU80tSqIHSpDhtaxkr0dxNRxo8MloM4P2RdlSfVX0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KCCyzKqvcoIa7jZA+P1+QvVTz+y75SmbOjoErlc8MT9Svkr0gPGEwxXI7jezO6AlHcZN4ShYdbDauUX3rbqdfpQ29sXIShM1ADuoje/8n1xzPDv9ibdA5SSu0TiOzbP6gcIO6m0XvUX80o1KG9Tw4jTVCOjSf2OD11E147jiB4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yenya.net; spf=pass smtp.mailfrom=yenya.net; arc=none smtp.client-ip=83.240.55.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yenya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yenya.net
Received: from nevin.yenya.net (dhcp239.yenya.net [10.0.0.239])
	by thorin.yenya.net (Postfix) with ESMTP id 7FBED2EAC824;
	Mon, 20 Jul 2026 17:09:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 thorin.yenya.net 7FBED2EAC824
From: =?UTF-8?q?Iva=20Kasprzakov=C3=A1?= <iva@yenya.net>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: xrabek1@fi.muni.cz,
	xkasprz@fi.muni.cz,
	=?UTF-8?q?Iva=20Kasprzakov=C3=A1?= <iva@yenya.net>
Subject: [PATCH] Bluetooth: fix BT dependency for submodules
Date: Mon, 20 Jul 2026 17:09:19 +0200
Message-ID: <20260720150919.9602-1-iva@yenya.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rfcomm (BT_RFCOMM), bnep (BT_BNEP), and hidp (BT_HIDP) modules are
dependent on the bluetooth module (BT, tristate) only transitively
through the boolean BT_BREDR. Therefore, the modules can be selected as
built-in even if the BT=m. The combination of BT=m and =y for the said
modules leads to the kernel build system silently ignoring those
modules, without ever compiling them as built-in or as loadable modules.

Add BT as a direct dependency to Kconfig of rfcomm, bnep and hidp. The
modules set to =y when BT=m will default to =m, rather then getting
silently ignored by the build system.

Signed-off-by: Iva Kasprzaková <iva@yenya.net>
---
 net/bluetooth/bnep/Kconfig   | 2 +-
 net/bluetooth/hidp/Kconfig   | 2 +-
 net/bluetooth/rfcomm/Kconfig | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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

