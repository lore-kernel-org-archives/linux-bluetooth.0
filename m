Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE79CC43465
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 21:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED12221EC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 21:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgIRVOC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 17:14:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:63638 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgIRVOB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 17:14:01 -0400
IronPort-SDR: N4HZ+po8b9aOvIET6ct6qMjqLo1cvmwGvC0I6hdr9V21pYaoPMSiZlKwA5z7S98Gz+IV0D4Avk
 AYTlpZMo3Hrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="178125452"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="178125452"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 14:09:00 -0700
IronPort-SDR: EfimtVZ/qPkYOJRGCVC692RG5hObZpTijeHORGV3MljeBnW4krraC7sTEumW3ay485m28TCn/C
 g72fZMIEnpTA==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="484377979"
Received: from han1-mobl3.jf.intel.com ([10.255.229.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 14:09:00 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ v4 03/20] btio: Add SPDX License Identifier
Date:   Fri, 18 Sep 2020 14:08:29 -0700
Message-Id: <20200918210846.37797-4-tedd.an@linux.intel.com>
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
 GPL-2.0-or-later     :      2

License: GPL-2.0-or-later
   btio/btio.h
   btio/btio.c
---
 btio/btio.c | 15 +--------------
 btio/btio.h | 15 +--------------
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 844d6007f..c18b6a012 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -6,20 +7,6 @@
  *  Copyright (C) 2009-2010  Nokia Corporation
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
diff --git a/btio/btio.h b/btio/btio.h
index 23e0ef72b..f0259cf1d 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -6,20 +7,6 @@
  *  Copyright (C) 2009-2010  Nokia Corporation
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
 #ifndef BT_IO_H
 #define BT_IO_H
-- 
2.17.1

