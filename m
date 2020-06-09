Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165BFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 03:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BDB207F9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 03:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgFID7L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 23:59:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:17236 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgFID7L (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 23:59:11 -0400
IronPort-SDR: aunxvtkzZkObYkglWRKn6c0Mhie7qzen1N0aHr7f1AP8WTY88oNw12lMylqz3lBd9Bt0KAx4FF
 AaK6qmrMzp3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 20:59:10 -0700
IronPort-SDR: jWer0k92bQxX0YFrEXuBD2EY2FKEBpc6gzUNhoS5XQC8OPeTfDDkn3vXnJTYWLM8N84NClb2La
 iS5alrwpLNqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,490,1583222400"; 
   d="scan'208";a="274461133"
Received: from vrsuryad-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.228.38])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2020 20:59:10 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, przemyslaw.fierek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/4] Put safeguards around Leave call
Date:   Mon,  8 Jun 2020 20:59:05 -0700
Message-Id: <20200609035909.51061-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This set of patches addresses the situation when an application
calls Leave() method on a node that has another incomplete
method call on Network interface associated with it.

The simple solution is to return error in response to Leave() method
if an application still owes the daemon either a reply to GetManagedObjects
request in case of Attach() or a reply to JoinComplete() in case of
Join(), Create() or Import()

Inga Stotland (4):
  mesh: Make "Busy" and "InProgress" to be distinct errors
  mesh: Add destroy callback to dbus_send_with_timeout()
  mesh: Add timeout to a get managed objects call
  mesh: Add "node is busy" check for Leave() method

 doc/mesh-api.txt |  4 +++-
 mesh/dbus.c      | 14 +++++++----
 mesh/dbus.h      |  1 +
 mesh/error.h     |  1 +
 mesh/manager.c   | 11 ++++-----
 mesh/mesh.c      | 17 +++++++------
 mesh/node.c      | 62 +++++++++++++++++++++++++++++-------------------
 mesh/node.h      |  2 +-
 8 files changed, 68 insertions(+), 44 deletions(-)

-- 
2.26.2

