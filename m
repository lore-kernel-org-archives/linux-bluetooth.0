Return-Path: <SRS0=11Tl=BR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41546C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 01:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2902177B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 01:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgHGBih (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Aug 2020 21:38:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:43978 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgHGBih (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Aug 2020 21:38:37 -0400
IronPort-SDR: QyEwnpsYG57s9w9/JOM/uMQOAfNy2T47JOsVAKJskj0iNvV/CAAHej7WoesqRjVeB8mcCMiAGA
 m/i/b82SpDjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="140558035"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="140558035"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 18:38:36 -0700
IronPort-SDR: PD8tttQWi2/Ra55aAh0VmpofO12MqFE/dKUDAD1IFfRk3S4ulJNgB0WMzhDHsuf2cTUq31n/bu
 P/noJS2AyUww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="397442060"
Received: from unknown (HELO ingas-nuc1.intel.com) ([10.254.119.50])
  by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2020 18:38:36 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v5 00/10] Mesh Config Server clean up
Date:   Thu,  6 Aug 2020 18:38:24 -0700
Message-Id: <20200807013834.123263-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

v5 - addressed more of Brian's comments. Added missing range checking

*******************
v4 - Further fixes in handling Key Refresh Phase Set message

*******************
 v3 - address Brian's comments
 
*******************
This patch set groups functionality by config messages.
Also, fixes the cases where malformed messages should be  silently
ignored and the situations when incorrect error status
is sent in response.


Inga Stotland (10):
  mesh: Clean up handling of config subscription messages
  mesh: Clean up handling of config model binding messages
  mesh: Clean up handling of config node identity message
  mesh: Clean up handling of config publication messages
  mesh: Clean up handling of config net and app key messages
  mesh: Clean up handling of config relay messages
  mesh: Clean up handling of config poll timeout message
  mesh: Clean up handling of config net transmit messages
  mesh: Clean up handling of config KR phase messages
  mesh: Refactor heartbeat pub/sub

 mesh/cfgmod-server.c    | 1198 +++++++++++++++++----------------------
 mesh/cfgmod.h           |    2 +-
 mesh/mesh-config-json.c |   12 +-
 mesh/mesh-config.h      |    6 +-
 mesh/mesh-defs.h        |    6 +
 mesh/model.c            |  238 ++++----
 mesh/model.h            |   21 +-
 mesh/net.c              |  326 +++++++----
 mesh/net.h              |   54 +-
 mesh/node.h             |    4 -
 10 files changed, 924 insertions(+), 943 deletions(-)

-- 
2.26.2

