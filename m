Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4038A415.2070506@soft.uni-linz.ac.at>
From: "Dr. Simon Vogl" <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.demon.co.uk>
CC: =?ISO-8859-1?Q?Fred_Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sco link help needed
References: <4034CA08.50500@soft.uni-linz.ac.at> <200402191629.38846.bluez-devel@schaettgen.de> <40376D2B.1060904@superbug.demon.co.uk>
In-Reply-To: <40376D2B.1060904@superbug.demon.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 22 Feb 2004 13:44:05 +0100

Hi James,
have you looked at what Jonathan Paisley implemented?
http://www.dcs.gla.ac.uk/~jp/snd-bluez-sco/
Cheers,
Simon

James Courtier-Dutton wrote:

> Fred Schättgen wrote:
>
>> On Thursday 19 February 2004 15:36, Simon Vogl wrote:
>>
>>> Hi,
>>> I desparately need some help with audio links:
>>> I have written two small programs that use my pc to emulate a headset
>>> and a handsfree device. Both work quite nicely, the rfcomm-based
>>> initialization takes place, and I get an SCO connection, but 
>>> mysteriously,
>>> I don't get a single byte of audio data (I don't see it with hcidump
>>> neither).
>>>
>>> my setup:
>>> * Acer usb bluetooth dongle
>>> * test phones used: p800 (headset), p6600/ngage/3650 (handsfree) 
>>> with no
>>> luck... * kernel 2.4.23
>>> * bluez utils&lib from cvs
>>> * and yes, i did register hset profile via sdptool....
>>>
>>> I had the program running perfectly already with a T68i....
>>> Any help appreciated heavily (for example a traace of a successful
>>> connection...), Simon
>>
>>
>>
>> I wrote a small handsfree application as a part of the KDE Bluetooth 
>> Framework. It basically worked, even though it had problems with an 
>> ever increasing lag, which has probably nothing to do with bluez. But 
>> at the moment it's broken and it's not very high priority, since my 
>> microphone is also broken ;)
>> But you might take a look at it.. it's in kdeextragear-3:
>> http://webcvs.kde.org/cgi-bin/cvsweb.cgi/kdeextragear-3/kdebluetooth/handsfree/ 
>>
>> I'll try to fix it during the next days.
>>
>> Btw. I'm not sure if the sound doesn't work currently because of a 
>> kernel problem. Maybe I should try with an older kernel.. It used to 
>> work with 2.4.24 if I remember correctly.
>>
>> greetings
>> Fred
>>
> For those interested, I am planning to write an alsa driver for 
> bluetooth headsets.
> The alsa driver module would load into kernel, but not present any 
> sound devices.
> Once a pairing had been set up (a small tool will be used for the 
> pairing), the alsa driver module would then dynamically add a sound 
> card to the kernel device list, and this sound card would work just 
> like any other sound device in linux.
> The alsa driver would handle both iso and rfcomm connections, iso for 
> the sound, rfcomm for mixer volume etc.
>
> Is anyone else working on this, or shall I start alone?
>
> Cheers
> James




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
