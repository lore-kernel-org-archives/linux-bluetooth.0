Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5551F3BA2
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780533705; cv=none; b=frHuyDBkELfhJb1KLxEzoQIx9XuxQUj3u+xw1RPn6A4aLNuVtM2+SRihcTDoT6plnXESHO6az8Vw820zfVK2Txrmiuwk3oA0T/tQZj0wDOqBX0jdGTNzc4eh5FgRTZaoCFk6DfGyCQoIB+JxKttq8I/gvatcAcLqO4rDrEI45iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780533705; c=relaxed/simple;
	bh=vllC8sSSAEtPQwjWbxxrONTNuPn2xUNi52zAMfqFlVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G4wFKIafGaE81X9cCf/i4VkjelaA9gge1r32FJYCTlUyoAe1VSbTVEiVrwtgVEoe8uVUGperuV/JZk+hyKgDVfKtzA9B+i0qK99Fx95oaX1JhzqIMXR1g5XmGkI2Cdr9WsbvPLVQmK1+s8S8qLSL5AK+cuyQb+0nONC4o+1LBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id Uux6w7pr3PpWVUw9QwaRlg; Thu, 04 Jun 2026 00:41:36 +0000
Received: from host2044.hostmonster.com ([67.20.76.238])
	by cmsmtp with ESMTPS
	id Uw9PwheVccYN5Uw9QwQwrL; Thu, 04 Jun 2026 00:41:36 +0000
X-Authority-Analysis: v=2.4 cv=QN5oRhLL c=1 sm=1 tr=0 ts=6a20c9c0
 a=O1AQXT3IpLm5MaED65xONQ==:117 a=QeWor2tdjpy9U23wdFvjzw==:17
 a=FelO9ux0wxsA:10 a=z6gsHLkEAAAA:8 a=EUspDBNiAAAA:8 a=Dei6p5SHAAAA:8
 a=pGLkceISAAAA:8 a=K6OOt2kg37SFjHz4vKsA:9 a=RVmHIydaz68A:10
 a=M-Yerj1wOn-OpK7r_3ei:22 a=iekntanDnrheIxGr1pkv:22
Received: from [66.118.44.127] (port=57104 helo=timdesk.home.local)
	by host2044.hostmonster.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <tim.bird@sony.com>)
	id 1wUw9O-000000046jp-2Uyy;
	Wed, 03 Jun 2026 18:41:34 -0600
From: Tim Bird <tim.bird@sony.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	jannh@google.com,
	kuba@kernel.org,
	kiran.k@intel.com,
	chharry@chromium.org,
	gustavo@padovan.org,
	prameela.j04cs@gmail.com,
	salvatore.benedetto@intel.com,
	maxk@qualcomm.com
Cc: tim.bird@sony.com,
	linux-bluetooth@vger.kernel.org,
	linux-spdx@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Add SPDX id lines to some source files
Date: Wed,  3 Jun 2026 18:41:25 -0600
Message-ID: <20260604004125.715884-1-tim.bird@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host2044.hostmonster.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sony.com
X-BWhitelist: no
X-Source-IP: 66.118.44.127
X-Source-L: No
X-Exim-ID: 1wUw9O-000000046jp-2Uyy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (timdesk.home.local) [66.118.44.127]:57104
X-Source-Auth: tim@bird.org
X-Email-Count: 3
X-Org: HG=bhshared_hm;ORG=bluehost;
X-Source-Cap: YmlyZG9yZztiaXJkb3JnO2hvc3QyMDQ0Lmhvc3Rtb25zdGVyLmNvbQ==
X-Local-Domain: no
X-CMAE-Envelope: MS4xfIv2eTQWk3qDaj6iBJj9VQQDiW0lstbIvbFI8kveJz+9jv3hf4R6vmprN8hbdjBLuT2iSvYakTfQLghPvv7BHxxcflo655c9Vc03zTnoVCDDDIq5OZ63
 OVNTOTBNCJPSZUJXmDpsVftz+rjta/2Rxo+XA6zzbI6fMmcwpeOM6qHOL7V+3IUqHsdFk3bd1/qBPRiQEt2nbkCL+94D1uohNWo=

Many bluetooth source files are missing SPDX-License-Identifier
lines. Add appropriate IDs to these files, and remove other
license lines from the headers.

Leave the warranty disclaimer in files where the license ID is
GPL-2.0 but the wording of the disclaimer is slightly different
from that of the GPL v2 disclaimer.

It is not different enough to cause licensing conflicts, but is
kept to honor the original contributors' legal intent.

---
V1 -> V2:
 - Leave different warranty disclaimers (which is most them)
 - Remove files recently removed from drivers/bluetooth from the patch

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 drivers/bluetooth/btrsi.c         | 12 +-----------
 include/net/bluetooth/bluetooth.h |  5 +----
 include/net/bluetooth/hci.h       |  5 +----
 include/net/bluetooth/hci_core.h  |  5 +----
 include/net/bluetooth/hci_mon.h   |  5 +----
 include/net/bluetooth/hci_sock.h  |  5 +----
 include/net/bluetooth/l2cap.h     |  5 +----
 include/net/bluetooth/mgmt.h      |  5 +----
 include/net/bluetooth/rfcomm.h    |  5 +----
 include/net/bluetooth/sco.h       |  5 +----
 net/bluetooth/af_bluetooth.c      |  5 +----
 net/bluetooth/bnep/core.c         |  5 +----
 net/bluetooth/bnep/netdev.c       |  5 +----
 net/bluetooth/bnep/sock.c         |  5 +----
 net/bluetooth/ecdh_helper.c       |  5 +----
 net/bluetooth/ecdh_helper.h       |  5 +----
 net/bluetooth/hci_conn.c          |  5 +----
 net/bluetooth/hci_core.c          |  5 +----
 net/bluetooth/hci_debugfs.c       |  5 +----
 net/bluetooth/hci_debugfs.h       |  5 +----
 net/bluetooth/hci_event.c         |  5 +----
 net/bluetooth/hci_sock.c          |  5 +----
 net/bluetooth/hidp/core.c         |  5 +----
 net/bluetooth/hidp/hidp.h         |  5 +----
 net/bluetooth/hidp/sock.c         |  5 +----
 net/bluetooth/l2cap_core.c        |  5 +----
 net/bluetooth/l2cap_sock.c        |  5 +----
 net/bluetooth/lib.c               |  5 +----
 net/bluetooth/mgmt.c              |  5 +----
 net/bluetooth/mgmt_util.c         |  5 +----
 net/bluetooth/mgmt_util.h         |  5 +----
 net/bluetooth/rfcomm/core.c       |  5 +----
 net/bluetooth/rfcomm/sock.c       |  5 +----
 net/bluetooth/rfcomm/tty.c        |  5 +----
 net/bluetooth/sco.c               |  5 +----
 net/bluetooth/selftest.c          |  5 +----
 net/bluetooth/selftest.h          |  5 +----
 net/bluetooth/smp.c               |  5 +----
 net/bluetooth/smp.h               |  5 +----
 39 files changed, 39 insertions(+), 163 deletions(-)

diff --git a/drivers/bluetooth/btrsi.c b/drivers/bluetooth/btrsi.c
index c68dd2fba01c..59ad0b9b14c3 100644
--- a/drivers/bluetooth/btrsi.c
+++ b/drivers/bluetooth/btrsi.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2017 Redpine Signals Inc.
  *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 3faea66b1979..b624da5026f5 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
@@ -5,10 +6,6 @@
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 572b1c620c5d..a8b2e8781054 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
@@ -5,10 +6,6 @@
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index aa600fbf9a53..7e15da47fe3a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
@@ -5,10 +6,6 @@
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index bbd752494ef9..4b2a0af4ed58 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
    BlueZ - Bluetooth protocol stack for Linux
 
    Copyright (C) 2011-2012  Intel Corporation
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci_sock.h
index 13e8cd4414a1..16f150b861be 100644
--- a/include/net/bluetooth/hci_sock.h
+++ b/include/net/bluetooth/hci_sock.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5172afee5494..b1039ebdf06f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
@@ -6,10 +7,6 @@
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 8234915854b6..08daed7a96d5 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
    BlueZ - Bluetooth protocol stack for Linux
 
    Copyright (C) 2010  Nokia Corporation
    Copyright (C) 2011-2012  Intel Corporation
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index c05882476900..feb6b3ae5e69 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
    RFCOMM implementation for Linux Bluetooth stack (BlueZ)
    Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
    Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index f40ddb4264fc..214409527b35 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 1a6aa3f8d4d6..bcbc11c9cb15 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 0de5df690bd0..b18e1cf28bb4 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BNEP implementation for Linux Bluetooth stack (BlueZ).
    Copyright (C) 2001-2002 Inventel Systemes
@@ -7,10 +8,6 @@
 
    Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/bnep/netdev.c b/net/bluetooth/bnep/netdev.c
index cc1cff63194f..ee1e39a3daff 100644
--- a/net/bluetooth/bnep/netdev.c
+++ b/net/bluetooth/bnep/netdev.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BNEP implementation for Linux Bluetooth stack (BlueZ).
    Copyright (C) 2001-2002 Inventel Systemes
@@ -7,10 +8,6 @@
 
    Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
index 00d47bcf4d7d..f3fe818d0e4c 100644
--- a/net/bluetooth/bnep/sock.c
+++ b/net/bluetooth/bnep/sock.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BNEP implementation for Linux Bluetooth stack (BlueZ).
    Copyright (C) 2001-2002 Inventel Systemes
@@ -6,10 +7,6 @@
 
    Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/ecdh_helper.c b/net/bluetooth/ecdh_helper.c
index 0efc93fdae8a..1938e5559d88 100644
--- a/net/bluetooth/ecdh_helper.c
+++ b/net/bluetooth/ecdh_helper.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ECDH helper functions - KPP wrappings
  *
  * Copyright (C) 2017 Intel Corporation
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation;
- *
  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
  * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/ecdh_helper.h b/net/bluetooth/ecdh_helper.h
index 830723971cf8..9d787d3c8797 100644
--- a/net/bluetooth/ecdh_helper.h
+++ b/net/bluetooth/ecdh_helper.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * ECDH helper functions - KPP wrappings
  *
  * Copyright (C) 2017 Intel Corporation
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation;
- *
  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
  * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 54eabaa46960..c335372e4062 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
@@ -5,10 +6,6 @@
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 28d7929dc593..243d01069a91 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
@@ -5,10 +6,6 @@
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 99e2e9fc70e8..0635e4641db4 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BlueZ - Bluetooth protocol stack for Linux
 
    Copyright (C) 2014 Intel Corporation
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/hci_debugfs.h b/net/bluetooth/hci_debugfs.h
index 9a8a7c93bb12..92365cbc922a 100644
--- a/net/bluetooth/hci_debugfs.h
+++ b/net/bluetooth/hci_debugfs.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2014 Intel Corporation
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index eea2f810aafa..e588c744ce36 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
@@ -5,10 +6,6 @@
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 0290dea081f6..c81852411250 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 70344bd3248a..0e24c5e2955e 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    HIDP implementation for Linux Bluetooth stack (BlueZ).
    Copyright (C) 2003-2004 Marcel Holtmann <marcel@holtmann.org>
    Copyright (C) 2013 David Herrmann <dh.herrmann@gmail.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/hidp/hidp.h b/net/bluetooth/hidp/hidp.h
index 6ef88d0a1919..959b745bb770 100644
--- a/net/bluetooth/hidp/hidp.h
+++ b/net/bluetooth/hidp/hidp.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
    HIDP implementation for Linux Bluetooth stack (BlueZ).
    Copyright (C) 2003-2004 Marcel Holtmann <marcel@holtmann.org>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index c93aaeb3a3fa..b75bea3cf422 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    HIDP implementation for Linux Bluetooth stack (BlueZ).
    Copyright (C) 2003-2004 Marcel Holtmann <marcel@holtmann.org>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 45b175399e8d..ad2f26d935ca 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
@@ -8,10 +9,6 @@
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c138aa4ae266..e3eda309f1b3 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
@@ -7,10 +8,6 @@
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index 305044a84478..cea21a4c49a0 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index de5bd6b637b2..a732b586979d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BlueZ - Bluetooth protocol stack for Linux
 
    Copyright (C) 2010  Nokia Corporation
    Copyright (C) 2011-2012 Intel Corporation
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 4f19654d41a9..6ea107c0e054 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BlueZ - Bluetooth protocol stack for Linux
 
    Copyright (C) 2015  Intel Corporation
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
index bcba8c9d8952..20810cf06e81 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2015  Intel Coropration
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d11bd5337d57..593583c694a7 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    RFCOMM implementation for Linux Bluetooth stack (BlueZ).
    Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
    Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index bd7d959c6e9e..bb7cf98f85cf 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    RFCOMM implementation for Linux Bluetooth stack (BlueZ).
    Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
    Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 91bf5274262e..4b9a699ec59b 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    RFCOMM implementation for Linux Bluetooth stack (BlueZ).
    Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
    Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index f1799c6a6f87..be5614a6c5ee 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
index f49604d44b87..ae5b44bb9d3d 100644
--- a/net/bluetooth/selftest.c
+++ b/net/bluetooth/selftest.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BlueZ - Bluetooth protocol stack for Linux
 
    Copyright (C) 2014 Intel Corporation
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/selftest.h b/net/bluetooth/selftest.h
index 2aa0a346a913..34d684ee84fd 100644
--- a/net/bluetooth/selftest.h
+++ b/net/bluetooth/selftest.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2014 Intel Corporation
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 98f1da4f5f55..ef464568b9c7 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index c5da53dfab04..eac27bd541bb 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
-- 
2.43.0

