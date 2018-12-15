Return-Path: <SRS0=1Za/=OY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0054C43387
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Dec 2018 00:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19F8206C0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Dec 2018 00:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeLOA02 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:26:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:22245 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbeLOA01 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Dec 2018 19:26:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 16:26:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,355,1539673200"; 
   d="scan'208";a="109640267"
Received: from bgix-dell-lap.sea.intel.com ([10.251.138.67])
  by fmsmga008.fm.intel.com with ESMTP; 14 Dec 2018 16:26:27 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v3 00/30] Major rewrite for Multi-Node and DBus
Date:   Fri, 14 Dec 2018 16:25:54 -0800
Message-Id: <20181215002624.9313-1-brian.gix@intel.com>
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

v3 -- distcheck and pedantic styleguide fixes



Brian Gix (12):
  mesh: Staging for Mesh DBus API rewrite
  mesh: Delete obsolete files
  mesh: Rewite Network layer for multiple nodes
  mesh: Direction agnostic PB-Adv implimentation
  mesh: Acceptor side provisioning implimentation
  mesh: Initiator side provisioning implimentation
  mesh: Rewrite Controler interface for full init
  mesh: Unchanged variables set to const
  mesh: re-arrange provisioning for DBus API
  mesh: restructure I/O for multiple nodes
  mesh: Clean-up Comment style
  mesh: Enable building Mesh Daemon

Inga Stotland (18):
  mesh: Utilities for DBus support
  mesh: Internal errors
  mesh: Re-write storage for Multiple Nodes
  mesh: Rewrite Node handling for multiple nodes
  mesh: centralize generic utilities
  mesh: Re-architect for DBus API
  mesh: Make config model handle multiple nodes
  mesh: Multi node Config Server model
  mesh: Restrusture DB to support multiple nodes
  mesh: restructure model services for multiple nodes
  mesh: DBUS interface for Provisioning Agent
  mesh: restructure App Key storage
  mesh: Update for DBus API and multi-node support
  mesh: Add default location for Mesh Node storage
  mesh: Add structural changes for mesh
  mesh: Sample Provisioning Agent
  mesh: Sample On/Off Client and Server
  mesh: Sample Mesh Joiner (provision acceptor)

 Makefile.mesh                  |   26 +-
 configure.ac                   |    5 +
 mesh/agent.c                   |  665 ++++++++++++++++----
 mesh/agent.h                   |   71 ++-
 mesh/appkey.c                  |   17 +-
 mesh/cfgmod-server.c           |  173 +++---
 mesh/cfgmod.h                  |    2 +-
 mesh/config/composition.json   |   44 --
 mesh/dbus.c                    |  181 ++++++
 mesh/dbus.h                    |   40 ++
 mesh/display.c                 |   64 --
 mesh/error.h                   |   35 ++
 mesh/friend.c                  |   76 +--
 mesh/main.c                    |   73 ++-
 mesh/mesh-db.c                 |  454 +++++++++-----
 mesh/mesh-db.h                 |    6 +-
 mesh/mesh-io-api.h             |    2 +-
 mesh/mesh-io-generic.c         |  149 ++++-
 mesh/mesh-io.c                 |    3 +-
 mesh/mesh-io.h                 |    3 +-
 mesh/mesh.c                    |  625 ++++++++++++++-----
 mesh/mesh.h                    |   27 +-
 mesh/model.c                   |  811 +++++++++++++++++-------
 mesh/model.h                   |   66 +-
 mesh/net.c                     |  293 +++------
 mesh/net.h                     |   31 +-
 mesh/node.c                    | 1338 +++++++++++++++++++++++++++++++++-------
 mesh/node.h                    |   42 +-
 mesh/pb-adv.c                  |  444 +++++++++++++
 mesh/{display.h => pb-adv.h}   |   13 +-
 mesh/prov-acceptor.c           |  711 +++++++++++++++++++++
 mesh/prov-initiator.c          |  650 +++++++++++++++++++
 mesh/prov.c                    |  722 ----------------------
 mesh/prov.h                    |   14 +-
 mesh/provision.c               | 1162 ----------------------------------
 mesh/provision.h               |  112 +++-
 mesh/storage.c                 |  570 ++++++++---------
 mesh/storage.h                 |   39 +-
 mesh/test/agent.py             |   40 ++
 mesh/test/example-onoff-client |  288 +++++++++
 mesh/test/example-onoff-server |  365 +++++++++++
 mesh/test/test-join            |  408 ++++++++++++
 mesh/util.c                    |   26 +
 mesh/util.h                    |    1 +
 44 files changed, 7188 insertions(+), 3699 deletions(-)
 delete mode 100644 mesh/config/composition.json
 create mode 100644 mesh/dbus.c
 create mode 100644 mesh/dbus.h
 delete mode 100644 mesh/display.c
 create mode 100644 mesh/error.h
 create mode 100644 mesh/pb-adv.c
 rename mesh/{display.h => pb-adv.h} (71%)
 create mode 100644 mesh/prov-acceptor.c
 create mode 100644 mesh/prov-initiator.c
 delete mode 100644 mesh/prov.c
 delete mode 100644 mesh/provision.c
 create mode 100755 mesh/test/agent.py
 create mode 100644 mesh/test/example-onoff-client
 create mode 100644 mesh/test/example-onoff-server
 create mode 100644 mesh/test/test-join

-- 
2.14.5

