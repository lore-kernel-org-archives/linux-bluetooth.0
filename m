Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [ANN] Zaurus BlueZ kernel packages for ROM v3.10
References: <1054908696.4791.157.camel@baroque.rococosoft.com>
	<200306301314.25320.justin-qt@affinix.com>
	<005a01c33fa0$122b7120$0181a8c0@zaz1>
In-Reply-To: <005a01c33fa0$122b7120$0181a8c0@zaz1>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200307010050.33996.justin-qt@affinix.com>
From: Justin Karneges <justin-qt@affinix.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 1 Jul 2003 00:50:33 -0700

Max, Marcel, can you comment on this bug?  I'd like to get to the bottom of 
it.

-Justin

On Tuesday 01 July 2003 12:12 am, Xavier Garreau wrote:
> > Also, I think I found a bug in dtl1_cs and/or bluez itself:  the card
>
> cannot
>
> > survive a suspend.  Turning off / on the Zaurus, or simply running
>
> "cardctl
>
> > suspend ; cardctl resume" will leave the driver in an unusable state.
> > Running "cardctl eject ; cardctl insert" fixes the problem.  I'm willing
>
> to
>
> > hack on the driver and remedy this, if I could just figure out how to
> > cross-compile the modules...
>
> This bug happens with every PC Card | CF Card I've tested.
>
> BR


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
