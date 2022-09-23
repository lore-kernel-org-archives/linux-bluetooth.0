Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B1FC07E9D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 18:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiIWSAu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiIWSAt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 14:00:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D1F8C028
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 11:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663956048; x=1695492048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Qe3EEGwjOJAFfWuVOfdQJ4FuFXvzFxoL9HU49eQLaA=;
  b=bsS12wGN+VNvdqsmjUWuiaj8skK9KZ0XRVwaJpIFXmK1v/I8x+rniSzt
   KkvVDMz90BaCGae8vFNCec/MdHesMkGge/62o2ZxlrCwGDwHTwWjnIkDq
   GJ74ZhlQEst+bQ+OoW+zHxVfkLAD2/GMR7rubCYZmz7U5/bkjNrPXMnYN
   IYEMgqd/OEwYEmgZBN4RUpBGzht1IeFsUWksAtfQJfB4AdXBdI+1FpwZt
   Ydz5/Ijgt/2hRs2bX8ffEbXeQfKjzp0gwjjBgi3iQzkPu3WsizBUhimki
   tM+tGe7Iw8V4kPx+CxTUReUcgsbvqye8q43n82n0ye4mlqW0fRabBhd4V
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="300633802"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="300633802"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 11:00:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="745878190"
Received: from cramirez-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.82.81])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 11:00:30 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v5 0/2] Mesh demon switched to using kernel Mesh MGMT
Date:   Fri, 23 Sep 2022 11:00:16 -0700
Message-Id: <20220923180018.815614-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset enables the mesh daemon (bluetooth-meshd) to use the new
MGMT mesh opcodes and events to send and receive Mesh packets. By
default, the daemon attempts to enable the experimental mesh
functionality, and query the kernel for active mesh support before then
enumerating the available controllers and selecting ojne that works.

If no kernel support is found, it will continue to use a raw HCI socket
for mesh support.

v2-v3: Fix whitespace and spelling

v4: Rework missed 2 new files...  readded.

v5: Fix null-point dereference found by CI

Brian Gix (2):
  mesh: Improve PB-ADV timing for reliability
  mesh: Add new kernel MGMT based IO transport

 Makefile.mesh          |   9 +-
 mesh/main.c            |  39 +-
 mesh/mesh-io-api.h     |  11 +-
 mesh/mesh-io-generic.c |  47 +--
 mesh/mesh-io-mgmt.c    | 788 +++++++++++++++++++++++++++++++++++++++++
 mesh/mesh-io-mgmt.h    |  11 +
 mesh/mesh-io-unit.c    |  13 +-
 mesh/mesh-io.c         | 189 +++++++---
 mesh/mesh-io.h         |   4 +-
 mesh/mesh-mgmt.c       | 164 +++++++--
 mesh/mesh-mgmt.h       |  12 +-
 mesh/mesh.c            |   6 +-
 mesh/mesh.h            |   2 +-
 mesh/pb-adv.c          |   9 +-
 14 files changed, 1160 insertions(+), 144 deletions(-)
 create mode 100644 mesh/mesh-io-mgmt.c
 create mode 100644 mesh/mesh-io-mgmt.h

-- 
2.37.3

