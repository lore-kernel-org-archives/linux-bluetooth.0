Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C77C433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C94207D8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgEVAfH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 20:35:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:55685 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgEVAfG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 20:35:06 -0400
IronPort-SDR: vTEPOO29lMaCGrTteNTCh+rBrgo/nD5lXSY16F4cw7/BAl/yAwlKdtMqc4tmZmaTqXlIcoE6CC
 zf/tkZ44Zpeg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 17:35:05 -0700
IronPort-SDR: d+vQIAyDE9usFa/N9vpxTAqnAhNlDvkKfWv9LKSlhyNPfNrfZ2drfBcmMUqfG1OKlT0c3I+MHd
 db9pZbmvsm+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="300961675"
Received: from nsalivat-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.98.52])
  by orsmga008.jf.intel.com with ESMTP; 21 May 2020 17:35:05 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 05/10] mesh: Remove unused function prototypes from node.h
Date:   Thu, 21 May 2020 17:34:56 -0700
Message-Id: <20200522003501.106165-6-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522003501.106165-1-inga.stotland@intel.com>
References: <20200522003501.106165-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/node.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mesh/node.h b/mesh/node.h
index 3019d316b..076714e66 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -92,8 +92,6 @@ bool node_import(const char *app_root, const char *sender, const uint8_t *uuid,
 			uint16_t net_idx, bool kr, bool ivu,
 			uint32_t iv_index, uint16_t unicast,
 			node_ready_func_t cb, void *user_data);
-void node_id_set(struct mesh_node *node, uint16_t node_id);
-uint16_t node_id_get(struct mesh_node *node);
 bool node_dbus_init(struct l_dbus *bus);
 void node_cleanup_all(void);
 struct mesh_config *node_config_get(struct mesh_node *node);
-- 
2.26.2

