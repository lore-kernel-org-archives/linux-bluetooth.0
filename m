Return-Path: <SRS0=CqyX=RZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B73C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 22:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEED218B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 22:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfCVW6I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:58:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:16306 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbfCVW6I (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Mar 2019 18:58:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 15:58:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="127856161"
Received: from bgix-dell-lap.sea.intel.com ([10.255.84.223])
  by orsmga008.jf.intel.com with ESMTP; 22 Mar 2019 15:58:07 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com, marcel@holtmann.org,
        luiz.dentz@gmail.com, johan.hedberg@gmail.com
Subject: [PATCH BlueZ v4 0/1] mesh: Add APIs for Provisioner and Config Client
Date:   Fri, 22 Mar 2019 15:57:53 -0700
Message-Id: <20190322225754.27039-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Version 4 of this patch incorporates Inga's refinements, and a clear deliniation between methods to manage the local node key database, and the configuration clients calls to send those keys to remote node's configuration servers.

Brian Gix (1):
  mesh: Add APIs for Provisioner and Config Client

 doc/mesh-api.txt | 425 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 409 insertions(+), 16 deletions(-)

-- 
2.14.5

