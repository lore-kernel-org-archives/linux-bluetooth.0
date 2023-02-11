Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9F1C636D7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Feb 2023 10:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBKK5N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Feb 2023 05:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjBKK5K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Feb 2023 05:57:10 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7AA1C7F9
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 02:57:09 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id E106824076D
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 11:57:07 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PDSGq322Nz9rxL;
        Sat, 11 Feb 2023 11:57:07 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 4/9] monitor: add MGMT setting bit names for CIS feature support
Date:   Sat, 11 Feb 2023 10:53:48 +0000
Message-Id: <4fce505a05e24dfa66e35cbef4371f8166b44853.1676112710.git.pav@iki.fi>
In-Reply-To: <3df45c4a6737b249b519d4c6128e2eb783198abc.1676112710.git.pav@iki.fi>
References: <20230127205205.20235-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add names for CIS Central/Peripheral MGMT bits:

@ MGMT Event: Command Complete (0x0001) plen 283  {0x0002} [hci0] 3.745117
      Read Controller Information (0x0004) plen 280
        Status: Success (0x00)
        Address: XX:XX:XX:XX:XX:XX (Intel Corporate)
        Version: Bluetooth 5.3 (0x0c)
        Manufacturer: Intel Corp. (2)
        Supported settings: 0x000ffeff
          Powered
          Connectable
          Fast Connectable
          Discoverable
          Bondable
          Link Security
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Advertising
          Secure Connections
          Debug Keys
          Privacy
          Controller Configuration
          Static Address
          PHY Configuration
          Wideband Speech
          CIS Central
          CIS Peripheral
        Current settings: 0x000c0ad1
          Powered
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
          CIS Central
          CIS Peripheral
        Class: 0x7c0104
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Desktop workstation
          Rendering (Printing, Speaker)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Audio (Speaker, Microphone, Headset)
          Telephony (Cordless telephony, Modem, Headset)
        Name: xxx
        Short name:
---

Notes:
    v2: add example output

 monitor/packet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 44f1941bd..d9e8abf41 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12649,6 +12649,8 @@ static const struct bitfield_data mgmt_settings_table[] = {
 	{ 15, "Static Address"		},
 	{ 16, "PHY Configuration"	},
 	{ 17, "Wideband Speech"		},
+	{ 18, "CIS Central"		},
+	{ 19, "CIS Peripheral"		},
 	{ }
 };
 
-- 
2.39.1

