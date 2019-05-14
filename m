Return-Path: <SRS0=jb0q=TO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3205C04AB4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 May 2019 22:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC0320879
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 May 2019 22:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfENWyK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 May 2019 18:54:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:22776 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfENWyJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 May 2019 18:54:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 15:54:09 -0700
X-ExtLoop1: 1
Received: from ingas-nuc1.sea.intel.com ([10.252.138.236])
  by orsmga003.jf.intel.com with ESMTP; 14 May 2019 15:54:09 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/2] Start implementing mesh Management interface
Date:   Tue, 14 May 2019 15:54:05 -0700
Message-Id: <20190514225407.29594-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set ads a sketleton for org.bluez.mesh.Management1 interface.
Also, adds check for the existence of the provisioning agent for an
attaching node: this information will be further used to validate
number of method calls on Management interface

Inga Stotland (2):
  mesh: Add check for org.bluez.mesh.Provisioner1 interface
  mesh: Add skeleton for org.bluez.mesh.Management1 interface

 Makefile.mesh  |   1 +
 mesh/dbus.c    |  12 ++-
 mesh/error.h   |   1 +
 mesh/manager.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/manager.h |  20 ++++
 mesh/mesh.h    |   4 +-
 mesh/node.c    |   5 +-
 7 files changed, 303 insertions(+), 6 deletions(-)
 create mode 100644 mesh/manager.c
 create mode 100644 mesh/manager.h

-- 
2.21.0

