Return-Path: <SRS0=5m6h=C6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE2CC4346E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 19:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D042223E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 19:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgIUTHc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:07:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:2463 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbgIUTHb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Sep 2020 15:07:31 -0400
IronPort-SDR: h3rHhkWrXQgd3BakwqvyX70Aqk26ndRv3WK/hijPAQoo7PdLYRiFVUiAfepREyZSZx3weogiuf
 Jo7XgFrYKxPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="161384277"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="161384277"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 12:07:31 -0700
IronPort-SDR: I83WMMCFb4vnwx+OlmRdBAf1n8xHVUo3CEq4RgjuHDXYUtEphlPN/Jg8dWHiyMQ34uWxq55lXK
 onkPKsLKbjjw==
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="485626805"
Received: from han1-mobl3.jf.intel.com ([10.254.86.223])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 12:07:30 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ V4 RESEND 13/20] plugins: Add SPDX License Identifier
Date:   Mon, 21 Sep 2020 12:00:33 -0700
Message-Id: <20200921190040.45309-14-tedd.an@linux.intel.com>
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
 GPL-2.0-or-later     :      7

License: GPL-2.0-or-later
   plugins/autopair.c
   plugins/hostname.c
   plugins/neard.c
   plugins/policy.c
   plugins/sixaxis.c
   plugins/wiimote.c
   plugins/external-dummy.c
---
 plugins/autopair.c       | 15 +--------------
 plugins/external-dummy.c | 15 +--------------
 plugins/hostname.c       | 15 +--------------
 plugins/neard.c          | 15 +--------------
 plugins/policy.c         | 15 +--------------
 plugins/sixaxis.c        | 15 +--------------
 plugins/wiimote.c        | 15 +--------------
 7 files changed, 7 insertions(+), 98 deletions(-)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index 3089430a8..665a4f4a6 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2012 Google Inc.
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
diff --git a/plugins/external-dummy.c b/plugins/external-dummy.c
index 536ad0663..1c209e8b7 100644
--- a/plugins/external-dummy.c
+++ b/plugins/external-dummy.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
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
diff --git a/plugins/hostname.c b/plugins/hostname.c
index 4f9dfe6d8..f7ab9e8bc 100644
--- a/plugins/hostname.c
+++ b/plugins/hostname.c
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
diff --git a/plugins/neard.c b/plugins/neard.c
index 6ffcd6e10..ff5de11f4 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2012-2013  Tieto Poland
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
diff --git a/plugins/policy.c b/plugins/policy.c
index 3ce6f1deb..dac1b7a24 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013  Intel Corporation.
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
diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 996f85dd6..d693a86c0 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -7,20 +8,6 @@
  *  Copyright (C) 2013  Szymon Janc <szymon.janc@gmail.com>
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
diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index 0ced27514..9c4e0a58b 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2011-2012 David Herrmann <dh.herrmann@googlemail.com>
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
-- 
2.25.4

