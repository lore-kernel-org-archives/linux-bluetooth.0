Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] autoconf breaks portability. Film at 11.
From: Marcel Holtmann <marcel@holtmann.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1084371089.4426.148.camel@hades.cambridge.redhat.com>
References: <1084268833.11301.0.camel@hades.cambridge.redhat.com>
	 <1084368666.25099.38.camel@pegasus>
	 <1084369122.4426.106.camel@hades.cambridge.redhat.com>
	 <1084369703.25099.56.camel@pegasus>
	 <1084371089.4426.148.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1084382619.25099.81.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 12 May 2004 19:23:39 +0200

Hi David,

> I sent you proper Makefiles a long time ago. You didn't apply them :)

must have missed it. Please send it again.

> This is what I get on Fedora Core 2 on both i386 and PPC, btw:
> 
> hades /hades/bluez/libs2 $ ./bootstrap
> configure.in: installing `./install-sh'
> configure.in: installing `./missing'
> configure.in:19: installing `./config.guess'
> configure.in:19: installing `./config.sub'
> configure.in:19: required file `./ltmain.sh' not found
> compat/Makefile.am: installing `./depcomp'

but this isn't a problem. It says something like that, but also creates
every file that it complains about.

> OK, you can have another one then :)
> 
> On PPC, the HCI/LMP version numbers and manufacturer code are
> byte-swapped in hciconfig from utils2. hciconfig from bluez-utils-2.7
> gives:
> 
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x4d9 LMP Ver: 1.2 (0x2) LMP Subver: 0x4d9
>         Manufacturer: Cambridge Silicon Radio (10)
>  
> ... while hciconfig from utils2 gives:
> 
>         HCI Ver: 1.2 (0x2) HCI Rev: 0xd904  LMP Ver: 1.2 (0x2) LMP Subver: 0xd904
>         Manufacturer: not assigned (2560)

Actually I think I have fixed it in both packages. The different between
them is that the byteswap is done in libs2 and not utils2, while it is
done in utils and not libs. Please reinstall libs2 from CVS and check
again.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
