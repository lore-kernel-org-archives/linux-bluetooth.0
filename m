Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04020a1dbe030e257568@[192.168.49.19]>
To: bluez-devel@lists.sourceforge.net
From: Bob Gustafson <bobgus@rcn.com>
Subject: Re: [Bluez-devel] btsco under FC3
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
Date: Thu, 6 Jan 2005 09:51:20 -0600

OK, from scratch - get @AO.. problem

[root@hoho2 blue]# mv btsco btsco.save
[root@hoho2 blue]# mkdir btsco
[root@hoho2 blue]# cp -r btsco.save/CVS btsco
[root@hoho2 blue]# cd btsco
[root@hoho2 btsco]# cvs update -d
...
[root@hoho2 btsco]# ./bootstrap 2>&1 | tee bootstrap.out
configure.in: installing `./install-sh'
configure.in: installing `./missing'
[root@hoho2 btsco]# ./configure 2>&1 | tee config.out
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for gcc... gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ANSI C... none needed
checking for style of include used by make... GNU
checking dependency style of gcc... none
checking for a BSD-compatible install... /usr/bin/install -c
checking for ranlib... ranlib
checking for ALSA CFLAGS...
checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
checking for libasound headers version >= 1.0.3... found.
checking for snd_ctl_open in -lasound... yes
./configure: line 3249: XIPH_PATH_AO: command not found
configure: creating ./config.status
config.status: creating Makefile
config.status: creating sbc/Makefile
config.status: creating avdtp/Makefile
config.status: creating config.h
config.status: executing depfiles commands
[root@hoho2 btsco]# make 2>&1 | tee make.out
make  all-recursive
make[1]: Entering directory `/home/user1/blue/btsco'
Making all in sbc
make[2]: Entering directory `/home/user1/blue/btsco/sbc'
gcc -DHAVE_CONFIG_H -I. -I. -I..    @AO_CFLAGS@ -Wall -O2 -c sbc.c
gcc: @AO_CFLAGS@: No such file or directory
make[2]: *** [sbc.o] Error 1
make[2]: Leaving directory `/home/user1/blue/btsco/sbc'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/user1/blue/btsco'
make: *** [all] Error 2
[root@hoho2 btsco]#


BobG


Sent by me a minute or so aga
>Whoops - no tarball - loaded from CVS
>
>BobG
>
>
>Hi Marcel
>
>Yes, I did that too. @AO.... did not seem to disappear from the Makefile
>without help from 'vim'
>
>Will build from tarball again to see if my libtool is necessary.
>
>BobG
>
>>Hi Bob,
>>
>>> Yes, I did that too.
>>>
>>> something like 'up2date libao-devel', but the @AO. symbols were still in
>>> the Makefile. I did lots of things, so need to do a clean install and
>>> update to make certain what needs to be done to what.
>>
>>you need to ./bootstrap and ./configure again.
>>
>>Regards
>>
>>Marcel
>>
>>
>>
>>
>>-------------------------------------------------------
>>The SF.Net email is sponsored by: Beat the post-holiday blues
>>Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
>>It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
>>_______________________________________________
>>Bluez-devel mailing list
>>Bluez-devel@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
