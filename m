Return-Path: <SRS0=CFtH=CY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E10C433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 00:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCBD7208DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 00:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIOAFz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Sep 2020 20:05:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:37105 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgIOAFw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Sep 2020 20:05:52 -0400
IronPort-SDR: ApmCtbNOn0y2bEEAfdPBMGaSurcZJi7JKzrUPet2iIHHsHDCIY+7wVyqC/He1wDdMkR3Gh8JLz
 u7NPER7OsYlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="160112056"
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="160112056"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 17:05:38 -0700
IronPort-SDR: o+/LyK8JKsU2m/P6ny2ZiIMOCV39cuneAk3xGZJB69MONprWW99az6btXZaqybI72JkkyxaEpd
 fxV4DrIc7yTA==
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="507333204"
Received: from azvasil-mobl.amr.corp.intel.com (HELO han1-mobl3.jf.intel.com) ([10.254.127.225])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 17:05:38 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ v3 15/17] unit: Add SPDX License Identifier
Date:   Mon, 14 Sep 2020 17:04:55 -0700
Message-Id: <20200915000457.22988-16-tedd.an@linux.intel.com>
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
 GPL-2.0-or-later     :     25
 LGPL-2.1-or-later    :      1
 GPL-2.0-only         :      2
 BSD-2-Clause         :      1

License: GPL-2.0-or-later
   unit/test-hog.c
   unit/test-eir.c
   unit/test-gobex-header.c
   unit/test-crc.c
   unit/test-avrcp.c
   unit/test-ringbuf.c
   unit/test-gobex-apparam.c
   unit/test-gobex.c
   unit/test-hfp.c
   unit/test-textfile.c
   unit/test-avdtp.c
   unit/test-sdp.c
   unit/test-gatt.c
   unit/test-avctp.c
   unit/test-gattrib.c
   unit/test-queue.c
   unit/test-gobex-packet.c
   unit/test-uuid.c
   unit/test-crypto.c
   unit/test-uhid.c
   unit/test-gdbus-client.c
   unit/test-midi.c
   unit/test-lib.c
   unit/test-mgmt.c
   unit/test-gobex-transfer.c

License: LGPL-2.1-or-later
   unit/test-mesh-crypto.c

License: GPL-2.0-only
   unit/util.h
   unit/util.c

License: BSD-2-Clause
   unit/test-ecc.c
---
 unit/test-avctp.c          | 15 +--------------
 unit/test-avdtp.c          | 15 +--------------
 unit/test-avrcp.c          | 15 +--------------
 unit/test-crc.c            | 15 +--------------
 unit/test-crypto.c         | 15 +--------------
 unit/test-ecc.c            | 21 +--------------------
 unit/test-eir.c            | 15 +--------------
 unit/test-gatt.c           | 15 +--------------
 unit/test-gattrib.c        | 15 +--------------
 unit/test-gdbus-client.c   | 15 +--------------
 unit/test-gobex-apparam.c  | 15 +--------------
 unit/test-gobex-header.c   | 15 +--------------
 unit/test-gobex-packet.c   | 15 +--------------
 unit/test-gobex-transfer.c | 15 +--------------
 unit/test-gobex.c          | 15 +--------------
 unit/test-hfp.c            | 15 +--------------
 unit/test-hog.c            | 15 +--------------
 unit/test-lib.c            | 15 +--------------
 unit/test-mesh-crypto.c    | 11 +----------
 unit/test-mgmt.c           | 15 +--------------
 unit/test-midi.c           | 16 +---------------
 unit/test-queue.c          | 15 +--------------
 unit/test-ringbuf.c        | 15 +--------------
 unit/test-sdp.c            | 15 +--------------
 unit/test-textfile.c       | 15 +--------------
 unit/test-uhid.c           | 15 +--------------
 unit/test-uuid.c           | 15 +--------------
 unit/util.c                | 14 +-------------
 unit/util.h                | 14 +-------------
 29 files changed, 29 insertions(+), 407 deletions(-)

diff --git a/unit/test-avctp.c b/unit/test-avctp.c
index c92618bab..fa7db59c8 100644
--- a/unit/test-avctp.c
+++ b/unit/test-avctp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
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
diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 13c03d037..f5340d6f3 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2012  Intel Corporation. All rights reserved.
  *
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
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index adf25f002..34a70377d 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
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
diff --git a/unit/test-crc.c b/unit/test-crc.c
index 791fa5137..107c95e13 100644
--- a/unit/test-crc.c
+++ b/unit/test-crc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2011  Intel Corporation
  *
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
diff --git a/unit/test-crypto.c b/unit/test-crypto.c
index 46c7c0e5c..3a88b4a52 100644
--- a/unit/test-crypto.c
+++ b/unit/test-crypto.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2011  Intel Corporation
  *
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
diff --git a/unit/test-ecc.c b/unit/test-ecc.c
index d9136814d..b838cc29b 100644
--- a/unit/test-ecc.c
+++ b/unit/test-ecc.c
@@ -1,27 +1,8 @@
+// SPDX-License-Identifier: BSD-2-Clause
 /*
  * Copyright (c) 2013, Kenneth MacKay
  * All rights reserved.
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are
- * met:
- *  * Redistributions of source code must retain the above copyright
- *   notice, this list of conditions and the following disclaimer.
- *  * Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/unit/test-eir.c b/unit/test-eir.c
index 421d0db13..e05a37d01 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2011  Intel Corporation
  *
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
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 0b77df51c..6a49210c5 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
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
diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c
index 416e59635..9c7dea094 100644
--- a/unit/test-gattrib.c
+++ b/unit/test-gattrib.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Google, Inc.
  *
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
diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index ccf706713..514c58b8e 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2011  Intel Corporation
  *
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
diff --git a/unit/test-gobex-apparam.c b/unit/test-gobex-apparam.c
index 59393c681..330a7819a 100644
--- a/unit/test-gobex-apparam.c
+++ b/unit/test-gobex-apparam.c
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
diff --git a/unit/test-gobex-header.c b/unit/test-gobex-header.c
index 3450f8123..941e18d47 100644
--- a/unit/test-gobex-header.c
+++ b/unit/test-gobex-header.c
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
diff --git a/unit/test-gobex-packet.c b/unit/test-gobex-packet.c
index d382ee5b3..2664bef4e 100644
--- a/unit/test-gobex-packet.c
+++ b/unit/test-gobex-packet.c
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
diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 3f8905c0b..4f652dea8 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
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
diff --git a/unit/test-gobex.c b/unit/test-gobex.c
index 1afb7ceff..6fbfa183e 100644
--- a/unit/test-gobex.c
+++ b/unit/test-gobex.c
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
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 890eee659..f504724d7 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
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
 
 #include <sys/socket.h>
diff --git a/unit/test-hog.c b/unit/test-hog.c
index e257fbd88..e6d4affc4 100644
--- a/unit/test-hog.c
+++ b/unit/test-hog.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2015  Intel Corporation. All rights reserved.
  *
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
diff --git a/unit/test-lib.c b/unit/test-lib.c
index 1dd5d92cf..8395c2a73 100644
--- a/unit/test-lib.c
+++ b/unit/test-lib.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -6,20 +7,6 @@
  *  Copyright (C) 2013  Instituto Nokia de Tecnologia - INdT
  *
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
diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
index ed37ae1a7..12709dace 100644
--- a/unit/test-mesh-crypto.c
+++ b/unit/test-mesh-crypto.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
index c67678b9a..1b71e562f 100644
--- a/unit/test-mgmt.c
+++ b/unit/test-mgmt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2012  Intel Corporation. All rights reserved.
  *
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
diff --git a/unit/test-midi.c b/unit/test-midi.c
index 593bc5a5c..644fcdc6d 100644
--- a/unit/test-midi.c
+++ b/unit/test-midi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,21 +6,6 @@
  *  Copyright (C) 2015,2016 Felipe F. Tonello <eu@felipetonello.com>
  *  Copyright (C) 2016 ROLI Ltd.
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
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/unit/test-queue.c b/unit/test-queue.c
index d912a6416..46018ef9c 100644
--- a/unit/test-queue.c
+++ b/unit/test-queue.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2012  Intel Corporation. All rights reserved.
  *
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
diff --git a/unit/test-ringbuf.c b/unit/test-ringbuf.c
index ef3bf0a50..b1cf51115 100644
--- a/unit/test-ringbuf.c
+++ b/unit/test-ringbuf.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2012  Intel Corporation. All rights reserved.
  *
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
diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 03501d021..d3a885f19 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2012  Intel Corporation. All rights reserved.
  *
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
diff --git a/unit/test-textfile.c b/unit/test-textfile.c
index 4b43898d6..a1485a543 100644
--- a/unit/test-textfile.c
+++ b/unit/test-textfile.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
  *
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
diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index 320cd54d4..001d39a3d 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
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
diff --git a/unit/test-uuid.c b/unit/test-uuid.c
index 7c6789e39..0889630cf 100644
--- a/unit/test-uuid.c
+++ b/unit/test-uuid.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2011  Intel Corporation
  *
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
diff --git a/unit/util.c b/unit/util.c
index c8054d2e4..e7804d884 100644
--- a/unit/util.c
+++ b/unit/util.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  *
  *  OBEX library with GLib integration
  *
  *  Copyright (C) 2011  Intel Corporation. All rights reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
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
diff --git a/unit/util.h b/unit/util.h
index b13fd2f16..d5d0f19c5 100644
--- a/unit/util.h
+++ b/unit/util.h
@@ -1,22 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  *
  *  OBEX library with GLib integration
  *
  *  Copyright (C) 2011  Intel Corporation. All rights reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
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
 
 #define TEST_BUF_MAX 5
-- 
2.25.4

