Return-Path: <cyrus@holtmann.org>
Message-ID: <5512919B.9000707@broadcom.com>
Date: Wed, 25 Mar 2015 11:44:43 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: =?ISO-8859-1?Q?J=FCrgen_Bausa?= <juergen.Bausa@online.de>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>
Subject: Re: Broadcom 43340 BT support
References: <201503242237.07923.Juergen.Bausa@online.de> <F2171E58-C919-4EEB-9305-6BC3858A7242@holtmann.org>
In-Reply-To: <F2171E58-C919-4EEB-9305-6BC3858A7242@holtmann.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/25/15 00:42, Marcel Holtmann wrote:
> Hi Juergen,
>
>> I have a laptop (asus x205ta / intel-baytrail) with the broadcom 43340
>> chipset. However, while wireless is working now, bluetooth is not. I am
>> running debian jessie 32 bit with kernel 4.0rc4:
>>
>> root@lina:/home/jba# hciconfig --all
>> hci0:   Type: BR/EDR  Bus: SDIO
>>         BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
>>         DOWN
>>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
>>         Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>>         Packet type: DM1 DH1 HV1
>>         Link policy:
>>         Link mode: SLAVE ACCEPT
>
> can you figure out which driver is claiming that it is SDIO based? I assumed the Baytrail Bluetooth controllers are all attached via UARTs. I didn't know that Broadcom had Bluetooth on SDIO. The WiFi part yes, but the Bluetooth part should be on an UART.

According to documentation SDIO function #3 is providing access to BT 
over SDIO. However, I did not (yet) come across any device that uses 
that. I did find some devices where function #3 cis says BT and btsdio 
claims it, but the BT part is not hooked up to it. So it is either usb 
or uart. For uart our BT group plans to upstream a new driver (something 
they never did before), but have not heard much on that recently.

> Please also check with "rfkill list" if the device might be blocked.
>
> Arend might know more, but you would need to dig into the list of SDIO devices. Sadly I think Linux does not yet have a lssdio tool. So maybe lshw can get us some info on what the kernel thinks about this device. Alternatively you need to dig you sysfs and look at ACPI. Maybe dmesg reveals something useful.

You can confirm it is function #3 of the same mmc device as wifi, but 
chances are BT requires the UART driver.

Regards,
Arend

> Regards
>
> Marcel
>
