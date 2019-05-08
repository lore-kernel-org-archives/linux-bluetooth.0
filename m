Return-Path: <SRS0=XQ0Y=TI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA76AC04A6B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 21:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A541C216C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 21:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfEHVuK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 May 2019 17:50:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:39553 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfEHVuJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 May 2019 17:50:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 14:50:09 -0700
X-ExtLoop1: 1
Received: from ingas-nuc1.sea.intel.com ([10.251.29.44])
  by fmsmga004.fm.intel.com with ESMTP; 08 May 2019 14:50:09 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/1 v2] mesh Create() method
Date:   Wed,  8 May 2019 14:50:07 -0700
Message-Id: <20190508215008.32403-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Rebased on top of bluez tip

Inga Stotland (1):
  mesh: Add CreateNetwork method() implementation

 mesh/mesh.c |  70 ++++++++++++++++-
 mesh/node.c | 218 ++++++++++++++++++++++++++++++++++------------------
 mesh/node.h |   8 +-
 3 files changed, 218 insertions(+), 78 deletions(-)

-- 
2.17.2

