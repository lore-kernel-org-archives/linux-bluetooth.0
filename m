Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Dec 2009 16:01:35 +0100
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: "Daniel T. Cobra" <dcobra@videam.com.br>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Long delay to (re)connect a bluetooth mouse
Message-ID: <20091229160135.12d85fe6@strolchi.home.s3e.de>
In-Reply-To: <4B325905.6090103@videam.com.br>
References: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>
 <4B2A4B90.1040009@videam.com.br>
 <4B2BBF58.4030901@videam.com.br>
 <1261173899.4041.96.camel@localhost.localdomain>
 <1261176544.4b2c06e0e0eae@www.fastmail.com.br>
 <1261177111.4041.99.camel@localhost.localdomain>
 <20091223164841.7070e75d@strolchi.home.s3e.de>
 <4B325905.6090103@videam.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Wed, 23 Dec 2009 15:53:09 -0200
"Daniel T. Cobra" <dcobra@videam.com.br> wrote:

> If I don't use the mouse for some time (I haven't clocked it, but it is 
> probably some 5 to 10 minutes), it goes into what I assume is sleep 
> mode, i.e., the cursor stops responding to mouse movements. It only 
> reconnects if I press a button,

Ok, that's clear.

> but it takes about 5 seconds for the 
> cursor to start tracking the mouse movements again. Switching the mouse 
> off, then on while it is connected has the same effect as bringing it 
> out of sleep mode: it takes 5 seconds to start working again. I haven't 
> tried switching it off, then on while it is asleep, to see if it makes 
> any difference (I don't have it here with me now, but I'll do this test 
> tonight).

No, it probably won't make a difference. Additionally, the bug I
remembered (where it would have made a difference) was different: the
mouse did not reconnect at all, unless it was completely disconnected
by either replugging the dongle or switching the mouse off and on. And
that bug is fixed since years anyway ;)

For the record: I tried the same (waiting until the mouse falls asleep
then pressing a button to reconnect) on an Acer Bluetooth Mouse and it
immediately reconnected and worked, in definitely under one second.
So it seems it is something a little bit specific to your device (I'm
not saying the mouse is doing something wrong, it might just be
behaving differently from what is expected by bluez, and this might
need to be fixed in bluez).

> Venu's suggestion of comparing the HCI dumps of reconnection under 
> Windows and Linux will probably shed more light onto this problem.

Yes, probably. If this does not help, we could try to compare the dumps
of your mouse and mine.

> By 
> the way, I had no luck googling for an hcidump equivalent for Windows. 
> Can anybody suggest one?

I have no idea, sorry.

Good luck ;)

	seife
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
