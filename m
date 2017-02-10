Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Scanning for advertising packets more often
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <508E30B7-76A0-4589-8D2D-5C736695E4C4@gmail.com>
Date: Fri, 10 Feb 2017 12:36:06 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <550F50C3-6A06-450E-A065-796809BFED62@holtmann.org>
References: <508E30B7-76A0-4589-8D2D-5C736695E4C4@gmail.com>
To: Bridger Maxwell <bridger.maxwell@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bridger,

> I’m trying to make a Bluetooth LE peripheral that will work without pairing. Instead, multiple receivers can listen for events by listening for changes in the advertising packet. I’ve got the peripheral configured to broadcast every 100ms, but the receiver running Bluez only gets updates about once per second.
> 
> Is there a way to configure Bluez to get advertising packets scanned more often? I’d also like to turn off any duplicate filtering.
> 
> Additionally, the peripheral broadcasts two types of advertising packets. One type is from the builtin firmware and I don’t care about. The other type is my custom advertising packet. Both of these have the same MAC address. I believe Bluez is filtering duplicates from the same address within each 1 second window. I am getting a random sampling of either the firmware advertising packet or my custom advertising packet once per second.
> 
> I’m using Pybluez[ble] to use Bluez. This is the scratch script I have running so far: https://gist.github.com/bridger/83fc2e9c60fd07d925b0bec80c47acab I tried using LE_SET_SCAN_PARAMETERS to change the scan interval and window but this didn’t seem to have an effect.
> 
> If this is a bad idea, let me know. I liked the simplicity of not pairing but maybe I’m headed in the wrong direction.

scanning without duplicate filtering is a pretty nasty thing from a power consumption point of view. It is not that BlueZ (and the kernel) can not handle it. It is just that it will cause many wakeups.

Question is if you know the BD_ADDR of your peripheral ahead of time and just want to disable duplicate filtering for a device we can stick into the whitelist or if you want to do it for all devices. I am really reluctant to enable this for all devices. Since people test this in their small setup with only a few devices around. And then it goes into the wild and you enter areas with millions of LE advertising packets around. And then out of the sudden all hell breaks loose. We have been extremely cautious with using duplicate filtering and the whitelist for all our transaction driven by the kernel.

Regards

Marcel

