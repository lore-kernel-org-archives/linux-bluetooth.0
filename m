Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970C6C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6286121871
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeLSEU0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:20:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:30645 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbeLSEU0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 23:20:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 20:20:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,371,1539673200"; 
   d="scan'208";a="99820019"
Received: from bgix-dell-lap.sea.intel.com ([10.252.192.41])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2018 20:20:25 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v5 00/30] Major rewrite for Multi-Node and DBus
Date:   Tue, 18 Dec 2018 20:19:46 -0800
Message-Id: <20181219042016.25538-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Mesh Daemon has been largely rewritten.

It matches the API in doc/mesh-api.txt, and is now accessible
from non-privledged DBus clients.  The commandline version has
been temporarily removed, although it will probably be re-added
in the future. The dBus privledges need to be adjusted to allow
for non-privledged access to Daemon interfaces.  We will shortly
also be adding a Mesh Specific README and TODO file, but in
the meantime, contact Brian and/or Inga with any questions.

v5 -- Address Marcel's v4 comments.

Brian Gix (12):
  mesh: Staging for Mesh DBus API rewrite
  mesh: Delete obsolete files
  mesh: Rewrite Network layer for multiple nodes
  mesh: Direction agnostic PB-Adv implementation
  mesh: Acceptor side provisioning implementation
  mesh: Initiator side provisioning implementation
  mesh: Rewrite Controler interface for full init
  mesh: Unchanged variables set to const
  mesh: re-arrange provisioning for DBus API
  mesh: restructure I/O for multiple nodes
  mesh: Clean-up Comment style
  mesh: Enable building Mesh Daemon

Inga Stotland (18):
  mesh: Utilities for DBus support
  mesh: Internal errors
  mesh: Rewrite storage for Multiple Nodes
  mesh: Rewrite Node handling for multiple nodes
  mesh: centralize generic utilities
  mesh: Re-architect for DBus API
  mesh: Make config model handle multiple nodes
  mesh: Multi node Config Server model
  mesh: Restructure DB to support multiple nodes
  mesh: restructure model services for multiple nodes
  mesh: DBUS interface for Provisioning Agent
  mesh: restructure App Key storage
  mesh: Update for DBus API and multi-node support
  mesh: Add default location for Mesh Node storage
  mesh: Add structural changes for mesh
  mesh: Sample Provisioning Agent
  mesh: Sample On/Off Client and Server
  mesh: Sample Mesh Joiner (provision acceptor)

 .gitignore                   |    1 -
 Makefile.mesh                |   19 +-
 configure.ac                 |    3 +
 mesh/agent.c                 |  664 +++++++++++++++++----
 mesh/agent.h                 |   68 ++-
 mesh/agent.py                |   40 ++
 mesh/appkey.c                |   17 +-
 mesh/btmesh.c                |  181 ------
 mesh/cfgmod-server.c         |  173 +++---
 mesh/cfgmod.h                |    2 +-
 mesh/config/composition.json |   44 --
 mesh/dbus.c                  |  151 +++++
 mesh/dbus.h                  |   34 ++
 mesh/display.c               |   64 --
 mesh/error.h                 |   35 ++
 mesh/example-onoff-client    |  288 +++++++++
 mesh/example-onoff-server    |  365 ++++++++++++
 mesh/friend.c                |   76 +--
 mesh/main.c                  |   73 ++-
 mesh/mesh-db.c               |  454 +++++++++-----
 mesh/mesh-db.h               |    6 +-
 mesh/mesh-io-api.h           |    2 +-
 mesh/mesh-io-generic.c       |  149 ++++-
 mesh/mesh-io.c               |    3 +-
 mesh/mesh-io.h               |    3 +-
 mesh/mesh.c                  |  624 +++++++++++++++-----
 mesh/mesh.h                  |   27 +-
 mesh/model.c                 |  811 +++++++++++++++++--------
 mesh/model.h                 |   66 ++-
 mesh/net.c                   |  293 +++------
 mesh/net.h                   |   31 +-
 mesh/node.c                  | 1338 +++++++++++++++++++++++++++++++++++-------
 mesh/node.h                  |   42 +-
 mesh/pb-adv.c                |  444 ++++++++++++++
 mesh/{display.h => pb-adv.h} |   13 +-
 mesh/prov-acceptor.c         |  684 +++++++++++++++++++++
 mesh/prov-initiator.c        |  641 ++++++++++++++++++++
 mesh/prov.c                  |  722 -----------------------
 mesh/prov.h                  |   14 +-
 mesh/provision.c             | 1162 ------------------------------------
 mesh/provision.h             |  112 +++-
 mesh/storage.c               |  570 ++++++++----------
 mesh/storage.h               |   39 +-
 mesh/test-join               |  408 +++++++++++++
 mesh/util.c                  |   26 +
 mesh/util.h                  |    1 +
 46 files changed, 7096 insertions(+), 3887 deletions(-)
 create mode 100755 mesh/agent.py
 delete mode 100644 mesh/btmesh.c
 delete mode 100644 mesh/config/composition.json
 create mode 100644 mesh/dbus.c
 create mode 100644 mesh/dbus.h
 delete mode 100644 mesh/display.c
 create mode 100644 mesh/error.h
 create mode 100644 mesh/example-onoff-client
 create mode 100644 mesh/example-onoff-server
 create mode 100644 mesh/pb-adv.c
 rename mesh/{display.h => pb-adv.h} (71%)
 create mode 100644 mesh/prov-acceptor.c
 create mode 100644 mesh/prov-initiator.c
 delete mode 100644 mesh/prov.c
 delete mode 100644 mesh/provision.c
 create mode 100644 mesh/test-join

-- 
2.14.5

