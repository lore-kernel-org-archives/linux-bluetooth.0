Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] btsco under FC3
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <v04020a1dbe030e257568@[192.168.49.19]>
References: <v04020a1dbe030e257568@[192.168.49.19]>
Content-Type: text/plain
Message-Id: <1105032390.4299.92.camel@pegasus>
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
Date: Thu, 06 Jan 2005 18:26:30 +0100

Hi Bob,

> OK, from scratch - get @AO.. problem
> 
> [root@hoho2 blue]# mv btsco btsco.save
> [root@hoho2 blue]# mkdir btsco
> [root@hoho2 blue]# cp -r btsco.save/CVS btsco
> [root@hoho2 blue]# cd btsco
> [root@hoho2 btsco]# cvs update -d
> ...
> [root@hoho2 btsco]# ./bootstrap 2>&1 | tee bootstrap.out
> configure.in: installing `./install-sh'
> configure.in: installing `./missing'
> [root@hoho2 btsco]# ./configure 2>&1 | tee config.out
> checking for a BSD-compatible install... /usr/bin/install -c
> checking whether build environment is sane... yes
> checking for gawk... gawk
> checking whether make sets $(MAKE)... yes
> checking for gcc... gcc
> checking for C compiler default output file name... a.out
> checking whether the C compiler works... yes
> checking whether we are cross compiling... no
> checking for suffix of executables...
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether gcc accepts -g... yes
> checking for gcc option to accept ANSI C... none needed
> checking for style of include used by make... GNU
> checking dependency style of gcc... none
> checking for a BSD-compatible install... /usr/bin/install -c
> checking for ranlib... ranlib
> checking for ALSA CFLAGS...
> checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
> checking for libasound headers version >= 1.0.3... found.
> checking for snd_ctl_open in -lasound... yes
> ./configure: line 3249: XIPH_PATH_AO: command not found

and again, the development files from the AO library are missing. Check
your Fedora Core 3 distribution.

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
