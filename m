Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B65C6FA86
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 22:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIVWbW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Sep 2022 18:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIVWbP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Sep 2022 18:31:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC442D4303
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 15:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663885873; x=1695421873;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bA3w8hl44UjbrHcE/dEdMrxpPSZ7nD+/cWb2ugRxoNI=;
  b=DvEM9mdSfHZ9oaWWnwxQw/y5k/MVVOoveSC1f6FLKuEWBXopH2R0d3PV
   /FUPWcFrsE0fnGWUYK8oneN91u7riXfGrOpafDSX3O15Os76Ctk+tjTHp
   Icj8TmC3izcXh0JMwO9G5wwwlfh1zM8MmTRUDSzQ2xutnE07anTqd/azO
   lA5mtZ7epwlh/5mjFFZIWyW4Tn/Xh6hGQ7yZe3yYIc1koFlWuJ/jy/QpK
   8vTSYwKg9byKdMyZKaHvf1ep4B05oimyVWu83CeT+gZoHqU+G7Yt0OMXd
   S4GiyUYdT40xrIOxUJn70zX0eFDsBQ2CBQ1Xy9AER4qhbeJZaGOMwyDQ6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="298049387"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="298049387"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 15:31:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="762389334"
Received: from avarhadk-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.213.161.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 15:31:12 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v4 0/2] Mesh demon switched to using kernel Mesh MGMT
Date:   Thu, 22 Sep 2022 15:31:00 -0700
Message-Id: <20220922223102.640173-1-brian.gix@intel.com>
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
 mesh/mesh-io.c         | 188 +++++++---
 mesh/mesh-io.h         |   4 +-
 mesh/mesh-mgmt.c       | 164 +++++++--
 mesh/mesh-mgmt.h       |  12 +-
 mesh/mesh.c            |   6 +-
 mesh/mesh.h            |   2 +-
 mesh/pb-adv.c          |   9 +-
 14 files changed, 1159 insertions(+), 144 deletions(-)
 create mode 100644 mesh/mesh-io-mgmt.c
 create mode 100644 mesh/mesh-io-mgmt.h

-- 
2.37.3

