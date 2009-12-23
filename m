Return-Path: <cyrus@holtmann.org>
Message-ID: <4B325905.6090103@videam.com.br>
Date: Wed, 23 Dec 2009 15:53:09 -0200
From: "Daniel T. Cobra" <dcobra@videam.com.br>
MIME-Version: 1.0
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Long delay to (re)connect a bluetooth mouse
References: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>	<4B2A4B90.1040009@videam.com.br>	<4B2BBF58.4030901@videam.com.br>	<1261173899.4041.96.camel@localhost.localdomain>	<1261176544.4b2c06e0e0eae@www.fastmail.com.br>	<1261177111.4041.99.camel@localhost.localdomain> <20091223164841.7070e75d@strolchi.home.s3e.de>
In-Reply-To: <20091223164841.7070e75d@strolchi.home.s3e.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan:

> David, "every time I bring the mouse out of sleep mode", does this mean
> the mouse went to sleep, you click the button (or move the mouse) and
> it takes 5 seconds to reconnect? If so, could you try if it makes a
> difference if you switch off the mouse instead? (wait until it falls
> asleep, then switch off and on and check if it reconnects faster. Might
> not be easy if this is a mouse that wakes up on movement, then you
> probably need to lay it upside down until it sleeps).
>   

If I don't use the mouse for some time (I haven't clocked it, but it is 
probably some 5 to 10 minutes), it goes into what I assume is sleep 
mode, i.e., the cursor stops responding to mouse movements. It only 
reconnects if I press a button, but it takes about 5 seconds for the 
cursor to start tracking the mouse movements again. Switching the mouse 
off, then on while it is connected has the same effect as bringing it 
out of sleep mode: it takes 5 seconds to start working again. I haven't 
tried switching it off, then on while it is asleep, to see if it makes 
any difference (I don't have it here with me now, but I'll do this test 
tonight).

Venu's suggestion of comparing the HCI dumps of reconnection under 
Windows and Linux will probably shed more light onto this problem. By 
the way, I had no luck googling for an hcidump equivalent for Windows. 
Can anybody suggest one?

Regards,

Daniel

