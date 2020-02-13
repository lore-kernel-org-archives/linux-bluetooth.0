Return-Path: <SRS0=+UdQ=4B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE06C352A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Feb 2020 23:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B86421734
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Feb 2020 23:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgBMXEo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Feb 2020 18:04:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:31346 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgBMXEn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Feb 2020 18:04:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 15:04:42 -0800
X-IronPort-AV: E=Sophos;i="5.70,438,1574150400"; 
   d="scan'208";a="347827816"
Received: from han1-xps-13-9350.jf.intel.com ([10.54.74.61])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 15:04:42 -0800
Message-ID: <d71649611135c6b7a1ab3a4e59ce3e05265f8470.camel@linux.intel.com>
Subject: Re: [RFC v3] Bluetooth: Add debugfs option to enable runtime debug
 statements
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Date:   Thu, 13 Feb 2020 15:03:31 -0800
In-Reply-To: <AF6B4197-8AFE-429A-ACFB-14500A7D500F@holtmann.org>
References: <20200203153603.61931-1-marcel@holtmann.org>
         <AF6B4197-8AFE-429A-ACFB-14500A7D500F@holtmann.org>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, 2020-02-13 at 08:27 +0100, Marcel Holtmann wrote:
> Hi,
> 
> > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > ---
> > include/net/bluetooth/bluetooth.h | 10 +++++
> > net/bluetooth/Kconfig             |  7 +++
> > net/bluetooth/af_bluetooth.c      |  2 +
> > net/bluetooth/lib.c               | 73 +++++++++++++++++++++++++++++++
> > 4 files changed, 92 insertions(+)
> 
> does anybody have any comments on this. It is not the final solution, but as
> an interim it might be a good start.
> 

I did quick test and it worked fine. Below is the testing output.
Let me know if need further testing..


root@tester-VirtualBox:/sys/kernel/debug/bluetooth# dmesg -c
root@tester-VirtualBox:/sys/kernel/debug/bluetooth# cat debug_enable 
N
root@tester-VirtualBox:/sys/kernel/debug/bluetooth# echo 'Y' > debug_enable 
root@tester-VirtualBox:/sys/kernel/debug/bluetooth# hciconfig -a
hci0:	Type: Primary  Bus: USB
	BD Address: 9C:DA:3E:F2:8E:46  ACL MTU: 1021:4  SCO MTU: 96:6
	UP RUNNING 
	RX bytes:1367 acl:0 sco:0 events:68 errors:0
	TX bytes:3729 acl:0 sco:0 commands:68 errors:0
	Features: 0xbf 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH SNIFF 
	Link mode: SLAVE ACCEPT 
	Name: 'tester-VirtualBox'
	Class: 0x0c0000
	Service Classes: Rendering, Capturing
	Device Class: Miscellaneous, 
	HCI Version: 5.0 (0x9)  Revision: 0x100
	LMP Version: 5.0 (0x9)  Subversion: 0x100
	Manufacturer: Intel Corp. (2)

root@tester-VirtualBox:/sys/kernel/debug/bluetooth# dmesg
[  891.432216] Bluetooth: sock 00000000ec80bfe5
[  891.432448] Bluetooth: cmd 800448d2 arg 565442b6c260
[  891.432465] Bluetooth: channel 2 len 36
[  891.432480] Bluetooth: cmd 800448d3 arg 565441d4b860
[  891.432485] Bluetooth: 0
[  891.432489] Bluetooth: hci0 orig refcnt 5
[  891.432493] Bluetooth: hci0 orig refcnt 6
[  891.434491] Bluetooth: sock 00000000a8d1e746
[  891.434511] Bluetooth: sock 00000000a8d1e746 sk 00000000ea127ff9
[  891.434514] Bluetooth: 0
[  891.434517] Bluetooth: hci0 orig refcnt 5
[  891.434527] Bluetooth: channel 2 len 36
[  891.434538] Bluetooth: sk 00000000ea127ff9, opt 2
[  891.434546] Bluetooth: sk 00000000ea127ff9, opt 2
[  891.434558] Bluetooth: sock 00000000a8d1e746 sk 00000000ea127ff9
[  891.434577] Bluetooth: hci0 cmd_cnt 1 cmd queued 1
[  891.434584] Bluetooth: hci0 type 1 len 3
[  891.434588] Bluetooth: hdev 00000000124fe225 len 3
[  891.434593] Bluetooth: hci0
[  891.532680] Bluetooth: intf 00000000ed2b072f
[  891.532682] Bluetooth: intf 00000000600468f3
[  891.532683] Bluetooth: hci0
[  891.532696] Bluetooth: hci0
[  891.532702] Bluetooth: hci0
[  891.533095] Bluetooth: hci0 urb 0000000015f7b113 status 0 count 3
[  891.534575] Bluetooth: hci0 urb 00000000f939b99d status 0 count 64
[  891.535214] Bluetooth: hci0 urb 00000000f939b99d status 0 count 64
[  891.535885] Bluetooth: hci0 urb 00000000f939b99d status 0 count 64
[  891.536831] Bluetooth: hci0 urb 00000000f939b99d status 0 count 62
[  891.536852] Bluetooth: hci0
[  891.536854] Bluetooth: hdev 00000000124fe225 len 254
[  891.536860] Bluetooth: hci0 Event packet
[  891.536862] Bluetooth: hci0 status 0x00
[  891.536864] Bluetooth: opcode 0x0c14 status 0x00
[  891.536865] Bluetooth: hci0 opcode 0x0c14
[  891.536880] Bluetooth: sock 00000000a8d1e746, sk 00000000ea127ff9
[  891.536885] Bluetooth: sk 00000000ea127ff9, opt 2
[  891.536905] Bluetooth: sock 00000000a8d1e746 sk 00000000ea127ff9
[  891.536907] Bluetooth: channel 2 len 10
[  891.536909] Bluetooth: hci0 orig refcnt 6
[  891.536921] Bluetooth: sock 000000004b3ad07d
[  891.536927] Bluetooth: sock 000000004b3ad07d sk 00000000ea127ff9
[  891.536928] Bluetooth: 0
[  891.536929] Bluetooth: hci0 orig refcnt 5
[  891.536932] Bluetooth: channel 2 len 36
[  891.536935] Bluetooth: sk 00000000ea127ff9, opt 2
[  891.536937] Bluetooth: sk 00000000ea127ff9, opt 2
[  891.536941] Bluetooth: sock 000000004b3ad07d sk 00000000ea127ff9
[  891.536946] Bluetooth: hci0 cmd_cnt 1 cmd queued 1
[  891.536948] Bluetooth: hci0 type 1 len 3
[  891.536949] Bluetooth: hdev 00000000124fe225 len 3
[  891.536950] Bluetooth: hci0
[  891.537315] Bluetooth: hci0 urb 00000000bf489ae9 status 0 count 3
[  891.537789] Bluetooth: hci0 urb 00000000f939b99d status 0 count 9
[  891.537807] Bluetooth: hci0
[  891.537808] Bluetooth: hdev 00000000124fe225 len 9
[  891.537812] Bluetooth: hci0 Event packet
[  891.537813] Bluetooth: hci0 status 0x00
[  891.537814] Bluetooth: hci0 class 0x0c0000
[  891.537816] Bluetooth: opcode 0x0c23 status 0x00
[  891.537817] Bluetooth: hci0 opcode 0x0c23
[  891.537827] Bluetooth: sock 000000004b3ad07d, sk 00000000ea127ff9
[  891.537832] Bluetooth: sk 00000000ea127ff9, opt 2
[  891.537853] Bluetooth: sock 000000004b3ad07d sk 00000000ea127ff9
[  891.537855] Bluetooth: channel 2 len 10
[  891.537856] Bluetooth: hci0 orig refcnt 6
[  891.537865] Bluetooth: sock 00000000847c4083
[  891.537870] Bluetooth: sock 00000000847c4083 sk 00000000ea127ff9
[  891.537871] Bluetooth: 0
[  891.537872] Bluetooth: hci0 orig refcnt 5
[  891.537874] Bluetooth: channel 2 len 36
[  891.537877] Bluetooth: sk 00000000ea127ff9, opt 2
[  891.537879] Bluetooth: sk 00000000ea127ff9, opt 2
[  891.537882] Bluetooth: sock 00000000847c4083 sk 00000000ea127ff9
[  891.537886] Bluetooth: hci0 cmd_cnt 1 cmd queued 1
[  891.537888] Bluetooth: hci0 type 1 len 3
[  891.537889] Bluetooth: hdev 00000000124fe225 len 3
[  891.537890] Bluetooth: hci0
[  891.538149] Bluetooth: hci0 urb 00000000bf489ae9 status 0 count 3
[  891.538822] Bluetooth: hci0 urb 00000000f939b99d status 0 count 14
[  891.538854] Bluetooth: hci0
[  891.538856] Bluetooth: hdev 00000000124fe225 len 14
[  891.538862] Bluetooth: hci0 Event packet
[  891.538864] Bluetooth: hci0 status 0x00
[  891.538866] Bluetooth: opcode 0x1001 status 0x00
[  891.538868] Bluetooth: hci0 opcode 0x1001
[  891.538883] Bluetooth: sock 00000000847c4083, sk 00000000ea127ff9
[  891.538889] Bluetooth: sk 00000000ea127ff9, opt 2
[  891.538924] Bluetooth: sock 00000000847c4083 sk 00000000ea127ff9
[  891.538927] Bluetooth: channel 2 len 10
[  891.538930] Bluetooth: hci0 orig refcnt 6
[  891.539051] Bluetooth: sock 00000000ec80bfe5 sk 0000000035240669
[  891.539053] Bluetooth: channel 2 len 10
[  893.959807] Bluetooth: intf 00000000600468f3
[  893.961620] Bluetooth: hci0 urb 00000000f939b99d status -2 count 0
[  893.963498] Bluetooth: hci0 urb 00000000abc1f0d6 status -2 count 0
[  893.964657] Bluetooth: hci0 urb 000000002a96d38f status -2 count 0
[  893.964993] Bluetooth: intf 00000000ed2b072f
root@tester-VirtualBox:/sys/kernel/debug/bluetooth# dmesg -c > /dev/null 2>&1
root@tester-VirtualBox:/sys/kernel/debug/bluetooth# echo 'N' > debug_enable 
root@tester-VirtualBox:/sys/kernel/debug/bluetooth# hciconfig -a
hci0:	Type: Primary  Bus: USB
	BD Address: 9C:DA:3E:F2:8E:46  ACL MTU: 1021:4  SCO MTU: 96:6
	UP RUNNING 
	RX bytes:1644 acl:0 sco:0 events:71 errors:0
	TX bytes:3738 acl:0 sco:0 commands:71 errors:0
	Features: 0xbf 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH SNIFF 
	Link mode: SLAVE ACCEPT 
	Name: 'tester-VirtualBox'
	Class: 0x0c0000
	Service Classes: Rendering, Capturing
	Device Class: Miscellaneous, 
	HCI Version: 5.0 (0x9)  Revision: 0x100
	LMP Version: 5.0 (0x9)  Subversion: 0x100
	Manufacturer: Intel Corp. (2)

root@tester-VirtualBox:/sys/kernel/debug/bluetooth# dmesg
root@tester-VirtualBox:/sys/kernel/debug/bluetooth# 




> I have not seen any kbuild issues popping up. However I like to get some
> Tested-By, Reviewed-By lines added to the patch and I can send a patch version
> with proper commit message if there is interest in getting this upstream.
> 
> Regards
> 
> Marcel
> 

