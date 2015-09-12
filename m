Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: hcidump does not show all traffic
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <3717569.7lEr2NYy4T@eik132.beelaertsict.nl>
Date: Sat, 12 Sep 2015 11:18:09 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <19D4F963-B41D-4617-9AC1-F79EBE554A2C@holtmann.org>
References: <16191327.qpDB01f2sL@eik132.beelaertsict.nl> <9EAE4CF9-7F4F-4DD8-A983-B9393DFFD339@holtmann.org> <3717569.7lEr2NYy4T@eik132.beelaertsict.nl>
To: Freek de Kruijf <f.de.kruijf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Freek,

>>> I am trying to monitor the traffic between my linux system and an external
>>> bluetooth system using the command "hcidump -i hci0 -w filename". I only
>>> catch some traffic from the host to the external device, but nothing from
>>> the device to the host. I analyze the file using wireshark.
>> 
>> you need a newer Wireshark version. I remember it had some issues with
>> correctly decoding the base packet types. Double check with btmon or
>> hcidump that all traffic is actually in the file.
> 
> I finally found the cause. The bluetooth communication was between an 
> application of a normal user and the device. I used hcidump from the same 
> user. Now that I use hcidump as root I get all the traffic. Silly mistake.
> 
> I would propose to put some text in the man page of hcidump about using the 
> command only as root. Maybe it should be installed in sbin instead of bin.

just start using btmon instead of hcidump.

Regards

Marcel

