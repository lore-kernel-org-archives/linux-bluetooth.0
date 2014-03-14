Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_Myxh+i50v+0bMJgDCActz4Na_fZdVbNuNjwCE7Bss_kQ@mail.gmail.com>
References: <CALdY0K5NNrrWdY73e44kp+QNxF2dizEyU44ny9k5h1YFQDf21w@mail.gmail.com>
	<CAJdJm_Myxh+i50v+0bMJgDCActz4Na_fZdVbNuNjwCE7Bss_kQ@mail.gmail.com>
Date: Fri, 14 Mar 2014 16:19:41 +0000
Message-ID: <CALdY0K6u0ZrJM-z7YKd2zmDzPStX2azVO-v4LUa385Ziq4uzOA@mail.gmail.com>
Subject: Re: Bluetooth low energy with gatttool and jawbone
From: Christian Bianchini <christian.bianchini@euservers.net>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

You were right!
Something happened, but I am not sure how to continue now, even
because after primary I get some data then the device disconnect
itself.

$ sudo gatttool -b DC:7A:F8:10:AF:A5 -t random -I
[   ][DC:7A:F8:10:AF:A5][LE]> connect
[CON][DC:7A:F8:10:AF:A5][LE]> primary
[CON][DC:7A:F8:10:AF:A5][LE]>
attr handle: 0x0001, end grp handle: 0x0007 uuid:
00001800-0000-1000-8000-00805f9b34fb
attr handle: 0x0008, end grp handle: 0x0008 uuid:
00001801-0000-1000-8000-00805f9b34fb
attr handle: 0x0009, end grp handle: 0x0012 uuid:
f7c9ba7e-6658-4390-b53c-1de5e1453654
attr handle: 0x0013, end grp handle: 0xffff uuid:
0000180a-0000-1000-8000-00805f9b34fb

I dont have bluetoothctl, there is special package for ubuntu?

thanks

On Fri, Mar 14, 2014 at 4:07 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Christian,
>
> On Fri, Mar 14, 2014 at 11:51 AM, Christian Bianchini
> <christian.bianchini@euservers.net> wrote:
>> I was trying to connect my Jawbone UP 24 with my pc to get some data from
>> this device.
>> This is how much I have done:
>>
>> $ sudo hcitool  lescan
>> LE Scan ...
>> DC:7A:F8:10:AF:A5 (unknown)
>> DC:7A:F8:10:AF:A5 UP24
>> DC:7A:F8:10:AF:A5 (unknown)
>> DC:7A:F8:10:AF:A5 (unknown)
>>
>> $ sudo hcitool lecc --random DC:7A:F8:10:AF:A5
>> Connection handle 70
>
> "hcitool lecc" is unnecessary and may cause problems, so just skip it.
> "connect" command for gatttool will do the right thing.
>
>>
>>  sudo gatttool -b DC:7A:F8:10:AF:A5 -I
>
> also pass "-t random" so you can connect to devices with random
> address (the detault used type is public).
>
>> [   ][DC:7A:F8:10:AF:A5][LE]> connect
>> [CON][DC:7A:F8:10:AF:A5][LE]>
>>
>>
>> After this I tried to type "primary" but I just get a timeout.
>
> First try the changes described above and see if it works.
>
>> The device should vibrate to accept the pairing, there is in someway to set
>> a PIN when pairing?
>
> If your device requires a PIN for pairing (and will not work without
> pairing), you need to do the pairing Using BlueZ and bluetoothctl.
> This will save the necessary LTK on the kernel and then you can try
> using gatttool again.
>
> bluetoothctl is a interactive tool (like gattttool -I), just type
> "help" to see available commands. I think you need at least these
> commands
>
> scan on
> # (wait for device to appear)
> scan off
> default-agent
> agent on
> pair <addr>
> # (here it should ask for PIN confirmation or entry)
> quit
>
> Then try gatttool as usual.
>
>>
>> Also I tried with my android, the procedure is the same:
>> - Scan for devices
>> - Find Jawbone
>> - Vibrate the device
>> - Press a button on the device
>> - The pairing is done
>
> Remember to clear pairing on the device side (this is device specific,
> usually it is a button sequence or menu) after using android app,
> otherwise pairing with BlueZ may fail with "PIN on key missing".
>
> Finally, I suggest running "btmon" on a terminal all the time so you
> can see the connection traffic and spot errors.
>
> Best Regards,
> --
> Anderson Lizardo
> http://www.indt.org/?lang=en
> INdT - Manaus - Brazil



-- 
---------------------------
Web/Mobile Developer
Luiis Group
christian@bianchini.ch
