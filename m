Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D370ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 20:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiIVUjE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Sep 2022 16:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiIVUjD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Sep 2022 16:39:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53B51103C4
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663879140; x=1695415140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gs0syu6PDpgGuORWwYL0BuaPKpN/TRV3+bKxC7imBEA=;
  b=H0YGHQ2oZzXY1zjI4GSdYCrPDIRanFk/ldzRe2Ak6btHqDxCiTAM0s2r
   MHo9pUMi3awxDl0EvANusbQAv6crhipdrtaq7muC1PVJax16NLJJVgDT3
   D5hQVH5Ca47stCaHMFxb/XDkvO/qcBtraIXGcD8dSeNtjrP+yA3U0lBFz
   5JG1sDr5OvJaeKcwAG6xw6EnljfZm5aiHmc8Hyih/d2Vd6qWA22hC9kKf
   Aq75YidelBzJ97fz35TaEaX2L1iTdV6qDUk5wPUueQEI4uY6EuOKB2aha
   exEQhS95Wg+okPgJiG953ArYj5hGmiQ7g2HReugdBaWxWX/qcEd6pb1iZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301303192"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301303192"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:39:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="865028660"
Received: from mobl2.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.23.53])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:38:59 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ 0/4] Mesh demon switched to using kernel Mesh MGMT
Date:   Thu, 22 Sep 2022 13:38:48 -0700
Message-Id: <20220922203852.494315-1-brian.gix@intel.com>
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

Brian Gix (4):
  mgmt: Add support for Mesh in the kernel
  lib: Add defines of new MGMT opcodes and events
  mesh: Improve PB-ADV timing for reliability
  mesh: Add new kernel MGMT based IO transport

 Makefile.mesh          |   9 +-
 doc/mgmt-api.txt       | 192 +++++++++++++++++++++++++++++++++--------
 lib/mgmt.h             |   6 ++
 mesh/main.c            |  39 ++++++++-
 mesh/mesh-io-api.h     |  11 ++-
 mesh/mesh-io-generic.c |  47 +++-------
 mesh/mesh-io-unit.c    |  13 ++-
 mesh/mesh-io.c         | 188 ++++++++++++++++++++++++++++++----------
 mesh/mesh-io.h         |   4 +-
 mesh/mesh-mgmt.c       | 164 +++++++++++++++++++++++++++--------
 mesh/mesh-mgmt.h       |  12 ++-
 mesh/mesh.c            |   6 +-
 mesh/mesh.h            |   2 +-
 mesh/pb-adv.c          |   9 +-
 14 files changed, 523 insertions(+), 179 deletions(-)

-- 
2.37.3

