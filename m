Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Re:cross compilation of BlueZ for MIPS
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050323044813.25763.qmail@web8508.mail.in.yahoo.com>
References: <20050323044813.25763.qmail@web8508.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1111580740.22872.152.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 23 Mar 2005 13:25:40 +0100

Hi,

> >when i compile i get error like non structure ember
> >"nice" in core.c file.
> 
> >the Bluetooth kernel source code uses more than one
> >core.c and I only that it must be the kernel source,
> >because a nice member doesn"t exists inside the
> >userspace code. Provide a the full error message and
> >explain what you are doing, because otherwise such
> >posts are useless.
> 
> After patching(patch2.4.20-mh18),enabling BNEP and
> HIDP support in menuconfig, when i compile using cross
> toolchain i get error message as given below.If i
> doesnot include BNEP and HIDP it successfully compiles
> with rfcomm support.
> 
> ..compiling stuff.......
> ........................
> make[4]: Entering directory
> `/home/08_03_05_project/kernels/linux-2.4.20/net/bluetooth/bnep'
> mips_fp_le-gcc -D__KERNEL__
> -I/home/08_03_05_project/kernels/linux-2.4.20/include 
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2
> -fno-strict-aliasing -fno-common -g -ggdb
> -fno-omit-frame-pointer 
> -I
> /home/08_03_05_project/kernels/linux-2.4.20/include/asm/gcc
> -G 0 -mno-abicalls -fno-pic -pipe -mtune=r4600 
> -mips32 -Wa,--trap   -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=core  -c -o core.o core.c
> core.c: In function `bnep_session':
> core.c:482: error: structure has no member named
> `nice'
> make[4]: *** [core.o] Error 1
> .......................
> .......................
> make: *** [_dir_net] Error 2

this actually means that your kernel contains another backport that is
not mainline. The -mh patches are only tested with mainline. In your
case replacing that line with "set_user_nice(current, -15);" may helps.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
