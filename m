Return-Path: <SRS0=+lf3=PF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E676CC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF267217F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeL1WHx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:07:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:19949 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbeL1WHx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Dec 2018 17:07:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2018 14:07:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,411,1539673200"; 
   d="scan'208";a="113968676"
Received: from bgix-dell-lap.sea.intel.com ([10.252.140.14])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2018 14:07:52 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v6 00/26] Major rewrite for Multi-Node and DBus
Date:   Fri, 28 Dec 2018 14:07:19 -0800
Message-Id: <20181228220745.25147-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Mesh Daemon has been largely rewritten.

It matches the API in doc/mesh-api.txt, and is now accessible from non-
privledged DBus clients.  The commandline version has been temporarily
removed, although it will probably be re-added in the future. The dBus
privledges need to be adjusted to allow for non-privledged access to
Daemon interfaces.  We will shortly also be adding a Mesh Specific README
and TODO file, but in the meantime, contact Brian and/or Inga with any
questions.

v6 -- Address Marcel's v5 comments, including cleanup, and unstacking
include files.  There was also some compression of commits, where little
was being actually done.  Other big difference with patch set is a more
verbose explanation of non-trivial commits, particularily where functionality
was removed (or deleted) in favor of rewrites in other (mostly new) files.
This is especially true of Provisioning which has been largely rewritten for
both readability and for focus.

Tested on TIP of upstream/master as of 28-Dec-2018, on Fedora 27, 28 and 29,
with both ./bootstrap-configure, and distcheck.

Brian Gix (10):
  mesh: Structural changes for mesh
  mesh: Rewrite Network layer for multiple nodes
  mesh: Direction agnostic PB-ADV implementation
  mesh: Acceptor side provisioning implementation
  mesh: Initiator side provisioning implementation
  mesh: Rewrite Controler interface for full init
  mesh: Unchanged variables set to const
  mesh: re-arrange provisioning for DBus API
  mesh: restructure I/O for multiple nodes
  mesh: Clean-up Comment style

Inga Stotland (16):
  mesh: Utilities for DBus support
  mesh: Internal errors
  mesh: Rewrite storage for Multiple Nodes
  mesh: Rewrite Node handling for multiple nodes
  mesh: Hex-String manipulation, and debug logging
  mesh: Re-architect for DBus API
  mesh: Multi node Config Server model
  mesh: Restructure DB to support multiple nodes
  mesh: Restructure model services for multiple nodes
  mesh: DBUS interface for Provisioning Agent
  mesh: restructure App Key storage
  mesh: Update for DBus API and multi-node support
  mesh: Add default location for Mesh Node storage
  mesh: Sample Provisioning Agent
  mesh: Sample On/Off Client and Server
  mesh: Sample Mesh Joiner (provision acceptor)

 .gitignore                   |    1 -
 Makefile.mesh                |   19 +-
 configure.ac                 |    3 +
 mesh/agent.c                 |  665 +++++++++++++++++----
 mesh/agent.h                 |   69 ++-
 mesh/appkey.c                |   19 +-
 mesh/appkey.h                |    1 -
 mesh/btmesh.c                |  181 ------
 mesh/cfgmod-server.c         |  179 +++---
 mesh/cfgmod.h                |    3 +-
 mesh/config/composition.json |   44 --
 mesh/dbus.c                  |  151 +++++
 mesh/dbus.h                  |   33 ++
 mesh/display.c               |   64 --
 mesh/error.h                 |   34 ++
 mesh/friend.c                |   76 +--
 mesh/main.c                  |   75 ++-
 mesh/mesh-db.c               |  456 +++++++++-----
 mesh/mesh-db.h               |    9 +-
 mesh/mesh-io-api.h           |    2 +-
 mesh/mesh-io-generic.c       |  149 ++++-
 mesh/mesh-io.c               |    3 +-
 mesh/mesh-io.h               |    3 +-
 mesh/mesh.c                  |  626 +++++++++++++++-----
 mesh/mesh.h                  |   28 +-
 mesh/model.c                 |  813 +++++++++++++++++--------
 mesh/model.h                 |   69 ++-
 mesh/net.c                   |  294 +++------
 mesh/net.h                   |   34 +-
 mesh/node.c                  | 1340 +++++++++++++++++++++++++++++++++++-------
 mesh/node.h                  |   43 +-
 mesh/pb-adv.c                |  444 ++++++++++++++
 mesh/{display.h => pb-adv.h} |   13 +-
 mesh/prov-acceptor.c         |  684 +++++++++++++++++++++
 mesh/prov-initiator.c        |  641 ++++++++++++++++++++
 mesh/prov.c                  |  722 -----------------------
 mesh/prov.h                  |   14 +-
 mesh/provision.c             | 1162 ------------------------------------
 mesh/provision.h             |  112 +++-
 mesh/storage.c               |  571 ++++++++----------
 mesh/storage.h               |   38 +-
 mesh/util.c                  |   27 +-
 mesh/util.h                  |    2 +-
 test/agent.py                |   40 ++
 test/example-onoff-client    |  288 +++++++++
 test/example-onoff-server    |  365 ++++++++++++
 test/test-join               |  408 +++++++++++++
 47 files changed, 7103 insertions(+), 3914 deletions(-)
 delete mode 100644 mesh/btmesh.c
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
 create mode 100755 test/agent.py
 create mode 100644 test/example-onoff-client
 create mode 100644 test/example-onoff-server
 create mode 100644 test/test-join

-- 
2.14.5

