Return-Path: <SRS0=5m6h=C6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A132C4346E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 19:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D112054F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 19:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgIUTHP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:07:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:8705 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbgIUTHP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Sep 2020 15:07:15 -0400
IronPort-SDR: HJQlsNi+3EFQuwTLJrsGpfrzw1WgER3C5/oj/Q1oIhvLv7hEyKCZMdgILjXZjnTgEsCu4JiCZE
 cFVs3VfwtQag==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="245298266"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="245298266"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 12:06:59 -0700
IronPort-SDR: lpvxgaP5jjElJBywVu8JcUPQL2yqYZz1hKoO4NhO0iwW1EgLkcB00xGY3RabW+QmEkVKvJJ2Oi
 HTuqNyU08H+g==
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="485626547"
Received: from han1-mobl3.jf.intel.com ([10.254.86.223])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 12:06:58 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ V4 RESEND 12/20] peripheral: Add SPDX License Identifier
Date:   Mon, 21 Sep 2020 12:00:32 -0700
Message-Id: <20200921190040.45309-13-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200921190040.45309-1-tedd.an@linux.intel.com>
References: <20200921190040.45309-1-tedd.an@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds SPDX License Identifier and removes the license text.

-------------------------------------
       License            COUNT
-------------------------------------
 LGPL-2.1-or-later    :     11

License: LGPL-2.1-or-later
   peripheral/log.h
   peripheral/main.c
   peripheral/efivars.c
   peripheral/attach.h
   peripheral/gatt.c
   peripheral/attach.c
   peripheral/log.c
   peripheral/gap.h
   peripheral/efivars.h
   peripheral/gap.c
   peripheral/gatt.h
---
 peripheral/attach.c  | 15 +--------------
 peripheral/attach.h  | 15 +--------------
 peripheral/efivars.c | 15 +--------------
 peripheral/efivars.h | 15 +--------------
 peripheral/gap.c     | 15 +--------------
 peripheral/gap.h     | 15 +--------------
 peripheral/gatt.c    | 15 +--------------
 peripheral/gatt.h    | 15 +--------------
 peripheral/log.c     | 15 +--------------
 peripheral/log.h     | 15 +--------------
 peripheral/main.c    | 15 +--------------
 11 files changed, 11 insertions(+), 154 deletions(-)

diff --git a/peripheral/attach.c b/peripheral/attach.c
index 1de02ac04..f7dc7ecea 100644
--- a/peripheral/attach.c
+++ b/peripheral/attach.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2015  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/peripheral/attach.h b/peripheral/attach.h
index f76e2fba2..c8d787d76 100644
--- a/peripheral/attach.h
+++ b/peripheral/attach.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2015  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 void attach_start(void);
diff --git a/peripheral/efivars.c b/peripheral/efivars.c
index 3cc213c0c..74fceed3e 100644
--- a/peripheral/efivars.c
+++ b/peripheral/efivars.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2015  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/peripheral/efivars.h b/peripheral/efivars.h
index 430d14330..5dac95395 100644
--- a/peripheral/efivars.h
+++ b/peripheral/efivars.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2015  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #define EFIVARS_NON_VOLATILE			0x00000001
diff --git a/peripheral/gap.c b/peripheral/gap.c
index 52a7bed9b..b12e08b3d 100644
--- a/peripheral/gap.c
+++ b/peripheral/gap.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2015  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/peripheral/gap.h b/peripheral/gap.h
index 6d6737810..da307a2ad 100644
--- a/peripheral/gap.h
+++ b/peripheral/gap.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2015  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #include <stdint.h>
diff --git a/peripheral/gatt.c b/peripheral/gatt.c
index bbbf3f59f..ff1354cb4 100644
--- a/peripheral/gatt.c
+++ b/peripheral/gatt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2015  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/peripheral/gatt.h b/peripheral/gatt.h
index 5b68f3573..7e2418a70 100644
--- a/peripheral/gatt.h
+++ b/peripheral/gatt.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2015  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #include <stdint.h>
diff --git a/peripheral/log.c b/peripheral/log.c
index d5834eb72..ac674b2df 100644
--- a/peripheral/log.c
+++ b/peripheral/log.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2015  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/peripheral/log.h b/peripheral/log.h
index 36619b36e..29d1d6ac0 100644
--- a/peripheral/log.h
+++ b/peripheral/log.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2015  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 void log_open(void);
diff --git a/peripheral/main.c b/peripheral/main.c
index 75427ab3a..6ce729178 100644
--- a/peripheral/main.c
+++ b/peripheral/main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2015  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
-- 
2.25.4

