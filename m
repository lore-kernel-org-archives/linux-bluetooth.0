Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluez installation query
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: bluez-devel@lists.sf.net
In-Reply-To: <20050317060516.82046.qmail@web41129.mail.yahoo.com>
References: <20050317060516.82046.qmail@web41129.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1111055149.11792.51.camel@pegasus>
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
Date: Thu, 17 Mar 2005 11:25:49 +0100

Hi Jose,

> On suse linux 9.1, iam not able to make and make
> install the bluez install files 'utils, libs etc'.
> when i say ./configure, this is what is listed:
> 
> ose:/home/jose/bluetooth/bluez-hcidump-1.18 #
> ./configure --with-gcc --prefix=/usr
> --mandir=/usr/share/man
> checking for a BSD-compatible install...
> /usr/bin/install -c
> checking whether build environment is sane... yes
> checking for gawk... gawk
> checking whether make sets $(MAKE)... no
> checking whether to enable maintainer-specific
> portions of Makefiles... no
> checking for gcc... no
> checking for cc... no
> checking for cc... no
> checking for cl... no
> configure: error: no acceptable C compiler found in
> $PATH
> See `config.log' for more details.
> 
> 
> how do i set the path to the gcc?

is this the SuSE 9.1 Personal edition? If yes, then you don't have a GCC
on it. Otherwise simply install it.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
