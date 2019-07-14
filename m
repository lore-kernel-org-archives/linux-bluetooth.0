Return-Path: <SRS0=dLRT=VL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26988C73C66
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 06:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF57D20820
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 06:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfGNG2P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Jul 2019 02:28:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:30353 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfGNG2P (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Jul 2019 02:28:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2019 23:28:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,489,1557212400"; 
   d="scan'208";a="318387970"
Received: from ingas-nuc1.sea.intel.com ([10.251.146.93])
  by orsmga004.jf.intel.com with ESMTP; 13 Jul 2019 23:28:14 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 00/10 v2] mesh: Configuration storage re-org
Date:   Sat, 13 Jul 2019 23:28:02 -0700
Message-Id: <20190714062812.31041-1-inga.stotland@intel.com>
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
is saved. 

Currently, the daemon supports only JSON-based configuration format.
It is expected that other configuration formats may be added in future.

As a result of these changes, storage.c and storage.h are obsolete
and are removed.

Inga Stotland (10):
  mesh: Move network config setup from storage.c to node.c
  mesh: Rename mesh-db.c to mesh-config-json.c
  mesh: Change mesh_db prefix to mesh_config
  mesh: Move load from storage functionality into node.c
  mesh: Confine dependency on json-c to mesh-config-json.c
  mesh: Replace storage_save_config with mesh_config_save_config
  mesh: Use mesh_config APIs to store node configuration
  mesh: Manage node config directory in mesh-config
  mesh: Create or re-use a node storage directory for keyring
  mesh: Rename mesh_config_srv_init() to cfgmod_server_init()

 Makefile.mesh                          |    3 +-
 mesh/appkey.c                          |   19 +-
 mesh/cfgmod-server.c                   |   31 +-
 mesh/cfgmod.h                          |    2 +-
 mesh/keyring.c                         |   36 +-
 mesh/{mesh-db.c => mesh-config-json.c} | 1071 +++++++++++++++++-------
 mesh/mesh-config.h                     |  172 ++++
 mesh/mesh-db.h                         |  157 ----
 mesh/mesh.c                            |   15 +-
 mesh/mesh.h                            |    1 +
 mesh/model.c                           |   23 +-
 mesh/net.c                             |   26 +-
 mesh/node.c                            |  221 +++--
 mesh/node.h                            |   14 +-
 mesh/storage.c                         |  656 ---------------
 mesh/storage.h                         |   51 --
 mesh/util.c                            |   39 +-
 mesh/util.h                            |    1 +
 18 files changed, 1218 insertions(+), 1320 deletions(-)
 rename mesh/{mesh-db.c => mesh-config-json.c} (58%)
 create mode 100644 mesh/mesh-config.h
 delete mode 100644 mesh/mesh-db.h
 delete mode 100644 mesh/storage.c
 delete mode 100644 mesh/storage.h

-- 
2.21.0

