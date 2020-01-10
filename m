Return-Path: <SRS0=nFDS=27=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD449C32771
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 01:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB95820673
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 01:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbgAJBlr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 20:41:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:58409 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbgAJBlr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 20:41:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 17:41:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="236689153"
Received: from ingas-nuc1.sea.intel.com ([10.254.104.252])
  by orsmga002.jf.intel.com with ESMTP; 09 Jan 2020 17:41:46 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/2] Fix AppKey deletion
Date:   Thu,  9 Jan 2020 17:41:43 -0800
Message-Id: <20200110014145.1785-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set contains fixes for:
 - deleting individual app key deletion as a result receiving
 Config AppKey Delete message. The fix removes a dulpicate attempt
 to write to config storage and some function call simplifications

- deleting a number of appkeys as a result of receiving
Config NetKey Delete message. When deleting multiple entries from a
queue, do not use queue iteration mechanism as the deletion of
multiple entries may result in seg fault. Instead, find and delete
bound keys one by one until none are found.
 

Inga Stotland (2):
  mesh: Fix logic in AppKey deletion
  mesh: Fix wholesale deletion of appkeys bound to a netkey

 mesh/appkey.c | 32 ++++++++++++++++++++++++--------
 mesh/node.c   | 29 ++---------------------------
 mesh/node.h   |  4 ++--
 3 files changed, 28 insertions(+), 37 deletions(-)

-- 
2.21.1

