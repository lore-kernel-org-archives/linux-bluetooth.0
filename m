Return-Path: <SRS0=+lf3=PF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00080C43613
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D077B217F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeL1WHy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:07:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:19951 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbeL1WHy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Dec 2018 17:07:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2018 14:07:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,411,1539673200"; 
   d="scan'208";a="113968686"
Received: from bgix-dell-lap.sea.intel.com ([10.252.140.14])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2018 14:07:52 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v6 03/26] mesh: Internal errors
Date:   Fri, 28 Dec 2018 14:07:22 -0800
Message-Id: <20181228220745.25147-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181228220745.25147-1-brian.gix@intel.com>
References: <20181228220745.25147-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

Error codes that map to specific faults that may occur while
using the Mesh DBus API.
---
 mesh/error.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 mesh/error.h

diff --git a/mesh/error.h b/mesh/error.h
new file mode 100644
index 000000000..a6aaa2fef
--- /dev/null
+++ b/mesh/error.h
@@ -0,0 +1,34 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+/*
+ * Important: Changes in this table must be reflected in the
+ * the entries of error_table[] in dbus.c
+ */
+enum mesh_error {
+	MESH_ERROR_NONE,
+	MESH_ERROR_FAILED,
+	MESH_ERROR_NOT_AUTHORIZED,
+	MESH_ERROR_NOT_FOUND,
+	MESH_ERROR_INVALID_ARGS,
+	MESH_ERROR_BUSY,
+	MESH_ERROR_ALREADY_EXISTS,
+	MESH_ERROR_DOES_NOT_EXIST,
+	MESH_ERROR_CANCELED,
+};
-- 
2.14.5

