Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Fabien Chevalier <fabchevalier@free.fr>
In-Reply-To: <4749E9DB.3020801@free.fr>
References: <4749E9DB.3020801@free.fr>
Date: Mon, 26 Nov 2007 06:47:31 +0100
Message-Id: <1196056051.4217.51.camel@aeonflux>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>,
        Johan Hedberg <johan.hedberg@nokia.com>
Subject: Re: [Bluez-devel] [PATCH] Bluez exceptions refactoring updated patch
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

Hi Fabien,

> I finally managed to spend a few hours of my spare time on Bluez.
> 
> As a result i updated the patch that updates the common/ directory as 
> well as the various services to share the exceptions definition.
> 
> Changes compared to previous version:
>   - renamed the common .h and .c as error.h and error.c
>   - completely removed various error.{c,h} from services directory
>   - updated api documentation (dbus-api.txt + services api definition).
> 
> The patch is pretty big, if needed i can provided splitted patches for 
> various directories.

I think we should do it in a few steps to make it actually readable if
we ever have to track this down:

	- Create common/error.[ch]
	- Update dbus-api.txt
	- Remove error.[ch] from every service and use common/error.h
	  It should be one patch per service and also update its API
	  document

Two comments on your patch itself. The copyright on common/error.[ch] is
not only yours. Keep the original copyright of the files.

It is great that you added comments for each function, but they belong
inside the *.c files. The rule is that they should be placed where the
actual function body is defined.

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
