Return-Path: <SRS0=+lf3=PF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985FBC43613
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689F0217F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeL1WH4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:07:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:19951 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbeL1WH4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Dec 2018 17:07:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2018 14:07:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,411,1539673200"; 
   d="scan'208";a="113968713"
Received: from bgix-dell-lap.sea.intel.com ([10.252.140.14])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2018 14:07:54 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v6 11/26] mesh: Unchanged variables set to const
Date:   Fri, 28 Dec 2018 14:07:30 -0800
Message-Id: <20181228220745.25147-12-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181228220745.25147-1-brian.gix@intel.com>
References: <20181228220745.25147-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/mesh-io-api.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/mesh-io-api.h b/mesh/mesh-io-api.h
index f69fceeb2..acf12445d 100644
--- a/mesh/mesh-io-api.h
+++ b/mesh/mesh-io-api.h
@@ -31,7 +31,7 @@ typedef bool (*mesh_io_deregister_t)(struct mesh_io *io, uint8_t filter_id);
 typedef bool (*mesh_io_filter_set_t)(struct mesh_io *io,
 			uint8_t filter_id, const uint8_t *data, uint8_t len,
 			mesh_io_status_func_t callback, void *user_data);
-typedef bool (*mesh_io_tx_cancel_t)(struct mesh_io *io, uint8_t *pattern,
+typedef bool (*mesh_io_tx_cancel_t)(struct mesh_io *io, const uint8_t *pattern,
 								uint8_t len);
 
 struct mesh_io_api {
-- 
2.14.5

