Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: Zygo Blaxell <zblaxell@feedme.hungrycats.org>
Subject: Re: The link I had working quit.  Help
Date: Wed, 08 Apr 2009 00:11:10 -0400
Cc: Zygo Blaxell <zblaxell@dactyl.hungrycats.org>,
	linux-bluetooth@vger.kernel.org
References: <200904041636.25409.gene.heskett@verizon.net>
 <200904070008.48621.gene.heskett@verizon.net>
 <20090407204055.GB18671@hungrycats.org>
In-reply-to: <20090407204055.GB18671@hungrycats.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-15
Message-id: <200904080011.10597.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 07 April 2009, Zygo Blaxell wrote:
>On Tue, Apr 07, 2009 at 12:08:48AM -0400, Gene Heskett wrote:
>> On Monday 06 April 2009, Zygo Blaxell wrote:
>> >Do you seriously have a Coco3 wired up to Bluetooth?  How?  Presumably
>> > not with a native stack...some kind of dongle?
>>
>> Roger Taylor is selling a remake of the old Deluxe RS-232 pack, with an a7
>> eb101 module taking the place of the db25 connector.  $65.  Uses the same
>> old rs-232 drivers.  He is one of the movers & shakers of the coco list on
>> maltedmedia.com.
>
>After reading http://www.a7eng.com/downloads/a7-ds-eb101.pdf it looks
>like the device has an automatic discovery mode which is activated by
>pressing a switch for more than 5 but less than 10 seconds.  It seems
>to assume it's talking to another device which has a serial port profile
>service enabled...maybe it only works with other eb101's.
>
>It also has a command mode (http://www.a7eng.com/downloads/a7-qs-serial.pdf)
>which lets you read things like the device settings and information about
>remote devices from the module's point of view.  Especially interesting
>ones (page 9) are:
>
>	get connectable  (should be on)
>	get trustedlist  (should include your paired bluez device)

I fired up a terminal proggy on that device, but none of the answers I got 
were english, like its not running at 9600 baud on the serial interface.  I 
get answers, but they are something like |C> where I recall seeing an <ACK> or 
<NAK> out of it before.

I took some time and replaced the power connector coming out of the coco which 
was getting flaky after 15 years, and now I have much cleaner video.  It had 
one of those 4 pin automotive connectors where the male & female are swapped 
so that when mated, its polarized.  But I think they make those things with 
some sort of a pressure connection that goes away in 15 years just laying 
there.  So since I'm not getting english answers I think I'll toss that 
problem back at Roger & see what he says. 

I suppose I could diddle the baud rate of the terminal proggy too, maybe it 
didn't default to 9600 when I do a power up with the reset button held down, 
which is supposed to reset it to factory defaults.

Yeah, next test, brb.

I went thru the baud rate settings, testing each increment until I got back 
around to 9600, at which point the eb101 started giving me english answers.  
The answers all looked sensible, including an 'lst visible' which returned the 
address on these dinky dongles as 11:11:11:11:11:11, so I tried to do a
 'con 11:11:11:11:11:11 spp'
which was immediately ACK'd, but 5 seconds later returns an error 14, which is 
sort of a blanket error code for almost anything, like miss-matched pins, 
whatever.  l2ping did work before, but now is:
[root@coyote test]#  l2ping -i /dev/rfcomm0 00:0c:84:00:86:F8
Ping: 00:0c:84:00:86:F8 from 11:11:11:11:11:11 (data size 44) ...
4 bytes from 00:0c:84:00:86:F8 id 0 time 11.81ms
4 bytes from 00:0c:84:00:86:F8 id 1 time 7.87ms
4 bytes from 00:0c:84:00:86:F8 id 2 time 29.88ms
4 bytes from 00:0c:84:00:86:F8 id 3 time 26.88ms
4 bytes from 00:0c:84:00:86:F8 id 4 time 26.87ms
4 bytes from 00:0c:84:00:86:F8 id 5 time 25.86ms
4 bytes from 00:0c:84:00:86:F8 id 6 time 7.86ms
^C7 sent, 7 received, 0% loss

Progress?  DamnifIknow & its the witching hour so I'm gonna go checkout some 
zz's.  I'm also doing 'lights out manufacturing' except what I'm doing is 
sharpening a carbide tipped saw blade, using my milling machine which is run 
by emc, to position a dremel with a diamond wheel in it to very precisely 
grind about .005" off the face of each carbide chip, probably about .0002" per 
pass as I'm using a very gentle touch.  It will turn the blade 20 times, touch 
each tooth in turn for about 10 seconds per tooth, 40 teeth.  That operation 
will be done about dawn, and it can run itself till I wake up again. :)

Thanks a bunch.  I appreciate it, a lot.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Not all who own a harp are harpers.
		-- Marcus Terentius Varro

