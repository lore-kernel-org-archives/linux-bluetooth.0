Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Subject: Re: [Bluez-devel] [ANN] Zaurus BlueZ kernel packages for ROM v3.10
References: <1054908696.4791.157.camel@baroque.rococosoft.com>
	<200307011438.34033.justin-qt@affinix.com>
	<1057105614.8261.67.camel@pegasus>
In-Reply-To: <1057105614.8261.67.camel@pegasus>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200307011810.21601.justin-qt@affinix.com>
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
Date: Tue, 1 Jul 2003 18:10:21 -0700

On Tuesday 01 July 2003 05:26 pm, Marcel Holtmann wrote:
> > What is significant about cardctl suspend?  This will break the driver
> > also, and perhaps it easier to look into this than the full pda suspend.
>
> As I know, that happen to all cards with a special driver (dtl1_cs and
> bluecard_cs) and I don't know why.

As soon as I am able to build the modules, is there any way I can help you 
assist in debugging this?  Maybe I can sprinkle some printfs around the 
suspend-handling code or elsewhere, and we can track down at what point the 
driver fails?

-Justin


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
