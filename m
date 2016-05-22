Return-Path: <qingtao.cao.au@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1329FD88-F4DB-420F-8B69-DF45798745B7@holtmann.org>
References: <CAPcThSG+7dEmy=MpJnzYFTb+o__j=mZncjxKyQNqOfPYGdzTTg@mail.gmail.com>
	<CAPcThSG5AhO3tczS-D3QBptafg=6dabrkizOx-cT+1S2Cxpv4g@mail.gmail.com>
	<1329FD88-F4DB-420F-8B69-DF45798745B7@holtmann.org>
Date: Mon, 23 May 2016 09:12:45 +1000
Message-ID: <CAPcThSFzMjaYqm7aKum_WQJeamnEoE0wDzP7Eii5bYYCLLh4Pg@mail.gmail.com>
Subject: Re: How to enable hci0 for bcm4356 chip on htc m9?
From: Qingtao Cao <qingtao.cao.au@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Marcel for your information! I would check it out in more
recent kernel, it certainly makes a lot sense to complete the
mechanism in kernel space to download the minidrive provided by
userspace .hcd files :-)

Best regards,
Harry

On Fri, May 20, 2016 at 5:16 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Qingtao,
>
>> I've figured out how to enable hci0 for bcm4356 chipset on Linux other
>> than android. Turns out the bluedroid in CyanogenMod android for htc
>> m9 phone no longer uses bluez and its dbus interfaces any longer, no
>> wonder there is no hci0 found there.
>>
>> Turns out broadcom wifi/bt/fm chipset needs a special program to
>> download the required "mini driver" or *.hcd file to it at system
>> startup. Previously I tried to extract relevant code from broadcom's
>> libbt-vendor.so implementation for bluedroid, it was on the correct
>> direction but I hadn't unveiled all needed code. Turns out there is a
>> open source program for this purpose already, brcm_patchram_plus,
>> which could bring about the hci0 interface by the following command:
>>
>> ./brcm_patchram_plus -d --patchram
>> /system/etc/firmware/BCM4354A2_001.003.015.0064.0175.hcd --no2bytes
>> --baudrate 4000000 --use_baudrate_for_download --bd_addr
>> 90:E7:C4:F3:F7:09 --enable_hci --scopcm=3D0,4,0,0,0,1,0,3,0,0
>> /dev/ttyHS0 &
>>
>> Please note that bluetooth kernel driver needs to enable HCIUART and
>> HCIUART_H4 options to  activate relevant tty driver for the HCI-UART
>> interface. Of course, before running the above program, the bluetooth
>> hardware functionality should be powered on by "rfkill unblock
>> bluetooth" command, or directly writing 1 into relevant
>> /sys/class/rfkill/rfkillN/state file.
>>
>> Moreover, if the --scopcm option needs to be changed, the process of
>> brcm_patchram_plus can be killed and restarted, however, I found that
>> I also need to block and then unblock the bluetooth via rfkill command
>> otherwise it will fail to download the mini drivers in the hcd file.
>>
>> Last but not least, please note that the --scopcm option is not
>> working for me at the time being. I've already specified SCORouting =3D
>> PCM in audio.conf, but SCO-over-PCM doesn't work for me and I can't
>> hear anything from a connected bluetooth headset. Only change the SCO
>> routing to HCI (also requires the first byte, sco_routing, in the
>> --scopcm option, set to 1) would I hear some sound through the
>> headset, however, unfortunately, they are simply noise.
>
> we added hci_bcm.c kernel driver for driving Broadcom chips. We use it fo=
r some Broadcom UART based chips that are enumerated via ACPI. For DT we ar=
e still missing support, but should be easy to add. And then it will do the=
 proper baud rate setup, patchram download etc.
>
> Regards
>
> Marcel
>
