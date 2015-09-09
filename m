Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: MacbookPro12,1 Bluetooth not found by Bluez
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441788082.8206.0@mail.quuxo.net>
Date: Wed, 9 Sep 2015 08:21:22 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CF352616-2132-4266-92B6-4F643C69BE5D@holtmann.org>
References: <1441775933.3223.2@mail.quuxo.net> <8B052FF6-9EF3-4A9D-9ECA-773B40DC807E@holtmann.org> <1441788082.8206.0@mail.quuxo.net>
To: Michael Gratton <mike@vee.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

>>> Is there anything I can do to help debug this?
>> check /sys/kernel/debug/usb/devices for the Bluetooth controller entry.
> 
> The following is reported there:
> 
> T: Bus=01 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#= 2 Spd=12 MxCh= 0
> D: Ver= 2.01 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=05ac ProdID=8290 Rev= 0.90
> S: Manufacturer=Broadcom Corp.
> S: Product=Bluetooth USB Host Controller
> C:* #Ifs= 6 Cfg#= 1 Atr=e0 MxPwr= 0mA
> A: FirstIf#= 2 IfCount= 4 Cls=ff(vend.) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID ) Sub=01 Prot=01 Driver=usbhid
> E: Ad=85(I) Atr=03(Int.) MxPS= 8 Ivl=10ms
> I:* If#= 1 Alt= 0 #EPs= 1 Cls=03(HID ) Sub=01 Prot=02 Driver=usbhid
> E: Ad=86(I) Atr=03(Int.) MxPS= 8 Ivl=10ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
> E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
> E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> I: If#= 3 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> I: If#= 3 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> I: If#= 3 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> I: If#= 3 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> I: If#= 3 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> E: Ad=84(I) Atr=02(Bulk) MxPS= 32 Ivl=0ms
> E: Ad=04(O) Atr=02(Bulk) MxPS= 32 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

okay, this is new. Is this by any chance the new Broadwell based MacBook Pro from beginning of the year?

>>> Kernel logs:
> [snip]
>>>> [ 10.254634] usbcore: registered new interface driver btusb
>>>> ...
>>>> [ 16.642700] usb 1-3: device descriptor read/64, error -110
>> This might actually be the problem. It seems the Bluetooth controller gets detected correctly and the btusb driver loaded, but then we get some issues with the descriptor reading.
>> Does the original Ubuntu 15.10 kernel work or any other kernel than 4.2-rc8. If you find a working kernel, you might need to bisect this. However my feeling is that this might be an issue in the USB host controller or somewhere else.
> 
> Just rebooted into the stock Ubuntu 4.2.0 kernel - same result. I upgraded this system from 15.04, which was running 3.19, and this problem existed with that version as well.
> 
>> In general all MacBook Bluetooth controllers are suppose to work. If you happen to still have OS X installed, then start it and see if it might runs a firmware upgrade for the controller.
> 
> I don't - I might be able to try it form an external hard drive over the next few days however. Will report back if I do manage to.

If you can, then that would be great, however I assume that with the new Broadwell designs they have picked new Broadcom controllers and instead of hiding behind an internal USB hub, the devices are multi-function devices with HID and Bluetooth combined into a single USB device.

I do think there is an update of the Bluetooth controller firmware from 0.90 that you have to 1.04 at least. While it might not make the controller work, but it might fix actual Bluetooth bug in the firmware that you would stumble over later. So try to boot up an OS X if you can. If this is the BCM20703A1 chip from Broadcom, then they are rather new and having an updated firmware helps there.

We have the following statement in probe function:

        /* interface numbers are hardcoded in the spec */                        
        if (intf->cur_altsetting->desc.bInterfaceNumber != 0)                    
                return -ENODEV;

This will avoid activating the device correctly in your case.

As a background, we chose to do it this simple since Bluetooth is a multi-interface device by itself. It uses interface 0 (for ACL/cmd/evt) and also interface 1 (for SCO). So the interface numbers are pretty much hard coded and in the last 15 years nobody did it different. However it seems you find the first device that does this differently now.

So you change the above 0 to a 2 and the later on then 1 to a 3.

                /* Interface numbers are hardcoded in the specification */       
                data->isoc = usb_ifnum_to_if(data->udev, 1);

This should get you your controller working, but obviously that is just for testing. The real fix is a lot more complicated and such a simple change will break every other Bluetooth dongle you might want to play with.

Regards

Marcel

