Return-Path: <ohadbc@gmail.com>
Message-ID: <4f436aae0702210418t94fc550l4fffe1088588bed5@mail.gmail.com>
Date: Wed, 21 Feb 2007 14:18:39 +0200
From: "Choi Sonim" <choisonim@gmail.com>
Sender: ohadbc@gmail.com
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluez-utils-3.9 compilation error
Cc: "Marcel Holtmann" <marcel@holtmann.org>
In-Reply-To: <1172059655.7403.9.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4f436aae0702192256p8fb5182web7a3aa633eb1025@mail.gmail.com>
	 <1172059655.7403.9.camel@violet>
List-ID: <bluez-devel.lists.sourceforge.net>

hi Marcel,

On 2/21/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Choi,
>
> > I get this in the 'make' phase:
> >
> > libhciserver.a(dbus-common.o): In function `unregister_sdp_record':
> > dbus-common.c:(.text+0x90): undefined reference to
> > `sdp_device_record_unregister_binary'
> > libhciserver.a(dbus-common.o): In function `register_sdp_binary':
> > dbus-common.c:(.text+0x106): undefined reference to
> > `sdp_device_record_register_binary'
> > collect2: ld returned 1 exit status
> >
> > dows anyone have any clue ?
>
> the ChangeLog file clearly states that you need an appropriate
> bluez-libs installation.

but i did built the bluez-libs-3.9 before. they were installed to /usr/local/lib
and I did export LD_LIBRARY_PATH=/usr/local/lib.
should I do anything more ?

thank you very much for the help
choi

>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
