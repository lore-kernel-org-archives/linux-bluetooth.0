Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D68DC432C3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 13:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B1B20748
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 13:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKRNxp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:53:45 -0500
Received: from mail.tinia.it ([212.104.57.17]:44910 "EHLO mail.tinia.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfKRNxp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 08:53:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id DAEE3222722;
        Mon, 18 Nov 2019 14:44:15 +0100 (CET)
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pMKv1QEduIUR; Mon, 18 Nov 2019 14:44:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id 840C0222712;
        Mon, 18 Nov 2019 14:44:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at yes
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BmVZ6fgVl6NV; Mon, 18 Nov 2019 14:44:14 +0100 (CET)
Received: from blemesh.cbl.lan (customer-93-189-143-66.com-com.it [93.189.143.66])
        by mail.tinia.eu (Postfix) with ESMTPA id 57BC722270F;
        Mon, 18 Nov 2019 14:44:14 +0100 (CET)
From:   Daniele Biagetti <daniele.biagetti@cblelectronics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniele <dbiagio@tiscali.it>
Subject: [PATCH 0/6] Add features and fix some undesired behaviour of meshctl
Date:   Mon, 18 Nov 2019 14:43:59 +0100
Message-Id: <20191118134405.20212-1-daniele.biagetti@cblelectronics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Daniele <dbiagio@tiscali.it>

The followings extend the features of meshctl, adding:
 * The Subscription Delete message to the configuration client=20
   (as per Mesh Profile 4.3.2.21)
 * The Generic OnOff Set Unacknowledged message to the onoff
   client model
 * Generic Level Client Model, limited to the following messages:
   - generic level get and set
   - generic level set unacknowledged
   - generic level status
 * Generic Power OnOff Client except the Generic OnPowerUp Set
   Unacknowledged message
They also contains two fixes:
 * The first one cames up when more than a client model is added
   to the local node. The received status messages are forwarded
   to all clients and they needs to be filtered within each client
   in order to avoid wrong reports on the bt shell
 * The second one replaces a return statment within the onoff=20
   client model with a warning message when the user selects an
   unknown target address. For example it happens when the user=20
   tries to send messages to a group address due to the fact that
   such addresses are not stored whitn the json database.

Daniele (6):
  tools/mesh: Add onoff set unack message to onoff client model
  tools/mesh: Fix status messages processing
  tools/mesh: Fix unwanted return in onoff client model
  tools/mesh: Add subscription delete message to config client model
  tools/mesh: Add generic level model support
  tools/mesh: Add generic power onoff client model

 Makefile.tools               |   4 +-
 tools/mesh/config-client.c   |  40 +++++
 tools/mesh/level-model.c     | 298 +++++++++++++++++++++++++++++++++++
 tools/mesh/level-model.h     |  34 ++++
 tools/mesh/local_node.json   |  10 +-
 tools/mesh/node.c            |  11 ++
 tools/mesh/onoff-model.c     |  52 ++++--
 tools/mesh/onpowerup-model.c | 262 ++++++++++++++++++++++++++++++
 tools/mesh/onpowerup-model.h |  34 ++++
 tools/meshctl.c              |   8 +
 10 files changed, 734 insertions(+), 19 deletions(-)
 create mode 100644 tools/mesh/level-model.c
 create mode 100644 tools/mesh/level-model.h
 create mode 100644 tools/mesh/onpowerup-model.c
 create mode 100644 tools/mesh/onpowerup-model.h

--=20
2.20.1

