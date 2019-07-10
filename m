Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1373EC73C68
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D6020838
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfGJFKC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:10:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:28140 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfGJFKC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 01:10:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 22:10:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,473,1557212400"; 
   d="scan'208";a="189050265"
Received: from ingas-nuc1.sea.intel.com ([10.254.182.100])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2019 22:10:00 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/9] mesh: Configuration storage re-org
Date:   Tue,  9 Jul 2019 22:09:50 -0700
Message-Id: <20190710050959.7321-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This set of patches introduces the notion of generic mesh-config API
that allows the daemon to be agnostic of the underlying node configuration
directory layout and the format of the file(s) in which node configuration
is saved. The only assumption is that the configuration is stored in
<mesh_storage_directory>/<node_uuid> directory.

Currently, the daemon supports only JSON-based configuration format.
It is expected that other configuration formats may be added in future.


Inga Stotland (9):
  mesh: Move network config setup from storage.c to node.c
  mesh: Rename mesh-db.c to mesh-config-json.c
  mesh: Change mesh_db prefix to mesh_config
  mesh: Generalize mesh-config APIs
  mesh: Change variable prefix "jconfig" to "config"
  mesh: Define storage format specific read/write routines
  mesh: Implement config read/write for mesh json format
  mesh: Switch to using mesh-config routines for storage
  mesh: Make storage.c json-c agnostic

 Makefile.mesh                          |   2 +-
 mesh/cfgmod-server.c                   |  27 +-
 mesh/{mesh-db.c => mesh-config-json.c} | 515 ++++++++++++++++++-------
 mesh/mesh-config.h                     | 161 ++++++++
 mesh/mesh-db.h                         | 157 --------
 mesh/mesh.c                            |  11 +-
 mesh/model.c                           |   7 +-
 mesh/node.c                            |  83 ++--
 mesh/node.h                            |   4 +-
 mesh/storage.c                         | 385 +++++++-----------
 10 files changed, 745 insertions(+), 607 deletions(-)
 rename mesh/{mesh-db.c => mesh-config-json.c} (73%)
 create mode 100644 mesh/mesh-config.h
 delete mode 100644 mesh/mesh-db.h

-- 
2.21.0

