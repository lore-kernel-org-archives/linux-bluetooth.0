Return-Path: <SRS0=QFCk=X4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9C5C10F14
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Oct 2019 08:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C9621A4C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Oct 2019 08:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfJCIJA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:09:00 -0400
Received: from mail.mera.com ([188.40.162.229]:37496 "EHLO mail.mera.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfJCIJA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Oct 2019 04:09:00 -0400
Received: from mera-exch1.mera.com ([188.130.168.211] helo=mera-exch.mera.com)
        by mail.mera.com with esmtps (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (envelope-from <mikhail.pavlukhin@mera.com>)
        id 1iFwAT-0002XZ-Ll; Thu, 03 Oct 2019 08:08:57 +0000
Received: from mera-exch3.mera.com (2001:67c:2344:100::23) by
 mera-exch1.mera.com (2001:67c:2344:100::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Thu, 3 Oct 2019 11:08:51 +0300
Received: from mera-exch3.mera.com ([fe80::14f2:6b98:ed28:64d3]) by
 mera-exch3.mera.com ([fe80::14f2:6b98:ed28:64d3%6]) with mapi id
 15.01.1591.017; Thu, 3 Oct 2019 11:08:51 +0300
From:   Mikhail Pavlukhin <mikhail.pavlukhin@mera.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Subject: RE: Bluetooth / rfcomm  issue with traffic send
Thread-Topic: Bluetooth / rfcomm  issue with traffic send
Thread-Index: AdV5waxOsNlW3R6yC0Gfov9roMCrLA==
Date:   Thu, 3 Oct 2019 08:08:50 +0000
Message-ID: <916eca5326594ddea3e0fa9fefc1571b@mera.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.8.16]
x-inside-org: True
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Resending to the mail list in plain text

From: Mikhail Pavlukhin 
Sent: Thursday, October 3, 2019 10:45 AM
To: 'linux-bluetooth@vger.kernel.org' <linux-bluetooth@vger.kernel.org>
Cc: 'johan.hedberg@gmail.com' <johan.hedberg@gmail.com>; 'marcel@holtmann.org' <marcel@holtmann.org>
Subject: Bluetooth / rfcomm issue with traffic send

Hello,

Would you please assist me with a troubleshooting of the issue with Bluetooth stack? Any advice or recommendation is appreciated.

The system is based on the:
- Linux kernel 4.14.68 
- Bluez - 5.48
- Intel Stick computer with attached Bluetooth USB adapter Broadcom
- Application written in JavaScript/NodeJS and JavaScript plugin https://github.com/waeco/node-bluez helping with Bluetooth connection management

The aim is to establish connection with external device using Bluetooth SPP profile and send/receive certain amount of traffic to the external device. External device is ALPS Evolution series based (https://www.alps.com/prod/info/E/HTML/Communication/Bluetooth/Bluetooth_list1.html)

The observation is the following:
Bluetooth SPP Connection can be successfully established (after SDP discovery, Pairing procedures) and socket descriptor is returned to the user space application. So it is possible to use it for sending - receiving traffic. It is supposed to send some packets containing ASCII symbols with different intensity (packets per second) and packet length. Traffic sending might continue up to several hours. At some moment (spontaneously) that traffic stops (do not see any packets outgoing from the HCI interface associated with Broadcom adapter) even though peer device is available and working fine. Bluez reports devices as paired and connected. In that moment each call of send function on socket finished with failure and errno 11 reported. Tried to check dmesg and system logs, but there is no indication of the failures or error reports. Tried to compare list of open sockets in bad and good case (for rfcomm and our application/NodeJS) - they are the same. Now trying to use Dynamic Debug featu
 re in Linux kernel and trace functions in https://github.com/torvalds/linux/blob/63bdf4284c38a48af21745ceb148a087b190cd21/net/bluetooth/rfcomm/sock.c, but there are a lot of printouts so it is hard to follow what is going on.
It seems the issue with traffic stop reproducible more frequently in case if there is high traffic intensity and small packet length (~64 Kbps).

Could you please advise what modules better to trace with Dynamic Debug feature? Are there any idea why errno 11 can be reported? BTW am I right saying that errno 11 is 
#define EAGAIN šššššš 11šššš /* Try again */ (taken from https://github.com/torvalds/linux/blob/6f0d349d922ba44e4348a17a78ea51b7135965b1/include/uapi/asm-generic/errno-base.h) ?
Actually send attempt is retried, but the traffic sending (towards to the external device) is not restarted even after few minutes.

Thank you in advance, Mikhail.

