Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [EXT] Unexpected SMP Command 0x17
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <E3B98393E6037849B63EA428240A6513607C80@PGSMSX103.gar.corp.intel.com>
Date: Thu, 30 Mar 2017 08:13:44 +0200
Cc: Szymon Janc <szymon.janc@codecoup.pl>,
        Avinash Kadam <avinashk@marvell.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        "Wong, Mun choy" <mun.choy.wong@intel.com>,
        "Zulqarnain, Adam" <adam.zulqarnain@intel.com>
Message-Id: <127FD0E3-D17E-4010-B5FC-1716F9B4BCD5@holtmann.org>
References: <E3B98393E6037849B63EA428240A651360654F@PGSMSX103.gar.corp.intel.com>
 <3fa5cd6f9317401fbf4da0b5236c1ff1@SC-EXCH02.marvell.com>
 <AC5A66AA-49F3-4F10-8D7A-EDDEC395A4FE@holtmann.org> <1589262.TPhyyzNXdL@ix>
 <E3B98393E6037849B63EA428240A6513607C80@PGSMSX103.gar.corp.intel.com>
To: "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joshua,

>>>> Yes, for secure connection the LTK is generated locally.
>>>> But issue here is observed that after Pairing is complete the key
>>>> distribution is not completed from Master.
>>>> 
>>>> i.e. After Slave sends the  "Signature key:" but Master doesn't
>>>> share any key.  Attached logs.
>>> I get that and that is clear from the logs. Something is stalling here
>>> and because of that, you run into the 30 seconds SMP timeout. We just
>>> need to know if the 4.9 kernel is doing this correctly. If so, then
>>> you can bi-sect that patch that fixes. Without proof that 4.9 is also
>>> broken, nobody will even bother to chase this down.
>> 
>> I think the problem here is race between ACL data and HCI events on USB
>> dongle...  We get initial slave keys but those get dropped due to encryption
>> changed event not being received yet. Since keys were silently dropped we later
>> on get unexpected SMP PDU and ignoring remaining keys as well which
>> eventually leads to SMP timeout.
>> 
>> If this is USB dongle (using btusd) then only (AFAIK) solution would be to have a
>> workaround for this inside chip (it would delay ACL data received right after
>> encryption change giving host time to handle encpryption change event).
>> Bluetooth specification for USB transport is unfortunatelly kinda broken.
>> 
>> --
>> pozdrawiam
>> Szymon Janc
> 
> Thank you for your reply. Your inputs are valuable to us in helping to debug the issue. Yes, we are indeed using the btusb kernel module and it is using a USB interface (Bluetooth over USB).
> 
> I noticed that when btmgmt settings are set to turn 'bredr off', the 'ssp' mode also turns off. Is this behavior expected to occur?
> My current settings are 'powered connectable discoverable bondable le secure-conn’

the SSP (Secure Simple Pairing) is a BR/EDR only feature. So when you disable BR/EDR, it will be disabled as well.

Regards

Marcel

