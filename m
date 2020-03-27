Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BF0C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C77420716
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC0Sm7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:42:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:39636 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgC0Sm7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 14:42:59 -0400
IronPort-SDR: 0mIlqQORQ19Qc+nouIvzidL8PatNrSFxVHZRrmg/rmKezO1vavmVUUWLlAlEJeqF/Hl7fgIcnu
 V8C1lol2M9Gg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 11:42:58 -0700
IronPort-SDR: OBxumLzdtteZ4HnnTy/G4LLXOlt9Q7E0gwrPVpt9qLci2N1HhmP1aJNX98j3WPLh67CDL7qLRU
 ikxkEPiA4ohw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="421193638"
Received: from ingas-nuc1.sea.intel.com ([10.251.8.23])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2020 11:42:58 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/4] API changes for forward compatibility
Date:   Fri, 27 Mar 2020 11:42:53 -0700
Message-Id: <20200327184257.15042-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


The changes are contained to Management and Provisioner APIs. 

  The following methods are modified to allow for future development:
    
    Interface org.bluez.mesh.Management1:
    
    Old: void UnprovisionedScan(uint16 seconds)
    New: void UnprovisionedScan(dict options)
    
        The options parameter is a dictionary with the following keys defined:
        uint16 Seconds
                    Specifies number of seconds for scanning to be active.
                    If set to 0 or if this key is not present, then the
                    scanning will continue until UnprovisionedScanCancel()
                    or AddNode() methods are called.
        other keys TBD
    
    Old: void AddNode(array{byte}[16] uuid)
    New: void AddNode(array{byte}[16] uuid, dict options)
    
        The options parameter is currently an empty dictionary
    
    Interface org.bluez.mesh.Provisioner1
    
    Old: void ScanResult(int16 rssi, array{byte} data)
    New: void ScanResult(int16 rssi, array{byte} data, dict options)
    
        The options parameter is currently an empty dictionary

Inga Stotland (4):
  doc/mesh-api: Forward compatibility modifications
  mesh: Update UnprovisionedScan, AddNode & ScanResult
  test/test-mesh: Update to match modified APIs
  tools/mesh-cfgclient: Update to match modified APIs

 doc/mesh-api.txt       | 28 +++++++++++++++++++++-------
 mesh/manager.c         | 39 ++++++++++++++++++++++++++++++---------
 test/test-mesh         | 39 +++++++++++++++++++++++++--------------
 tools/mesh-cfgclient.c | 36 ++++++++++++++++++++++++++++++------
 4 files changed, 106 insertions(+), 36 deletions(-)

-- 
2.21.1

