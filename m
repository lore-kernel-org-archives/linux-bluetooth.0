Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <005a01c33fa0$122b7120$0181a8c0@zaz1>
From: "Xavier Garreau" <x.garreau@prim-time.fr>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>, "Justin Karneges" <justin-qt@affinix.com>
References: 
	<1054908696.4791.157.camel@baroque.rococosoft.com><200306282117.57840.justin
	-qt@affinix.com><007101c33f05$99e146d0$0181a8c0@zaz1>
	<200306301314.25320.justin-qt@affinix.com>
Subject: Re: [Bluez-devel] [ANN] Zaurus BlueZ kernel packages for ROM v3.10
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Tue, 1 Jul 2003 09:12:02 +0200

> Also, I think I found a bug in dtl1_cs and/or bluez itself:  the card
cannot
> survive a suspend.  Turning off / on the Zaurus, or simply running
"cardctl
> suspend ; cardctl resume" will leave the driver in an unusable state.
> Running "cardctl eject ; cardctl insert" fixes the problem.  I'm willing
to
> hack on the driver and remedy this, if I could just figure out how to
> cross-compile the modules...

This bug happens with every PC Card | CF Card I've tested.

BR
-- 
Xavier Garreau
http://www.xgarreau.org/



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
