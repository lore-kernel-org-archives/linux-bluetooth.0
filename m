Return-Path: <SRS0=kdk/=ZN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E36CC432C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 07:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7BE2089D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 07:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKUHMG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:12:06 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:44218 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKUHMG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Nov 2019 02:12:06 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 63FEACED0F;
        Thu, 21 Nov 2019 08:21:11 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v2 2/2] Bluetooth: btbcm: Add entry for BCM4335A0 UART
 bluetooth
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191120110235.13987-3-mohammad.rasim96@gmail.com>
Date:   Thu, 21 Nov 2019 08:12:04 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-amlogic@lists.infradead.org
Content-Transfer-Encoding: 7bit
Message-Id: <A262568B-EEE5-4C74-B20F-914929995BFC@holtmann.org>
References: <20191120110235.13987-1-mohammad.rasim96@gmail.com>
 <20191120110235.13987-3-mohammad.rasim96@gmail.com>
To:     Mohammad Rasim <mohammad.rasim96@gmail.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mohammad,

> This patch adds the device ID for the BCM4335A0 module
> (part of the AMPAK AP6335 WIFI/Bluetooth combo)
> 
> hciconfig output:
> ```
> hci1:   Type: Primary  Bus: UART
>        BD Address: 43:35:B0:07:1F:AC  ACL MTU: 1021:8  SCO MTU: 64:1
>        UP RUNNING
>        RX bytes:5079 acl:0 sco:0 events:567 errors:0
>        TX bytes:69065 acl:0 sco:0 commands:567 errors:0
>        Features: 0xbf 0xfe 0xcf 0xff 0xdf 0xff 0x7b 0x87
>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>        Link policy: RSWITCH SNIFF
>        Link mode: SLAVE ACCEPT
>        Name: 'alarm'
>        Class: 0x000000
>        Service Classes: Unspecified
>        Device Class: Miscellaneous,
>        HCI Version: 4.0 (0x6)  Revision: 0x161
>        LMP Version: 4.0 (0x6)  Subversion: 0x4106
>        Manufacturer: Broadcom Corporation (15)
> ```
> 
> Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
> ---
> drivers/bluetooth/btbcm.c   | 1 +
> drivers/bluetooth/hci_bcm.c | 1 +
> 2 files changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

