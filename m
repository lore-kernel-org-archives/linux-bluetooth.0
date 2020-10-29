Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99815C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 20:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4735820725
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 20:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgJ2UZK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 16:25:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:58305 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbgJ2UZJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 16:25:09 -0400
IronPort-SDR: zIkjX48c+gETLt2TBb2Y5V+zl9CkxJo8r3qUs+GTh1jrCA+8OWbVR+2SQDs7S/CmkKl6cWUnBM
 yiuqDBbqdbTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="156280444"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="156280444"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 13:25:03 -0700
IronPort-SDR: qkiBrBl9kPnyTwVAcCCTn0TWYL9Q6vEBDmLySRd3wpasHNwSpsaHcmjv8bLpAZIPNZfgKnbrRA
 +PVdqJgTBcwg==
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="526868873"
Received: from han1-mac01.jf.intel.com (HELO linux.intel.com) ([10.7.201.135])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 13:25:02 -0700
Date:   Thu, 29 Oct 2020 13:24:57 -0700
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     David Zakarias <david.zakarias@gmail.com>
Cc:     "An, Tedd" <tedd.an@intel.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Add support for 0cb5:c547 Realtek
 8822CE device
Message-ID: <20201029202457.GA61415@linux.intel.com>
References: <CAC_SeizxoD1PkNHWYg1FcV9x6tote2JyJNX3Kwu3XtHkCF+FPQ@mail.gmail.com>
 <d492a9ad6467d881a7ff325d4210707194f534ca.camel@intel.com>
 <CAC_SeiyJYunkTt81Nh=kc7yFrEkx4iqJ=HE0N8Vd1QrgXmRx=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_SeiyJYunkTt81Nh=kc7yFrEkx4iqJ=HE0N8Vd1QrgXmRx=g@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

On 2020-10-29 at 17:57:49 +0100, David Zakarias wrote:
> Hi Tedd,
> 
> Is this what you are looking for?
> 
> 
> T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh= 4
> B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=1d6b ProdID=0002 Rev= 5.09
> S:  Manufacturer=Linux 5.9.1 xhci-hcd
> S:  Product=xHCI Host Controller
> S:  SerialNumber=0000:02:00.3
> C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0cb5 ProdID=c547 Rev= 0.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Radio
> S:  SerialNumber=00e04c000001
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 

This seems the right device and you just need to include this device
info only.

> T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=10000 MxCh= 2
> B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 3.10 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
> P:  Vendor=1d6b ProdID=0003 Rev= 5.09
> S:  Manufacturer=Linux 5.9.1 xhci-hcd
> S:  Product=xHCI Host Controller
> S:  SerialNumber=0000:02:00.3
> C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms
> 
> T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh= 4
> B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=1d6b ProdID=0002 Rev= 5.09
> S:  Manufacturer=Linux 5.9.1 xhci-hcd
> S:  Product=xHCI Host Controller
> S:  SerialNumber=0000:02:00.4
> C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms
> 
> T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=10000 MxCh= 2
> B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 3.10 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
> P:  Vendor=1d6b ProdID=0003 Rev= 5.09
> S:  Manufacturer=Linux 5.9.1 xhci-hcd
> S:  Product=xHCI Host Controller
> S:  SerialNumber=0000:02:00.4
> C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms
> 
> An, Tedd <tedd.an@intel.com> ezt írta (időpont: 2020. okt. 28., Sze, 22:26):
> >
> > Hi David
> >
> > On Tue, 2020-10-27 at 21:52 +0100, David Zakarias wrote:
> > > My Redmibook 16 AMD laptop contains the RTL8822CE chip having the USB
> > > identifier 0cb5:c547. This patch adds this Id to btusb.c's blacklist
> > > table, enabling the loading of the Realtek firmware.
> > > This, together with another patch by Edward Vear (hci_core: Fix
> > > attempting to set RPA timeout when unsupported, see
> > > https://marc.info/?l=linux-bluetooth&m=160378222632366&w=2) makes my
> > > bluetooth mouse work.
> > >
> > > Signed-off-by: David Zakarias <david.zakarias@gmail.com>
> > > ---
> > > --- bluetooth/drivers/bluetooth/btusb.c.orig 2020-10-27 21:24:51.331035974
> > > +0100
> > > +++ bluetooth/drivers/bluetooth/btusb.c 2020-10-27 21:21:46.000000000 +0100
> > > @@ -386,6 +386,7 @@ static const struct usb_device_id blackl
> > >
> > >   /* Additional Realtek 8822CE Bluetooth devices */
> > >   { USB_DEVICE(0x04ca, 0x4005), .driver_info = BTUSB_REALTEK },
> > > + { USB_DEVICE(0x0cb5, 0xc547), .driver_info = BTUSB_REALTEK },
> > >
> > >   /* Silicon Wave based devices */
> > >   { USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
> >
> > Please include the content of /sys/kernel/debug/usb/devices for this device in
> > the commit message.
> >
> > Regards,
> >
> > Tedd Ho-Jeong An

Regards,

Tedd
