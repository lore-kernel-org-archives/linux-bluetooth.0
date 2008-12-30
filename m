Return-Path: <cyrus@holtmann.org>
Subject: Re: bccmds
From: Marcel Holtmann <marcel@holtmann.org>
To: David Thornton <david@villagepublishing.com.au>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4959AE62.8020605@villagepublishing.com.au>
References: <4959AE62.8020605@villagepublishing.com.au>
Content-Type: text/plain
Date: Tue, 30 Dec 2008 06:19:20 +0100
Message-Id: <1230614360.15666.51.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> I looked at bccmd.c in /tools right after you posted - and hence solved 
> my problem.
> 
> I am, though, getting a strange error after sending an HCI inquiry command.
> 
> here are the first 15 lines of each response:
> 
> thingo: 0x04
> thingo: 0x0f
> thingo: 0x04
> thingo: 0x00
> thingo: 0x01
> thingo: 0x00
> thingo: 0x00
> thingo: 0x00
> thingo: 0x00
> thingo: 0x00
> 
> that packet is normal - command status event
> 
> thingo: 0x04
> thingo: 0x10
> thingo: 0x01
> thingo: 0x35
> thingo: 0x01
> thingo: 0x00
> thingo: 0x00
> thingo: 0x00
> thingo: 0x00
> thingo: 0x00
> 
> hardware error - but i cannot tell what the error code means (yes i will 
> check Core Spec 2.0 now :) )
> 
> thingo: 0x04
> thingo: 0xff
> thingo: 0x1f
> thingo: 0xc3
> thingo: 0x02
> thingo: 0x00
> thingo: 0x0f
> thingo: 0x00
> thingo: 0x20
> thingo: 0xa7
> 
> this packet looks like a CSR manufaturer specific response (0xff) what 
> does that mean?
> 
> even stranger is when run again and every subsequent time before a 
> reboot (of bluecore) it  works and gives back the correct amount of 
> hosts found!!!
> 
> Is it to do with some kind of baud error? Bluecore can adapt to 
> different baud rates just by looking at the data sent over time - but i 
> want to know what effect this - moreover what it mucks up.

you can use "hcidump -X -V -m 10" to have it decode CSR vendor commands
and events. It has support for decoding BCCMDs.

Regards

Marcel


