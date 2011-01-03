Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Jan 2011 14:29:27 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Jason Gooner <jgoonerz@gmx.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: hciemu / VHCI bluetooth module query
Message-ID: <20110103172926.GA2660@piper>
References: <20110103041034.193140@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110103041034.193140@gmx.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jason,

On 05:10 Mon 03 Jan, Jason Gooner wrote:
> Hi,
> 
> I have a couple of questions on hciemu and the Bluetooth Virtual HCI kernel module. Basically, I am trying to work out how much emulation for Bluetooth is already in place at the kernel level. My project essentially needs to fake a Bluetooth session i.e. emulate a device by injecting raw HCI packets into the kernel so that they get passed on to the higher level Bluez Bluetooth stack.
> 
> Would I be correct in thinking that the VHCI kernel module provides complete functionality for sending and receiving HCI frames? So, to emulate a Bluetooth device I could make a tool (adapt hciemu) to pass HCI packets into this module and they should get passed to Bluez somewhere along the line?
> 

The VHCI driver is pretty simple (and complete) implementation of a HCI 
Transport driver. I think that you are missing just one thing, the point of
VHCI is to emulate a Bluetooth controller i.e. a Bluetooth adapter.

> I want to simulate things like a file transfer with a Bluetooth device and I think im correct in saying it will all boil down to HCI packets which will encapsulate all other Bluetooth layers, so if I can pass these HCI packets into the kernel via the VHCI module that would be perfect. Is this the purpose of VHCI and is it complete enough in it's current state to send and receive HCI data?
> 

I think that the purpose of VHCI was to do tests without access to actual
hardware. The utopia would be a Bluetooth controller implemented entirely in
software that we could use to test BlueZ.

> I have tried using the HCIEmu tool with the VHCI module and it would be perfect if it worked, but I can't ping the created virtual device with l2ping. Does anyone know why? Surely the l2pings should just be passed up into bluez, if I knew what functionality was missing from hciemu/bluez that prevents the use of things like l2ping then I can work on adding them in.
> 

l2ping doesn't work because the virtual adapter can't be found by real
adapters. 

> So to paraphrase - I would like the device created by HCIEMU to respond appropriatly to all HCI commands it recieves - my understanding is this should just be a case of the hci packets being passed into bluez and sending back the response. It seems fairly near being complete, but I don't know what's pissing and preventing l2ping from working (and presumably other higher level bluetooth profiles e.g file transfer).
> 
> 
> Thanks for any help,
> 
> Jason
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
-- 
Vinicius
