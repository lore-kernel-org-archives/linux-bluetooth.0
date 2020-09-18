Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ECDC43466
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 21:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECDE0222BB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 21:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgIRVOD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 17:14:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:63641 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgIRVOD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 17:14:03 -0400
IronPort-SDR: pnmdaIOqLiPV1iNHtEQct3ugLq+/O8mLCZG5Bc6I7WlyFVeDh15nxmaF1dEwJoo9V1fKjlyMTp
 bqLTmjTQRieA==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="178125470"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="178125470"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 14:09:07 -0700
IronPort-SDR: bjtq1f11MzKFbu3FMJ+ztFCNU2F7o7ASze4PXuRGMrmp7PTZ8IG9bs2YIgxJdkWEpMKF1QcD7l
 6Zx+tNkogEFA==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="484378039"
Received: from han1-mobl3.jf.intel.com ([10.255.229.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 14:09:07 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ v4 07/20] gobex: Add SPDX License Identifier
Date:   Fri, 18 Sep 2020 14:08:33 -0700
Message-Id: <20200918210846.37797-8-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200918210846.37797-1-tedd.an@linux.intel.com>
References: <20200918210846.37797-1-tedd.an@linux.intel.com>
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
 GPL-2.0-or-later     :     12

License: GPL-2.0-or-later
   gobex/gobex-defs.h
   gobex/gobex-transfer.c
   gobex/gobex.c
   gobex/gobex-apparam.h
   gobex/gobex-header.h
   gobex/gobex-header.c
   gobex/gobex.h
   gobex/gobex-packet.h
   gobex/gobex-defs.c
   gobex/gobex-debug.h
   gobex/gobex-apparam.c
   gobex/gobex-packet.c
---
 gobex/gobex-apparam.c  | 15 +--------------
 gobex/gobex-apparam.h  | 15 +--------------
 gobex/gobex-debug.h    | 15 +--------------
 gobex/gobex-defs.c     | 15 +--------------
 gobex/gobex-defs.h     | 15 +--------------
 gobex/gobex-header.c   | 15 +--------------
 gobex/gobex-header.h   | 15 +--------------
 gobex/gobex-packet.c   | 15 +--------------
 gobex/gobex-packet.h   | 15 +--------------
 gobex/gobex-transfer.c | 15 +--------------
 gobex/gobex.c          | 15 +--------------
 gobex/gobex.h          | 15 +--------------
 12 files changed, 12 insertions(+), 168 deletions(-)

diff --git a/gobex/gobex-apparam.c b/gobex/gobex-apparam.c
index b16cee11a..818180cb1 100644
--- a/gobex/gobex-apparam.c
+++ b/gobex/gobex-apparam.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX library with GLib integration
  *
  *  Copyright (C) 2012  Intel Corporation.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/gobex/gobex-apparam.h b/gobex/gobex-apparam.h
index 6c0860928..ace615225 100644
--- a/gobex/gobex-apparam.h
+++ b/gobex/gobex-apparam.h
@@ -1,23 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  OBEX library with GLib integration
  *
  *  Copyright (C) 2012  Intel Corporation.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifndef __GOBEX_APPARAM_H
diff --git a/gobex/gobex-debug.h b/gobex/gobex-debug.h
index a98653d83..eeb2209f0 100644
--- a/gobex/gobex-debug.h
+++ b/gobex/gobex-debug.h
@@ -1,22 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *  OBEX library with GLib integration
  *
  *  Copyright (C) 2011  Intel Corporation. All rights reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifndef __GOBEX_DEBUG_H
diff --git a/gobex/gobex-defs.c b/gobex/gobex-defs.c
index 1c7c39a16..811be762b 100644
--- a/gobex/gobex-defs.c
+++ b/gobex/gobex-defs.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX library with GLib integration
  *
  *  Copyright (C) 2011  Intel Corporation. All rights reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/gobex/gobex-defs.h b/gobex/gobex-defs.h
index 326e3cb09..84351205d 100644
--- a/gobex/gobex-defs.h
+++ b/gobex/gobex-defs.h
@@ -1,23 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  OBEX library with GLib integration
  *
  *  Copyright (C) 2011  Intel Corporation. All rights reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifndef __GOBEX_DEFS_H
diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index c594999a5..011d33d1a 100644
--- a/gobex/gobex-header.c
+++ b/gobex/gobex-header.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX library with GLib integration
  *
  *  Copyright (C) 2011  Intel Corporation. All rights reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/gobex/gobex-header.h b/gobex/gobex-header.h
index 6600b1b4a..129f35ba1 100644
--- a/gobex/gobex-header.h
+++ b/gobex/gobex-header.h
@@ -1,23 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  OBEX library with GLib integration
  *
  *  Copyright (C) 2011  Intel Corporation. All rights reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifndef __GOBEX_HEADER_H
diff --git a/gobex/gobex-packet.c b/gobex/gobex-packet.c
index a89f5b6d3..11937a5a5 100644
--- a/gobex/gobex-packet.c
+++ b/gobex/gobex-packet.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX library with GLib integration
  *
  *  Copyright (C) 2011  Intel Corporation. All rights reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/gobex/gobex-packet.h b/gobex/gobex-packet.h
index 1d94ccf20..ed153bac5 100644
--- a/gobex/gobex-packet.h
+++ b/gobex/gobex-packet.h
@@ -1,23 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  OBEX library with GLib integration
  *
  *  Copyright (C) 2011  Intel Corporation. All rights reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifndef __GOBEX_PACKET_H
diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index e96e61fbc..c94d018b2 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX library with GLib integration
  *
  *  Copyright (C) 2011  Intel Corporation. All rights reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/gobex/gobex.c b/gobex/gobex.c
index d68a85eb6..54e3b0814 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX library with GLib integration
  *
  *  Copyright (C) 2011  Intel Corporation. All rights reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/gobex/gobex.h b/gobex/gobex.h
index a94d9246e..f16e4426c 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -1,23 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  OBEX library with GLib integration
  *
  *  Copyright (C) 2011  Intel Corporation. All rights reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifndef __GOBEX_H
-- 
2.17.1

