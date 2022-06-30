Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF25C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 21:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbiF3VOw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiF3VOv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 17:14:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2CD1FCCF
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656623690; x=1688159690;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XUIWS8InKYLfjv9sCg+brF2VZPzCPp+3MPNXux8fhN4=;
  b=RykVFf4mCvyYdm706oRNY4vEVhfGxZPOMGA+9ni15ueQ+aju8c9mvMoM
   6ng4aWu/AqXF1//paVrqjPGUCYBaSMp/3FQ1by0fXavl59ffB+j3yD6Fk
   h14H3Koj4AAdUEVE5mOSh09nYjTa2oXIG4chFDy9ElfiPWA5owDfG9Jta
   km+cLLzlYWEoKNMcIq+qYl3AZyHGKoAeTshWDdvl2PfV5qZ3wZGZ9un5r
   J07fduVICrCeEI/E99GIm3OZJDIeVqIVVE72/S6LlBY7UFT+ZfVIM/9+O
   nGlYpHXNulg53k6Ec2oedt+gmpx6JH5dWEYtZYs8XkOUqzWCIRdFieA+p
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="271242786"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="271242786"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 14:14:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="733788061"
Received: from ikipnis-mobl2.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.122.213])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 14:14:49 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Fix potential memory leak
Date:   Thu, 30 Jun 2022 14:13:13 -0700
Message-Id: <20220630211313.210017-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This memory leak will never happen, however since we added a new
return from function that malloc'd memory, the free should still be
done.
---
 mesh/mesh-config-json.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 5bb1e5ce0..7f46c8582 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -1961,8 +1961,10 @@ bool mesh_config_comp_page_add(struct mesh_config *cfg, uint8_t page,
 	len = (size * 2) + 3;
 	buf = l_malloc(len);
 	ret = snprintf(buf, len, "%2.2x", page);
-	if (ret < 0)
+	if (ret < 0) {
+		l_free(buf);
 		return false;
+	}
 
 	hex2str(data, size, buf + 2, len - 2);
 
-- 
2.36.1

