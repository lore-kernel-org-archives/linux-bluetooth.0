Return-Path: <SRS0=mCsq=A7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E55C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jul 2020 20:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F64220773
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jul 2020 20:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGTUmI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:42:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:45380 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgGTUmH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Jul 2020 16:42:07 -0400
IronPort-SDR: ij/qqMOazJTzpOx8VIIzOGMDCMohGB72QcdslAAmapablGsG8hFsHSDH+f6WE9eb1fHY3QjL05
 V6QAz4vQpK8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="137492271"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="137492271"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 13:42:07 -0700
IronPort-SDR: I6Vr1MJopZ4DUVQohuhuZLU1t6WKGK6fnBdJurZJ4XZtfYgrhu34zKfTFmcsGttfFmJccbfBdD
 CB+DNOCsKXiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="283636787"
Received: from aukiwe-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.77.52])
  by orsmga003.jf.intel.com with ESMTP; 20 Jul 2020 13:42:07 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh-cfgclient: Fix segfault on remote node reset
Date:   Mon, 20 Jul 2020 13:42:06 -0700
Message-Id: <20200720204206.226761-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes a segfault that is caused by freeeing non-allocated memory.
Happens upon the removal of a remote node when remote's net key and/or
app key queues are destroyed.

__GI___libc_free (mem=0x1) at malloc.c:3102
    destroy=destroy@entry=0x55761f63a3b0 <l_free>) at ell/queue.c:107
    destroy=destroy@entry=0x55761f63a3b0 <l_free>) at ell/queue.c:82
    at tools/mesh/remote.c:140
    at tools/mesh/cfgcli.c:764
    at tools/mesh/cfgcli.c:764
    msg=0x5576213aa6f0, user_data=<optimized out>)
    at tools/mesh-cfgclient.c:1522
    dbus=dbus@entry=0x55762132f860, message=message@entry=0x5576213aa6f0)
    at ell/dbus-service.c:1793
    user_data=0x55762132f860) at ell/dbus.c:285
    user_data=0x55762132f940) at ell/io.c:126
---
 tools/mesh/remote.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index 2a8f747d6..c74f0bec1 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -134,10 +134,11 @@ uint8_t remote_del_node(uint16_t unicast)
 		l_queue_destroy(rmt->els[i], NULL);
 		remote_add_blacklisted_address(unicast + i, iv_index, true);
 	}
+
 	l_free(rmt->els);
 
-	l_queue_destroy(rmt->net_keys, l_free);
-	l_queue_destroy(rmt->app_keys, l_free);
+	l_queue_destroy(rmt->net_keys, NULL);
+	l_queue_destroy(rmt->app_keys, NULL);
 	l_free(rmt);
 
 	mesh_db_del_node(unicast);
-- 
2.26.2

