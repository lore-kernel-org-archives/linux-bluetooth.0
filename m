Return-Path: <SRS0=CFtH=CY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D5FC433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 00:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A1B6205F4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 00:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgIOAFg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Sep 2020 20:05:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:37077 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIOAFb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Sep 2020 20:05:31 -0400
IronPort-SDR: imstoPoSw58qrdo9GXSO7ZqWmfAz35bOPELDildO4420tCq5+UH31iw5vLtGQMrkXSdWWSjYeU
 Upagi73vVe8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="160112031"
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="160112031"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 17:05:25 -0700
IronPort-SDR: Tfbf9/SgP0qGS+XJMKPJNfm5mpXZTDle2l7Wnny8W+g+x7LIMpYfWPuc2u3MzxmCJGRuL1Z4oq
 08TAq18DEiRw==
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="507333148"
Received: from azvasil-mobl.amr.corp.intel.com (HELO han1-mobl3.jf.intel.com) ([10.254.127.225])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 17:05:25 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ v3 07/17] gobex: Add SPDX License Identifier
Date:   Mon, 14 Sep 2020 17:04:47 -0700
Message-Id: <20200915000457.22988-8-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200915000457.22988-1-tedd.an@linux.intel.com>
References: <20200915000457.22988-1-tedd.an@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
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
2.25.4

