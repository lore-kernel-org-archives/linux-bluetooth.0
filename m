Return-Path: <SRS0=CsNs=TW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9128C072A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 05:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E3920862
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 05:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfEVFds (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 May 2019 01:33:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:63614 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfEVFds (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 May 2019 01:33:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 22:33:47 -0700
X-ExtLoop1: 1
Received: from ingas-nuc1.sea.intel.com ([10.254.190.110])
  by orsmga007.jf.intel.com with ESMTP; 21 May 2019 22:33:47 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/2] mesh: Clean up D-Bus message references
Date:   Tue, 21 May 2019 22:33:37 -0700
Message-Id: <20190522053339.6289-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This set of patches cleans up the usage of l_dbus_message_ref() and
l_dbus_message_unref() in the mesh daemon

Inga Stotland (2):
  mesh: Unreference pending D-Bus messages
  mesh: Remove unnecessary message ref/unref in agent.c

 mesh/agent.c | 16 ----------------
 mesh/mesh.c  |  8 +++++---
 2 files changed, 5 insertions(+), 19 deletions(-)

-- 
2.21.0

