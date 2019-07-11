Return-Path: <SRS0=ssTf=VI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC5CC742A1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 23:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49B7208E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 23:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbfGKXAB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:00:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:23001 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbfGKXAB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jul 2019 19:00:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 16:00:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="166515964"
Received: from bgix-dell-lap.sea.intel.com ([10.255.80.129])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2019 16:00:00 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, michal.lowas-rzechonek@silvair.com,
        brian.gix@intel.com
Subject: [PATCH BlueZ v2 0/9] mesh: Provisioner Initiator added
Date:   Thu, 11 Jul 2019 15:59:43 -0700
Message-Id: <20190711225952.1599-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

v2 additions:
* Style guide changes noted by Michal
* Additional patch to use packed structures for Mesh Spec specifid OTA messages

The added functionality of this patch set allows any node with a keyring
provision a new node into the network. It does *not* implement a
user App that can store a Configuration Database, but it does provide
extensions to the python test script to test the primitives.

Brian Gix (9):
  doc: Cleanup API Provisioner1 interface
  mesh: Fix support for Provisioner Initiator
  mesh: Add special Beacon handler for Provisioning
  mesh: Expose mapping function for D-Bus errors
  mesh: Expose resources needed by Management1 interface
  mesh: Fix implementation of Provisioner Initiator
  mesh: Implement DBus Provisioning methods
  mesh: Convert provisioning pkts to packed structs
  test: This extends the mesh tool to exercise Provisioning methods

 doc/mesh-api.txt       |  13 ++-
 mesh/crypto.c          |   8 +-
 mesh/crypto.h          |   8 +-
 mesh/manager.c         | 304 +++++++++++++++++++++++++++++++++++++++++++++++--
 mesh/mesh-io-generic.c |   2 +-
 mesh/mesh-io.c         |   6 +-
 mesh/mesh-io.h         |   7 +-
 mesh/mesh.c            |  10 +-
 mesh/mesh.h            |   4 +-
 mesh/node.c            |  42 +++++--
 mesh/node.h            |   3 +
 mesh/pb-adv.c          | 177 +++++++++++++++++-----------
 mesh/pb-adv.h          |   3 +-
 mesh/prov-acceptor.c   | 158 +++++++++++++------------
 mesh/prov-initiator.c  | 283 +++++++++++++++++++++++++++++++++------------
 mesh/prov.h            |  51 ++++++++-
 mesh/provision.h       |  10 +-
 test/test-mesh         | 113 ++++++++++++++++++
 18 files changed, 946 insertions(+), 256 deletions(-)

-- 
2.14.5

