Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42170F9B.8000508@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] rfcomm question 3
References: <20050219082709.54395.qmail@web60904.mail.yahoo.com>
In-Reply-To: <20050219082709.54395.qmail@web60904.mail.yahoo.com>
Content-Type: text/plain; charset=Big5
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 19 Feb 2005 11:06:19 +0100

Hello Michael

finally I understand what you're trying to do. that explains a lot!
I would have been confused too if somone told me about socket programming
while doing what you do.
I suggest to add a description of what you do when posting to a mailinglist
the next time. That might save a lot of time :-)

> Yes, of course, and the connection layer is rfcomm. I typed "rfcomm
> connect 0 <address>" to connect to T610, and it was success.

what service is on rfcomm channel 0 on the mobile phone? obex?


Ok. So now you try
1. to connect with your mobile phone to the pc
2. send the menu from the pc to the mobile phone
3. do what already worked before...

As far as I know - please correct me if someone knows better - a mobile
phone doesn't provide a feature to connect to remote devices (at least mine
doesn't). It wouldn't make sense, because the mobile phone has no idea what
to do after it connected, does it?
I wonder how your tutor made this. If he tells you, could you send this to
the list? I'm really interested...

Actually I think you now have to write/download a program for your mobile
phone that connects to an obex (if you're working with obex) service (on
your pc) - or ask your tutor how he did it...
Then you can send the menu from to pc to the mobile phone and everything
should be fine.
And here now comes the sdp thing that your tutor mentioned. Your mobile
phone will do a service scan on your pc (paging), then it should find a
obex service that it knows it's able to connect to.

Can I have your program that sent the menu from the pc to the mobile phone?
I never worked with something like this but I'm be very interested how this
looks/works. I don't mind that I've to connect from the pc to the mobile
phone...

Please inform me of any success/failures (after you described what you do,
i'm really interested in it - you might already have noticed it).


regards
Marco


Ka Kin Cheung wrote:
> Hi Marco!
>     Thanks for you reply as I afraid that you may not reply my mail due 
> to my ridicious act before.
>     Regarding to your questions:
> 1.>The connection between your mobile phone and your pc is over 
> bluetooth >and your pc then sends the infrared signals to the 
> television, is this correct?
> Yes, correct.
> 2.>You were able to connect from your pc to the mobile phone. Did you use
>  >bluetooth?
> Yes, of course, and the connection layer is rfcomm. I typed "rfcomm 
> connect 0 <address>" to connect to T610, and it was success. Now what I 
> do is to change the approach, but still it is not successful.
> 3.>Which service do you connected to (from your mobile phone), what's 
> it's >name?
> The service that the PC provided for T610 is Object push
> 4.>Then you sent the menu for the remote control from your pc to your mobile
>  >phone using at commands and got the choices you made on the mobile 
>  >phone bacck to your pc. Your pc then sent the answer to the television 
>  >using infrared?
> Exactly!
> 
>  >Hope I understood this more or less correctly...
> I'm glad that you understand much about my project. So I hope that you 
> can point out something about how I do for sdp so that I can eventually 
> let the T610 to connect to PC while my main program is running.
> Thanks so much.
> Michael
> 
> 
> ------------------------------------------------------------------------
> Yahoo! 工具列 - 內置防止彈出視窗工能 <http://hk.toolbar.yahoo.com>！


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
