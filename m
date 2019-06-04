Return-Path: <SRS0=Orb+=UD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05072C282CE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jun 2019 06:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D321324889
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jun 2019 06:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfFDGHu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:07:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:8052 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFDGHu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jun 2019 02:07:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 23:07:50 -0700
X-ExtLoop1: 1
Received: from ligangti-mobl3.ccr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.84.181])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jun 2019 23:07:49 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, marcel@holtmann.org, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/2 v3] Add support for systemd mesh service
Date:   Mon,  3 Jun 2019 23:07:46 -0700
Message-Id: <20190604060748.3533-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set adds files necessary to run bluetooth-meshd
as systemd service and also removes explicit call to daemon()

Inga Stotland (2):
  build: Add support for systemd bluetooth-mesh service
  mesh: Do not daemonize, run in foreground or as service

 Makefile.mesh                  | 14 ++++++++++++--
 mesh/bluetooth-mesh.service.in | 16 ++++++++++++++++
 mesh/main.c                    | 17 ++++++-----------
 mesh/org.bluez.mesh.service    |  5 +++++
 4 files changed, 39 insertions(+), 13 deletions(-)
 create mode 100644 mesh/bluetooth-mesh.service.in
 create mode 100644 mesh/org.bluez.mesh.service

-- 
2.21.0

