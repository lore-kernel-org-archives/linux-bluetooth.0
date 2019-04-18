Return-Path: <SRS0=fj53=SU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F477C10F0E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 22:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFEA21479
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 22:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfDRWPk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:15:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:2818 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbfDRWPk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Apr 2019 18:15:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 15:15:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,367,1549958400"; 
   d="scan'208";a="292733286"
Received: from bgix-dell-lap.sea.intel.com ([10.254.112.76])
  by orsmga004.jf.intel.com with ESMTP; 18 Apr 2019 15:15:39 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, marcel@holtmann.org, brian.gix@intel.com,
        johan.hedberg@gmail.com, michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ v6 0/1] mesh: Add APIs for Provisioner and Config Client
Date:   Thu, 18 Apr 2019 15:15:17 -0700
Message-Id: <20190418221518.13652-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Version 6 is a further refinement based on reflector feedback, and
adds methods to import externally derived App and Net keys as well
to a local nodes Config Client key storage.

Brian Gix (1):
  mesh: Add APIs for Provisioner and Config Client

 doc/mesh-api.txt | 492 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 478 insertions(+), 14 deletions(-)

-- 
2.14.5

