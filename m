Return-Path: <cyrus@holtmann.org>
Message-ID: <4A421E89.3080300@gdatech.co.in>
Date: Wed, 24 Jun 2009 18:09:37 +0530
From: Benjamin Vasanthakumar J <j.benjamin@gdatech.co.in>
MIME-Version: 1.0
To: John Frankish <j-frankish@slb.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Mixed Results Playing mp3
References: <6AC5A55546F64545AE996F8200E3AC4E06B17B90@NL0105EXC01V01.eur.slb.com>	<4A42056D.90600@wowway.com> <6AC5A55546F64545AE996F8200E3AC4E06B1802D@NL0105EXC01V01.eur.slb.com>
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E06B1802D@NL0105EXC01V01.eur.slb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear John Frankish,
>   
>> I get the following results:
>>
>> 1. mplayer-gtk1 (svn 29308): plays without problems
>>
>> 2. xmms-1.2.11: no error messages, but produces "noise" and "clicks" (the bluez wiki mentions "issues" with xmms).
>>
>> 3. aplay-1.0.20: Is it possible to play mp3 with aplay, if so, what command is required?
>>     
>
> aplay will not play mp3 encoded files.
>
>   
>> 4. mpg123-1.8.1: "mpg123 -v -a plug:bluetooth file.mp3", "mpg123 -v -a bluetooth file.mp3", no error messages, but produces "noise" and "clicks"
>>
>> I don't see why xmms and mpg123 wouldn't work and there are no error messages or pointers from "bluetoothd -dn" - does anybody have any ideas?
>>
>> -----------
>> pcm.rawbluetooth {
>>    type bluetooth
>>    device 00:12:EE:A6:1D:F4
>> }
>>
>> pcm.bluetooth {
>>    type plug
>>    slave {
>>       pcm {
>>          type bluetooth
>>          device 00:12:EE:A6:1D:F4
>>       }
>>    }
>> }
>>     
>
>
> Please refer to here:
>
> http://wiki.bluez.org/wiki/HOWTO/AudioDevices
>
>   
>> I did (and I tried this also with the same results), the .asoundrc I used is as per the example /etc/alsa/Bluetooth.conf provided in the bluez-4.41 tarball
>>     
>
> Your asoundrc differs from the example.
>
> Does your mpg123 support alsa?
>
>   
>> yes, it plays mp3 without problems via the machine's sound card
>>     
>
> John
>
>   
>> --
>>     
> Thanks for the reply

Whether .wav file play through 'aplay' is working fine for you?

At my side, I can hear only a beep tone. Please find the "bluetoothd 
-nd" log:

bluetoothd[2904]: Failed to access HAL
bluetoothd[2904]: Accepted new client connection on unix socket (fd=18)
bluetoothd[2904]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[2904]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[2904]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[2904]: open sco - object=ANY source=ANY 
destination=AE:2D:CC:AA:BB:1e
bluetoothd[2904]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[2904]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[2904]: State changed 
/org/bluez/2904/hci0/dev_AE_2D_CC_AA_BB_14: HEAS
bluetoothd[2904]: adapter_get_device(AE:2D:CC:AA:BB:14)
bluetoothd[2904]: Discovered Headset service on channel 2
bluetoothd[2904]: /org/bluez/2904/hci0/dev_AE_2D_CC_AA_BB_14: Connecting 
to AE:2
bluetoothd[2904]: /org/bluez/2904/hci0/dev_AE_2D_CC_AA_BB_14: Connected 
to AE:24
bluetoothd[2904]: telephony-dummy: device 0x20059db0 connected
bluetoothd[2904]: State changed 
/org/bluez/2904/hci0/dev_AE_2D_CC_AA_BB_14: HEAD
bluetoothd[2904]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[2904]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[2904]: State changed 
/org/bluez/2904/hci0/dev_AE_2D_CC_AA_BB_14: HEAS
bluetoothd[2904]: Received AT+VGS=8
bluetoothd[2904]: Received AT+VGM=8
bluetoothd[2904]: SCO socket opened for headset 
/org/bluez/2904/hci0/dev_AE_2D_4
bluetoothd[2904]: SCO fd=21
bluetoothd[2904]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[2904]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[2904]: State changed 
/org/bluez/2904/hci0/dev_AE_2D_CC_AA_BB_14: HEAG
bluetoothd[2904]: Unix client disconnected (fd=18)
bluetoothd[2904]: State changed 
/org/bluez/2904/hci0/dev_AE_2D_CC_AA_BB_14: HEAD
bluetoothd[2904]: client_free(0x200587d0)
*bluetoothd[2904]: No matching connection found for handle 45
bluetoothd[2904]: telephony-dummy: device 0x20059db0 disconnected*
bluetoothd[2904]: State changed 
/org/bluez/2904/hci0/dev_AE_2D_CC_AA_BB_14: HEAD

*Which is the SCORouting we need to give on the audio.conf, by default 
it is HCI?*


I do not have X server on my linux box, please suggest which are all the 
command line audio players I can use.

Please advice.
Thanks & Regards,
Benjamin
