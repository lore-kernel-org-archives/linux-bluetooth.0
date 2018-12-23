Return-Path: <SRS0=7VLe=PA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B3AC43387
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 17:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D9A2087F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 17:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbeLWRyL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Dec 2018 12:54:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:62764 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbeLWRyL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Dec 2018 12:54:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2018 09:54:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,388,1539673200"; 
   d="scan'208";a="120576217"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga002.jf.intel.com with ESMTP; 23 Dec 2018 09:54:10 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.175]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.224]) with mapi id 14.03.0415.000;
 Sun, 23 Dec 2018 09:54:10 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Subject: RE: [PATCH BlueZ v5 00/30] Major rewrite for Multi-Node and DBus
Thread-Topic: [PATCH BlueZ v5 00/30] Major rewrite for Multi-Node and DBus
Thread-Index: AQHUl1I04aDFszVGl0Gt4dMlkKaVl6WMoOvA
Date:   Sun, 23 Dec 2018 17:54:09 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375D8E4C22@ORSMSX101.amr.corp.intel.com>
References: <20181219042016.25538-1-brian.gix@intel.com>
In-Reply-To: <20181219042016.25538-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDNlMThlNzktYWI3Yy00M2U3LTk0YjktZTBjMzlhYzg0ZTAxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVXdQdzBUY1NjTGw0TEs4UGpcL3VPRlVKTmUybWF6aHZ3SXY3SDYzTGdvc1ZsTzNXXC9wTFF6cFVHblJCYlRaRDRCIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel (et al.)

Given no further commenting, I intend to apply the Mesh patchset (version 5)
this coming Wednesday (26-Dec-2018).  Any objections should be made before then.

> -----Original Message-----
> From: Gix, Brian
> Sent: Tuesday, December 18, 2018 8:20 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: johan.hedberg@gmail.com; Stotland, Inga <inga.stotland@intel.com>;
> marcel@holtmann.org; Gix, Brian <brian.gix@intel.com>
> Subject: [PATCH BlueZ v5 00/30] Major rewrite for Multi-Node and DBus
> 
> The Mesh Daemon has been largely rewritten.
> 
> It matches the API in doc/mesh-api.txt, and is now accessible from non-
> privledged DBus clients.  The commandline version has been temporarily
> removed, although it will probably be re-added in the future. The dBus
> privledges need to be adjusted to allow for non-privledged access to
> Daemon interfaces.  We will shortly also be adding a Mesh Specific README
> and TODO file, but in the meantime, contact Brian and/or Inga with any
> questions.
> 
> v5 -- Address Marcel's v4 comments.
> 
> Brian Gix (12):
>   mesh: Staging for Mesh DBus API rewrite
>   mesh: Delete obsolete files
>   mesh: Rewrite Network layer for multiple nodes
>   mesh: Direction agnostic PB-Adv implementation
>   mesh: Acceptor side provisioning implementation
>   mesh: Initiator side provisioning implementation
>   mesh: Rewrite Controler interface for full init
>   mesh: Unchanged variables set to const
>   mesh: re-arrange provisioning for DBus API
>   mesh: restructure I/O for multiple nodes
>   mesh: Clean-up Comment style
>   mesh: Enable building Mesh Daemon
> 
> Inga Stotland (18):
>   mesh: Utilities for DBus support
>   mesh: Internal errors
>   mesh: Rewrite storage for Multiple Nodes
>   mesh: Rewrite Node handling for multiple nodes
>   mesh: centralize generic utilities
>   mesh: Re-architect for DBus API
>   mesh: Make config model handle multiple nodes
>   mesh: Multi node Config Server model
>   mesh: Restructure DB to support multiple nodes
>   mesh: restructure model services for multiple nodes
>   mesh: DBUS interface for Provisioning Agent
>   mesh: restructure App Key storage
>   mesh: Update for DBus API and multi-node support
>   mesh: Add default location for Mesh Node storage
>   mesh: Add structural changes for mesh
>   mesh: Sample Provisioning Agent
>   mesh: Sample On/Off Client and Server
>   mesh: Sample Mesh Joiner (provision acceptor)
> 
>  .gitignore                   |    1 -
>  Makefile.mesh                |   19 +-
>  configure.ac                 |    3 +
>  mesh/agent.c                 |  664 +++++++++++++++++----
>  mesh/agent.h                 |   68 ++-
>  mesh/agent.py                |   40 ++
>  mesh/appkey.c                |   17 +-
>  mesh/btmesh.c                |  181 ------
>  mesh/cfgmod-server.c         |  173 +++---
>  mesh/cfgmod.h                |    2 +-
>  mesh/config/composition.json |   44 --
>  mesh/dbus.c                  |  151 +++++
>  mesh/dbus.h                  |   34 ++
>  mesh/display.c               |   64 --
>  mesh/error.h                 |   35 ++
>  mesh/example-onoff-client    |  288 +++++++++
>  mesh/example-onoff-server    |  365 ++++++++++++
>  mesh/friend.c                |   76 +--
>  mesh/main.c                  |   73 ++-
>  mesh/mesh-db.c               |  454 +++++++++-----
>  mesh/mesh-db.h               |    6 +-
>  mesh/mesh-io-api.h           |    2 +-
>  mesh/mesh-io-generic.c       |  149 ++++-
>  mesh/mesh-io.c               |    3 +-
>  mesh/mesh-io.h               |    3 +-
>  mesh/mesh.c                  |  624 +++++++++++++++-----
>  mesh/mesh.h                  |   27 +-
>  mesh/model.c                 |  811 +++++++++++++++++--------
>  mesh/model.h                 |   66 ++-
>  mesh/net.c                   |  293 +++------
>  mesh/net.h                   |   31 +-
>  mesh/node.c                  | 1338 +++++++++++++++++++++++++++++++++++--
> -----
>  mesh/node.h                  |   42 +-
>  mesh/pb-adv.c                |  444 ++++++++++++++
>  mesh/{display.h => pb-adv.h} |   13 +-
>  mesh/prov-acceptor.c         |  684 +++++++++++++++++++++
>  mesh/prov-initiator.c        |  641 ++++++++++++++++++++
>  mesh/prov.c                  |  722 -----------------------
>  mesh/prov.h                  |   14 +-
>  mesh/provision.c             | 1162 ------------------------------------
>  mesh/provision.h             |  112 +++-
>  mesh/storage.c               |  570 ++++++++----------
>  mesh/storage.h               |   39 +-
>  mesh/test-join               |  408 +++++++++++++
>  mesh/util.c                  |   26 +
>  mesh/util.h                  |    1 +
>  46 files changed, 7096 insertions(+), 3887 deletions(-)  create mode 100755
> mesh/agent.py  delete mode 100644 mesh/btmesh.c  delete mode 100644
> mesh/config/composition.json  create mode 100644 mesh/dbus.c  create
> mode 100644 mesh/dbus.h  delete mode 100644 mesh/display.c  create
> mode 100644 mesh/error.h  create mode 100644 mesh/example-onoff-client
> create mode 100644 mesh/example-onoff-server  create mode 100644
> mesh/pb-adv.c  rename mesh/{display.h => pb-adv.h} (71%)  create mode
> 100644 mesh/prov-acceptor.c  create mode 100644 mesh/prov-initiator.c
> delete mode 100644 mesh/prov.c  delete mode 100644 mesh/provision.c
> create mode 100644 mesh/test-join
> 
> --
> 2.14.5

