Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050308091838.35137.qmail@web40624.mail.yahoo.com>
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
Date: Tue, 8 Mar 2005 10:18:38 +0100 (CET)

On the zaurus i've inserted the card, the card is
operative (cardctl said it), i load by hand the
modules dtl1_cs, and bluez...but i' get the same
message, as the device is not ready. I get the same
message when i do hciconfgi on my laptop and i've not
inserted the usb bt dongle.
On the zaurus this seems that there aren't a link
between the card and the stack..i mistake?How can i
try to solve this?
Thanks 
Best regards
Andrea S.
--- Paolino paperino <vonzoltan@yahoo.it> wrote:
> Hi, 
> if i not mistake, it shuold be a rev F+, thanks' for
> your hint...so i must' use hciattach, i plug the
> card,
> then lsmod dtl1_cs, and then hciconfig hci0 up...
> thank's...i will try this
> Andrea S.
> 
> --- Marcel Holtmann <marcel@holtmann.org> wrote:
> > Hi Andrea,
> > 
> > > Ok, i've seen taht Socket CF has got problem
> (now
> > > solved) with the ker 2.6. But with 2.4 (Zaurus
> has
> > a
> > > 2.4.28 customized by embedix) works fine?
> > > Which comand i must type to bring up a Bluetooth
> > CF
> > > card..afterm plugged into might i use hciattach?
> > On
> > > which device? Zaurus ttyS0 ttyS1 let do the
> > hciattach
> > > in a timeout...
> > 
> > what revision is it? The revision E and F uses the
> > dtl1_cs driver and
> > are not serial port based.
> > 
> > Regards
> > 
> > Marcel
> > 
> > 
> > 
> > 
> >
>
-------------------------------------------------------
> > SF email is sponsored by - The IT Product Guide
> > Read honest & candid reviews on hundreds of IT
> > Products from real users.
> > Discover which products truly live up to the hype.
> > Start reading now.
> >
>
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> >
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> > 
> 
> 
> 		
> ___________________________________ 
> Nuovo Yahoo! Messenger: E' molto più divertente:
> Audibles, Avatar, Webcam, Giochi, Rubrica… Scaricalo
> ora! 
> http://it.messenger.yahoo.it
> 
> 
>
-------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT
> Products from real users.
> Discover which products truly live up to the hype.
> Start reading now.
>
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
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
