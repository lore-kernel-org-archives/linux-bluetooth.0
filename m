Return-Path: <mtortonesi@ing.unife.it>
From: Mauro Tortonesi <mtortonesi@ing.unife.it>
To: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problems with nc6 with bluez support
Date: Thu, 22 Jan 2004 12:21:49 +0100
References: <200401221042.53134.mtortonesi@ing.unife.it> <1074767225.7263.65.camel@pegasus>
In-Reply-To: <1074767225.7263.65.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200401221221.49241.mtortonesi@ing.unife.it>
List-ID: <bluez-devel.lists.sourceforge.net>

On Thursday 22 January 2004 11:27, you wrote:
> Hi Mauro,
>
> > i have just modified nc6 (an advanced IPv6-enabled nc clone) to support
> > connections over bluetooth. normal connections over l2cap seem to work
> > fine (although i have not been able to tranfer audio data over l2cap yet)
> > but when i try to perform data tranfers over sco the
>
> looks like nice stuff and if I find some extra time I will test it.

yes, IMVHO it is nice indeed. unfortunately, i haven't added 
configuration-time checks for Bluez yet, so if anyone of you wants to try nc6 
with bluetooth, he'll have to edit src/Makefile and add -DHAVE_BLUEZ to DEFS 
and -lbluetooth to LDFLAGS.

i was thinking about adding something like the following test to configure.ac 
to check if the system supports bluez:

bluez=yes
PROTO_BLUEZ(
  [
    AC_CHECK_LIB(bluetooth, baswap, , bluez=no)
  ],
  [
    AC_MSG_NOTICE([Disabling Bluetooth support: PF_BLUETOOTH protocol family 
is required])
    bluez=no
  ]
)

where PROTO_BLUEZ is defined in this way:

AC_DEFUN([PROTO_BLUEZ],[
  AC_CACHE_CHECK([for Bluetooth support], [ds6_cv_proto_bluez],[
    AC_TRY_CPP([
#include <sys/types.h>
#include <sys/socket.h>

#ifndef PF_BLUETOOTH
#error Missing PF_BLUETOOTH
#endif
#ifndef AF_BLUETOOTH
#error Mlssing AF_BLUETOOTH
#endif
    ],[
      ds6_cv_proto_bluez=yes
    ],[
      ds6_cv_proto_bluez=no
    ])
  ])

  if test "X$ds6_cv_proto_bluez" = "Xyes"; then :
    $1
  else :
    $2
  fi
])

what do you think about it?

> But you should forget about the SCO transfers. SCO is for audio transmission
> (voice) only. Use L2CAP (SOCK_SEQPACKET) and RFCOMM (SOCK_STREAM).

in fact i just wanted to perform audio transmission.

i have written the audioread application, that reads an oggvorbis file, 
decodes it and writes the PCM samples to stdout, and the audiotest 
application, that reads PCM samples from stdin and writes them to /dev/dsp.

so i was testing audio transfers by issuing this command on the server host:

nc6 -b -l -p 10 | audiotest
(nc6 -b -l --sco | audiotest for SCO)

and this command on the client host:

audioread file.ogg | nc6 -b 00:0D:88:8E:CA:07 10
(audioread file.ogg | nc6 -b --sco 00:0D:88:8E:CA:07 for SCO)

i must have made something wrong, since all the audio transfer tests i've made 
failed.

> > i am using kernel 2.4.25-pre6 and 2.4.22 on my test hosts. perhaps i
> > should switch to 2.6-series kernels? i am not sure about this, since
> > l2test and scotest from bluez-utils 2.3 seem to work fine on these
> > kernel.
>
> The 2.4.25-pre6 is still fine. If you get a problem with a 2.4 kernel
> apply the latest of my -mh patches.

so are you suggesting to stick to 2.4 for the moment? i have been using 2.6 on 
my laptop for the last 5 months and i am really enthusiastic about it ;-)

-- 
Aequam memento rebus in arduis servare mentem...

Mauro Tortonesi                 mtortonesi@ing.unife.it
                                mauro@deepspace6.net
                                mauro@ferrara.linux.it
Deep Space 6 - IPv6 with Linux  http://www.deepspace6.net
Ferrara Linux User Group        http://www.ferrara.linux.it
