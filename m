Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] missing libsdp
From: Marcel Holtmann <marcel@holtmann.org>
To: Christoph Torens <c.torens@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <opsd8mhqi6eocfdv@debian>
References: <opsd8mhqi6eocfdv@debian>
Content-Type: text/plain
Message-Id: <1095071938.5695.33.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 13 Sep 2004 12:38:58 +0200

Hi Christoph,

> I just compiled bluez-libs-2.10 and bluez-utils-2.10
> everything went fine, but starting hcitool I get this message:
> 
> hcitool: error while loading shared libraries: libsdp.so.2: cannot open  
> shared object file: No such file or directory

the libsdp is no longer needed. Sounds like there is an old install of
hcitool. Check that you only have one hcitool program installed on your
system.

> I cross compiled it, so that _might_ be a source of error.
> To be exact I did for bluez-libs:
> ./configure --host=arm-linux
> 
> and for bluez-utils I did:
> ./configure --host=arm-linux  
> --with-bluez=/home/sordid/downloads/bluez-libs-2.10_installDESTDIR/usr/  
> --with-usb=/opt/arcom/arm-linux/src/linux-source-2.4.21-rmk1-pxa1-arcom1/drivers/usb/  
> --enable-debug --enable-test --enable-initscripts
> 
> I thought the USB command is ment for cross-compiling,
> so I gave the sources for arm-linux USB as the path.
> Thats right?

We never include kernel headers, so this is wrong. And as the help text
of the USB option says it, you can specify the prefix of the USB library
with it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
