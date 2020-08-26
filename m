Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF2FC433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 16:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A252078B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 16:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHZQy2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:54:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:2013 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgHZQy0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 12:54:26 -0400
IronPort-SDR: MamyRcwKctf+6eGInT8XavSvgBumzLzh43bDyTJMJp8uTvYBDMU4s0mk2ljUj7JN9EYrAtLxo9
 qTElNDGJuo5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="135883619"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="135883619"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:54:26 -0700
IronPort-SDR: 9yfVrKycYdK9RkCf7/FLZ+guBuR617iQNn2z2AuiYlFCuAHn/fxvXtTsQMvuGEL5oQ5hc1mYv8
 Xc0b+QMATojg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="331851951"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.63.130])
  by fmsmga002.fm.intel.com with ESMTP; 26 Aug 2020 09:54:25 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v3 0/4] Mesh send/publish API change
Date:   Wed, 26 Aug 2020 09:54:16 -0700
Message-Id: <20200826165420.563822-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
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

This allows us to eliminate VendorPublish() method.

********* v3 ************
Added Vendor specific clarity to the Publish() method description in
mesh-api.txt, since VendorPublish() is removed.


Inga Stotland (4):
  doc/mesh-api: Add "options" dictionary to Send/Publish
  mesh: Handle "options" dictionary in Send/Publish methods
  tools/mesh-cfglient: Add "options" to Send/DevKeySend
  test/test-mesh: Add "options" to Send/Publish

 doc/mesh-api.txt       |  60 ++++++++++--------
 mesh/cfgmod-server.c   |   2 +-
 mesh/model.c           |   6 +-
 mesh/model.h           |   9 +--
 mesh/node.c            | 140 ++++++++++++++++++++---------------------
 test/test-mesh         |  11 +++-
 tools/mesh-cfgclient.c |   8 +++
 7 files changed, 127 insertions(+), 109 deletions(-)

-- 
2.25.4

