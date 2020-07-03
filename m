Return-Path: <SRS0=5fpF=AO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A87C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jul 2020 16:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B1C820870
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jul 2020 16:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgGCQU1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jul 2020 12:20:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:10774 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgGCQU1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jul 2020 12:20:27 -0400
IronPort-SDR: no61GK9JPuKqki1UeFNeL4jYFs6sA45YCyUZS1AxxcRdD0L2HSlX7sUFvB9jrZXPiXxhH/a0VG
 dpKpxhlsgz9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="232033682"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="232033682"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 09:20:26 -0700
IronPort-SDR: 7WBDWnu79obzexHNvVgFM6SQS1cbb5IsQ02Cc5lfHZEMMp8OGY1kqmXz6P978KMlacTzjWKOya
 aRTgZgcHjVog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="296244897"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.251.6.196])
  by orsmga002.jf.intel.com with ESMTP; 03 Jul 2020 09:20:26 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Fix Seg Fault - App unattached IVIndex chg
Date:   Fri,  3 Jul 2020 09:20:18 -0700
Message-Id: <20200703162018.940172-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Object path to node interfaces do not exist unless the owning
application is attached.  This caused a Segmentation fault if IVIndex
change was signaled.

Crash output:

mesh/pb-adv.c:send_adv_segs() size: 01, CRC: 3e
mesh/pb-adv.c:pb_adv_packet() Link closed notification: 00
mesh/net.c:update_iv_ivu_state() iv_upd_state = IV_UPD_NORMAL

Program received signal SIGSEGV, Segmentation fault.
0xb6fbc1dc in strlen () from /usr/lib/arm-linux-gnueabihf/libarmmem-v7l.so
(gdb) backtrace
0  0xb6fbc1dc in strlen () from /usr/lib/arm-linux-gnueabihf/libarmmem-v7l.so
1  0x00448488 in l_str_hash (p=0x0) at ell/hashmap.c:168
2  0x00448980 in l_hashmap_lookup (hashmap=0x46b550, key=key@entry=0x0) at ell/hashmap.c:487
3  0x00444704 in _dbus_object_tree_property_changed (dbus=0x469438, path=0x0, interface_name=0x44bb74 "org.bluez.mesh.Node1", property_name=0x44aa18 "IVIndex") at ell/dbus-service.c:1196
4  0x0044545c in l_dbus_property_changed (dbus=<optimized out>, path=<optimized out>, interface=<optimized out>, property=<optimized out>) at ell/dbus-service.c:1804
5  0x0041805c in node_property_changed (node=<optimized out>, property=<optimized out>) at mesh/node.c:2392
6  0x0040c690 in update_iv_ivu_state (ivu=false, iv_index=0, net=0x46e240) at mesh/net.c:2569
7  process_beacon (net_ptr=0x46e240, user_data=0xbefff1e4) at mesh/net.c:2610
8  0x00431edc in l_queue_foreach (queue=<optimized out>, function=0x40c468 <process_beacon>, user_data=user_data@entry=0xbefff1e4) at ell/queue.c:441
9  0x0040a848 in beacon_recv (user_data=<optimized out>, info=<optimized out>, data=<optimized out>, len=<optimized out>) at mesh/net.c:2647
10 0x00431edc in l_queue_foreach (queue=<optimized out>, function=0x408bec <process_rx_callbacks>, function@entry=0x15463acd, user_data=user_data@entry=0xbefff230) at ell/queue.c:441
11 0x00409ec0 in process_rx (len=<optimized out>, data=0xbefff297 "+\001", addr=0xbefff258 "\260\362B", instant=4646248, rssi=-78 '\262', pvt=<optimized out>) at mesh/mesh-io-generic.c:121
12 event_adv_report (io=0x46c3c8, size=<optimized out>, buf=0xbefff255) at mesh/mesh-io-generic.c:159
13 event_callback (buf=<optimized out>, size=<optimized out>, user_data=0x46c3c8) at mesh/mesh-io- generic.c:172
14 0x0042ff58 in queue_foreach (queue=0x46d370, function=0x42f2b0 <process_notify>, user_data=user_data@entry= 0xbefff289) at src/shared/queue.c:219
15 0x0042f674 in process_event (size=<optimized out>, data=0xbefff283, hci=0x46c3d8) at src/shared/hci.c:258
16 io_read_callback (io=<optimized out>, user_data=0x46c3d8) at src/shared/hci.c:286
17 0x00432600 in io_callback (fd=<optimized out>, events=1, user_data=0x46d318) at ell/io.c:126
18 0x0043348c in l_main_iterate (timeout=<optimized out>) at ell/main.c:470
19 0x00433554 in l_main_run () at ell/main.c:520
20 l_main_run () at ell/main.c:502
21 0x004337b4 in l_main_run_with_signal (callback=<optimized out>, user_data=0x0) at ell/main.c:642
22 0x00404e90 in main (argc=<optimized out>, argv=<optimized out>) at mesh/main.c:269
(gdb)
---
 mesh/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/node.c b/mesh/node.c
index 9f0f15070..3e888ce61 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -2388,7 +2388,7 @@ void node_property_changed(struct mesh_node *node, const char *property)
 {
 	struct l_dbus *bus = dbus_get_bus();
 
-	if (bus)
+	if (bus && node->obj_path)
 		l_dbus_property_changed(dbus_get_bus(), node->obj_path,
 						MESH_NODE_INTERFACE, property);
 }
-- 
2.25.4

