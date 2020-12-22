Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C09C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 15:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB19221FA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 15:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgLVP6Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 10:58:25 -0500
Received: from atl4mhfb03.myregisteredsite.com ([209.17.115.119]:44826 "EHLO
        atl4mhfb03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbgLVP6Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 10:58:25 -0500
Received: from jax4mhob14.registeredsite.com (jax4mhob14.registeredsite.com [64.69.218.102])
        by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 0BMFvhsd006484
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 10:57:43 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.85])
        by jax4mhob14.registeredsite.com (8.14.4/8.14.4) with ESMTP id 0BMFv0Vt187796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 10:57:01 -0500
Received: (qmail 134632 invoked by uid 0); 22 Dec 2020 15:57:00 -0000
X-TCPREMOTEIP: 208.85.15.155
X-Authenticated-UID: sbrown@opensat.com
Received: from unknown (HELO 155-15-85-208.altiusbb.net) (sbrown@opensat.com@208.85.15.155)
  by 0 with ESMTPA; 22 Dec 2020 15:57:00 -0000
Received: from localhost (localhost [127.0.0.1])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id D20E815403CC
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 10:56:59 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at ewol.com
Received: from 155-15-85-208.altiusbb.net ([127.0.0.1])
        by localhost (fl-server.ewol.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fsWKIsKAbu6U for <linux-bluetooth@vger.kernel.org>;
        Tue, 22 Dec 2020 10:56:57 -0500 (EST)
Received: from w7.lan (w7.lan [192.168.1.9])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id BD33215401A9
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 10:56:57 -0500 (EST)
Message-ID: <cf925daf120458a23798be054865d1e39068f7b5.camel@ewol.com>
Subject: mesh: call to Publish triggers apparent output loop in
 mesh/mesh-io-generic.c
From:   Steve Brown <sbrown@ewol.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Tue, 22 Dec 2020 10:56:57 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Publish functions as expected, but results in continuous, very heavy
HCI traffic (~every .7ms per btmon log). I don't think it's my
application as the problem persists after the application disconnects
from dbus and exits.

The calls to LE Set Adv Param all fail. Prior to the Publish call, LE
Set Param calls succeed. The only difference I can see is the failing
ones have an interval of 50ms and the ones that succeed have 100ms. A
successful one is appended.

I'm at current Bluez head (65231892cd). The platform is a rpi4. 

Below is a pretty normal looking meshd log, a btmon dump and some more
normal looking dbus traffic.

Steve

Dec 22 09:22:56 mesh0 bluetooth-meshd[38760]: mesh/node.c:publish_call() Publish
Dec 22 09:22:56 mesh0 bluetooth-meshd[38760]: mesh/mesh-config-json.c:mesh_config_write_seq_number() Seq Cache: 210 -> 274
Dec 22 09:22:56 mesh0 bluetooth-meshd[38760]: mesh/model.c:mesh_model_rx() iv_index 00000000 key_aid = 6e
Dec 22 09:22:56 mesh0 bluetooth-meshd[38760]: mesh/util.c:print_packet() 46976.692 Used App Key: dae814b7da47ab8c992fcc03a60c100b
Dec 22 09:22:56 mesh0 bluetooth-meshd[38760]: mesh/util.c:print_packet() 46976.692 Clr Rx: 820200030064
Dec 22 09:22:56 mesh0 bluetooth-meshd[38760]: mesh/net.c:send_seg() segN 0 segment 0 seg_off 0
Dec 22 09:22:56 mesh0 bluetooth-meshd[38760]: mesh/util.c:print_packet() 46976.692 Clr-Net Tx: 00080000d10001c0006eaaffbb7633799725e9d600000000
Dec 22 09:22:56 mesh0 bluetooth-meshd[38760]: mesh/util.c:print_packet() 46976.693 RX: Network [enc] :: 7eb235f367ed0172ca7d0345f4a1d9ce42d116f80ab00b0e
Dec 22 09:22:56 mesh0 bluetooth-meshd[38760]: mesh/util.c:print_packet() 46976.693 RX: Network [clr] :: 7e080000d10001c0006eaaffbb7633799725e9d6
Dec 22 09:22:56 mesh0 bluetooth-meshd[38760]: mesh/util.c:print_packet() 46976.715 RX: Network [enc] :: 7e6e7c8a337f4355f2921b9d8fd3e7eb3a866af261fc46d1
Dec 22 09:22:56 mesh0 bluetooth-meshd[38760]: mesh/util.c:print_packet() 46976.715 RX: Network [clr] :: 7e070000d10001c0006eaaffbb7633799725e9d6
Dec 22 09:22:57 mesh0 bluetooth-meshd[38760]: mesh/util.c:print_packet() 46977.097 RX: Network [enc] :: 7e3a351647d646ec107415b165540e1057fdc9847c
Dec 22 09:22:57 mesh0 bluetooth-meshd[38760]: mesh/util.c:print_packet() 46977.097 RX: Network [clr] :: 7e0a00007d010000016e8961a6de509fb1
Dec 22 09:22:57 mesh0 bluetooth-meshd[38760]: mesh/net.c:msg_in_cache() Add 0100 + 00007d + 6e8961a6
Dec 22 09:22:57 mesh0 bluetooth-meshd[38760]: mesh/net.c:packet_received() RX: Network 0100 -> 0001 : TTL 0x0a : IV : 00000000 SEQ 0x00007d
Dec 22 09:22:57 mesh0 bluetooth-meshd[38760]: mesh/net.c:packet_received() RX: App 0x0100 -> 0x0001 : TTL 0x0a : SEQ 0x00007d
Dec 22 09:22:57 mesh0 bluetooth-meshd[38760]: mesh/model.c:mesh_model_rx() iv_index 00000000 key_aid = 6e
Dec 22 09:22:57 mesh0 bluetooth-meshd[38760]: mesh/util.c:print_packet() 46977.097 Used App Key: dae814b7da47ab8c992fcc03a60c100b
Dec 22 09:22:57 mesh0 bluetooth-meshd[38760]: mesh/util.c:print_packet() 46977.097 Clr Rx: 820400
Dec 22 09:22:57 mesh0 bluetooth-meshd[38760]: mesh/model.c:send_msg_rcvd() Send "MessageReceived"
============================================================================================================================
btmon output after Publish call:

< HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15                                                          #1756 [hci0] 60.253779
        Min advertising interval: 50.000 msec (0x0050)
        Max advertising interval: 50.000 msec (0x0050)
        Type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Own address type: Random (0x01)
        Direct address type: Public (0x00)
        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
        Channel map: 37, 38, 39 (0x07)
        Filter policy: Allow Scan Request from White List Only, Allow Connect Request from White List Only (0x03)
> HCI Event: Command Complete (0x0e) plen 4                                                                                 #1757 [hci0] 60.254089
      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32                                                                #1758 [hci0] 60.254304
        Length: 26
        Mesh Data: 7eb235f367ed0172ca7d0345f4a1d9ce42d116f80ab00b0e
          IVI: 0
          NID: 0x7e
        b2 35 f3 67 ed 01 72 ca 7d 03 45 f4 a1 d9 ce 42  .5.g..r.}.E....B
        d1 16 f8 0a b0 0b 0e                             .......
> HCI Event: Command Complete (0x0e) plen 4                                                                                 #1759 [hci0] 60.254686
      LE Set Advertising Data (0x08|0x0008) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1                                                                 #1760 [hci0] 60.254874
        Advertising: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                                                                 #1761 [hci0] 60.255170
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1                                                                 #1762 [hci0] 60.302847
        Advertising: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                                 #1763 [hci0] 60.303586
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15                                                          #1764 [hci0] 60.303744
        Min advertising interval: 50.000 msec (0x0050)
        Max advertising interval: 50.000 msec (0x0050)
        Type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Own address type: Random (0x01)
        Direct address type: Public (0x00)
        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
        Channel map: 37, 38, 39 (0x07)
        Filter policy: Allow Scan Request from White List Only, Allow Connect Request from White List Only (0x03)
> HCI Event: Command Complete (0x0e) plen 4                                                                                 #1765 [hci0] 60.304053
      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
                                                                                                              
=====================================================================================================
dbus-monitor output

method call time=1608649585.797421 sender=:1.223 -> destination=org.bluez.mesh serial=21 path=/org/bluez/mesh/nodeb3f28276086958109ac1e2cbd76fbf7e; interface=org.bluez.mesh.Node1; member=Publish
   object path "/com/silvair/sample/element0"
   uint16 4097
   array [
   ]
   array of bytes [
      82 02 00 03 00 64
   ]
method return time=1608649585.798741 sender=:1.221 -> destination=:1.223 serial=29 reply_serial=21
method call time=1608649586.337429 sender=:1.221 -> destination=:1.223 serial=30 path=/com/silvair/sample/element0; interface=org.bluez.mesh.Element1; member=MessageReceived
   uint16 256
   uint16 1
   variant       uint16 1
   array of bytes [
      82 04 00
   ]

===================================================================================
Successful LE Set Adv Param

< HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15                                                                 #90 [hci0] 6.392018
        Min advertising interval: 100.000 msec (0x00a0)
        Max advertising interval: 100.000 msec (0x00a0)
        Type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Own address type: Random (0x01)
        Direct address type: Public (0x00)
        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
        Channel map: 37, 38, 39 (0x07)
        Filter policy: Allow Scan Request from White List Only, Allow Connect Request from White List Only (0x03)
> HCI Event: Command Complete (0x0e) plen 4                                                                                        #91 [hci0] 6.392399
      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
        Status: Success (0x00)




