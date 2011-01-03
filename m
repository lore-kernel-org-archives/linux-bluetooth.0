Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset="utf-8"
Date: Mon, 03 Jan 2011 05:10:33 +0100
From: "Jason Gooner" <jgoonerz@gmx.com>
Message-ID: <20110103041034.193140@gmx.com>
MIME-Version: 1.0
Subject: hciemu / VHCI bluetooth module query
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have a couple of questions on hciemu and the Bluetooth Virtual HCI kernel module. Basically, I am trying to work out how much emulation for Bluetooth is already in place at the kernel level. My project essentially needs to fake a Bluetooth session i.e. emulate a device by injecting raw HCI packets into the kernel so that they get passed on to the higher level Bluez Bluetooth stack.

Would I be correct in thinking that the VHCI kernel module provides complete functionality for sending and receiving HCI frames? So, to emulate a Bluetooth device I could make a tool (adapt hciemu) to pass HCI packets into this module and they should get passed to Bluez somewhere along the line?

I want to simulate things like a file transfer with a Bluetooth device and I think im correct in saying it will all boil down to HCI packets which will encapsulate all other Bluetooth layers, so if I can pass these HCI packets into the kernel via the VHCI module that would be perfect. Is this the purpose of VHCI and is it complete enough in it's current state to send and receive HCI data?

I have tried using the HCIEmu tool with the VHCI module and it would be perfect if it worked, but I can't ping the created virtual device with l2ping. Does anyone know why? Surely the l2pings should just be passed up into bluez, if I knew what functionality was missing from hciemu/bluez that prevents the use of things like l2ping then I can work on adding them in.

So to paraphrase - I would like the device created by HCIEMU to respond appropriatly to all HCI commands it recieves - my understanding is this should just be a case of the hci packets being passed into bluez and sending back the response. It seems fairly near being complete, but I don't know what's pissing and preventing l2ping from working (and presumably other higher level bluetooth profiles e.g file transfer).


Thanks for any help,

Jason
