Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Surf-kid20 <surf-kid20@freemail.hu>
Subject: Re: [Bluez-users] receiving files from the phone
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1111704550.9195.3.camel@pegasus>
Message-ID: <freemail.20050301124848.97317@fm3.freemail.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
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
Date: Fri, 1 Apr 2005 12:48:48 +0200 (CEST)

Hi,

> Hi,
> 
> > I'd like to transfer files from a nokia phone to the PC. How
> > can I achieve this?
> > What are the transfer rates you've experienced?
> > 
> > What I've already tried:
> > 
> > linux 2.4.28 + affix bluetooth driver + btctl utility's OBEX
> > FTP commands:
> > it works, but only with 13-15kbyte/sec receiving speed
> > 
> > liunx 2.6.10 + the kernels inbuilt bluez driver and the
> > following programs:
> > 
> > btftp from the bluez CVS (receiving speed about 25kbyte/sec)
> > KDE's bluetooth utilities which have an obex FTP transfer
> > utility it could receive
> > at a rate of 20kbyte/sec.
> > 
> > My question is how to debug what makes transfer so slow?
> > What rates have you exprienced using obex ftp and object
> > push? (I'm particularly interested in the phone>PC
direction).
> > Any other possibilities for file transfer apart from obex
> > ftp and object push?
> 
> I can't tell you anything about the Affix stack, but the
BlueZ part of
> RFCOMM is doing quite good. However sometimes the phone is
the limit
> here and RFCOMM + OBEX adds a lot of unneeded overhead.
> 
> Regards
> 
> Marcel

I've also tried the blueZ driver, however the phone>PC
direction using OBEX was still only max 20kbyte/sec (at a
distance of 1 meters, DH5 packets were listed at pkg_config).

How could we debug what is causing this slowdown? (where is
the narrow part of the channel..)

Can anyone give some figures for Phone>PC transfer rate
using OBEX?

Is there any other (faster) option to transfer files from
phone to the PC?

I'd be really grateful also, if you could point me to a
manufacturer of some _serial_ bluetooth modul (just a
module, not a complete product), which can do fast OBEX
transfers...

Best regards,
Surf


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
