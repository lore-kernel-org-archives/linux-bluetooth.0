Return-Path: <SRS0=1Za/=OY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49D4C43614
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Dec 2018 00:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E77208C1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Dec 2018 00:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbeLOA0g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:26:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:22249 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729963AbeLOA0f (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Dec 2018 19:26:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 16:26:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,355,1539673200"; 
   d="scan'208";a="109640341"
Received: from bgix-dell-lap.sea.intel.com ([10.251.138.67])
  by fmsmga008.fm.intel.com with ESMTP; 14 Dec 2018 16:26:33 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v3 18/30] mesh: restructure I/O for multiple nodes
Date:   Fri, 14 Dec 2018 16:26:12 -0800
Message-Id: <20181215002624.9313-19-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181215002624.9313-1-brian.gix@intel.com>
References: <20181215002624.9313-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/mesh-io.c | 3 ++-
 mesh/mesh-io.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index 5cdfdc5ff..8cf6c486a 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -177,7 +177,8 @@ bool mesh_io_send(struct mesh_io *io, struct mesh_io_send_info *info,
 	return false;
 }
 
-bool mesh_io_send_cancel(struct mesh_io *io, uint8_t *pattern, uint8_t len)
+bool mesh_io_send_cancel(struct mesh_io *io, const uint8_t *pattern,
+								uint8_t len)
 {
 	io = l_queue_find(io_list, match_by_io, io);
 
diff --git a/mesh/mesh-io.h b/mesh/mesh-io.h
index 754f6129c..71d3cb980 100644
--- a/mesh/mesh-io.h
+++ b/mesh/mesh-io.h
@@ -96,4 +96,5 @@ bool mesh_set_filter(struct mesh_io *io, uint8_t filter_id,
 
 bool mesh_io_send(struct mesh_io *io, struct mesh_io_send_info *info,
 					const uint8_t *data, uint16_t len);
-bool mesh_io_send_cancel(struct mesh_io *io, uint8_t *pattern, uint8_t len);
+bool mesh_io_send_cancel(struct mesh_io *io, const uint8_t *pattern,
+								uint8_t len);
-- 
2.14.5

