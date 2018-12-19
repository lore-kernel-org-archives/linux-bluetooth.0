Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426B0C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 13:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BB3214AE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 13:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="jfGd5lgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeLSNC7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:02:59 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:32830 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbeLSNC7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 08:02:59 -0500
Received: by mail-lf1-f46.google.com with SMTP id i26so14980619lfc.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Dec 2018 05:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIhhlc1TdtKyYzqCdvnot2Q14g7eMoDKhRKkqFHekmM=;
        b=jfGd5lgT1k/Nr/dTyB+WgnthpTb/8yIR67976Ht1aJ7oS05RR2RCK/jZyOJhg3aa/9
         Y/4dxMHjwFhOO0x0j1QF04VvG2bUJFhK8k8Py8RBbF33j4xktSM023fX5aYiePAIM0Ed
         iNPvs4FimFXjPJUY0vEQGs9cYGPxo5cda+6eoWCphLo/bieQQvcYewZ+HtVU/+a1n5oF
         fRcanN7geMvIsw2aS6vCNMrMh9XEIcryBGxxUWPwqwELUf17mbaI+rFrOE3CUxt1Jn4Y
         DVi7Dhkd+K3wjMeduCmv13F5jwATxPxWv0G/qQbUx0Kw8WvOmBfKN2kI93q2T4b2XAo9
         D4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iIhhlc1TdtKyYzqCdvnot2Q14g7eMoDKhRKkqFHekmM=;
        b=AJYzstPnRi8LRnxDGsEvOiQBIzdScNrT6Z1YxNFfN+Xuw3wDe3iHAIFzRThPRcQp9O
         26Mk2kwcWboL6VUpr4DWInWI71A2tipa/iS8zEvRNfmlX3Af16ZMNP++xNXeuvx3BKce
         hpgU+lcZqKlqQf2R6471Qm6kCzUifqpRB15o9Kozy4tSqZfISv9SMW9nc6OYbYAaHuL4
         uyoFI6yY6Dpgt4qZk2gjkFiQ3Fm0W0ji4xG1mxQONKekv/Po7XEV8DH7cX4wc1QflnmT
         YiaYfskLHY5/JPAMTctQiO8yVlAS+Co2a8Bx8246pypRscDRhVvzr/d6x7AhE6ifXWBi
         M+iA==
X-Gm-Message-State: AA+aEWZG9ZejAvPsqmKNJieTNnfdHrgeoWf13LWb3rSus9jYyIL5lmkI
        gDPH3Joutf3xll6ZEvnYf5QfUg==
X-Google-Smtp-Source: AFSGD/Vr+cEaEKsBF8y/BLpwARnJcKbzDP6PasET9h9hBDG1r7oIGtHh+AM06uOiEyIuVvEEMscB/g==
X-Received: by 2002:a19:a149:: with SMTP id k70mr12277712lfe.5.1545224576029;
        Wed, 19 Dec 2018 05:02:56 -0800 (PST)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id d2sm3879058lfg.16.2018.12.19.05.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 05:02:55 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Subject: Re: [PATCH BlueZ v3 00/30] Major rewrite for Multi-Node and DBus
Date:   Wed, 19 Dec 2018 14:02:53 +0100
Message-ID: <2494279.1ZcSzd4OGp@ix>
Organization: CODECOUP
In-Reply-To: <398288BA-8B31-4D3F-97CE-62E4CD683923@intel.com>
References: <20181215002624.9313-1-brian.gix@intel.com> <17761993.WvVeqkb5i9@ix> <398288BA-8B31-4D3F-97CE-62E4CD683923@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On Tuesday, 18 December 2018 16:08:12 CET Gix, Brian wrote:
> Hi Szymon,
>=20
> > On Dec 18, 2018, at 12:16 AM, Szymon Janc <szymon.janc@codecoup.pl> wro=
te:
> >=20
> > Hi Brian,
> >=20
> >> On Monday, 17 December 2018 19:42:01 CET Gix, Brian wrote:
> >> This patch-set has been applied upstream.
> >=20
> > There is something wrong with Makefile.mesh
>=20
> This was tested by us on Fedora 27 and 28, without issues.
>=20
> What build platform produced these errors?

I'm runnning Fedora 29

> Since Marcel is backing out the entire patchset, we will create a v4
> patchset that removes btmesh (the non-daemon executable) entirely.  It
> probably won=E2=80=99t actually be needed in the future anyway... The DBu=
s APIs
> should be sufficient.
> > Makefile.am: installing './depcomp'
> > parallel-tests: installing './test-driver'
> > Makefile.mesh:31: warning: variable 'mesh_btmesh_LDADD' is defined but =
no
> > program or
> > Makefile.mesh:31: library has 'mesh_btmesh' as canonical name (possible
> > typo) Makefile.am:306:   'Makefile.mesh' included from here
> > Makefile.mesh:32: warning: variable 'mesh_btmesh_DEPENDENCIES' is defin=
ed
> > but no program or
> > Makefile.mesh:32: library has 'mesh_btmesh' as canonical name (possible
> > typo) Makefile.am:306:   'Makefile.mesh' included from here
> >=20
> >=20
> > Enabling commented out code (why is it commented out btw?) in
> > Makefile.mesh
> > stil results in:
> >=20
> > Makefile.mesh:39: warning: mesh_btmesh_LDADD multiply defined in condit=
ion
> > MESH ...
> > Makefile.am:306:   'Makefile.mesh' included from here
> > Makefile.mesh:31: ... 'mesh_btmesh_LDADD' previously defined here
> > Makefile.am:306:   'Makefile.mesh' included from here
> >=20
> >>> -----Original Message-----
> >>> From: Gix, Brian
> >>> Sent: Friday, December 14, 2018 4:26 PM
> >>> To: linux-bluetooth@vger.kernel.org
> >>> Cc: johan.hedberg@gmail.com; Stotland, Inga <inga.stotland@intel.com>;
> >>> marcel@holtmann.org; Gix, Brian <brian.gix@intel.com>
> >>> Subject: [PATCH BlueZ v3 00/30] Major rewrite for Multi-Node and DBus
> >>>=20
> >>> The Mesh Daemon has been largely rewritten.
> >>>=20
> >>> It matches the API in doc/mesh-api.txt, and is now accessible from no=
n-
> >>> privledged DBus clients.  The commandline version has been temporarily
> >>> removed, although it will probably be re-added in the future. The dBus
> >>> privledges need to be adjusted to allow for non-privledged access to
> >>> Daemon interfaces.  We will shortly also be adding a Mesh Specific
> >>> README
> >>> and TODO file, but in the meantime, contact Brian and/or Inga with any
> >>> questions.
> >>>=20
> >>> v3 -- distcheck and pedantic styleguide fixes
> >>>=20
> >>> Brian Gix (12):
> >>>  mesh: Staging for Mesh DBus API rewrite
> >>>  mesh: Delete obsolete files
> >>>  mesh: Rewite Network layer for multiple nodes
> >>>  mesh: Direction agnostic PB-Adv implimentation
> >>>  mesh: Acceptor side provisioning implimentation
> >>>  mesh: Initiator side provisioning implimentation
> >>>  mesh: Rewrite Controler interface for full init
> >>>  mesh: Unchanged variables set to const
> >>>  mesh: re-arrange provisioning for DBus API
> >>>  mesh: restructure I/O for multiple nodes
> >>>  mesh: Clean-up Comment style
> >>>  mesh: Enable building Mesh Daemon
> >>>=20
> >>> Inga Stotland (18):
> >>>  mesh: Utilities for DBus support
> >>>  mesh: Internal errors
> >>>  mesh: Re-write storage for Multiple Nodes
> >>>  mesh: Rewrite Node handling for multiple nodes
> >>>  mesh: centralize generic utilities
> >>>  mesh: Re-architect for DBus API
> >>>  mesh: Make config model handle multiple nodes
> >>>  mesh: Multi node Config Server model
> >>>  mesh: Restrusture DB to support multiple nodes
> >>>  mesh: restructure model services for multiple nodes
> >>>  mesh: DBUS interface for Provisioning Agent
> >>>  mesh: restructure App Key storage
> >>>  mesh: Update for DBus API and multi-node support
> >>>  mesh: Add default location for Mesh Node storage
> >>>  mesh: Add structural changes for mesh
> >>>  mesh: Sample Provisioning Agent
> >>>  mesh: Sample On/Off Client and Server
> >>>  mesh: Sample Mesh Joiner (provision acceptor)
> >>>=20
> >>> Makefile.mesh                  |   26 +-
> >>> configure.ac                   |    5 +
> >>> mesh/agent.c                   |  665 ++++++++++++++++----
> >>> mesh/agent.h                   |   71 ++-
> >>> mesh/appkey.c                  |   17 +-
> >>> mesh/cfgmod-server.c           |  173 +++---
> >>> mesh/cfgmod.h                  |    2 +-
> >>> mesh/config/composition.json   |   44 --
> >>> mesh/dbus.c                    |  181 ++++++
> >>> mesh/dbus.h                    |   40 ++
> >>> mesh/display.c                 |   64 --
> >>> mesh/error.h                   |   35 ++
> >>> mesh/friend.c                  |   76 +--
> >>> mesh/main.c                    |   73 ++-
> >>> mesh/mesh-db.c                 |  454 +++++++++-----
> >>> mesh/mesh-db.h                 |    6 +-
> >>> mesh/mesh-io-api.h             |    2 +-
> >>> mesh/mesh-io-generic.c         |  149 ++++-
> >>> mesh/mesh-io.c                 |    3 +-
> >>> mesh/mesh-io.h                 |    3 +-
> >>> mesh/mesh.c                    |  625 ++++++++++++++-----
> >>> mesh/mesh.h                    |   27 +-
> >>> mesh/model.c                   |  811 +++++++++++++++++-------
> >>> mesh/model.h                   |   66 +-
> >>> mesh/net.c                     |  293 +++------
> >>> mesh/net.h                     |   31 +-
> >>> mesh/node.c                    | 1338
> >>> +++++++++++++++++++++++++++++++++----
> >>>=20
> >>> ---
> >>>=20
> >>> mesh/node.h                    |   42 +-
> >>> mesh/pb-adv.c                  |  444 +++++++++++++
> >>> mesh/{display.h =3D> pb-adv.h}   |   13 +-
> >>> mesh/prov-acceptor.c           |  711 +++++++++++++++++++++
> >>> mesh/prov-initiator.c          |  650 +++++++++++++++++++
> >>> mesh/prov.c                    |  722 ----------------------
> >>> mesh/prov.h                    |   14 +-
> >>> mesh/provision.c               | 1162 -------------------------------=
=2D--
> >>> mesh/provision.h               |  112 +++-
> >>> mesh/storage.c                 |  570 ++++++++---------
> >>> mesh/storage.h                 |   39 +-
> >>> mesh/test/agent.py             |   40 ++
> >>> mesh/test/example-onoff-client |  288 +++++++++  mesh/test/example-
> >>>=20
> >>> onoff-server |  365 +++++++++++
> >>>=20
> >>> mesh/test/test-join            |  408 ++++++++++++
> >>> mesh/util.c                    |   26 +
> >>> mesh/util.h                    |    1 +
> >>> 44 files changed, 7188 insertions(+), 3699 deletions(-)  delete mode
> >>> 100644
> >>>=20
> >>> mesh/config/composition.json  create mode 100644 mesh/dbus.c  create
> >>> mode 100644 mesh/dbus.h  delete mode 100644 mesh/display.c  create
> >>> mode 100644 mesh/error.h  create mode 100644 mesh/pb-adv.c  rename
> >>> mesh/{display.h =3D> pb-adv.h} (71%)  create mode 100644 mesh/prov-
> >>> acceptor.c  create mode 100644 mesh/prov-initiator.c  delete mode 100=
644
> >>> mesh/prov.c  delete mode 100644 mesh/provision.c  create mode 100755
> >>> mesh/test/agent.py  create mode 100644 mesh/test/example-onoff-client
> >>> create mode 100644 mesh/test/example-onoff-server  create mode 100644
> >>> mesh/test/test-join
> >>>=20
> >>> --
> >>> 2.14.5


=2D-=20
pozdrawiam
Szymon Janc


