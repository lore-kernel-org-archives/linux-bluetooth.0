Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEE3C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Apr 2021 16:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C56610CB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Apr 2021 16:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhDHQ6Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:58:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:19271 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230522AbhDHQ6Z (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Apr 2021 12:58:25 -0400
IronPort-SDR: jS0xWqN2qMsCFrayL/rSroZuCmevuY+CSBrULrhMFbNlQQlnNRKesuZJUkosrEb81AwTzbrQXk
 oEpaf6eGNI6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="257567855"
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="257567855"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 09:58:13 -0700
IronPort-SDR: vcHjRw9EBMWSpX+/SpR69rkr53Lhbs9bcPBeHrKWKhgT4yryuCrgnw3xRO577vVWl4BsLBtzxT
 zqL6aZHtEfSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="613407689"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 08 Apr 2021 09:58:11 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>,
        Lokendra Singh <lokendra.singh@intel.com>
Subject: [PATCH v1] Bluetooth: Fix alt settings for incoming SCO with transparent coding format
Date:   Thu,  8 Apr 2021 22:31:59 +0530
Message-Id: <20210408170159.19510-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For incoming SCO connection with transparent coding format, alt setting
of CVSD is getting applied instead of Transparent.

Before fix:
< HCI Command: Accept Synchron.. (0x01|0x0029) plen 21  #2196 [hci0] 321.342548
        Address: 1C:CC:D6:E2:EA:80 (Xiaomi Communications Co Ltd)
        Transmit bandwidth: 8000
        Receive bandwidth: 8000
        Max latency: 13
        Setting: 0x0003
          Input Coding: Linear
          Input Data Format: 1's complement
          Input Sample Size: 8-bit
          # of bits padding at MSB: 0
          Air Coding Format: Transparent Data
        Retransmission effort: Optimize for link quality (0x02)
        Packet type: 0x003f
          HV1 may be used
          HV2 may be used
          HV3 may be used
          EV3 may be used
          EV4 may be used
          EV5 may be used
> HCI Event: Command Status (0x0f) plen 4               #2197 [hci0] 321.343585
      Accept Synchronous Connection Request (0x01|0x0029) ncmd 1
        Status: Success (0x00)
> HCI Event: Synchronous Connect Comp.. (0x2c) plen 17  #2198 [hci0] 321.351666
        Status: Success (0x00)
        Handle: 257
        Address: 1C:CC:D6:E2:EA:80 (Xiaomi Communications Co Ltd)
        Link type: eSCO (0x02)
        Transmission interval: 0x0c
        Retransmission window: 0x04
        RX packet length: 60
        TX packet length: 60
        Air mode: Transparent (0x03)
........
> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2336 [hci0] 321.383655
< SCO Data TX: Handle 257 flags 0x00 dlen 60            #2337 [hci0] 321.389558
> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2338 [hci0] 321.393615
> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2339 [hci0] 321.393618
> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2340 [hci0] 321.393618
< SCO Data TX: Handle 257 flags 0x00 dlen 60            #2341 [hci0] 321.397070
> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2342 [hci0] 321.403622
> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2343 [hci0] 321.403625
> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2344 [hci0] 321.403625
> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2345 [hci0] 321.403625
< SCO Data TX: Handle 257 flags 0x00 dlen 60            #2346 [hci0] 321.404569
< SCO Data TX: Handle 257 flags 0x00 dlen 60            #2347 [hci0] 321.412091
> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2348 [hci0] 321.413626
> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2349 [hci0] 321.413630
> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2350 [hci0] 321.413630
< SCO Data TX: Handle 257 flags 0x00 dlen 60            #2351 [hci0] 321.419674

After fix:

< HCI Command: Accept Synchronou.. (0x01|0x0029) plen 21  #309 [hci0] 49.439693
        Address: 1C:CC:D6:E2:EA:80 (Xiaomi Communications Co Ltd)
        Transmit bandwidth: 8000
        Receive bandwidth: 8000
        Max latency: 13
        Setting: 0x0003
          Input Coding: Linear
          Input Data Format: 1's complement
          Input Sample Size: 8-bit
          # of bits padding at MSB: 0
          Air Coding Format: Transparent Data
        Retransmission effort: Optimize for link quality (0x02)
        Packet type: 0x003f
          HV1 may be used
          HV2 may be used
          HV3 may be used
          EV3 may be used
          EV4 may be used
          EV5 may be used
> HCI Event: Command Status (0x0f) plen 4                 #310 [hci0] 49.440308
      Accept Synchronous Connection Request (0x01|0x0029) ncmd 1
        Status: Success (0x00)
> HCI Event: Synchronous Connect Complete (0x2c) plen 17  #311 [hci0] 49.449308
        Status: Success (0x00)
        Handle: 257
        Address: 1C:CC:D6:E2:EA:80 (Xiaomi Communications Co Ltd)
        Link type: eSCO (0x02)
        Transmission interval: 0x0c
        Retransmission window: 0x04
        RX packet length: 60
        TX packet length: 60
        Air mode: Transparent (0x03)
< SCO Data TX: Handle 257 flags 0x00 dlen 60              #312 [hci0] 49.450421
< SCO Data TX: Handle 257 flags 0x00 dlen 60              #313 [hci0] 49.457927
> HCI Event: Max Slots Change (0x1b) plen 3               #314 [hci0] 49.460345
        Handle: 256
        Max slots: 5
< SCO Data TX: Handle 257 flags 0x00 dlen 60              #315 [hci0] 49.465453
> SCO Data RX: Handle 257 flags 0x00 dlen 60              #316 [hci0] 49.470502
> SCO Data RX: Handle 257 flags 0x00 dlen 60              #317 [hci0] 49.470519
< SCO Data TX: Handle 257 flags 0x00 dlen 60              #318 [hci0] 49.472996
> SCO Data RX: Handle 257 flags 0x00 dlen 60              #319 [hci0] 49.480412
< SCO Data TX: Handle 257 flags 0x00 dlen 60              #320 [hci0] 49.480492
< SCO Data TX: Handle 257 flags 0x00 dlen 60              #321 [hci0] 49.487989
> SCO Data RX: Handle 257 flags 0x00 dlen 60              #322 [hci0] 49.490303
< SCO Data TX: Handle 257 flags 0x00 dlen 60              #323 [hci0] 49.495496
> SCO Data RX: Handle 257 flags 0x00 dlen 60              #324 [hci0] 49.500304
> SCO Data RX: Handle 257 flags 0x00 dlen 60              #325 [hci0] 49.500311

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Lokendra Singh <lokendra.singh@intel.com>
---
 net/bluetooth/hci_event.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 016b2999f219..47166cea68bb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4404,12 +4404,12 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 
 	bt_dev_dbg(hdev, "SCO connected with air mode: %02x", ev->air_mode);
 
-	switch (conn->setting & SCO_AIRMODE_MASK) {
-	case SCO_AIRMODE_CVSD:
+	switch (ev->air_mode) {
+	case 0x02:
 		if (hdev->notify)
 			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
 		break;
-	case SCO_AIRMODE_TRANSP:
+	case 0x03:
 		if (hdev->notify)
 			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRANSP);
 		break;
-- 
2.17.1

