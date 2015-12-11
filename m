Return-Path: <lists@battlepenguin.com>
Subject: Re: ath3k Bluetooth adapter not loading: [0cf3:3004] Atheros
 Communications, Inc. AR3012 Bluetooth 4.0
To: Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
 Marcel Holtmann <marcel@holtmann.org>
References: <556486B0.1020104@battlepenguin.com>
 <EEAFDBFC-C252-4843-A9E0-3E74EA21B665@holtmann.org>
 <557EBF98.2000701@battlepenguin.com>
 <A93AF220-83E9-4FC3-BC07-18B285E5FA3D@holtmann.org>
 <557EDE40.7070006@battlepenguin.com> <557F03E2.3000001@qca.qualcomm.com>
 <557F0FD2.7000000@battlepenguin.com> <55808CAB.3020205@qca.qualcomm.com>
 <55816C31.3050008@battlepenguin.com> <55816F6D.3030706@battlepenguin.com>
 <5581C269.5020401@qca.qualcomm.com> <55822E92.60609@battlepenguin.com>
 <53369F14-1B95-40B4-AAB1-3181ED18CFD7@qca.qualcomm.com>
 <55823473.8040400@battlepenguin.com> <5582EB3A.3020101@qca.qualcomm.com>
 <5582F2BD.9070409@battlepenguin.com> <5582F3DF.9080208@qca.qualcomm.com>
 <5592A20F.2030701@battlepenguin.com> <55932F7F.5030706@qca.qualcomm.com>
Cc: "Huang, Rick" <rickh@qti.qualcomm.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Sumit's Mailing Lists <lists@battlepenguin.com>
Message-ID: <566B3D32.60500@battlepenguin.com>
Date: Fri, 11 Dec 2015 21:16:34 +0000
MIME-Version: 1.0
In-Reply-To: <55932F7F.5030706@qca.qualcomm.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

On 01/07/15 01:08, Ben Young Tae Kim wrote:
> Hi Marcel,
>
> On 06/30/15 07:05, Sumit's Mailing Lists wrote:
>> Ben,
>>
>> Kvalo updated the wl-ath+ kernel fork to 4.1.0 so I attempted this again
>> to see if it might have been a bug that's been fixed.
>>
>> So I'm using https://github.com/kvalo/ath commit
>> 916a6fc66cc013dd67af0d5da546be0012ac2b2c
>>
>> with the following patch:
>>
>> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
>> index f40e194..35fee06 100644
>> --- a/drivers/bluetooth/Makefile
>> +++ b/drivers/bluetooth/Makefile
>> @@ -1,6 +1,7 @@
>>  #
>>  # Makefile for the Linux Bluetooth HCI device drivers.
>>  #
>> +CFLAGS_btusb.o := -DDEBUG
>>  
>>  obj-$(CONFIG_BT_HCIVHCI)       += hci_vhci.o
>>  obj-$(CONFIG_BT_HCIUART)       += hci_uart.o
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 94c6c04..1c476d8 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -194,7 +194,6 @@ static const struct usb_device_id blacklist_table[] = {
>>         { USB_DEVICE(0x0930, 0x0227), .driver_info = BTUSB_ATH3012 },
>>         { USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },
>>         { USB_DEVICE(0x0cf3, 0x0036), .driver_info = BTUSB_ATH3012 },
>> -       { USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
>>         { USB_DEVICE(0x0cf3, 0x3008), .driver_info = BTUSB_ATH3012 },
>>         { USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
>>         { USB_DEVICE(0x0cf3, 0x311e), .driver_info = BTUSB_ATH3012 },
>> @@ -224,6 +223,7 @@ static const struct usb_device_id blacklist_table[] = {
>>         { USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME },
>>         { USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME },
>>         { USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME },
>> +       { USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_QCA_ROME },
>>  
>>         /* Broadcom BCM2035 */
>>         { USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
>>
>>
>> I rebooted into linux-4.1.0-wl-ath+ and the very first command I ran was
>> "hciconfig hci0 up" and I still get the following in my kernel logs:
>>
>> [   30.011420] hci0
>> [   30.011439] Bluetooth: hci0: Failed to access otp area (-113)
>>
>> Here is my full kernel log: https://bpaste.net/show/96c4d5571356
>>
>> Sumit
>>
>>
> According to log, looks like patch download was done in btusb_open function, however, btusb_open was not completed after QCA patching steps were going through I believe.
>
> [    6.505349] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000200.bin
> [    6.505352] Bluetooth: hci0: QCA: patch rome 0x200 build 0x299, firmware rome 0x200 build 0x111
> [    6.558661] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000200.bin
> ...
>
> [    9.133753] hci0 urb ffff8800c9cbba80 status -2 count 0
> [    9.134085] hci0 urb ffff8800c9cbb9c0 status -2 count 0
> [    9.134377] hci0 urb ffff8800c9cbb300 status -2 count 0
>
> The status -2 means urb->status(-ENOENT). Haven you seen this error during sequences of btusb_open function? Could you give me some insight why we're getting -ENOENT error after patching is done?
>
> Hi Sumit,
>
> I'm expecting your card is up and running properly on Windows to make sure there is NO HW problem. Can you please double confirm? Addition to that, does WLAN(ath10k) work on your laptop?
>
> Thanks
> -- Ben Kim
>

Sorry it's taken so long for me to get back to this. I gave up and just
bought an external Bluetooth adapter for a while. I've been travelling
and my external dongle broke along the way, so I'm back to trying to get
the internal one working.

I'm now on linux-4.3.0 stock, using the same patch and getting the same
error when I attempt to turn on the bluetooth adapter using "power on"
from the bluetoothctl command line tool.

[10052.098236] Bluetooth: hci0: Failed to access otp area (-108)

I saw someone had updated the bugzilla bug and cited someone else who
used my patch and got their bluetooth working:

https://bugzilla.kernel.org/show_bug.cgi?id=99371
http://marc.info/?l=linux-bluetooth&m=144633933801493&w=2

So this still isn't working for me. As far as the question, "Does it
work in Windows" unfortunately I no longer have Windows installed on
this laptop and don't have the equipment (external hard drive or
something) to try to get a native install. If I run Windows in Virtual
Box and I try to connect the device, it still shows up at an ath3k
device and Windows 8 can't load the drivers.

Neither of the official driver packages from MSI for this laptop work if
I have it connected via VM, so I fell like I need to get Windows running
natively to really test it:

KillerSuite_1.1.53.1484_Win7_Win81
KillerDrivers_1.1.52.1438

Interestingly enough, when looking for the driver from MSI for windows,
it's apparently different for this same model of laptop. They changed
out the card throughout the production cycle. According to the bottom of
my laptop, the label says:

RF Module inside:
Qualcomm Atheros QCNFA34AC

But I guess that's just the wi-fi and not the bluetooth? The ath10k wifi
works perfectly in kernel 4.3.0.

The kernel logs still show the firmware loading:

[   11.128970] Bluetooth: hci0: using rampatch file:
qca/rampatch_usb_00000200.bin
[   11.128972] Bluetooth: hci0: QCA: patch rome 0x200 build 0x299,
firmware rome 0x200 build 0x111
[   11.184335] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000200.bin
[ 6886.445648] Bluetooth: hci0: using rampatch file:
qca/rampatch_usb_00000200.bin
[ 6886.445656] Bluetooth: hci0: QCA: patch rome 0x200 build 0x299,
firmware rome 0x200 build 0x111
[ 6886.499929] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000200.bin

So the patch will only apply if the chipset is correct right? Or can
this be successful even if it's the wrong chip?

Sumit
