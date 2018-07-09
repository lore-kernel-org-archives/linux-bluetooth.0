Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Bluetooth connection disconnects every few minutes
To: pulseaudio-discuss@lists.freedesktop.org,
        Georg Chini <georg@chini.tk>,
        General PulseAudio Discussion
        <pulseaudio-discuss@lists.freedesktop.org>,
        linux-bluetooth@vger.kernel.org
References: <67077b05-dc49-3a97-c83f-4090f1cc7cea@gmail.com>
 <phdhvi$sdh$1@blaine.gmane.org>
 <8e41e2ae-bef4-d479-9706-49fd214081a6@chini.tk>
 <phdpkn$q3q$1@blaine.gmane.org> <pht30d$27m$1@blaine.gmane.org>
 <53d57478-4b61-65a4-7f09-b7e473cc613a@chini.tk>
From: Julian Sikorski <belegdol@gmail.com>
Message-ID: <305017ee-6420-3c44-7842-14776c37207d@gmail.com>
Date: Mon, 9 Jul 2018 18:51:16 +0200
MIME-Version: 1.0
In-Reply-To: <53d57478-4b61-65a4-7f09-b7e473cc613a@chini.tk>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

W dniu 08.07.2018 o 19:46, Georg Chini pisze:
> On 08.07.2018 15:21, Julian Sikorski wrote:
>> W dniu 02.07.2018 o 20:09, Julian Sikorski pisze:
>>> W dniu 02.07.2018 o 18:04, Georg Chini pisze:
>>>> On 02.07.2018 17:58, Julian Sikorski wrote:
>>>>> W dniu 29.06.2018 o 21:47, Julian Sikorski pisze:
>>>>>> Hi list,
>>>>>>
>>>>>> I have noticed that the bluetooth connection between my laptop (Intel
>>>>>> 7260) and my headphones (Sennheiser Momentum Wirelless) is very
>>>>>> unreliable. While under Windows 10 devices stay connected for
>>>>>> hours on
>>>>>> end, under Fedora 28 the connection is lost every few minutes at
>>>>>> most.
>>>>>> Often the connection will be reestablished only to be lost again.
>>>>>> bluetoothd shows messages like:
>>>>>>
> 
>>>>>> I am not sure where to look further. Does it look like an issue with
>>>>>> pulseaudio, or a deeper problem with linux bluetooth stack? Thanks
>>>>>> for
>>>>>> your input in advance!
>>>>>>
>>>>>> Best regards,
>>>>>> Julian
>>>>> This is what is logged by pulseaudio at the time the connection is
>>>>> lost:
>>>>>
>>>>> ( 118.064|  34.694) I: [bluetooth] module-bluez5-device.c: FD error:
>>>>> POLLERR POLLHUP
>>>>> ( 118.064|   0.000) I: [bluetooth] bluez5-util.c: Transport
>>>>> /org/bluez/hci0/dev_00_1B_66_81_8D_76/fd27 auto-released by BlueZ or
>>>>> already released
>>>>> ( 118.064|   0.000) I: [pulseaudio] backend-native.c: Lost RFCOMM
>>>>> connection.
>>>>>
>>>>>
>>>>  From what you are writing, it looks to me as if the issue is in the
>>>> USB
>>>> stack and the BT dongle keeps disconnecting/connecting. Have you
>>>> tried another dongle?
>>> Hi,
>>>
>>> I unfortunately do not own any other dongles. I tried getting some
>>> useful info with btmon but the log seems flooded with way too many
>>> messages to make anything out.
>>>
>> Hi Georg,
>>
>> it looks like the problem is more related to how the dongle interacts
>> with this specific headphone model. I have recently bought another one
>> for running (AfterShokz Trekz Air) and it works perfectly, connecting
>> automatically, staying connected and even switching profiles
>> automatically without issues so far.
>> The hci0: last event is not cmd complete (0x0f) message seems harmless
>> as it spams the dmesg output regardless of the device connected (and
>> also when no device is connected at all.
>> It appears that whatever is happening it makes the dongle reconnect:
>>
>> [nie lip  8 15:14:12 2018] usb 2-1.4: USB disconnect, device number 6
>> [nie lip  8 15:14:12 2018] usb 2-1.4: new full-speed USB device number 7
>> using ehci-pci
>> [nie lip  8 15:14:12 2018] usb 2-1.4: New USB device found,
>> idVendor=8087, idProduct=07dc, bcdDevice= 0.01
>> [nie lip  8 15:14:12 2018] usb 2-1.4: New USB device strings: Mfr=0,
>> Product=0, SerialNumber=0
>> [nie lip  8 15:14:12 2018] Bluetooth: hci0: read Intel version:
>> 3707100180012d0d2a
>> [nie lip  8 15:14:12 2018] Bluetooth: hci0: Intel device is already
>> patched. patch num: 2a
>>
>> Where would you recommend to look for reasons for this behaviour? btmon?
>> Thank you for the pointers!
>>
>> Best regards,
>> Julian
>>
>>
> Hi Julian,
> 
> sorry, I have no further ideas. Maybe Luiz can help you to investigate.
> To me it looks like the headphone is sending something that makes the
> dongle reset.
> 
> Regards
>             Georg

Hi Georg,

no worries - hopefully Luiz will find some time to look into this.
In the meantime I have been getting acquainted with btmon. I have
managed to pinpoint the exact moment during which sound stops coming
through the headphones and starts coming through the laptop speakers. In
the below testcase, it happens at 18:42:58:

< ACL Data TX: Handle 256 flags 0x02 dlen 850
                              #1825 [hci0] 18:42:58.908586
      Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
< ACL Data TX: Handle 256 flags 0x02 dlen 850
                              #1826 [hci0] 18:42:58.928877
      Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
@ MGMT Event: Class Of Device Changed (0x0007) plen 3
                           {0x0002} [hci0] 18:43:00.653578
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
@ MGMT Event: Class Of Device Changed (0x0007) plen 3
                           {0x0001} [hci0] 18:43:00.653578
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
@ MGMT Event: New Settings (0x0006) plen 4
                           {0x0002} [hci0] 18:43:00.653609
        Current settings: 0x00000ada
          Connectable
          Discoverable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Event: New Settings (0x0006) plen 4
                           {0x0001} [hci0] 18:43:00.653609
        Current settings: 0x00000ada
          Connectable
          Discoverable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
= bluetoothd: Unable to get io data for Headset Voice gateway:
getpeername: Transport endpoint is not connected..   18:43:00.654133
= Close Index: 7C:5C:F8:B2:DF:08
                                    [hci0] 18:43:00.678348
@ MGMT Event: Index Removed (0x0005) plen 0
                           {0x0002} [hci0] 18:43:00.678372
@ MGMT Event: Index Removed (0x0005) plen 0
                           {0x0001} [hci0] 18:43:00.678372
= Delete Index: 7C:5C:F8:B2:DF:08
                                    [hci0] 18:43:00.678377
= bluetoothd: Endpoint unregistered: sender=:1.1492
path=/MediaEndpoint/A2DPSource
18:43:00.678966
= bluetoothd: Endpoint unregistered: sender=:1.1492
path=/MediaEndpoint/A2DPSink
18:43:00.678984

I am copying linux-bluetooth, maybe someone there will have an idea as
well. Thank you for all your help in advance!

Best regards,
Julian
