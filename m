Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY117-F13C48B855ECD096F61965BFBA0@phx.gbl>
In-Reply-To: <1167725485.30886.35.camel@violet>
From: "Kelvin Xu" <kyoxu@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 02 Jan 2007 16:53:41 +0800
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Error Compiling Bluez-Util
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

May i know what is hciattach.c used for?

The function uart_speed() returns an int however B230400 are not. i guess 
there are some files which declared them as integers.

Regards,
Kelvin


>From: Marcel Holtmann <marcel@holtmann.org>
>Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
>To: BlueZ development <bluez-devel@lists.sourceforge.net>
>Subject: Re: [Bluez-devel] Error Compiling Bluez-Util
>Date: Tue, 02 Jan 2007 09:11:25 +0100
>
>Hi Kelvin,
>
> > When i was trying to compile Bluez-Util 3.7 in a scratchbox environment, 
>i
> > ran into the following errors:
> > In function 'uart_speed'
> > hciattach.c:106: error:'B230400' undeclared (first use in this function)
> > hciattach.c:108: error:'B460800' undeclared (first use in this function)
> > ..
> > ..
> > ..
> > etc
> >
> > May i know whether i have missed out on any header files or any linking
> > problems
> > I am trying to a arm target board.
>
>I have no idea, but this error shouldn't happen. Do you actually need
>hciattach? If not, then you can disable its compilation or simple
>comment out these lines.
>
>Regards
>
>Marcel
>
>
>
>-------------------------------------------------------------------------
>Take Surveys. Earn Cash. Influence the Future of IT
>Join SourceForge.net's Techsay panel and you'll get the chance to share 
>your
>opinions on IT & business topics through brief surveys - and earn cash
>http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel

_________________________________________________________________
Get MSN Messenger emoticons and display pictures here! 
http://ilovemessenger.msn.com/?mkt=en-sg


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
