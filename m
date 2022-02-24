Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E17C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 02:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiBXCHD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 21:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiBXCHD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 21:07:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036876258
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 18:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645668393; x=1677204393;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UZlEcpXqCyRdEhR3ljGXnm7515gYqE5BYc93WP/lZXE=;
  b=aDUmwaKUCGmq0fExSLFGZEANc3GfDM2f/hTH2WxQ+Go9gva0F0WS38BG
   1Mi8QR6T6rKJpdVzKwsreXUqa9BupGPr9Rp3VtnEwY+EhTpaezURvfjRd
   E6WBQdZXLrlKx9SKvEP/cTfTpfStbm3YKUg9iHjuL4GS7c5SSV/tomDnY
   bB19TeSHiHMJTMhLsu+U7HOOVI33qb58K3r2hnWBcQt1Zf1ztp7ia/FO+
   frkPusK8qkWNXxbTcis4WxGsKWP4Re3SOdXWqGXO/dhGPmSrWOVvLQxfP
   5QIuHwLL44EyY6Ho+rv4caEUPI4zTjIGpZl9JGX+28uuOuRooUvCAcCyc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="239524994"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="239524994"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:06:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="607268555"
Received: from tjsmith-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.34.213])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:06:33 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH 0/7] Kernel based mesh functionality
Date:   Wed, 23 Feb 2022 18:06:17 -0800
Message-Id: <20220224020624.159247-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set makes the bluetooth-meshd daemon use the Kernel based
mesh support *if available*. It defines and calls the MGMT commands
and events needed so that a controller can be used without making
it unavailable to the bluetoothd daemon.

Brian Gix (7):
  mgmt: Add support for Mesh in the kernel
  mgmt: Mesh specific structures and defines
  mesh: Add common MGMT command accessors
  mesh: rework Mesh-IO for multiple transports
  mesh: Added default "auto" to command line parsing
  mesh: Add new MGMT based IO transport
  mesh: Make Provisioning requests more IO compatible

 Makefile.mesh          |   9 +-
 doc/mgmt-api.txt       | 180 ++++++++++
 lib/mgmt.h             |  54 +++
 mesh/main.c            |  39 +-
 mesh/mesh-io-api.h     |  11 +-
 mesh/mesh-io-generic.c |  47 +--
 mesh/mesh-io-mgmt.c    | 787 +++++++++++++++++++++++++++++++++++++++++
 mesh/mesh-io-mgmt.h    |  11 +
 mesh/mesh-io-unit.c    |  13 +-
 mesh/mesh-io.c         | 191 +++++++---
 mesh/mesh-io.h         |   4 +-
 mesh/mesh-mgmt.c       | 149 ++++++--
 mesh/mesh-mgmt.h       |  12 +-
 mesh/mesh.c            |   6 +-
 mesh/mesh.h            |   2 +-
 mesh/pb-adv.c          |   9 +-
 16 files changed, 1379 insertions(+), 145 deletions(-)
 create mode 100644 mesh/mesh-io-mgmt.c
 create mode 100644 mesh/mesh-io-mgmt.h

-- 
2.35.1

