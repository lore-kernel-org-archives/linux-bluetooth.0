Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <007101c33f05$99e146d0$0181a8c0@zaz1>
From: "Xavier Garreau" <x.garreau@prim-time.fr>
To: "Justin Karneges" <justin-qt@affinix.com>, "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Cc: "Stephen Crane" <steve.crane@rococosoft.com>
References: <1054908696.4791.157.camel@baroque.rococosoft.com>
	<005f01c3302e$ca3537a0$0181a8c0@zaz1>
	<200306282005.08403.justin-qt@affinix.com>
	<200306282117.57840.justin-qt@affinix.com>
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
Date: Mon, 30 Jun 2003 14:46:17 +0200

> Subject: Re: [Bluez-devel] [ANN] Zaurus BlueZ kernel packages for ROM
v3.10

I'm still interrested in packaging bluez core, libs and apps for the zaurus.
When all is compiled and ready to work, i'll make another package.

I thought card detection during ipk install was a good thing to be done, if
i'm the only one wanting it, it can be removed...

I'll put rfcomm and bluepin, as soon as they are available.

> Third, the /dev nodes are not created.  When they are, ensure that they
can
> survive a reboot.

That's true...

> By the way, you may see my GUI package here:
>   http://www.affinix.com/~justin/zaurus-bluetooth-0.6.tar.gz

This can be added in the utils package. I think we need a kernel package, a
libs package and a utils package. But it can be further discussed...

BR,
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
