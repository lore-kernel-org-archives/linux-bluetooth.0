Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Cross Compile Blues ....
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0412011855510.2707-100000@redbean.intranet.gw-instruments.de>
References: 
	 <Pine.LNX.4.33.0412011855510.2707-100000@redbean.intranet.gw-instruments.de>
Content-Type: text/plain
Message-Id: <1101929937.15615.30.camel@pegasus>
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
Date: Wed, 01 Dec 2004 20:38:57 +0100

Hi Peter,

> I'm trying to cross compile bluez-libs / utils (Vers. 2.11). Actually, I
> can compile fine, but I've the following problems:
> 
> a) when I compile the libraries I'm unable to find a configure which
> allows me to have the libraries installed on the the build system but with
> a load path of the target system (/usr/lib). Here is the configure I use
> 
> ./configure --prefix=$XPREFIX --host=$TARGET --build=i686-pc-linux-gnu \
>             --with-kernel=$LINUX_DIR \
>             --libdir=$XPREFIX/lib --includedir=$XPREFIX/include
> 
> where XPREFIX is the path to the target root file system on my build
> system, TARGET is arm-linux  LINUX_DIR is the path to the linux sources
> for the target system. What I need is some configuration which installs
> the library files in $XPREFIX/lib and builds the libraries for RUN PATH
> /lib. Does anybody know how t get this working ????

use the normal prefix and install them with DESTDIR.

> b) the same problem occurs with the CONFIGDIR define in config.h.
> It is always set to $XPREFIX/etc/bluetooth
> instead of just /etc/bluetooth

As long as you don't override it with --sysconfdir.

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
