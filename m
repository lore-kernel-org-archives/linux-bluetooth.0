Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F22C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jun 2022 19:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiF2Twp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jun 2022 15:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiF2Twl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jun 2022 15:52:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8983EA99
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 12:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656532354; x=1688068354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qWyBbTXRfj5vX0WEDVES86/U1PzH/SH0DTgBK7l92fo=;
  b=HfIGYPXVdbAoTkARWKtjKkPuUkFn0A1vZUOsPhu/6Msi2SdFPqX4h3li
   D+HRJNR31ysax0/zTziHQ6QZHIepY338CLd1MN/24EjOrbhzFI1W/SSy3
   y6IyXrfwusadz5Rfve76+YK/agBLX0Rs+oBZQjZqMg036c/h4XbxADg4B
   9z6slUTOhHWW53bAHE6GUgVn5rpFWLpypbASBEOUbEb5A8FgSxiyzNqel
   EP5Oi4PVxZo4XSPNdu5QwHxmdWlQgCdTMv2JGfa9WMGbd7iVzq0v3oU9T
   7Xi8D+6oItoVLRX75p6YvSOIvbAhH3YVkSt81evQP8/KIVJZjqRKK4zqj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="282175958"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="282175958"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 12:44:43 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="647553059"
Received: from bsquresh-mobl4.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.91.166])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 12:44:43 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ 2/2] core: Fix signed vs unsigned compare
Date:   Wed, 29 Jun 2022 12:44:32 -0700
Message-Id: <20220629194432.20229-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629194432.20229-1-brian.gix@intel.com>
References: <20220629194432.20229-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

__time_t is not a portable data type, and can cause sign mismatch on
come compares.

Fixes:
  CC       src/bluetoothd-device.o
src/device.c: In function ‘device_is_name_resolve_allowed’:
src/device.c:4092:17: error: comparison of integer expressions of different signedness: ‘__time_t’ {aka ‘long int’} and ‘long unsigned int’ [-Werror=sign-compare]
  if (now.tv_sec >= device->name_resolve_failed_time +
                 ^~
cc1: all warnings being treated as errors
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 7b451e458..012d73583 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4088,7 +4088,7 @@ bool device_is_name_resolve_allowed(struct btd_device *device)
 	/* now >= failed_time + name_request_retry_delay, meaning the
 	 * period of not sending name request is over.
 	 */
-	if (now.tv_sec >= device->name_resolve_failed_time +
+	if ((unsigned)now.tv_sec >= device->name_resolve_failed_time +
 					btd_opts.name_request_retry_delay)
 		return true;
 
-- 
2.36.1

