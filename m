Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA00C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Oct 2022 20:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiJEUnS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Oct 2022 16:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiJEUnQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Oct 2022 16:43:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE26B6AA0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 13:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665002595; x=1696538595;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JAmhBbgVnN+P9UT9XPZJ/VWEAIUVj6QteoZVuMbxOL8=;
  b=itQVh6F5GtGbXCe66Jb0eJYqZL2+JHb/qVqII8O5rSVKiJPK06W1EHeb
   echNzym4Pc/je3zoU79RA0n2l3E3TpzfO0RVGgiXDbMVdbYjk/dl6Be+0
   nbcjAEZjU6AjJue5h6aABP9ow+1r3yXzPwf28UvOEPLCarxiXx/WsZ/Y6
   sIwMXSA2NU9A4GswS8npN5PhNLHPQ8qgLd9QaqPw4DTy7rG/RcHEmLL2T
   DK4udz57btBfu7wl10pGz/IJ6ydZFHlBPejyQCa9eqnR/PEDjiyBzo5rm
   DivTQX51sUmX0CodhRWYZ/dqbvHYQffTQqU44aNToEeCtYtLKvcUj9m/T
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="300866593"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="300866593"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 13:43:15 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="575559238"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="575559238"
Received: from orparaju-mobl2.amr.corp.intel.com (HELO istotlan-mobl1.intel.com) ([10.212.143.27])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 13:43:15 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix mesh to work with MESH_IO_TYPE_UNIT_TEST
Date:   Wed,  5 Oct 2022 13:43:09 -0700
Message-Id: <20221005204309.65983-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes mesh io flow for MESH_IO_TYPE_UNIT_TEST which
got broken after:
commit 9966cb8b6999a5f54fc13acbd7e1526512a84342
("mesh: Add new kernel MGMT based IO transport")
---
 mesh/main.c    | 8 +++++++-
 mesh/mesh-io.c | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index 619b17d88..3bca020a0 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -137,8 +137,14 @@ static void signal_handler(uint32_t signo, void *user_data)
 		return;
 
 	l_info("Terminating");
+
 	mesh_cleanup(true);
-	l_timeout_create(1, kill_to, NULL, NULL);
+
+	if (io_type != MESH_IO_TYPE_UNIT_TEST)
+		l_timeout_create(1, kill_to, NULL, NULL);
+	else
+		l_main_quit();
+
 	terminated = true;
 }
 
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index ae6a82ee4..233f4b328 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -151,7 +151,7 @@ struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts,
 
 	default_io->api = api;
 
-	if (!api->init(default_io, &default_io->favored_index, user_data))
+	if (!api->init(default_io, opts, user_data))
 		goto fail;
 
 	return default_io;
-- 
2.37.3

