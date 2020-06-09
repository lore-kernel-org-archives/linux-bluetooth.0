Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C183C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 19:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68CE720734
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 19:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389153AbgFITKS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:10:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:40922 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389150AbgFITKR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jun 2020 15:10:17 -0400
IronPort-SDR: +Gnpn8JxB6wCqJEDeJuYxLyTztyZbOBDZlr40rEZOIUvhftPK7CgpYWP7K/sHwdbCuHBfKjhIL
 OfOUgc8zwTSw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 12:10:17 -0700
IronPort-SDR: NW+9s45V0e8CDq8WZSv6PJCD+YYLAoC5QlwIQ8q6knKCHQmc/aQC/4uRjtRwtwA2fKAK13nSsp
 1b3UFy+s+ZgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,493,1583222400"; 
   d="scan'208";a="259071176"
Received: from rpedgeco-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.229.21])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2020 12:10:16 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, przemyslaw.fierek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 0/4] Put safeguards around Leave & Attach calls
Date:   Tue,  9 Jun 2020 12:10:11 -0700
Message-Id: <20200609191015.18459-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This set of patches addresses the situation when an application
calls Leave() or Attach() methods on a node that has another incomplete
method call on Network interface associated with it.

The simple solution is to return error in response to Leave() method
if an application still owes the daemon either a reply to GetManagedObjects
request in case of Attach() or a reply to JoinComplete() in case of
Join(), Create() or Import()

Similarly, a "Busy" error is returned in response to Attach() method
if an application still owes the daemon a reply to JoinComplete()
in case of pending Join(), Create() or Import()

Inga Stotland (4):
  mesh: Make "Busy" and "InProgress" to be distinct errors
  mesh: Add destroy callback to dbus_send_with_timeout()
  mesh: Add timeout to a get managed objects call
  mesh: Add "node is busy" check for Leave() & Attach()

 doc/mesh-api.txt |  5 +++-
 mesh/dbus.c      | 14 ++++++++---
 mesh/dbus.h      |  1 +
 mesh/error.h     |  1 +
 mesh/manager.c   | 11 ++++-----
 mesh/mesh.c      | 22 +++++++++++------
 mesh/node.c      | 64 +++++++++++++++++++++++++++++++-----------------
 mesh/node.h      |  1 +
 test/test-mesh   |  2 --
 9 files changed, 78 insertions(+), 43 deletions(-)

-- 
2.26.2

