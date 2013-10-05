Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/2] Bluetooth: Make LE scan interval and window a controller option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <524F3872.7070609@openbossa.org>
Date: Sat, 5 Oct 2013 04:39:23 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B6CE6A9A-E989-4F48-B12D-D23C47FC36A2@holtmann.org>
References: <1380881955-59853-1-git-send-email-marcel@holtmann.org> <524F3872.7070609@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

>> The scan interval and window for LE passive scanning and connection
>> establishment should be configurable on a per controller basis. So
>> introduce a setting that later on will allow modifying it.
> 
> Each remote device has their particular set of parameters based on the profiles it support. So, these parameters should be per device, not per controller.
> 
> IIRC, we discussed about this in New Orleans and the connection parameters will be informed to the kernel through the Mgmt command to load the connection list. This way, we'll have the parameters set per device.
> 
> So I don't understand exactly what is the purpose of this command you are introducing. Am I missing something?

I looked through the core specification and also the scan parameters profile. And actually the way I read it is that these two values are pretty much controller centric.

So yes, depending on the profile you are running you can change them. Or if you are running on an active device or if your device is in sleep mode. However at the end of day, the kernel does not really care much what these two values are. It can not make any smart decision about it.

The way I read especially the scan parameters profile is that not the peripheral is telling us what would be good scan parameters. Instead the central is telling what scan parameters it is using and then the peripheral is suppose to adjust its advertising to it.

All the information to pick good scan parameters are based on the remote profiles and whatever the system is currently doing. So my current take is that we let bluetoothd make that call and set the right parameters and the kernel just uses them. Of course buetoothd can adjust these at runtime any time it wants to.

Settings like the connection interval are different. They are learned from the advertising data and can be used by the connection process. The scan internal and window however make no difference. For background scanning and auto-connection handling these values should be used. In case of pairing and direct connections, we better set them to same value to get a continuous scan anyway. Same as we do for active scanning during discovery right now.

If anybody knows any better, I am happy to discuss this, but that is what I got from reading the actual specifications.

Regards

Marcel

