Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: SCO socket MTU problem in PulseAudio
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1486380902.4774.4.camel@iki.fi>
Date: Fri, 10 Feb 2017 12:48:28 +0100
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Renjith Thomas <renjith@lightlevitate.com>,
        Georg Chini <georg@chini.tk>
Message-Id: <6B0AC741-28BC-4F1A-90E2-5634246F591D@holtmann.org>
References: <1485867673.2993.5.camel@iki.fi>
 <A00CAB7E-3131-4430-8AEA-4132E28CE8FE@holtmann.org>
 <1486380902.4774.4.camel@iki.fi>
To: Tanu Kaskinen <tanuk@iki.fi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tanu,

>>> PulseAudio recently started to use
>>> 
>>>   getsockopt(sock, SOL_SCO, SCO_OPTIONS, &sco_opt, &len);
>>>   read_mtu = sco_opt.mtu;
>>>   write_mtu = sco_opt.mtu;
>>> 
>>> to query the MTU of the SCO socket. Previously we used a fixed value of
>>> 48, but that didn't work for some bluetooth chipsets (see the commit
>>> message[1]). Now, however, it was reported[2] that the new code doesn't
>>> work on some hardware where the old fixed MTU used to work.
>> 
>> can you share details here and btmon traces for the data buffer sizes
>> and the USB descriptor details. We would need to figure out where
>> this goes wrong and maybe introduce some driver quirks to ensure that
>> it returns usable values.
> 
> Georg already provided a btmon dump. Did that contain everything you
> need? The way you put your words, it's not clear to me if the USB
> descriptor details are included in the btmon output or is the USB
> descriptor a separate thing?
> 
> I'd like to provide clear instructions for users to get the necessary
> information, in case it turns out that Georg is not the only one with
> this problem. What options should be given to btmon?

< HCI Command: Read Local Version Info.. (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 2.0 (0x03) - Revision 5276 (0x149c)
        LMP version: Bluetooth 2.0 (0x03) - Subversion 5276 (0x149c)
        Manufacturer: Cambridge Silicon Radio (10)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0
> HCI Event: Command Complete (0x0e) plen 10
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 00:15:83:73:FD:06 (IVT corporation)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> HCI Event: Command Complete (0x0e) plen 11
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 384  ACL max packet: 8
        SCO MTU: 64   SCO max packet: 8

This seems to be CSR based hardware. Can we verify that this is the case with the /sys/kernel/debug/usb/devices info for this device. If this is a fake device, then all bets are off anyway.

And yes, it reports 64 octets for the MTU. Which is most likely what you are getting back from the SCO socket. If this is all bogus and doesn’t work for CSR devices, we need to quirk it in the btusb driver to report a different value.

As a side note, a newer btmon version will decode all the Unknown packet entries.

Regards

Marcel

