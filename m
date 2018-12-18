Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EFDC43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 09:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF25217D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 09:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="aGo+eJW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeLRJOt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:14:49 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:37777 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeLRJOt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 04:14:49 -0500
Received: by mail-lj1-f178.google.com with SMTP id t18-v6so1529561ljd.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Dec 2018 01:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LJkbpz5v+gtKYCGtsS2hY5L6kho50Xr31o4N0xV1z0Q=;
        b=aGo+eJW8xyqGhoDyF8dV1urYJTWs6LCcUvEfndM2Ltd/X7S6alSdsfO2qE9wRdLxfD
         LAdprC5TxGK7jRRW0i351vn1nnFW+APPAnVbItg+aRhXMVZzUHvCCdmxBYZXgjIH0p8C
         HFyqq8HpC+r1qgLOdQQjJd52d2WEcW1ogdgXAQHvbfZowwkKMbV0cih69SCnaV5hTN+g
         ObHlF5uSG2GV04X4MaIbT6hzuZDuyazusGJNZJDxnZQdj5LI6ayf7V1D+ljBq9Pjmmil
         Vbnq+KQaOBixWY3t8KwBWSWG/Z+fSft2pVH13ZnaC4UtKOduKOtsEzEw76sxDGt/cb9G
         NxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LJkbpz5v+gtKYCGtsS2hY5L6kho50Xr31o4N0xV1z0Q=;
        b=NChgcU8MzlZLAZolodDy8PrA+97ZbmorcEPfqmKKEpCNLqAiff+Gazjf+awN2nqbQo
         VF8h08hX8IKaAEXYUFEUhZDKfErlJy7jK/8NZfpAX7ZYNzMvrqc1AX15/V+QniIOEihc
         BWD4L+d3VhR1akAJC+amtrXNA1lWTiUIxavzI3hYCL8gLe8ORemfpxBcnhqNAhRRWXSH
         cXOavplO4taF7M0GAuTevQ7K3/O5cscqwSOlImzoOtG8r6EexpG1Rxa0oYFRdC7oLtDe
         ApdwJc5aLbsnIgx4JybUGUYl+QfJPojfHR1AZDU0BUxoPwOvFtHfHENpqknCREpBDi7/
         heiA==
X-Gm-Message-State: AA+aEWbJ1/XalI4M7ryDnw5x1Ccy8B2rDQURqpcfrLO+Z8X+ve0s1aFE
        P1P63C6X8eTjRjorho6Qsnit7Q==
X-Google-Smtp-Source: AFSGD/UnHIiUjXOfZU9OX3hq+cIZYkbgjN8Yl71XvoHUMFVcf4Vl0LhVcyzWMEjjVfA/cGnRPXexUQ==
X-Received: by 2002:a2e:630a:: with SMTP id x10-v6mr9096965ljb.11.1545124485913;
        Tue, 18 Dec 2018 01:14:45 -0800 (PST)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id i75sm3175326lfb.58.2018.12.18.01.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 01:14:45 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Subject: Re: [PATCH BlueZ v3 00/30] Major rewrite for Multi-Node and DBus
Date:   Tue, 18 Dec 2018 10:14:43 +0100
Message-ID: <110368016.VWXbCARz0c@ix>
Organization: CODECOUP
In-Reply-To: <17761993.WvVeqkb5i9@ix>
References: <20181215002624.9313-1-brian.gix@intel.com> <DEBB0CAA2616974FAE35E4B560B9A4375D8E01AF@ORSMSX101.amr.corp.intel.com> <17761993.WvVeqkb5i9@ix>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tuesday, 18 December 2018 09:16:13 CET Szymon Janc wrote:
> Hi Brian,
> 
> On Monday, 17 December 2018 19:42:01 CET Gix, Brian wrote:
> > This patch-set has been applied upstream.
> 
> There is something wrong with Makefile.mesh
> 
> Makefile.am: installing './depcomp'
> parallel-tests: installing './test-driver'
> Makefile.mesh:31: warning: variable 'mesh_btmesh_LDADD' is defined but no
> program or
> Makefile.mesh:31: library has 'mesh_btmesh' as canonical name (possible
> typo) Makefile.am:306:   'Makefile.mesh' included from here
> Makefile.mesh:32: warning: variable 'mesh_btmesh_DEPENDENCIES' is defined
> but no program or
> Makefile.mesh:32: library has 'mesh_btmesh' as canonical name (possible
> typo) Makefile.am:306:   'Makefile.mesh' included from here
> 
> 
> Enabling commented out code (why is it commented out btw?) in Makefile.mesh
> stil results in:
> 
> Makefile.mesh:39: warning: mesh_btmesh_LDADD multiply defined in condition
> MESH ...
> Makefile.am:306:   'Makefile.mesh' included from here
> Makefile.mesh:31: ... 'mesh_btmesh_LDADD' previously defined here
> Makefile.am:306:   'Makefile.mesh' included from here
> 


This seems to fix warnign for me. Was ot on purpose that btmesh wasn't added 
to noinst ?


diff --git a/Makefile.mesh b/Makefile.mesh
index 5344fbb21..1b8adea7e 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -31,8 +31,8 @@ mesh_meshd_DEPENDENCIES = $(ell_dependencies)
 mesh_btmesh_LDADD = src/libshared-mainloop.la $(ell_ldadd) -lreadline -ljson-
c
 mesh_btmesh_DEPENDENCIES = $(ell_dependencies)
 
-#
-# noinst_PROGRAMS += mesh/btmesh
+noinst_PROGRAMS += mesh/btmesh
+
 #
 # mesh_btmesh_SOURCES = $(mesh_sources) \
 #                                              mesh/btmesh.c



> > > -----Original Message-----
> > > From: Gix, Brian
> > > Sent: Friday, December 14, 2018 4:26 PM
> > > To: linux-bluetooth@vger.kernel.org
> > > Cc: johan.hedberg@gmail.com; Stotland, Inga <inga.stotland@intel.com>;
> > > marcel@holtmann.org; Gix, Brian <brian.gix@intel.com>
> > > Subject: [PATCH BlueZ v3 00/30] Major rewrite for Multi-Node and DBus
> > > 
> > > The Mesh Daemon has been largely rewritten.
> > > 
> > > It matches the API in doc/mesh-api.txt, and is now accessible from non-
> > > privledged DBus clients.  The commandline version has been temporarily
> > > removed, although it will probably be re-added in the future. The dBus
> > > privledges need to be adjusted to allow for non-privledged access to
> > > Daemon interfaces.  We will shortly also be adding a Mesh Specific
> > > README
> > > and TODO file, but in the meantime, contact Brian and/or Inga with any
> > > questions.
> > > 
> > > v3 -- distcheck and pedantic styleguide fixes
> > > 
> > > Brian Gix (12):
> > >   mesh: Staging for Mesh DBus API rewrite
> > >   mesh: Delete obsolete files
> > >   mesh: Rewite Network layer for multiple nodes
> > >   mesh: Direction agnostic PB-Adv implimentation
> > >   mesh: Acceptor side provisioning implimentation
> > >   mesh: Initiator side provisioning implimentation
> > >   mesh: Rewrite Controler interface for full init
> > >   mesh: Unchanged variables set to const
> > >   mesh: re-arrange provisioning for DBus API
> > >   mesh: restructure I/O for multiple nodes
> > >   mesh: Clean-up Comment style
> > >   mesh: Enable building Mesh Daemon
> > > 
> > > Inga Stotland (18):
> > >   mesh: Utilities for DBus support
> > >   mesh: Internal errors
> > >   mesh: Re-write storage for Multiple Nodes
> > >   mesh: Rewrite Node handling for multiple nodes
> > >   mesh: centralize generic utilities
> > >   mesh: Re-architect for DBus API
> > >   mesh: Make config model handle multiple nodes
> > >   mesh: Multi node Config Server model
> > >   mesh: Restrusture DB to support multiple nodes
> > >   mesh: restructure model services for multiple nodes
> > >   mesh: DBUS interface for Provisioning Agent
> > >   mesh: restructure App Key storage
> > >   mesh: Update for DBus API and multi-node support
> > >   mesh: Add default location for Mesh Node storage
> > >   mesh: Add structural changes for mesh
> > >   mesh: Sample Provisioning Agent
> > >   mesh: Sample On/Off Client and Server
> > >   mesh: Sample Mesh Joiner (provision acceptor)
> > >  
> > >  Makefile.mesh                  |   26 +-
> > >  configure.ac                   |    5 +
> > >  mesh/agent.c                   |  665 ++++++++++++++++----
> > >  mesh/agent.h                   |   71 ++-
> > >  mesh/appkey.c                  |   17 +-
> > >  mesh/cfgmod-server.c           |  173 +++---
> > >  mesh/cfgmod.h                  |    2 +-
> > >  mesh/config/composition.json   |   44 --
> > >  mesh/dbus.c                    |  181 ++++++
> > >  mesh/dbus.h                    |   40 ++
> > >  mesh/display.c                 |   64 --
> > >  mesh/error.h                   |   35 ++
> > >  mesh/friend.c                  |   76 +--
> > >  mesh/main.c                    |   73 ++-
> > >  mesh/mesh-db.c                 |  454 +++++++++-----
> > >  mesh/mesh-db.h                 |    6 +-
> > >  mesh/mesh-io-api.h             |    2 +-
> > >  mesh/mesh-io-generic.c         |  149 ++++-
> > >  mesh/mesh-io.c                 |    3 +-
> > >  mesh/mesh-io.h                 |    3 +-
> > >  mesh/mesh.c                    |  625 ++++++++++++++-----
> > >  mesh/mesh.h                    |   27 +-
> > >  mesh/model.c                   |  811 +++++++++++++++++-------
> > >  mesh/model.h                   |   66 +-
> > >  mesh/net.c                     |  293 +++------
> > >  mesh/net.h                     |   31 +-
> > >  mesh/node.c                    | 1338
> > >  +++++++++++++++++++++++++++++++++----
> > > 
> > > ---
> > > 
> > >  mesh/node.h                    |   42 +-
> > >  mesh/pb-adv.c                  |  444 +++++++++++++
> > >  mesh/{display.h => pb-adv.h}   |   13 +-
> > >  mesh/prov-acceptor.c           |  711 +++++++++++++++++++++
> > >  mesh/prov-initiator.c          |  650 +++++++++++++++++++
> > >  mesh/prov.c                    |  722 ----------------------
> > >  mesh/prov.h                    |   14 +-
> > >  mesh/provision.c               | 1162
> > >  ----------------------------------
> > >  mesh/provision.h               |  112 +++-
> > >  mesh/storage.c                 |  570 ++++++++---------
> > >  mesh/storage.h                 |   39 +-
> > >  mesh/test/agent.py             |   40 ++
> > >  mesh/test/example-onoff-client |  288 +++++++++  mesh/test/example-
> > > 
> > > onoff-server |  365 +++++++++++
> > > 
> > >  mesh/test/test-join            |  408 ++++++++++++
> > >  mesh/util.c                    |   26 +
> > >  mesh/util.h                    |    1 +
> > >  44 files changed, 7188 insertions(+), 3699 deletions(-)  delete mode
> > >  100644
> > > 
> > > mesh/config/composition.json  create mode 100644 mesh/dbus.c  create
> > > mode 100644 mesh/dbus.h  delete mode 100644 mesh/display.c  create
> > > mode 100644 mesh/error.h  create mode 100644 mesh/pb-adv.c  rename
> > > mesh/{display.h => pb-adv.h} (71%)  create mode 100644 mesh/prov-
> > > acceptor.c  create mode 100644 mesh/prov-initiator.c  delete mode 100644
> > > mesh/prov.c  delete mode 100644 mesh/provision.c  create mode 100755
> > > mesh/test/agent.py  create mode 100644 mesh/test/example-onoff-client
> > > create mode 100644 mesh/test/example-onoff-server  create mode 100644
> > > mesh/test/test-join
> > > 
> > > --
> > > 2.14.5


-- 
pozdrawiam
Szymon Janc


