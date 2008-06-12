Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Jun 2008 20:14:28 -0700 (PDT)
From: hong zhang <henryzhang62@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20419813.1056881213238999944.JavaMail.coremail@bj163app77.163.com>
MIME-Version: 1.0
Message-ID: <436638.99625.qm@web57910.mail.re3.yahoo.com>
Subject: Re: [Bluez-users] How to use Bluez with CSR chip ?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

If csr bc4 is initialized by eeprom (csr.psr is burned
into eeprom already) when power on. At this case, no
bccmd is needed. =



--- attaboyu@163.com wrote:

>    hi raymond
> the csr bc4 need to be configured before real
> running, some pskey should be set and warmreset
> should be issued. =

> 1. add --enable-bccmd feature while configure the
> bluez-utils
> 2. use bccmd after hci0 is up:
>     $bccmd -t hci psload -r /csr.psr
>      here csr.psr is the pskey config file, -r means
> warmreset after pskey configured,there is a example
> psr file in bluez-utils/tools/example
> =

> after that, u can see the other device through
> hcitool scan
> =

> attaboyu
> =

>  =D4=DA2008-06-11=A3=ACcolorant <colorant@163.com> =D0=B4=B5=C0=A3=BA
> >Hi henry
> >
> >    Thanks for you reply.
> >
> >    Yes , I am using BC4 A06 Rom version on an arm
> based embedded board.
> >
> >    So this one must set pskey before running right
> ?
> >
> >    I try to run the CSR's demo first to set the
> right pskey and run the =

> >chip up.
> >    After I exit the demo, I can use pc to detect
> the chip.
> >
> >    While , then I use :
> >
> >    hciattach /dev/ttyS1 bcsp 921600
> >
> >    to attach ttyS1 to hci0
> >
> >    after that , The PC can not detect the chip
> anymore.
> >
> >    and then I try
> >    hciconfig hci0 up
> >    it can bring up the hci0 interface , but the pc
> still don't detect the =

> >chip.
> >
> >    for kernel , I only insert bluetooth.ko and
> hci_uart.ko
> >
> >    So , can you kindly figure out what might be
> wrong in my operation ?
> >
> >    Seems to me the hciattach operation reset the
> chip. And I might need to =

> >modify the hciattach , or ?
> >
> >Raymond
> >
> >----- Original Message ----- =

> >From: "hong zhang" =

> >To: "BlueZ users" =

> >Sent: Wednesday, June 11, 2008 8:57 AM
> >Subject: Re: [Bluez-users] How to use Bluez with
> CSR chip ?
> >
> >
> >> Raymond,
> >>
> >> CSR bc4 is initialized in two ways based on your
> >> design. I assum your board is embedded. One is by
> >> eeprom and one is using command after build. You
> need
> >> to provide more information.
> >>
> >> You have to make sure your CSR bc4 chip on your
> board
> >> is up first before using bluez.
> >>
> >> Regular talking here is based on x86.
> >>
> >> ---henry
> >>
> >> --- colorant  wrote:
> >>
> >>> Hi
> >>>
> >>>     I am not sure is this the proper place to
> put up
> >>> this question, if not ,
> >>> please correct me.
> >>>
> >>>     I was trying to run bluez on our board with
> bc4
> >>> chip. This chip need to
> >>> set pskey before it can run
> >>>
> >>>     I use hciattach and hciconfig to bring up
> the
> >>> hci0 interface.
> >>>
> >>>     Then I try hcitool hci0 scan with my
> earphone
> >>> open.
> >>>
> >>>     Nothing happend.
> >>>
> >>>     while, if I using CSR's bchs a2dp demo ,
> it's
> >>> ok, I can play music. say
> >>> hardware is ok.
> >>>
> >>>     My question is :
> >>>
> >>>     1. To enable bluez with csr chip, is there
> >>> anything need to do vs the
> >>> standard kernel and bluez package ? Some config
> >>> need?
> >>>
> >>>     2. Did I need to place the bootrap init
> sequence
> >>> for the bc4 chip in
> >>> some place if I using bluez ? say in kernel or
> in
> >>> the bluez user space
> >>> scripts? Or , the standard kernel and bluez
> utility
> >>> already hand it, But I
> >>> just do the wrong way ?
> >>>
> >>>
> >>> Many thanks.
> >>> Raymond
> >>>
> >>>
> >>>
> >>>
> >>>
> >>
>
-------------------------------------------------------------------------
> >>> Check out the new SourceForge.net Marketplace.
> >>> It's the best place to buy or sell services for
> >>> just about anything Open Source.
> >>> http://sourceforge.net/services/buy/index.php
> >>> _______________________________________________
> >>> Bluez-users mailing list
> >>> Bluez-users@lists.sourceforge.net
> >>>
> >>
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> >>>
> >>
> >>
> >>
> >>
> >>
> >>
>
-------------------------------------------------------------------------
> >> Check out the new SourceForge.net Marketplace.
> >> It's the best place to buy or sell services for
> >> just about anything Open Source.
> >> http://sourceforge.net/services/buy/index.php
> >> _______________________________________________
> >> Bluez-users mailing list
> >> Bluez-users@lists.sourceforge.net
> >>
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> >> =

> >
> >
> >
> >
>
>-------------------------------------------------------------------------
> >Check out the new SourceForge.net Marketplace.
> >It's the best place to buy or sell services for
> >just about anything Open Source.
> >http://sourceforge.net/services/buy/index.php
> >_______________________________________________
> >Bluez-users mailing list
> >Bluez-users@lists.sourceforge.net
>
>https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
-------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php>
_______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> =




      =


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
