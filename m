Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] [bluetooth-alsa] and [libao-devel]
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <cpk3v3$4bb$1@sea.gmane.org>
References: <cpk3v3$4bb$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1102948606.8750.159.camel@pegasus>
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
Date: Mon, 13 Dec 2004 15:36:46 +0100

Hi,

> If you are having troubles trying to install the bluetooth-alsa for 
> headset support (http://bluetooth-alsa.sourceforge.net/) from a clean 
> Fedora Core 3 installation, this may help you:
> 
> Following the build instructions from the page above I got this output 
> from the ./configure script:
> .
> .
> .
>  > checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
>  > checking for libasound headers version >= 1.0.3... found.
>  > checking for snd_ctl_open in -lasound... yes
>  > ./configure: line 3249: XIPH_PATH_AO: command not found
>  > configure: creating ./config.status
>  > config.status: creating Makefile
>  > config.status: creating sbc/Makefile
> .
> .
> and the make process generates the following output+errors:
> 
> make  all-recursive
> make[1]: Entering directory `/home/lpeiro/btsco'
> Making all in sbc
> make[2]: Entering directory `/home/lpeiro/btsco/sbc'
> gcc -DHAVE_CONFIG_H -I. -I. -I..    @AO_CFLAGS@ -Wall -O2 -c sbclib.c
> gcc: @AO_CFLAGS@: No such file or directory
> make[2]: *** [sbclib.o] Error 1
> make[2]: Leaving directory `/home/lpeiro/btsco/sbc'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/lpeiro/btsco'
> make: *** [all] Error 2
> 
> 
> In order to have XIPH_PATH_AO available you will need libao-devel 
> package installed. This can be found at www.rpmfind.net, for the fedora 
> distribution.
> After that building process worked smoth for me.

we know and actually I already pointed this out in another thread you
can find in the mailing list archive ;)

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
