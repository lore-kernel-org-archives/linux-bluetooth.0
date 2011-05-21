Return-Path: <cyrus@holtmann.org>
Message-ID: <EF5531069538433D8696B4C7639348C4@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: =?iso-8859-1?Q?=22H=F6glind=2C_Henrik=22?=
	<Henrik.Hoglind@sonyericsson.com>,
	<linux-bluetooth@vger.kernel.org>
References: <BANLkTimoVzAObkRAt_5L_2V0ZHWkA2=VTg@mail.gmail.com> <9A742367D258D34A9753780E2AE6B8BD2CC75DBF45@SELDMBX04.corpusers.net>
In-Reply-To: <9A742367D258D34A9753780E2AE6B8BD2CC75DBF45@SELDMBX04.corpusers.net>
Subject: Re: Status of MAP and AVRCP
Date: Sat, 21 May 2011 13:45:52 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Henrik, and all others interested in AVRCP!


>Hi David,

>> I restarted work-in-earnest on an AVRCP layer a bit over two months ago
>> [...]
>> I will complete fairly extensive testing and begin submitting patches 
>> with
>> major surgery to audio/control.c, supporting the API doc worked out in 
>> the
>> Portland meeting, with a couple of minor extensions.  This will bring 
>> BlueZ
>>to AVRCP 1.3, figure by the end of this month.

>Have you made any progress with the avrcp v1.3 implementation? Judging
>from the messages on the list, there seems to be a lot of interest for
>this update. We are also awaiting this, and would be happy to help if
>there is something we can do.

+++++

FINALLY, after about seven months fighting what turned out to be hardware 
issues, I am progressing very nicely.

<TALE OF WOE>

After my initial work (which I presented in Portland), I upgraded my 
development box to a brand new ASUS motherboard, AMD Phenom x64, lots of 
redundant disk, etc.  I decommissioned my old box and put it into the 
closet.

However, the new box was flaky: occasionally the mouse would completely 
freeze (in Fedora 13), necessitating a full restart.  Lots of searching 
yielded only some advice to twiddle the X config, but no real success.

Worse still, when I would plug in the BT dongle (also USB based), it would 
work for a little, and then fail.  I could light it up with hciconfig, but 
it would soon timeout and freeze the session.  Meanwhile the same USB dongle 
would work with every other machine (but Windows based).  Also, my 
hand-built Bluetooth Remote (with its firmware, the CSR stack, etc.) would 
connect with full AVRCP to my BlackBerry Torch, to my various Windows 
desktops and laptops using either embedded Bluetooth or the USB dongle.

Given the rapid rate of change in the Management layer (hciops, etc.) I was 
cursing up a storm about the flaky BlueZ software, the lack of a 
frozen/stable release, and the fact that even after continually moving to 
the latest and greatest, BlueZ (apparently) was still not stable.  Given the 
fact that I could not reliably connect to BlueZ, I really was not making a 
lot of progress on the rest of the code.

About two weeks ago I decided to resurrect the old x86-based machine out of 
the closet and set it up with a new drive, loaded up Fedora 14, installed 
the latest BlueZ and applied my AVRCP fixes.  Everything lit up immediately. 
No problems ever since (except for parts of my code, and a hiccup in SSP).

The day I took the old box out and lit it up, I stumbled on the following 
thread:

http://www.nvnews.net/vbulletin/showthread.php?t=135022

So it turns out that the real problem all along was the nVidia chipset on my 
motherboard.  After adding a PCI-USB board to my system and turning off the 
onboard USB support, I now have both an x86 and an x86_64 instance, each 
happily running BlueZ (plus my devel branch).

</TALE OF WOE>

This has been an evenings-and-weekends project, but now that I have finally 
(!) stabilized my environment, I am working rapidly to release the first 
pieces of 1.3 in the next weeks (no later than end of June), focused on the 
Linux/BlueZ box as the Target (to me, the use-case of Control is secondary 
in BlueZ).  First release will include Change Playback and Change Track (and 
Send Metadata), the core of the requirement.  ChangeSetting and the rest 
will follow soon after, I expect the end of July.

By the way, no worries about the spamming, and I am sorry in turn about the 
long response.  I included the Tale of Woe in case others are having similar 
problems.  The chip in question is an nVidia MCP78S (nForce 750a series). 
Works well enough under Windows, but hangs under Linux...not good.

Stay tuned, and thanks for your interest.

David Stockwell

+++++

>Best regards,
>Henrik

Sorry for all the spamming. Not a very good way to make a first impression 
on the list. :-(

Best regards,
Henrik

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html 

