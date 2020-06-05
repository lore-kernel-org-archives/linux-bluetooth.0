Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF83CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 14:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96D920659
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 14:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgFEO2N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:28:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:50960 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgFEO2N (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 10:28:13 -0400
IronPort-SDR: O5NRvpd61UJVpfnFmrAx2PO5liJ/KYMzZtjfhNL8cgBooirbzp2W71goZCqz8Aj/jMfAeWiPWf
 SdDKGLQHbTSA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 07:28:11 -0700
IronPort-SDR: UpJb6ONSx+jpjVCjWVq6G6uaYawXK/yW99oH60QkdF9f8NUNyGUPbyuQgpN4JyCMQzWgdF529O
 2EJxkplemd5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,476,1583222400"; 
   d="scan'208";a="471808358"
Received: from amit-h97m-d3h.iind.intel.com (HELO localhost.localdomain) ([10.223.96.198])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jun 2020 07:28:10 -0700
From:   Amitsi5x <amitx.k.singh@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     amitx.k.singh@intel.com
Subject: [PATCH 1/2] bluez:load Generic access service
Date:   Fri,  5 Jun 2020 19:55:40 +0530
Message-Id: <20200605142541.28412-4-amitx.k.singh@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605142541.28412-1-amitx.k.singh@intel.com>
References: <20200605142541.28412-1-amitx.k.singh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: “AmitSingh” <amitx.k.singh@intel.com>

It allow to load generic access service to database

Signed-off-by: “AmitSingh” <amitx.k.singh@intel.com>
---
 src/gatt-client.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 20c3fbec2..2ae258da0 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -2009,9 +2009,6 @@ static void export_service(struct gatt_db_attribute *attr, void *user_data)
 	struct btd_gatt_client *client = user_data;
 	struct service *service;
 
-	if (gatt_db_service_get_claimed(attr))
-		return;
-
 	service = service_create(attr, client);
 	if (!service)
 		return;
-- 
2.17.1

