Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD679C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 May 2022 23:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbiETXmA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 19:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiETXl6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 19:41:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A5119FF7F
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 16:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653090117; x=1684626117;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lAP+YC/9SDKjV/LypDEsjeWwr6G1ZDMair0ke2iZJGQ=;
  b=GT74DSe4AaXBAMfD1gIgx8KtujpsCOrcMKe7LP7FYKoC5Rxlbf+BaX2Z
   4MNWSmMWxh94a5P/PM8li+xyQew4E29SfS933++h9g5BII2YJj1T97iFa
   DNoPvIpBqtaSdNI7kAW2TzEGYfSbj5VaRkzTO8cFQjPc7xIz1ouwk9KqK
   dwL09mm901T7gxBnGOdHDx69vpJcUud5LndsUW5OBe9063Uzjk0zJoSJW
   ezzEg95us6fDoCHwppstdnYuY58ybQfYz+T4V5Rzkn+yX6b1vMMkQv/d0
   +TwbxNbnGmS61jnXfj4AvPFgEytI+ZRyhYVZqi4bC+1qh5GCudBT7KDSB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="252658493"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="252658493"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 16:41:57 -0700
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="571079050"
Received: from kepettin-mobl1.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.166.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 16:41:57 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] client: Fix settingof advertisement interval
Date:   Fri, 20 May 2022 16:41:51 -0700
Message-Id: <20220520234151.19286-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes incorrect argument read when using "interval" command
in "advertisement" submenu
---
 client/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index ccbfc620b..1df94f000 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2768,7 +2768,7 @@ static void cmd_advertise_interval(int argc, char *argv[])
 	max = min;
 
 	if (argc > 2) {
-		max = strtol(argv[1], &endptr, 0);
+		max = strtol(argv[2], &endptr, 0);
 		if (!endptr || *endptr != '\0' || max < 20 || max > 10485) {
 			bt_shell_printf("Invalid argument\n");
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
-- 
2.35.3

