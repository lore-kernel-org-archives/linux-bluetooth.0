Return-Path: <SRS0=yo6A=RS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91528C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Mar 2019 17:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EA9218AC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Mar 2019 17:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbfCORh6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:37:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:18192 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfCORh6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Mar 2019 13:37:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 10:37:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="127315134"
Received: from bgix-dell-lap.sea.intel.com ([10.254.19.129])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2019 10:37:57 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com, marcel@holtmann.org,
        luiz.dentz@gmail.com, johan.hedberg@gmail.com
Subject: [PATCH BlueZ v2 0/1] mesh: Add APIs for Provisioner and Config Client
Date:   Fri, 15 Mar 2019 10:37:34 -0700
Message-Id: <20190315173735.32458-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This v2 version corrects the cosmetic errors that Johan found, but
leaves open the larger architectural questions his comments raised on
the division between the bluetooth-meshd daemon and an Application
implementing the Provisioner/Configuration Client role.

Brian Gix (1):
  mesh: Add APIs for Provisioner and Config Client

 doc/mesh-api.txt | 261 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 246 insertions(+), 15 deletions(-)

-- 
2.14.5

