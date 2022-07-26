Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E08C00144
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jul 2022 23:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbiGZXBw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jul 2022 19:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiGZXBw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jul 2022 19:01:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7232AE0FB
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jul 2022 16:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658876511; x=1690412511;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=irAMA1GuAIW25qkyo8RRFrBF0dDVSTg+onkzW7iLbNk=;
  b=YpP7Td5v8qJ3ASF82Fzf11Uvlt5iwpprjvQudKiDu76G382LUf6juFpS
   JY25YAJ7HJW5OyX/AL4prtbCUeHYrIWwDvpo4lvKJ1ws0/+sLEgzO6VYy
   f69KO2mGx7Z8K5AAwgHW5pRi2BUtD075pc8hg8JvSRZrS96B59kDN1W2V
   OAuUQ4MDwZUig3N6os2P3MooKQ5n60InJ2Xebeug9Z/shnyCH+vo/+/cv
   0T7RYQKKFP9hGfibAqYbiXjIy2EJEuAGL08Bxjc8k2kUFubfu2Y+at8o5
   mBOqJlUGCdWxhxJ5Uk4aDWufLMzIkojxTRAgrC/9WtG442fQEovZxZFG/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="274965136"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="274965136"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 16:01:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="668098972"
Received: from srezaei-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.5.115])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 16:01:48 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v3 0/4] Clean-up stale/unused hci_request.c code
Date:   Tue, 26 Jul 2022 16:01:36 -0700
Message-Id: <20220726230140.205481-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This will be a growing patch-set of conversions and dead-code removal
towards the goal of retiring hci_request.c

The patch sets will be split amoung the work queues and delayed work
queues as initialized in hci_request_setup(), with the ultimate goal of
eliminating hci_request.c entirely.

v2: Published

v3: Continuing work.  This does include one conversion
(SCO configure_datapath) that has been tested with mgmt-tester and
sco-tester, but has not been tested with a controller with an
off-loadable codec.


Brian Gix (4):
  Bluetooth: Convert le_scan_disable timeout to hci_sync
  Bluetooth: Rework le_scan_restart for hci_sync
  Bluetooth: Delete unused hci_req_stop_discovery()
  Bluetooth: Convert SCO configure_datapath to hci_sync

 net/bluetooth/hci_conn.c    |  85 +++++++++--
 net/bluetooth/hci_request.c | 282 +-----------------------------------
 net/bluetooth/hci_request.h |   4 -
 net/bluetooth/hci_sync.c    | 148 +++++++++++++++++++
 4 files changed, 223 insertions(+), 296 deletions(-)

-- 
2.37.1

