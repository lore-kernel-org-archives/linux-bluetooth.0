Return-Path: <cyrus@holtmann.org>
Message-ID: <52532774.60903@openbossa.org>
Date: Mon, 07 Oct 2013 18:28:20 -0300
From: Andre Guedes <andre.guedes@openbossa.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Make LE scan interval and window a controller
 option
References: <1380881955-59853-1-git-send-email-marcel@holtmann.org> <524F3872.7070609@openbossa.org> <B6CE6A9A-E989-4F48-B12D-D23C47FC36A2@holtmann.org>
In-Reply-To: <B6CE6A9A-E989-4F48-B12D-D23C47FC36A2@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 10/04/2013 11:39 PM, Marcel Holtmann wrote:
> Hi Andre,
>
>>> The scan interval and window for LE passive scanning and connection
>>> establishment should be configurable on a per controller basis. So
>>> introduce a setting that later on will allow modifying it.
>>
>> Each remote device has their particular set of parameters based on the profiles it support. So, these parameters should be per device, not per controller.
>>
>> IIRC, we discussed about this in New Orleans and the connection parameters will be informed to the kernel through the Mgmt command to load the connection list. This way, we'll have the parameters set per device.
>>
>> So I don't understand exactly what is the purpose of this command you are introducing. Am I missing something?
>
> I looked through the core specification and also the scan parameters profile. And actually the way I read it is that these two values are pretty much controller centric.
>
> So yes, depending on the profile you are running you can change them. Or if you are running on an active device or if your device is in sleep mode. However at the end of day, the kernel does not really care much what these two values are. It can not make any smart decision about it.

The way I see it, for connection (including background scan), the scan 
window and interval are Peripheral centric. I'll explain.

Each profile specification recommends the set of parameters for 
connection establishment (see the "Connection Establishment" section of 
the profiles specification, for instance HoGP, PXP, FMP). At that 
section we find the advertising parameters the profile recommends for 
those who are implementing the Peripheral side and the connection 
parameters (scan window, scan interval, connection maximum and minimum 
interval) recommended for those who are implementing the Central side. 
The profiles may have different connection parameters (e.g. HoGP and FMP).

So, based on the scanning parameters defined by the profiles the Central 
supports, we should configure the background scan. For instance, let's 
say we have three devices with the following scanning parameters:
- Device A (HoGP): interval 22.5ms window 11.25ms
- Device B (PXP): interval 60ms window 30ms
- Device C (FMP): interval 60ms window 30ms

For that list of devices, the background scan should be configured with 
interval 22.5ms window 11.25ms. Now, let's say Device A connects. Then 
the background scan should be configured with interval 60ms window 30ms.

> The way I read especially the scan parameters profile is that not the peripheral is telling us what would be good scan parameters. Instead the central is telling what scan parameters it is using and then the peripheral is suppose to adjust its advertising to it.

The Scan Parameters Profile seems to be useful in situation like the one 
described above. The Central is not using the recommends scanning 
parameters (since it has more than one set of parameters) so it informs 
the Peripheral what parameters it is using. The Peripheral does its best 
to configure its advertising interval according to the scanning 
parameters the Central is using.

> All the information to pick good scan parameters are based on the remote profiles and whatever the system is currently doing. So my current take is that we let bluetoothd make that call and set the right parameters and the kernel just uses them. Of course buetoothd can adjust these at runtime any time it wants to.

The background scanning parameters can be configured by bluetoothd or 
internaly by the kernel. At the moment, I'm not sure what option is the 
best.

> Settings like the connection interval are different. They are learned from the advertising data and can be used by the connection process. The scan internal and window however make no difference. For background scanning and auto-connection handling these values should be used. In case of pairing and direct connections, we better set them to same value to get a continuous scan anyway. Same as we do for active scanning during discovery right now.

The maximum and minimum connection intervals are defined by the profiles 
and/or in the advertising data.

The Central should use them to establish connection in order to optimize 
the energy comsuption on the Peripheral side. If the Central doesn't use 
the recommended parameters, the Peripheral may send a Connection 
Parameter Update Request through the signaling channel to change the 
connection parameters.

Regards,

Andre
