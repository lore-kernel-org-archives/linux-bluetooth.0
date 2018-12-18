Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81588C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 23:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE24217D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 23:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeLRXAb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:00:31 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41977 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeLRXAa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 18:00:30 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id 18361CEE81;
        Wed, 19 Dec 2018 00:08:08 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ v4 00/30] Major rewrite for Multi-Node and DBus
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181218223139.8041-1-brian.gix@intel.com>
Date:   Wed, 19 Dec 2018 00:00:28 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        inga.stotland@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <9BBB0DA5-534C-4A9C-BFAF-31F5F0AD3EE6@holtmann.org>
References: <20181218223139.8041-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

> The Mesh Daemon has been largely rewritten.
> 
> It matches the API in doc/mesh-api.txt, and is now accessible
> from non-privledged DBus clients.  The commandline version has
> been temporarily removed, although it will probably be re-added
> in the future. The dBus privledges need to be adjusted to allow
> for non-privledged access to Daemon interfaces.  We will shortly
> also be adding a Mesh Specific README and TODO file, but in
> the meantime, contact Brian and/or Inga with any questions.
> 
> v4 -- Remove all trace of foreground btmesh app. It is obsolete, and
> adds no functionality not also present in the meshd executable.
> 
> Brian Gix (12):
>  mesh: Staging for Mesh DBus API rewrite
>  mesh: Delete obsolete files
>  mesh: Rewite Network layer for multiple nodes
>  mesh: Direction agnostic PB-Adv implimentation
>  mesh: Acceptor side provisioning implimentation
>  mesh: Initiator side provisioning implimentation
>  mesh: Rewrite Controler interface for full init
>  mesh: Unchanged variables set to const
>  mesh: re-arrange provisioning for DBus API
>  mesh: restructure I/O for multiple nodes
>  mesh: Clean-up Comment style
>  mesh: Enable building Mesh Daemon
> 
> Inga Stotland (18):
>  mesh: Utilities for DBus support
>  mesh: Internal errors
>  mesh: Re-write storage for Multiple Nodes
>  mesh: Rewrite Node handling for multiple nodes
>  mesh: centralize generic utilities
>  mesh: Re-architect for DBus API
>  mesh: Make config model handle multiple nodes
>  mesh: Multi node Config Server model
>  mesh: Restrusture DB to support multiple nodes
>  mesh: restructure model services for multiple nodes
>  mesh: DBUS interface for Provisioning Agent
>  mesh: restructure App Key storage
>  mesh: Update for DBus API and multi-node support
>  mesh: Add default location for Mesh Node storage
>  mesh: Add structural changes for mesh
>  mesh: Sample Provisioning Agent
>  mesh: Sample On/Off Client and Server
>  mesh: Sample Mesh Joiner (provision acceptor)
> 
> Makefile.mesh                  |   19 +-
> configure.ac                   |    5 +
> mesh/agent.c                   |  665 ++++++++++++++++----
> mesh/agent.h                   |   71 ++-
> mesh/appkey.c                  |   17 +-
> mesh/btmesh.c                  |  181 ------
> mesh/cfgmod-server.c           |  173 +++---
> mesh/cfgmod.h                  |    2 +-
> mesh/config/composition.json   |   44 —

I have no idea why we would create a directory config here. Put the json files in $(top_srcdir) and be done with it.

> mesh/dbus.c                    |  181 ++++++
> mesh/dbus.h                    |   40 ++
> mesh/display.c                 |   64 --
> mesh/error.h                   |   35 ++
> mesh/friend.c                  |   76 +--
> mesh/main.c                    |   73 ++-
> mesh/mesh-db.c                 |  454 +++++++++-----
> mesh/mesh-db.h                 |    6 +-
> mesh/mesh-io-api.h             |    2 +-
> mesh/mesh-io-generic.c         |  149 ++++-
> mesh/mesh-io.c                 |    3 +-
> mesh/mesh-io.h                 |    3 +-
> mesh/mesh.c                    |  625 ++++++++++++++-----
> mesh/mesh.h                    |   27 +-
> mesh/model.c                   |  811 +++++++++++++++++-------
> mesh/model.h                   |   66 +-
> mesh/net.c                     |  293 +++------
> mesh/net.h                     |   31 +-
> mesh/node.c                    | 1338 +++++++++++++++++++++++++++++++++-------
> mesh/node.h                    |   42 +-
> mesh/pb-adv.c                  |  444 +++++++++++++
> mesh/{display.h => pb-adv.h}   |   13 +-
> mesh/prov-acceptor.c           |  711 +++++++++++++++++++++
> mesh/prov-initiator.c          |  650 +++++++++++++++++++
> mesh/prov.c                    |  722 ----------------------
> mesh/prov.h                    |   14 +-
> mesh/provision.c               | 1162 ----------------------------------
> mesh/provision.h               |  112 +++-
> mesh/storage.c                 |  570 ++++++++---------
> mesh/storage.h                 |   39 +-
> mesh/test/agent.py             |   40 ++
> mesh/test/example-onoff-client |  288 +++++++++
> mesh/test/example-onoff-server |  365 +++++++++++
> mesh/test/test-join            |  408 ++++++++++++

Can we please not doing this kind of nesting of directories. Use the $(top_srcdir)/test for this.
> mesh/util.c                    |   26 +
> mesh/util.h                    |    1 +
> 45 files changed, 7177 insertions(+), 3884 deletions(-)
> delete mode 100644 mesh/btmesh.c
> delete mode 100644 mesh/config/composition.json
> create mode 100644 mesh/dbus.c
> create mode 100644 mesh/dbus.h
> delete mode 100644 mesh/display.c
> create mode 100644 mesh/error.h
> create mode 100644 mesh/pb-adv.c
> rename mesh/{display.h => pb-adv.h} (71%)
> create mode 100644 mesh/prov-acceptor.c
> create mode 100644 mesh/prov-initiator.c
> delete mode 100644 mesh/prov.c
> delete mode 100644 mesh/provision.c
> create mode 100755 mesh/test/agent.py
> create mode 100644 mesh/test/example-onoff-client
> create mode 100644 mesh/test/example-onoff-server
> create mode 100644 mesh/test/test-join

Regards

Marcel

