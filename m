Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050305184255.73952.qmail@web40614.mail.yahoo.com>
From: Paolino paperino <vonzoltan@yahoo.it>
Subject: Re: [Bluez-users] Socket CF PCMCIA
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Sat, 5 Mar 2005 19:42:55 +0100 (CET)

Ok, i've seen taht Socket CF has got problem (now
solved) with the ker 2.6. But with 2.4 (Zaurus has a
2.4.28 customized by embedix) works fine?
Which comand i must type to bring up a Bluetooth CF
card..afterm plugged into might i use hciattach? On
which device? Zaurus ttyS0 ttyS1 let do the hciattach
in a timeout...
Somebody have ever used Secket CF BT on Zaurus? 
(Mine is a SL 6000)
Thank's people of Bluez!!
Best regards 
Andrea S.
--- Mathias Adam <a2@adamis.de> wrote:
> On 04.03.05 20:42:41, Marcel Holtmann wrote:
> > there are problems with the 2.6 kernel, but nobody
> knows for sure what
> > and where the problems are.
> 
> I asked here last week about the same problems with
> the socket bt card
> and 2.6 and didn't succeed yet.
> It seems that it's a problem within the 8250 serial
> driver (got that
> from the linux-pcmcia mailing list). I'm still
> investigating a little
> about that but don't think that I'll find a solution
> as I'm no linux
> kernel expert...
> 
> 
> Regards
> 
> Mathias
> 
> 
> -- 
> Zwei Dinge sind zu unserer Arbeit nötig:
> Unermüdliche Ausdauer und die
> Bereitschaft, etwas, in das man viel Zeit und Arbeit
> gesteckt hat,
> wieder wegzuwerfen.                                 
>     - Albert Einstein
> 
> 
>
-------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT
> Products from real users.
> Discover which products truly live up to the hype.
> Start reading now.
> http://ads.osdn.com/?ad_ide95&alloc_id396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


		
___________________________________ 
Nuovo Yahoo! Messenger: E' molto più divertente: Audibles, Avatar, Webcam, Giochi, Rubrica… Scaricalo ora! 
http://it.messenger.yahoo.it


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
