Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [btsco] configure/make errors
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41ED7E8D.8030709@pca.it>
References: <41ED7E8D.8030709@pca.it>
Content-Type: text/plain
Message-Id: <1106136920.8190.96.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 19 Jan 2005 13:15:20 +0100

Hi Luca,

> after having solved the automake error, configure gave me another one
> and googling solved it [1]. But, again, no dependencies from libao-dev
> is present in the README (and, strangely, automake doesn't complain).
> 
> This wasn't enough: make gave me other errors, because it could not find
> the Bluetooth dev libraries.
> 
> Attached a patch against the current CVS:
> 
> * bootstrap:
> checking for the existence of /usr/share/aclocal/ao.m4 and exiting with
> an error if not present (we cannot use the pkg-config because ao.m4 is
> used to generate the configure script)

And again. The bootstrap thing is for making the developer happy,
because he must call only one program/script for getting the repository
ready. It is not for others ;)

> * configure.in:
> used pkg-config to check the presence of the Bluetooth dev libraries

You can also use AM_PATH_BLUEZ. Since bluez-libs-2.13 it is also
available now, because not all systems use pkg-config.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
