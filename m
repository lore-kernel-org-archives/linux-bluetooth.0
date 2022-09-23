Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DE4C6FA90
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 12:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiIWMIm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 08:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiIWMGR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 08:06:17 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCAB135047
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 05:03:57 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1obguy-0000M6-WC
        for linux-bluetooth@vger.kernel.org; Fri, 23 Sep 2022 13:32:29 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 28NBWF7i3687927;
        Fri, 23 Sep 2022 13:32:26 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 2/2] mesh: Reply error if appkey added for wrong netkey
Date:   Fri, 23 Sep 2022 13:31:49 +0200
Message-Id: <20220923113149.14209-3-isak.westin@loytec.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220923113149.14209-1-isak.westin@loytec.com>
References: <20220923113149.14209-1-isak.westin@loytec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 212.17.98.152
X-SA-Exim-Mail-From: isak.westin@loytec.com
X-SA-Exim-Scanned: No (on voyager.loytec.com); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If a known appkey is added for a different netkey, the status reply
should be Invalid NetKey.
---
 mesh/appkey.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mesh/appkey.c b/mesh/appkey.c
index 52fed8c31..f31d81942 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -296,7 +296,9 @@ int appkey_key_add(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 
 	key = l_queue_find(app_keys, match_key_index, L_UINT_TO_PTR(app_idx));
 	if (key) {
-		if (memcmp(new_key, key->key, 16) == 0)
+		if (key->net_idx != net_idx)
+			return MESH_STATUS_INVALID_NETKEY;
+		else if (memcmp(new_key, key->key, 16) == 0)
 			return MESH_STATUS_SUCCESS;
 		else
 			return MESH_STATUS_IDX_ALREADY_STORED;
-- 
2.20.1





