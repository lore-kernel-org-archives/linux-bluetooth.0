Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: Keeping hci interface powered
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <m3oaqfl79f.fsf@carbon.jhcloos.org>
Date: Sat, 3 Jan 2015 17:40:06 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D043D131-E9F8-43C1-8671-0EACAE810420@holtmann.org>
References: <m3oaqfl79f.fsf@carbon.jhcloos.org>
To: James Cloos <cloos@jhcloos.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi James,

> I recently assembled a box for htpc duties, including a bluetooth
> keyboard.
> 
> It mostly works, except that the hci interface continually powers down.
> 
> I suspect every time the keyboard powers down,the hci does, too.
> 
> How can I prevent that?
> 
> I want the hci always to be powered, so that the keyboard can reconnect
> every time I hit a key.
> 
> As it is, whenever I want to use it, I have to ssh in from another
> system, run bluetoothctl and therein run power on and connect $MAC.

it should not do that at all. Once a controller is powered that should stay until you tell it otherwise.

However what might happen is that the whole machine goes to sleep and the Bluetooth controllers gets kicked off the USB bus. That is something we can't do anything about. So check dmesg and look for USB disconnects.

You can also check with btmon what happens when the keyboard disconnects. If the controller goes away it will tell you as well.

Regards

Marcel

