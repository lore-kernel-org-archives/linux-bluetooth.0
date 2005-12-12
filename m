Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth connection too slow
From: Mario Demontis <mario.demontis@email.it>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1133029959.15981.0.camel@blade>
References: <1133028275.9123.29.camel@localhost.localdomain><1133028830.28718.19.camel@blade><1133029672.9123.34.camel@localhost.localdomain><1133029959.15981.0.camel@blade>
Content-Type: text/plain
Message-Id: <1134424744.8666.10.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Mon, 12 Dec 2005 22:59:04 +0100

Hello Marcel
I made several efforts in order to try different combinations of ppp
parameters, but I didn't get any improvement: my ppp connection over
bluetooth is still 3 times slower than in windows :(
Now I'm trying to use different parameters for the terminal settings
(over rfcomm). Just a question:
If I set the speed of /dev/rfcomm0 to 1200 rather than 115200 or more,
how does the driver react? Does it ignore the setting? What about other
terminal settings (flow control, parity,...)

Thanks in advance
Mario

Il giorno sab, 26/11/2005 alle 19.32 +0100, Marcel Holtmann ha scritto:
> Hi Mario,
> 
> > > If you reach 32 kB/s then this is a good result. With Bluetooth prior
> > > EDR you will reach max something around 80 kB/s, but this is not really
> > > doable with PPP in between. The bottleneck can also be the UART inside
> > > your mobile phone.
> > 
> > That wouldn't explain the reason why under Windows I'm getting 32kB/s...
> > By the way, what I'm willing to do is just to have the same performance
> > under Linux
> 
> try to tweak your PPP settings, because I don't think that RFCOMM is the
> bottleneck here. I could be, but I doubt it.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

 

 

 --

 Email.it, the professional e-mail, gratis per te: http://www.email.it/f

 

 Sponsor:

 Cartucce, toner, ricariche...scegli a chi rivolgerti per la tua stampante. Clicca qui

 Clicca qui: http://adv.email.it/cgi-bin/foclick.cgi?mid=4198&d=12-12


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
