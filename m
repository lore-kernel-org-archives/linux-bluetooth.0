Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problems with nc6 with bluez support
From: Marcel Holtmann <marcel@holtmann.org>
To: Mauro Tortonesi <mtortonesi@ing.unife.it>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200401221221.49241.mtortonesi@ing.unife.it>
References: <200401221042.53134.mtortonesi@ing.unife.it>
	 <1074767225.7263.65.camel@pegasus>
	 <200401221221.49241.mtortonesi@ing.unife.it>
Content-Type: text/plain
Message-Id: <1074771503.19046.12.camel@pegasus>
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
Date: Thu, 22 Jan 2004 12:38:23 +0100

Hi Mauro,

> yes, IMVHO it is nice indeed. unfortunately, i haven't added 
> configuration-time checks for Bluez yet, so if anyone of you wants to try nc6 
> with bluetooth, he'll have to edit src/Makefile and add -DHAVE_BLUEZ to DEFS 
> and -lbluetooth to LDFLAGS.
> 
> i was thinking about adding something like the following test to configure.ac 
> to check if the system supports bluez:
> 
> bluez=yes
> PROTO_BLUEZ(
>   [
>     AC_CHECK_LIB(bluetooth, baswap, , bluez=no)
>   ],
>   [
>     AC_MSG_NOTICE([Disabling Bluetooth support: PF_BLUETOOTH protocol family 
> is required])
>     bluez=no
>   ]
> )
> 
> where PROTO_BLUEZ is defined in this way:
> 
> AC_DEFUN([PROTO_BLUEZ],[
>   AC_CACHE_CHECK([for Bluetooth support], [ds6_cv_proto_bluez],[
>     AC_TRY_CPP([
> #include <sys/types.h>
> #include <sys/socket.h>
> 
> #ifndef PF_BLUETOOTH
> #error Missing PF_BLUETOOTH
> #endif
> #ifndef AF_BLUETOOTH
> #error Mlssing AF_BLUETOOTH
> #endif
>     ],[
>       ds6_cv_proto_bluez=yes
>     ],[
>       ds6_cv_proto_bluez=no
>     ])
>   ])
> 
>   if test "X$ds6_cv_proto_bluez" = "Xyes"; then :
>     $1
>   else :
>     $2
>   fi
> ])
> 
> what do you think about it?

I must admit that I am not an autoconf expert, so my rule is that as
long as it works it is ok. A nice idea is to check for the sockaddr_*
definitions.

BTW please post a diff of nc6 that adds the Bluetooth support. This will
make it easier for me to audit your code.

> > But you should forget about the SCO transfers. SCO is for audio transmission
> > (voice) only. Use L2CAP (SOCK_SEQPACKET) and RFCOMM (SOCK_STREAM).
> 
> in fact i just wanted to perform audio transmission.
> 
> i have written the audioread application, that reads an oggvorbis file, 
> decodes it and writes the PCM samples to stdout, and the audiotest 
> application, that reads PCM samples from stdin and writes them to /dev/dsp.
> 
> so i was testing audio transfers by issuing this command on the server host:
> 
> nc6 -b -l -p 10 | audiotest
> (nc6 -b -l --sco | audiotest for SCO)
> 
> and this command on the client host:
> 
> audioread file.ogg | nc6 -b 00:0D:88:8E:CA:07 10
> (audioread file.ogg | nc6 -b --sco 00:0D:88:8E:CA:07 for SCO)
> 
> i must have made something wrong, since all the audio transfer tests i've made 
> failed.

The audio stuff is not very easy if you do SCO over HCI over USB. You
have to check if your dongle sends the SCO traffic over the HCI layer.
Then you really need the latest 2.4.25-pre kernel or you have to apply
one of my -mh patches.

> so are you suggesting to stick to 2.4 for the moment? i have been using 2.6 on 
> my laptop for the last 5 months and i am really enthusiastic about it ;-)

If you want to use SCO with an USB Bluetooth dongle? Yes, you must stick
to 2.4 until the SCO problem is solved. Of course if you own an OHCI USB
host adapater you can give 2.6 a try, but the UHCI will fail and crash
your system.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
