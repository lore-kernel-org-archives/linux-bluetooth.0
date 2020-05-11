Return-Path: <SRS0=PQ2f=6Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F1EC47255
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 May 2020 10:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F06C5207DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 May 2020 10:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgEKKVF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 May 2020 06:21:05 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58105 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgEKKVF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 May 2020 06:21:05 -0400
Received: from [192.168.1.91] (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6E513CECE3;
        Mon, 11 May 2020 12:30:45 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 1/2] Bluetooth: btusb: Add support for Intel Bluetooth
 Device Typhoon Peak (8087:0032)
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA8F774D-7073-4EC4-97AF-F5EF431E8E46@holtmann.org>
Date:   Mon, 11 May 2020 12:21:03 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        kiran.k@intel.com, "Hegde, Raghuram" <raghuram.hegde@intel.com>,
        Tumkur@vger.kernel.org, Narayan@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <96D67A1D-9EBF-4CE1-B2F6-239C7071D871@holtmann.org>
References: <20200427094558.16649-1-amit.k.bag@intel.com>
 <CA8F774D-7073-4EC4-97AF-F5EF431E8E46@holtmann.org>
To:     Amit K Bag <amit.k.bag@intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Amit,

>> Device from /sys/kernel/debug/usb/devices:
>> 
>> T:  Bus=01 Lev=01 Prnt=01 Port=13 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
>> D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>> P:  Vendor=8087 ProdID=0032 Rev= 0.00
>> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
>> 
>> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
>> Signed-off-by: Tumkur Narayan, Chethan <chethan.tumkur.narayan@intel.com>
>> ---
>> drivers/bluetooth/btusb.c | 2 ++
>> 1 file changed, 2 insertions(+)
> 
> patch has been applied to bluetooth-next tree.

so I am taking this patch back out. You are missing a Signed-off-by line. Please fix that and I also prefer first name last name for the addresses.

In addition there is white-space damage in the patch. That needs fixing as well.

Regards

Marcel

