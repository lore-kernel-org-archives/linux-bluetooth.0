Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alain Volmat <avolmat@src.ricoh.co.jp>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] 'make' and 'make install' not working
Message-ID: <20050317093011.GM4513@snoopy.src.ricoh.co.jp>
References: <20050317091358.63188.qmail@web52403.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050317091358.63188.qmail@web52403.mail.yahoo.com>
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
Date: Thu, 17 Mar 2005 18:30:11 +0900

Hi Jose,

this has actually nothing to do with Bluetooth I think but...

a common way to do, in case of your gcc is a a specific location
is to use CC environment variable.
CC=mygcc AR=myar LD=myLD NM=myNM ./configure ....

well here you don't need AR, LD, NM I think but that's just for the example.
so just doing CC=yourgccpath/gcc ./configure should do the trick.

or just follow what configure is telling you ...
> configure: error: no acceptable C compiler found in $PATH
since it couldn't found gcc inside $PATH, then add gcc's location into $PATH :D

Alain

* jose [Thu, 17 Mar 2005 at 01:13 -0800]
<quote>
> Hi,
> 
> After downloadin the bluez files, i did './configure',
> but iam unable to 'make' or 'make install'.
> 
> this is what i got when i did ./configure
> 
> 
> jose:/home/jose/bluetooth/bluez-hcidump-1.18 #
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
> 
> 
> 
> now, how do i set the path to gcc?
> 
> Thanks in advance,
> Jose
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
</quote>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
