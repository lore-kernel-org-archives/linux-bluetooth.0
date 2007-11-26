Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez@frederic-blain.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47482E7C.9090205@frederic-blain.com>
References: <47477234.9010007@free.fr>
	<1195956126.10878.444.camel@cookie.hadess.net>
	<47482E7C.9090205@frederic-blain.com>
Date: Mon, 26 Nov 2007 07:17:30 +0100
Message-Id: <1196057850.4217.74.camel@aeonflux>
Mime-Version: 1.0
Cc: Bastien Nocera <hadess@hadess.net>
Subject: Re: [Bluez-devel] Sony PS3 sixaxis & bluez
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Frederic,

> Thanks for this, I've updated http://wiki.bluez.org/wiki/Input to
> reflect explicitly this information.
> 
> Do you know why device initiated connections are not supported  (Lake
> of time,
> technical issues, ...) and if someone is working on this integration ?

in case of the PS3 controller you don't need device initiated
connections. The PS3 controller will be never discoverable. The bonding
procedure is triggered via the cable authorization. Meaning if you
attache the controller via its USB cable you have to do the magic
automatically in the background.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
