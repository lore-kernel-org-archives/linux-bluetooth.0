Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5742ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Sep 2022 12:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiILMpq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Sep 2022 08:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiILMpl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Sep 2022 08:45:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00D411A3E
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Sep 2022 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662986735; x=1694522735;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3CMCkOA8mGHb3oteDds4/fDrBfneJWig0Km/3eOThVQ=;
  b=WGRpLKrZE5flJV4MN3yxdSZvQGQrtpIC+0WOaUiLkf+qF6iIqmS4GWy8
   8CWNhu8T3C+5QF9UDOAt+05n0uqwVCFF+NY0p+n67zI31i26HR5EOMM92
   pP//L+HeD4zVhTeEI/CYfL0CNkYMH2M1cmzDRkcmzXU2kUIoP8RkQ3ZOj
   l+j3DdNGuKOxEKz3hytjIt+lcU8SjEQV2HcJq8swzCfpY0fDUORsp5RPi
   8vZyyVMzgrvfshq30PPL/EKNL2TeycguQ2ARJLGYJltFePI9Qgd6l+2D5
   kgoj4D23HCNPJKsVorGWKPgOWSQRQpP30l+0rYDjbfUEy+mUNlxePtvLw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="297855572"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="297855572"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 05:45:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="758382770"
Received: from bsblt022.iind.intel.com ([10.224.186.21])
  by fmsmga001.fm.intel.com with ESMTP; 12 Sep 2022 05:45:20 -0700
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ 0/4] Volume Control Profile
Date:   Mon, 12 Sep 2022 18:16:53 +0530
Message-Id: <20220912124657.404551-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Initial Development of Volment Control profile and its service
Volume Control Service.

Sathish Narasimman (4):
  lib/uuid: Add VCS UUIDs
  shared/vcp: Add initial code for handling VCP
  profiles: Add initial code for vcp plugin
  monitor/att: Add decoding support for Volume Control Serice

 Makefile.am          |    1 +
 Makefile.plugins     |    5 +
 configure.ac         |    4 +
 lib/uuid.h           |    7 +
 monitor/att.c        |  159 +++++++
 profiles/audio/vcp.c |  312 +++++++++++++
 src/shared/vcp.c     | 1033 ++++++++++++++++++++++++++++++++++++++++++
 src/shared/vcp.h     |   58 +++
 8 files changed, 1579 insertions(+)
 create mode 100644 profiles/audio/vcp.c
 create mode 100644 src/shared/vcp.c
 create mode 100644 src/shared/vcp.h

-- 
2.25.1

