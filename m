Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBB8C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 10:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiIUK0O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 06:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIUK0H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 06:26:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83228A7FB
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 03:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663755965; x=1695291965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B+c4oeqipEwnZ9r2wgg94HSONIC7ws6Pa5mDJTB3NtQ=;
  b=N0sW+GYFGj8T7Oj22mBRLTPuicASP98iupx9PAnrpGhQaAaCJQ+B+A0e
   3e3YgwsBeoGgPMWVg6JuH8J2MlQyK3ypguQOjypx5yfGOaZ2hPOBK9Wgc
   6g7Ml3TMkpzP6pOOFPB7BsvtHcNuw9S8YuUsHHWZsl15RKC4mg5kSbCZX
   WYCAMejyjfPbZdI4ge/kXzfaB90uRpjDAf4h48p4UPJdMPJ7LTwbq0Bd6
   qqxgrBfha9W3KAf2h+Ry2tROAMxp1QEdPFoBhXPsCBIgbkklzVV5bGfV7
   INGBR1T349slMRPyJ3CzT4QjNT7fQzVvdhdA7C5zTePTcPzIfwJNN4/MR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="279688487"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="279688487"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 03:26:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="948090244"
Received: from bsblt022.iind.intel.com ([10.224.186.21])
  by fmsmga005.fm.intel.com with ESMTP; 21 Sep 2022 03:26:03 -0700
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ v2 2/2] Profiles: Enable bt_vcp_set_debug
Date:   Wed, 21 Sep 2022 15:57:32 +0530
Message-Id: <20220921102732.688081-2-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921102732.688081-1-sathish.narasimman@intel.com>
References: <20220921102732.688081-1-sathish.narasimman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set bt_vcp_set_debug to be used for VCP.
---
 profiles/audio/vcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
index e7e84174e7d4..b42b0a4f79dd 100644
--- a/profiles/audio/vcp.c
+++ b/profiles/audio/vcp.c
@@ -62,6 +62,11 @@ struct vcp_data {
 
 static struct queue *sessions;
 
+static void vcp_debug(const char *str, void *user_data)
+{
+	DBG_IDX(0xffff, "%s", str);
+}
+
 static int vcp_disconnect(struct btd_service *service)
 {
 	DBG("");
@@ -87,6 +92,8 @@ static void vcp_data_add(struct vcp_data *data)
 		return;
 	}
 
+	bt_vcp_set_debug(data->vcp, vcp_debug, NULL, NULL);
+
 	if (!sessions)
 		sessions = queue_new();
 
-- 
2.25.1

