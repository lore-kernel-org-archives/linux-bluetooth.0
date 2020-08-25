Return-Path: <SRS0=aWoj=CD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EB1C433E3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Aug 2020 00:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8E62087D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Aug 2020 00:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgHYAyp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:54:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:44188 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgHYAyk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Aug 2020 20:54:40 -0400
IronPort-SDR: 8i91yPBQPauaZPMd0NCgsATOme5mhGU++07OIugMn27oiv+i26RgHvanE4+0bNhS/MGXa0Bqb+
 3BLb+5vfHojw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143797438"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="143797438"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:54:38 -0700
IronPort-SDR: Upinc3hlHcKC9N/G5UQ3dvvVsTgIAxyP1YM92V75+VXVrzCXCbz6b9qM5qrYp/qEx5zx1NHxqA
 01PHZqO+4W6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="474141831"
Received: from apaharia-mobl.gar.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.255.231.108])
  by orsmga005.jf.intel.com with ESMTP; 24 Aug 2020 17:54:37 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 0/4] Mesh send/publish API change
Date:   Mon, 24 Aug 2020 17:54:31 -0700
Message-Id: <20200825005435.26566-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set modifies Send, DevKeySend and Publish methods
on bluez.mesh.Node interface to include additional argument "options".

This new argument is a dictionary that currently has only one
new key word defined for Send() and DevKeySend():
    "ForceSegmented" - to force small payloads to be sent as
                      one-segment messages

Other key words may be defined in future to accommodate evolving
requirements of Mesh Profile specification.

********* v2 ************    
In case of Publish(), and additional keyword is defined
    "Vendor" -  16-bit Company ID as defined by the Bluetooth SIG
        
This allows to eliminate VendorPublish() method.

Inga Stotland (4):
  doc/mesh-api: Add "options" dictionary to Send/Publish
  mesh: Handle "options" dictionary in Send/Publish methods
  tools/mesh-cfglient: Add "options" to Send/DevKeySend
  test/test-mesh: Add "options" to Send/Publish

 doc/mesh-api.txt       |  57 ++++++++++-------
 mesh/cfgmod-server.c   |   2 +-
 mesh/model.c           |   6 +-
 mesh/model.h           |   9 +--
 mesh/node.c            | 140 ++++++++++++++++++++---------------------
 test/test-mesh         |  11 +++-
 tools/mesh-cfgclient.c |   8 +++
 7 files changed, 125 insertions(+), 108 deletions(-)

-- 
2.26.2

