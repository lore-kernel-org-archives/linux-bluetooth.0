Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928CFC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 21:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiIVVkv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Sep 2022 17:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiIVVkt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Sep 2022 17:40:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3221E108096
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663882849; x=1695418849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XDj25mfoeeqMG46NS98/JKvOcEcd7VyuK7v09qD+BZg=;
  b=JACtwJLf8rrWo2zxcovZcN21/Bp3hfhHaIOsLmO5vjoRt7fptXNhBNUW
   ZTZ1ZggnqpugVi5NzxIXfWTd/NVQTPCjetua6OJJRe4jHFBHiyTZQmHb9
   IpF/wIXov44Dr4+kLbuJAJNDvObrfyunSaa+AJ/xAkXn39Jbfa9zLxbxj
   CE0u6OtuxAAHpQPMhumjwKAuM2SsY4gPe4aku/xRJCdYh4BZCgZBUVHYA
   4cNFe6dW+o8L5oYjMmkBxF6kQB007oiU4Dmt8Y/m29awPqL1M6z3/S/e+
   FaLGn+TgBtlInQl5oNztcClEhk3065doNi3jqqEOa2hfW9g7+rYgZY2aC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="280807337"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="280807337"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 14:40:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="795272483"
Received: from avarhadk-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.213.161.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 14:40:48 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v3 0/2] Mesh demon switched to using kernel Mesh MGMT
Date:   Thu, 22 Sep 2022 14:40:37 -0700
Message-Id: <20220922214039.611611-1-brian.gix@intel.com>
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


Brian Gix (2):
  mesh: Improve PB-ADV timing for reliability
  mesh: Add new kernel MGMT based IO transport

 Makefile.mesh          |   9 +-
 mesh/main.c            |  39 ++++++++-
 mesh/mesh-io-api.h     |  11 ++-
 mesh/mesh-io-generic.c |  47 +++--------
 mesh/mesh-io-unit.c    |  13 ++-
 mesh/mesh-io.c         | 188 ++++++++++++++++++++++++++++++-----------
 mesh/mesh-io.h         |   4 +-
 mesh/mesh-mgmt.c       | 164 +++++++++++++++++++++++++++--------
 mesh/mesh-mgmt.h       |  12 ++-
 mesh/mesh.c            |   6 +-
 mesh/mesh.h            |   2 +-
 mesh/pb-adv.c          |   9 +-
 12 files changed, 360 insertions(+), 144 deletions(-)

-- 
2.37.3

