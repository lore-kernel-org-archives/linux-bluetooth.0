Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AACC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 23:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06244610A0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 23:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhHDXPN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:15:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:10020 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhHDXPN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 19:15:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="213760940"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="213760940"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 16:14:59 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="668379256"
Received: from ltd-ie-desk03.amr.corp.intel.com ([10.212.230.170])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 16:14:58 -0700
Message-ID: <4e9d536cb6a7cffb829f105183f2bb5bceb4122c.camel@linux.intel.com>
Subject: Re: [PATCH v5 1/2] Bluetooth: btusb: Record debug log for Mediatek
 Chip.
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        "\"Mark-YW Chen" =?UTF-8?Q?=28=E9=99=B3=E6=8F=9A=E6=96=87=29=22?= 
        <Mark-YW.Chen@mediatek.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, chris.lu@mediatek.com,
        will-cy.lee@mediatek.com, Sean Wang <sean.wang@mediatek.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Michael Sun <michaelfsun@google.com>, shawnku@google.com,
        jemele@google.com, apusaka@google.com, mcchou@chromium.org
Date:   Wed, 04 Aug 2021 16:14:57 -0700
In-Reply-To: <8988B918-95FD-42DE-95FA-3BAC4A144165@holtmann.org>
References: <20210804090316.12080-1-mark-yw.chen@mediatek.com>
         <8988B918-95FD-42DE-95FA-3BAC4A144165@holtmann.org>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mark,

I cannot find the original patch email and CI report, however this patch throws this warning.

drivers/bluetooth/btusb.c: In function ‘btusb_recv_acl_mtk’:
drivers/bluetooth/btusb.c:4033:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
 4033 |   usb_disable_autosuspend(data->udev);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/bluetooth/btusb.c:4034:2: note: here
 4034 |  case 0x05ff:  /* Firmware debug logging 1 */
      |  ^~~~


Regards,
Tedd


On Wed, 2021-08-04 at 16:48 +0200, Marcel Holtmann wrote:
> Hi Mark,
> 
> > Mediatek Bluetooth controller sends the FW log and FW dump via EP2.
> > This patch creates an MTK specified callback(btusb_recv_acl_mtk) to
> > replace the original one (hci_recv_frame) when an MTK controller is
> > detected. The new callback will separate the firmware dump traffics
> > from the ACL data to have them process separately.
> > 
> > 1. Add a new field (recv_acl) to the btusb_data struct to store
> > vendor-specific ACL callback handler.
> > 2. Add the MTK-specific ACL callback handler (btusb_recv_acl_mtk) to
> > process ACL data, debug log, and firmware dump.
> > 3. The debug log traces LMP/LL events and connection quality reports.
> > 4. The upper layer can use hci_channel_monitor to receive these
> > packets.
> > 
> > Example btmon: firmware debug log.
> > 1. Enable firmware debug log.
> > < HCI Command: Vendor (0x3f|0x005d) plen 4
> >        00 00 02 02                                      ....
> > > HCI Event: Command Complete (0x0e) plen 8
> >      Vendor (0x3f|0x005d) ncmd 1
> >        Status: Success (0x00)
> >        00 00 02 02                                      ....
> > 2. Diagnostic packet from controller
> > = Vendor Diagnostic (len 500)
> >          ff 05 f0 01 fd ff 02 0e 08 01 5d fc 00 00 00 02
> >          02 aa aa aa cb e3 f0 15 b0 0c 5f 01 00 d1 0f 33
> >          01 7f 00 08 57 61 0c 00 00 00 00 00 23 37 17 00
> >          fd ff 00 00 29 60 ff ff b1 56 e8 00 57 40 0a 40
> >          39 95 f2 00 47 40 43 00 fc f0 16 00 57 61 0c 00
> >          00 00 00 00 23 37 17 00 fd ff 00 00 29 60 ff ff
> >          65 95 f2 00 57 40 0a 40 ec d3 fc 00 47 40 3b 00
> >          2c f1 17 00 57 61 0c 00 00 00 00 00 23 37 17 00
> >          fd ff 00 00 29 60 ff ff 19 d4 fc 00 57 40 76 1c
> >          b2 61 01 01 47 40 b3 04 0b 63 18 00 fe ff 02 01
> >          04 05 33 8b 9e 08 00 aa aa aa aa aa 27 38 01 02
> >          01 00 00 00 02 e0 10 00 20 00 20 00 2a 08 40 00
> >          20 00 20 08 2a 08 02 00 40 00 00 01 2e 08 40 00
> >          01 67 b0 c2 2e 08 3e 07 ff ff ff ff 40 08 01 00
> >          02 00 00 00 34 08 a3 00 00 00 00 00 34 08 a3 00
> >          00 00 00 00 35 08 45 01 00 00 00 00 2e 08 40 00
> >          01 67 b0 c2 30 35 01 02 00 00 00 00 2c 31 01 00
> >          02 00 00 40 2d 19 03 00 00 40 00 00 fd ff 02 0f
> >          04 00 01 01 04 aa aa aa aa aa aa aa 57 61 0c 00
> >          00 00 00 00 23 46 32 00 01 00 00 00 2f 35 00 02
> >          00 00 00 00 29 35 ff 02 00 22 00 00 2d 31 a6 02
> >          02 00 00 00 31 6c 40 00 14 63 18 1b 31 6c 40 00
> >          14 63 18 23 51 08 53 00 12 63 18 00 2c 35 12 01
> >          fe 00 00 00 2b 35 fe 02 02 00 00 00 2f 31 21 00
> >          00 00 02 00 75 61 01 00 4c 1b 93 00 79 61 01 00
> >          00 00 00 00 12 e3 63 18 20 31 86 01 74 61 68 03
> >          00 00 04 00 a1 73 ff 00 b9 01 00 00 a1 73 04 00
> >          00 00 00 00 a1 73 00 00 00 00 00 00 a1 73 00 00
> >          02 00 00 00 31 6c 40 00 16 63 18 0c 31 6c 40 00
> >          16 63 18 1c 77 61 40 00 48 33 40 00 14 e3 63 18
> >          40 31 86 01 00 d1 02 c5 07 23 a1 34 73 61 37 02
> >          02 00 00 a1
> > 
> > Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> > Reviewed-by: Michael Sun <michaelfsun@google.com>
> > Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> > ---
> > drivers/bluetooth/btusb.c | 25 ++++++++++++++++++++++++-
> > 1 file changed, 24 insertions(+), 1 deletion(-)
> 
> patch has been applied to bluetooth-next tree.
> 
> Regards
> 
> Marcel
> 

