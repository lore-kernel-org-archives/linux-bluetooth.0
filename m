Return-Path: <SRS0=fr0v=SR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65327C10F0E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Apr 2019 19:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D7E20848
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Apr 2019 19:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfDOTt5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:49:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:2951 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbfDOTt5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Apr 2019 15:49:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 12:49:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208";a="140919332"
Received: from bgix-dell-lap.sea.intel.com ([10.254.112.76])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2019 12:49:56 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, marcel@holtmann.org, brian.gix@intel.com,
        johan.hedberg@gmail.com, michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ v5 0/1] mesh: Add APIs for Provisioner and Config Client
Date:   Mon, 15 Apr 2019 12:49:45 -0700
Message-Id: <20190415194946.13121-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Version 5 of this patch includes two new methods:

* ImportRemoteNode() -- Adds the device_key credentials of a *Remote* Node provisioned by an external process of some sort.

* ImportLocalNode() -- Adds new *Local* node that is being migrated from another platform, as if it had been provisioned locally.

These changes made based of discussions with Michal Lowas-Rzechonek.

Brian Gix (1):
  mesh: Add APIs for Provisioner and Config Client

 doc/mesh-api.txt | 451 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 437 insertions(+), 14 deletions(-)

-- 
2.14.5

