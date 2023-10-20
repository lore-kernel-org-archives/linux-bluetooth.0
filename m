Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBBDC001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 14:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377539AbjJTONs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377530AbjJTONr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 10:13:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16E2D41
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 07:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697811225; x=1729347225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KBhe0yXqXt7ZHhsZymsr3fzLps0zsk6XXIct1khCwyI=;
  b=PcPVjeh3sOyl68+GNREewaw8HVcIOe7JsAVAnUgm8c7wCwYVEi6o1Xi8
   bVJHdHJ1gmgZ3z6Ux79kFPpElVzlWAKbiU3BWJ6J23NXY/0yeEiHs2EQk
   yTSoF+1Z9HuSfL/GW49Kx1bbcP/9/lSvFdYWZP8bYTkoM/ZIptQZ2bCek
   K5DmnL9DyWdcRV6evGHUJzKYR5wfmzd+5JP3AcJpx2O8eR5s65yDre3Ie
   haxtuMZ98q/PYo2+4wDPQlRhzKXsJ3jHqa+4O0GGp+SsAquKMvFXY8qbO
   /gkWNnFugY8S0nVyLgHhndyeYGrWNfNNU8tKMjI/CcR7sHbd4A9y0MqP6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="365840890"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="365840890"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 07:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="1088756511"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="1088756511"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 20 Oct 2023 07:13:44 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 4/5] bap: Fix reading source codec capabilities
Date:   Fri, 20 Oct 2023 19:55:53 +0530
Message-Id: <20231020142554.486629-4-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020142554.486629-1-kiran.k@intel.com>
References: <20231020142554.486629-1-kiran.k@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Sink ASE capabilities were read instead of source.
---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 5cb8b5aba659..bd00fa210abe 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2634,7 +2634,7 @@ static void bap_add_source(struct bt_bap_pac *pac)
 	iov.iov_base = value;
 	iov.iov_len = 0;
 
-	queue_foreach(pac->bdb->sinks, pac_foreach, &iov);
+	queue_foreach(pac->bdb->sources, pac_foreach, &iov);
 
 	pacs_add_source_location(pac->bdb->pacs, pac->qos.location);
 	pacs_add_source_supported_context(pac->bdb->pacs,
-- 
2.34.1

