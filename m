Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C3BC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jun 2022 21:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiF2VRi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jun 2022 17:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiF2VRi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jun 2022 17:17:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68D83FD86
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 14:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656537457; x=1688073457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g/luvEaLinQrCM+LWbxbhgfJFVtoq5zUGl3Wlh5mxFg=;
  b=bwSjtGekalZElIA/IrC3GqV2tHpwGM6cYrFdu5gfi0qK398GaVwOQWUg
   /vncuzGjgiGF3m5fLeLgUIh9ZZUoMYLiBc0Otqluele8VLwsn3liuNYqP
   ru3br4BQNDPXHgrRsn1leVlxScIPwdenhrdSLvX1bpNd2gnQMIrvFJRCn
   tZGT0jsn/5rZ5Rkj1Tpf+uo9kl5unagvy4BX7FK988Rk5May3fMYAcm5M
   IWNTQv9rtDl0UFgE9Nk6IlYNJJet6V85N22n/snd39NU06QjuziwFa7xo
   RUtzptV1RS12/tM7EPzKqiDfXLCdXOySydnUVxzWGHD1t6xf6HGTMpth7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="282898076"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="282898076"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 14:16:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="647585413"
Received: from bshamoun-mobl2.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.96.196])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 14:16:49 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2 2/2] core: Fix signed vs unsigned compare
Date:   Wed, 29 Jun 2022 14:16:40 -0700
Message-Id: <20220629211640.65822-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629211640.65822-1-brian.gix@intel.com>
References: <20220629211640.65822-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

__time_t is not a portable data type, and can cause sign mismatch on
some compares.

Fixes:
  CC       src/bluetoothd-device.o
src/device.c: In function ‘device_is_name_resolve_allowed’:
src/device.c:4092:17: error: comparison of integer expressions of different signedness: ‘__time_t’ {aka ‘long int’} and ‘long unsigned int’ [-Werror=sign-compare]
  if (now.tv_sec >= device->name_resolve_failed_time +
                 ^~
cc1: all warnings being treated as errors
---
 src/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7b451e458..b91e5dc58 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4088,8 +4088,8 @@ bool device_is_name_resolve_allowed(struct btd_device *device)
 	/* now >= failed_time + name_request_retry_delay, meaning the
 	 * period of not sending name request is over.
 	 */
-	if (now.tv_sec >= device->name_resolve_failed_time +
-					btd_opts.name_request_retry_delay)
+	if (now.tv_sec >= (time_t)(device->name_resolve_failed_time +
+					btd_opts.name_request_retry_delay))
 		return true;
 
 	return false;
-- 
2.36.1

