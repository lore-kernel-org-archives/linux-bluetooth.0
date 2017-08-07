Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <11841060.dynqo2U1Dt@gentooasus>
References: <2299304.XBxEXHNB4J@gentooasus> <11841060.dynqo2U1Dt@gentooasus>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Mon, 7 Aug 2017 08:56:29 +0200
Message-ID: <CAAEJBhJ-ho-uvEw0QACzNY6qKkb1EbtTpsRfVhx8jqevFZ8+8A@mail.gmail.com>
Subject: Re: [RFC][PATCH BlueZ] sixaxis: Differing device name between usb and
 bluetooth connection
To: Nicolas Werner <nicolas.werner@gmx.net>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nicolas,

On 4 August 2017 at 22:29, Nicolas Werner <nicolas.werner@gmx.net> wrote:
> Am Samstag, 4. Februar 2017, 19:16:28 CEST schrieben Sie:
>> BlueZ sets the device name of Dual Shock 3 controller to "PLAYSTATION(R)3
>> Controller". When you connect the same controller via USB it is set to "Sony
>> PLAYSTATION(R)3 Controller".
>>
>> It seems that at least some games fail to recognize the controller as a Dual
>> Shock 3/sixaxis controller and don't load the default mapping for
>> PlayStation controllers, if the name doesn't contain the Sony part. Also I
>> don't see a reason to use a different name, when connecting via Bluetooth.
>>
>> I noticed this with "The Binding of Isaac: Rebirth" and it seems, that Steam
>> also recognizes the controller better after the patch, although I'm not
>> confident, if I can parse the controller configuration dialog correctly. I
>> don't know, if this breaks anything, because it depends on the current
>> name.
>>
>> The attached patch changes the device name set when pairing to match the
>> device name, when connected via USB.
>>
>> Nicolas Werner
>>
>> --- a/plugins/sixaxis.c
>> +++ b/plugins/sixaxis.c
>> @@ -56,7 +56,7 @@
>>         uint16_t version;
>>  } devices[] = {
>>         {
>> -               .name = "PLAYSTATION(R)3 Controller",
>> +               .name = "Sony PLAYSTATION(R)3 Controller",
>>                 .source = 0x0002,
>>                 .vid = 0x054c,
>>                 .pid = 0x0268,
>
> It seems I'm not the only one with this issue as I recently found this issue
> (https://bugzilla.kernel.org/show_bug.cgi?id=195225) in the kernel bug
> tracker. It looks like dual shock 4 controllers have a similar issue.
>
> I asked on IRC and someone recommended to ping this message. Again, I would
> appreciate some comments on this issue and it would be great if this issue
> could be fixed.

I'm not sure where I took original name from (probably this is how DS3
presents itself over BT).
Anyway, if this fix the problem I'm fine with changing the name (and
patch looks OK). Could you send a proper patch created with 'git
format-patch'?

As for DS4 this is a bit more trickier since that name is the name
device use over BT and we would probably have to spoof it...

-- 
pozdrawiam
Szymon K. Janc
