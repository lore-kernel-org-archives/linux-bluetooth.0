Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B609C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4907B21852
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 15:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeLRPIO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:08:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:45157 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbeLRPIO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 10:08:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 07:08:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,368,1539673200"; 
   d="scan'208";a="99661584"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2018 07:08:13 -0800
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 18 Dec 2018 07:08:13 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.175]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.232]) with mapi id 14.03.0415.000;
 Tue, 18 Dec 2018 07:08:12 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Szymon Janc <szymon.janc@codecoup.pl>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Subject: Re: [PATCH BlueZ v3 00/30] Major rewrite for Multi-Node and DBus
Thread-Topic: [PATCH BlueZ v3 00/30] Major rewrite for Multi-Node and DBus
Thread-Index: AQHUlAzY/IpZ6d81qkWrt6HYgcLcF6WDSB4AgAFpxYD//+z/Xw==
Date:   Tue, 18 Dec 2018 15:08:12 +0000
Message-ID: <398288BA-8B31-4D3F-97CE-62E4CD683923@intel.com>
References: <20181215002624.9313-1-brian.gix@intel.com>
 <DEBB0CAA2616974FAE35E4B560B9A4375D8E01AF@ORSMSX101.amr.corp.intel.com>,<17761993.WvVeqkb5i9@ix>
In-Reply-To: <17761993.WvVeqkb5i9@ix>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

> On Dec 18, 2018, at 12:16 AM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> 
> Hi Brian,
> 
>> On Monday, 17 December 2018 19:42:01 CET Gix, Brian wrote:
>> This patch-set has been applied upstream.
> 
> There is something wrong with Makefile.mesh

This was tested by us on Fedora 27 and 28, without issues.

What build platform produced these errors?

Since Marcel is backing out the entire patchset, we will create a v4 patchset that removes btmesh (the non-daemon executable) entirely.  It probably won’t actually be needed in the future anyway... The DBus APIs should be sufficient.

> Makefile.am: installing './depcomp'
> parallel-tests: installing './test-driver'
> Makefile.mesh:31: warning: variable 'mesh_btmesh_LDADD' is defined but no 
> program or
> Makefile.mesh:31: library has 'mesh_btmesh' as canonical name (possible typo)
> Makefile.am:306:   'Makefile.mesh' included from here
> Makefile.mesh:32: warning: variable 'mesh_btmesh_DEPENDENCIES' is defined but 
> no program or
> Makefile.mesh:32: library has 'mesh_btmesh' as canonical name (possible typo)
> Makefile.am:306:   'Makefile.mesh' included from here
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
> 
> 
> 
>>> -----Original Message-----
>>> From: Gix, Brian
>>> Sent: Friday, December 14, 2018 4:26 PM
>>> To: linux-bluetooth@vger.kernel.org
>>> Cc: johan.hedberg@gmail.com; Stotland, Inga <inga.stotland@intel.com>;
>>> marcel@holtmann.org; Gix, Brian <brian.gix@intel.com>
>>> Subject: [PATCH BlueZ v3 00/30] Major rewrite for Multi-Node and DBus
>>> 
>>> The Mesh Daemon has been largely rewritten.
>>> 
>>> It matches the API in doc/mesh-api.txt, and is now accessible from non-
>>> privledged DBus clients.  The commandline version has been temporarily
>>> removed, although it will probably be re-added in the future. The dBus
>>> privledges need to be adjusted to allow for non-privledged access to
>>> Daemon interfaces.  We will shortly also be adding a Mesh Specific README
>>> and TODO file, but in the meantime, contact Brian and/or Inga with any
>>> questions.
>>> 
>>> v3 -- distcheck and pedantic styleguide fixes
>>> 
>>> Brian Gix (12):
>>>  mesh: Staging for Mesh DBus API rewrite
>>>  mesh: Delete obsolete files
>>>  mesh: Rewite Network layer for multiple nodes
>>>  mesh: Direction agnostic PB-Adv implimentation
>>>  mesh: Acceptor side provisioning implimentation
>>>  mesh: Initiator side provisioning implimentation
>>>  mesh: Rewrite Controler interface for full init
>>>  mesh: Unchanged variables set to const
>>>  mesh: re-arrange provisioning for DBus API
>>>  mesh: restructure I/O for multiple nodes
>>>  mesh: Clean-up Comment style
>>>  mesh: Enable building Mesh Daemon
>>> 
>>> Inga Stotland (18):
>>>  mesh: Utilities for DBus support
>>>  mesh: Internal errors
>>>  mesh: Re-write storage for Multiple Nodes
>>>  mesh: Rewrite Node handling for multiple nodes
>>>  mesh: centralize generic utilities
>>>  mesh: Re-architect for DBus API
>>>  mesh: Make config model handle multiple nodes
>>>  mesh: Multi node Config Server model
>>>  mesh: Restrusture DB to support multiple nodes
>>>  mesh: restructure model services for multiple nodes
>>>  mesh: DBUS interface for Provisioning Agent
>>>  mesh: restructure App Key storage
>>>  mesh: Update for DBus API and multi-node support
>>>  mesh: Add default location for Mesh Node storage
>>>  mesh: Add structural changes for mesh
>>>  mesh: Sample Provisioning Agent
>>>  mesh: Sample On/Off Client and Server
>>>  mesh: Sample Mesh Joiner (provision acceptor)
>>> 
>>> Makefile.mesh                  |   26 +-
>>> configure.ac                   |    5 +
>>> mesh/agent.c                   |  665 ++++++++++++++++----
>>> mesh/agent.h                   |   71 ++-
>>> mesh/appkey.c                  |   17 +-
>>> mesh/cfgmod-server.c           |  173 +++---
>>> mesh/cfgmod.h                  |    2 +-
>>> mesh/config/composition.json   |   44 --
>>> mesh/dbus.c                    |  181 ++++++
>>> mesh/dbus.h                    |   40 ++
>>> mesh/display.c                 |   64 --
>>> mesh/error.h                   |   35 ++
>>> mesh/friend.c                  |   76 +--
>>> mesh/main.c                    |   73 ++-
>>> mesh/mesh-db.c                 |  454 +++++++++-----
>>> mesh/mesh-db.h                 |    6 +-
>>> mesh/mesh-io-api.h             |    2 +-
>>> mesh/mesh-io-generic.c         |  149 ++++-
>>> mesh/mesh-io.c                 |    3 +-
>>> mesh/mesh-io.h                 |    3 +-
>>> mesh/mesh.c                    |  625 ++++++++++++++-----
>>> mesh/mesh.h                    |   27 +-
>>> mesh/model.c                   |  811 +++++++++++++++++-------
>>> mesh/model.h                   |   66 +-
>>> mesh/net.c                     |  293 +++------
>>> mesh/net.h                     |   31 +-
>>> mesh/node.c                    | 1338
>>> +++++++++++++++++++++++++++++++++----
>>> 
>>> ---
>>> 
>>> mesh/node.h                    |   42 +-
>>> mesh/pb-adv.c                  |  444 +++++++++++++
>>> mesh/{display.h => pb-adv.h}   |   13 +-
>>> mesh/prov-acceptor.c           |  711 +++++++++++++++++++++
>>> mesh/prov-initiator.c          |  650 +++++++++++++++++++
>>> mesh/prov.c                    |  722 ----------------------
>>> mesh/prov.h                    |   14 +-
>>> mesh/provision.c               | 1162 ----------------------------------
>>> mesh/provision.h               |  112 +++-
>>> mesh/storage.c                 |  570 ++++++++---------
>>> mesh/storage.h                 |   39 +-
>>> mesh/test/agent.py             |   40 ++
>>> mesh/test/example-onoff-client |  288 +++++++++  mesh/test/example-
>>> 
>>> onoff-server |  365 +++++++++++
>>> 
>>> mesh/test/test-join            |  408 ++++++++++++
>>> mesh/util.c                    |   26 +
>>> mesh/util.h                    |    1 +
>>> 44 files changed, 7188 insertions(+), 3699 deletions(-)  delete mode
>>> 100644
>>> 
>>> mesh/config/composition.json  create mode 100644 mesh/dbus.c  create
>>> mode 100644 mesh/dbus.h  delete mode 100644 mesh/display.c  create
>>> mode 100644 mesh/error.h  create mode 100644 mesh/pb-adv.c  rename
>>> mesh/{display.h => pb-adv.h} (71%)  create mode 100644 mesh/prov-
>>> acceptor.c  create mode 100644 mesh/prov-initiator.c  delete mode 100644
>>> mesh/prov.c  delete mode 100644 mesh/provision.c  create mode 100755
>>> mesh/test/agent.py  create mode 100644 mesh/test/example-onoff-client
>>> create mode 100644 mesh/test/example-onoff-server  create mode 100644
>>> mesh/test/test-join
>>> 
>>> --
>>> 2.14.5
> 
> 
> -- 
> pozdrawiam
> Szymon Janc
> 
> 
