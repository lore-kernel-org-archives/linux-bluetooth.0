Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Cross Compile Blues ....
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0412021701500.6295-100000@redbean.intranet.gw-instruments.de>
References: 
	 <Pine.LNX.4.33.0412021701500.6295-100000@redbean.intranet.gw-instruments.de>
Content-Type: text/plain
Message-Id: <1102005176.7350.21.camel@pegasus>
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
Date: Thu, 02 Dec 2004 17:32:56 +0100

Hi Peter,

> thank you. This helped to build the libraries correctly. Library build now
> looks like this (if anybody runs into the same problem):
> 
> # configure and make bluez libs
> pushd bluez/bluez-libs-2.11
> ./configure --host=$TARGET --build=i686-pc-linux-gnu \
>             --with-kernel=$LINUX_DIR \
>             --libdir=/lib --includedir=$XPREFIX/include
> make
> make install DESTDIR=$XPREFIX
> popd

for what do you still need the --includedir ?

> However, it fails with utils. But this isn't much of a problem, for
> now I can live with the hack below....
> 
> When I don't use prefix with utils I get some real strange problem with
> the include pathes. Looks like the native include pathes are used ?!?
> 
> # configure and make bluez utils
> pushd bluez/bluez-utils-2.11
> ./configure --prefix=$XPREFIX --host=$TARGET --build=i686-pc-linux-gnu \
>             --with-kernel=$LINUX_DIR \
>             --libdir=$XPREFIX/lib --includedir=$XPREFIX/include
> #            --sysconfdir=/etc
> #            --without-glib
> # can't figure out how to get this right .......... so...
> echo "#undef CONFIGDIR" >> config.h
> echo "#define CONFIGDIR \"/etc/bluetooth\"" >> config.h
> make
> make install
> popd

Sounds like a bug to me. However I don't finally understand why you
wanna install everything into under / .

I never did any cross-compiling so far, but I am open for every
enhancement to make it easier.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
