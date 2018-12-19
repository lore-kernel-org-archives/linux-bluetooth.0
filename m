Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CFFC43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0406421871
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeLSEUd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:20:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:24363 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbeLSEUd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 23:20:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 20:20:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,371,1539673200"; 
   d="scan'208";a="99820048"
Received: from bgix-dell-lap.sea.intel.com ([10.252.192.41])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2018 20:20:32 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v5 01/30] mesh: Staging for Mesh DBus API rewrite
Date:   Tue, 18 Dec 2018 20:19:47 -0800
Message-Id: <20181219042016.25538-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181219042016.25538-1-brian.gix@intel.com>
References: <20181219042016.25538-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 Makefile.am | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index f84a1faba..7e92977b7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -303,7 +303,6 @@ unit_tests =
 include Makefile.tools
 include Makefile.obexd
 include android/Makefile.am
-include Makefile.mesh
 
 if HID2HCI
 rulesdir = $(UDEV_DIR)/rules.d
-- 
2.14.5

