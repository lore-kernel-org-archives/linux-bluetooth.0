Return-Path: <SRS0=3ySR=RW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759A3C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 21:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C40A2175B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 21:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfCSVAj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:00:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:7913 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfCSVAj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Mar 2019 17:00:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 14:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,246,1549958400"; 
   d="scan'208";a="124053031"
Received: from bgix-dell-lap.sea.intel.com ([10.251.151.31])
  by orsmga007.jf.intel.com with ESMTP; 19 Mar 2019 14:00:34 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com, marcel@holtmann.org,
        luiz.dentz@gmail.com, johan.hedberg@gmail.com
Subject: [PATCH BlueZ v3 0/1] mesh: Add APIs for Provisioner and Config Client
Date:   Tue, 19 Mar 2019 14:00:28 -0700
Message-Id: <20190319210029.24734-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Version 3 of this patch was made after a larger conversation that included
Marcel, and focused on preserving the security of all encryption keys in the
system including Device Keys, Application Keys and Network Keys. This modified
revision therefore avoids all passing of Keys of any kind over the D-Bus
interface, and puts off until later the question of how to export a
transferable Key and Node database until a later time.

Brian Gix (1):
  mesh: Add APIs for Provisioner and Config Client

 doc/mesh-api.txt | 363 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 348 insertions(+), 15 deletions(-)

-- 
2.14.5

