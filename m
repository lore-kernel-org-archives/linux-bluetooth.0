Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/2] Bluetooth: Make LE scan interval and window a controller option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <52532774.60903@openbossa.org>
Date: Tue, 8 Oct 2013 00:19:00 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <16725035-59E1-413B-A534-18585ACC20F8@holtmann.org>
References: <1380881955-59853-1-git-send-email-marcel@holtmann.org> <524F3872.7070609@openbossa.org> <B6CE6A9A-E989-4F48-B12D-D23C47FC36A2@holtmann.org> <52532774.60903@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

>>>> The scan interval and window for LE passive scanning and connection
>>>> establishment should be configurable on a per controller basis. So
>>>> introduce a setting that later on will allow modifying it.
>>> 
>>> Each remote device has their particular set of parameters based on the profiles it support. So, these parameters should be per device, not per controller.
>>> 
>>> IIRC, we discussed about this in New Orleans and the connection parameters will be informed to the kernel through the Mgmt command to load the connection list. This way, we'll have the parameters set per device.
>>> 
>>> So I don't understand exactly what is the purpose of this command you are introducing. Am I missing something?
>> 
>> I looked through the core specification and also the scan parameters profile. And actually the way I read it is that these two values are pretty much controller centric.
>> 
>> So yes, depending on the profile you are running you can change them. Or if you are running on an active device or if your device is in sleep mode. However at the end of day, the kernel does not really care much what these two values are. It can not make any smart decision about it.
> 
> The way I see it, for connection (including background scan), the scan window and interval are Peripheral centric. I'll explain.
> 
> Each profile specification recommends the set of parameters for connection establishment (see the "Connection Establishment" section of the profiles specification, for instance HoGP, PXP, FMP). At that section we find the advertising parameters the profile recommends for those who are implementing the Peripheral side and the connection parameters (scan window, scan interval, connection maximum and minimum interval) recommended for those who are implementing the Central side. The profiles may have different connection parameters (e.g. HoGP and FMP).
> 
> So, based on the scanning parameters defined by the profiles the Central supports, we should configure the background scan. For instance, let's say we have three devices with the following scanning parameters:
> - Device A (HoGP): interval 22.5ms window 11.25ms
> - Device B (PXP): interval 60ms window 30ms
> - Device C (FMP): interval 60ms window 30ms
> 
> For that list of devices, the background scan should be configured with interval 22.5ms window 11.25ms. Now, let's say Device A connects. Then the background scan should be configured with interval 60ms window 30ms.

so I wonder if it is worth it to put this into the kernel. Or let userspace just configure it. And if needed just change it.

Regards

Marcel

