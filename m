Return-Path: <SRS0=1Za/=OY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3023C43444
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Dec 2018 00:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0941206C0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Dec 2018 00:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbeLOA0r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:26:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:22249 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbeLOA0c (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Dec 2018 19:26:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 16:26:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,355,1539673200"; 
   d="scan'208";a="109640317"
Received: from bgix-dell-lap.sea.intel.com ([10.251.138.67])
  by fmsmga008.fm.intel.com with ESMTP; 14 Dec 2018 16:26:31 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v3 12/30] mesh: Unchanged variables set to const
Date:   Fri, 14 Dec 2018 16:26:06 -0800
Message-Id: <20181215002624.9313-13-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181215002624.9313-1-brian.gix@intel.com>
References: <20181215002624.9313-1-brian.gix@intel.com>
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

