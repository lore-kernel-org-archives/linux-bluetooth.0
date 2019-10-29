Return-Path: <SRS0=CsyS=YW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5D7CA9EAE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Oct 2019 20:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C82C2087F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Oct 2019 20:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfJ2Uk4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:40:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:15193 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfJ2Uk4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Oct 2019 16:40:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 13:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; 
   d="scan'208";a="401277148"
Received: from ingas-nuc1.sea.intel.com ([10.255.229.102])
  by fmsmga006.fm.intel.com with ESMTP; 29 Oct 2019 13:40:55 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 00/10] Mesh provisioning and configuration tool
Date:   Tue, 29 Oct 2019 13:40:44 -0700
Message-Id: <20191029204054.30599-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set adds a mesh-cfgclient tool that allows to create
mesh networks operating over advertising (PB-ADV) provisioning
bearer. The toolimplements support for:
 - creating of the inital "pcrovisioner" node with the initial network key
 - adding/removing network and application keys to the network
 - provisioning remote devices into mesh network
 - configuring of the provisioned nodes (Config Model Client operations)

Network configuration is saved in JSON format file.
Disclaimer: the storage is work in progress and is not fully implemented.

Also, some functionality overlaps with meshctl tool (GATT based mesh
network provisioning and configuration tool). For the time being, these
two tools are separate and coexist side by side. Eventually, additional
work needs to be done to eleiminate overlapping areas and potentially
merge the tools. Currently, meshctl supplemenal files are moved to
tools/mesh-gatt


Inga Stotland (10):
  tools/mesh: Remove extra dependencies from agent.c
  tools/mesh: Move meshctl specific files to mesh-gatt
  tools: Add mesh-cfgclient tool
  tools/mesh: move remote node processing to a separate file
  tools/mesh-cfgclient: Commands for Management iface methods
  tools/mesh-cfgclient: Add config menu key commands
  tools/mesh-cfgclient: Add timeout for expected response
  tools/mesh-cfgclient: Command line option for config
  tools/mesh: add initial support for config storage
  tools/mesh-cfgclient: Add README file

 .gitignore                                |    1 +
 Makefile.tools                            |   46 +-
 tools/mesh-cfgclient.c                    | 1861 +++++++++++++++++++++
 tools/mesh-gatt/README                    |   43 +
 tools/{mesh => mesh-gatt}/config-client.c |   14 +-
 tools/{mesh => mesh-gatt}/config-server.c |   14 +-
 tools/{mesh => mesh-gatt}/crypto.c        |    5 +-
 tools/{mesh => mesh-gatt}/crypto.h        |    0
 tools/{mesh => mesh-gatt}/gatt.c          |   11 +-
 tools/{mesh => mesh-gatt}/gatt.h          |    0
 tools/mesh-gatt/keys.h                    |   39 +
 tools/{mesh => mesh-gatt}/local_node.json |    0
 tools/{mesh => mesh-gatt}/mesh-net.h      |    0
 tools/{mesh => mesh-gatt}/net.c           |   16 +-
 tools/{mesh => mesh-gatt}/net.h           |    0
 tools/{mesh => mesh-gatt}/node.c          |   16 +-
 tools/{mesh => mesh-gatt}/node.h          |    0
 tools/{mesh => mesh-gatt}/onoff-model.c   |   15 +-
 tools/{mesh => mesh-gatt}/onoff-model.h   |    0
 tools/{mesh => mesh-gatt}/prov-db.c       |   14 +-
 tools/{mesh => mesh-gatt}/prov-db.h       |    0
 tools/{mesh => mesh-gatt}/prov.c          |   16 +-
 tools/{mesh => mesh-gatt}/prov.h          |    0
 tools/{mesh => mesh-gatt}/prov_db.json    |    0
 tools/mesh-gatt/util.c                    |  220 +++
 tools/mesh-gatt/util.h                    |   41 +
 tools/mesh/README                         |   43 +-
 tools/mesh/agent.c                        |   32 +-
 tools/mesh/cfgcli.c                       | 1378 +++++++++++++++
 tools/mesh/cfgcli.h                       |   25 +
 tools/mesh/config-model.h                 |    3 +-
 tools/mesh/keys.c                         |  166 ++
 tools/mesh/keys.h                         |   27 +-
 tools/mesh/mesh-db.c                      |  742 ++++++++
 tools/mesh/mesh-db.h                      |   54 +
 tools/mesh/model.h                        |   63 +
 tools/mesh/remote.c                       |  229 +++
 tools/mesh/remote.h                       |   27 +
 tools/mesh/util.c                         |  107 +-
 tools/mesh/util.h                         |   14 +-
 tools/meshctl.c                           |   22 +-
 41 files changed, 5073 insertions(+), 231 deletions(-)
 create mode 100644 tools/mesh-cfgclient.c
 create mode 100644 tools/mesh-gatt/README
 rename tools/{mesh => mesh-gatt}/config-client.c (99%)
 rename tools/{mesh => mesh-gatt}/config-server.c (94%)
 rename tools/{mesh => mesh-gatt}/crypto.c (99%)
 rename tools/{mesh => mesh-gatt}/crypto.h (100%)
 rename tools/{mesh => mesh-gatt}/gatt.c (98%)
 rename tools/{mesh => mesh-gatt}/gatt.h (100%)
 create mode 100644 tools/mesh-gatt/keys.h
 rename tools/{mesh => mesh-gatt}/local_node.json (100%)
 rename tools/{mesh => mesh-gatt}/mesh-net.h (100%)
 rename tools/{mesh => mesh-gatt}/net.c (99%)
 rename tools/{mesh => mesh-gatt}/net.h (100%)
 rename tools/{mesh => mesh-gatt}/node.c (98%)
 rename tools/{mesh => mesh-gatt}/node.h (100%)
 rename tools/{mesh => mesh-gatt}/onoff-model.c (96%)
 rename tools/{mesh => mesh-gatt}/onoff-model.h (100%)
 rename tools/{mesh => mesh-gatt}/prov-db.c (99%)
 rename tools/{mesh => mesh-gatt}/prov-db.h (100%)
 rename tools/{mesh => mesh-gatt}/prov.c (98%)
 rename tools/{mesh => mesh-gatt}/prov.h (100%)
 rename tools/{mesh => mesh-gatt}/prov_db.json (100%)
 create mode 100644 tools/mesh-gatt/util.c
 create mode 100644 tools/mesh-gatt/util.h
 create mode 100644 tools/mesh/cfgcli.c
 create mode 100644 tools/mesh/cfgcli.h
 create mode 100644 tools/mesh/keys.c
 create mode 100644 tools/mesh/mesh-db.c
 create mode 100644 tools/mesh/mesh-db.h
 create mode 100644 tools/mesh/model.h
 create mode 100644 tools/mesh/remote.c
 create mode 100644 tools/mesh/remote.h

-- 
2.21.0

