Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: mkj@gotu.dk (Martin =?utf-8?Q?Kj=C3=A6r_J=C3=B8rgensen?=)
To: Frank Praznik <frank.praznik@gmail.com>
Cc: Antonio Ospite <ao2@ao2.it>, linux-bluetooth@vger.kernel.org
Subject: Re: DS4 issues
References: <20151221144607.GA18773@mkjlap.gotu.dk>
	<20151228101822.03253569407ac9dfe4ea15be@ao2.it>
	<0F6173F5-CF72-47E8-BB6B-44200F75EB6E@gmail.com>
	<20151228164042.GA20182@mkjlap.gotu.dk>
	<20151230110944.GA11559@mkjlap.gotu.dk>
	<7A34E2B1-A42C-4162-80FC-F2C9E8796F67@gmail.com>
Date: Sun, 14 Feb 2016 11:47:07 +0100
In-Reply-To: <7A34E2B1-A42C-4162-80FC-F2C9E8796F67@gmail.com> (Frank Praznik's
	message of "Wed, 30 Dec 2015 10:36:10 -0500")
Message-ID: <87k2m7602c.fsf@gotu.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On ons, dec 30 2015, Frank Praznik <frank.praznik@gmail.com> wrote:

>> On Dec 30, 2015, at 06:09, Martin Kjær Jørgensen <mkj@gotu.dk> wrote:
>> 
>> On Mon, Dec 28, 2015 at 05:40:42PM +0100, Martin Kjær Jørgensen wrote:
>>> On Mon, Dec 28, 2015 at 10:48:21AM -0500, Frank Praznik wrote:
>>>> 
>>>>> On Dec 28, 2015, at 04:18, Antonio Ospite <ao2@ao2.it> wrote:
>>>>> 
>>>>> On Mon, 21 Dec 2015 15:46:07 +0100
>>>>> Martin Kjær Jørgensen <mkj@gotu.dk> wrote:
>>>>> 
>>>>>> Is there any "full" support for a Sony DualShock 4 in the bluez/kernel
>>>>>> stack?
>>>>>> 
>>>>> 
>>>>> CC-ing Frank as he is the author of the DS4 hid kernel driver.
>>>>> 
>>>>>> The one I own works perfectly when using USB cable.
>>>>>> 
>>>>>> When using bluetooth it gets recognized as a somewhat generic
>>>>>> Bluetooth Wireless Controller. Pairing it up with my system seems to
>>>>>> work as it creates a joystick device (/dev/input/js0) but when testing
>>>>>> it with jstest, only the touchpad on the DS4 triggers two of the
>>>>>> axis. None of the buttons or sticks reacts in jstest.
>>>>>> Pairing it with the usual bluetoothctl makes the DS4 LED dimmed blue
>>>>>> light.
>>>>>> 
>>>>>> I know of the ds4drv project and have used it to connect my DS4, but
>>>>>> it seems a big buggy and I was hoping it was or will be merged into
>>>>>> bluez/kernel, making it superfluous.
>>>>>> 
>>>>>> Using the DS4 makes the LED brighter than using ordinary bluetoothctl,
>>>>>> perhaps because ds4drv knows how to intruct the LED.
>>>>>> Even if my DS4 is almost next to my bluetooth radio device, the ds4drv
>>>>>> reports "Signal strength low (29/40/38) reports"
>>>>>> Testing with jstest seems to trigger all buttons and axises. The
>>>>>> touchpad itself as a button triggers, but touching the pad doesnt trigger
>>>>>> anything.
>>>>>> In some games the digital keys on the left doesnt get recognized, even
>>>>>> if they get triggered by jstest and other programs like Steam
>>>>>> recognizes them.
>>>>>> 
>>>>>> 
>>>>>> 
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>> 
>>>>> 
>>>>> --
>>>>> Antonio Ospite
>>>>> http://ao2.it
>>>>> 
>>>>> A: Because it messes up the order in which people normally read text.
>>>>> See http://en.wikipedia.org/wiki/Posting_style
>>>>> Q: Why is top-posting such a bad thing?
>>>> 
>>>> What kernel version are you using and how new the controller?  This sounds
>>>> like a bug others were having due to Sony making a change to the HID
>>>> descriptor in the controller firmware.  It’s been fixed in newer kernels, but it
>>>> will take time for the fix to make it’s way to most distros.
>>> 
>>> uname -a:
>>> Linux mkjlap 4.3.0-1-amd64 #1 SMP Debian 4.3.3-2 (2015-12-17) x86_64 GNU/Linux
>>> 
>>> DS4 is bought recently withing this month (dec,2015). The boxes for
>>> the controller are thrown out. The model is: CUH-ZCT1E if that is of
>>> any help.
>>> 
>>>> 
>>>> The patch is here if you are interested:
>>>> http://thread.gmane.org/gmane.linux.kernel.input/46634/focus=46902
>>> 
>>> Great. I'll try it.
>>> 
>>>> 
>>>> Regards,
>>>> Frank
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> I've patched the hci-sony.c with the source from the link above on the coresponding kernel source for my kernel, but no luck.
>> 
>> [18424.148328] sony 0005:054C:05C4.0008: Using modified Dualshock 4 Bluetooth report descriptor
>> [18424.149550] input: Wireless Controller as /devices/virtual/misc/uhid/0005:054C:05C4.0008/input/input24
>> [18424.150029] sony 0005:054C:05C4.0008: input,hidraw5: BLUETOOTH HID v1.00 Gamepad [Wireless Controller] on 28:B2:BD:94:0C:4F
>> [18429.149962] sony 0005:054C:05C4.0008: failed to set the Dualshock 4 operational mode
>> [18429.182447] sony: probe of 0005:054C:05C4.0008 failed with error -5
>> [18589.591829] sony 0005:054C:05C4.0009: Using modified Dualshock 4 Bluetooth report descriptor
>> [18589.592609] input: Wireless Controller as /devices/virtual/misc/uhid/0005:054C:05C4.0009/input/input25
>> [18589.592851] sony 0005:054C:05C4.0009: input,hidraw5: BLUETOOTH HID v1.00 Gamepad [Wireless Controller] on 28:B2:BD:94:0C:4F
>> [18594.595254] sony 0005:054C:05C4.0009: failed to set the Dualshock 4 operational mode
>> [18594.631481] sony: probe of 0005:054C:05C4.0009 failed with error -5
>> 
>> The reason for the two sony outputs is because I restarted
>> bluetooth.service after the first failure.
>> Using the DS4 with a USB cable still works as espected.
>
> Error -5 is an IO error which means that something in the Bluetooth
> communication stack is failing when the host tries to communicate with
> the controller.  The next step would be to run hcidump and see exactly
> what is happening when the system tries to talk to the controller.
>
> Are you running at least version 5.14 of BlueZ?

I'm running latest from Debian Testing:

$ bluetoothctl -v
5.36

Anything in particular to look for, or should I just dump the packets in
a file?
