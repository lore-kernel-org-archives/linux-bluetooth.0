Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] dbus.c: cleanup/fix method parameter getting
Message-ID: <20051107083749.GA6845@localhost.localdomain>
References: <20051105124837.GA27883@localhost.localdomain> <1131313209.5824.4.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1131313209.5824.4.camel@blade>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 7 Nov 2005 10:37:49 +0200

Hi Marcel,

On Sun, Nov 06, 2005, Marcel Holtmann wrote:
> I decided to take both patches and hopefully the D-Bus Python support
> will be fixed soon. However I applied another cleanup after your patches
> that fixes some weird coding that ends up in unnecessary deep indented
> lines. Please use this style for any loops and make use of labels for
> the exit path in functions.

Will do.

> What do you think about using also tabs in dbus-test?

I have nothing fundamental against it. The primary reason why it uses
four spaces for indentation currently is that it's the setting I've
always had in my .vimrc for python code.

Johan


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
