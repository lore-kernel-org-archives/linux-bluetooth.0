Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Re: Re: Re: Re: Re: hciattach problem
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <420A5CDE.80201@web.de>
References: <420A5CDE.80201@web.de>
Content-Type: text/plain
Message-Id: <1107975765.13863.96.camel@pegasus>
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
Date: Wed, 09 Feb 2005 20:02:45 +0100

Hi Andreas,

> >> I have checked with -mh3, too, and it does also work. I have no 
> >> But I think, I have done something wrong in the config or so. Thanks for 
> >> your help.
> >
> >actually I asked you to test 2.6.11-rc3 and not the -mh3. I want to be
> >sure that the latest testing kernel before the final 2.6.11 has no
> >problems with it. So grab 2.6.11-rc3-bk3 and test it please.
> >
> Sorry for my late post, but I was on holiday the last days. I have tried to compile 2.6.11-rc3-bk3, but the compiling breaks with an error:
> drivers/char/vt.c: In function `set_cursor':
> drivers/char/vt.c:560: error: structure has no member named `vc_vt'
> drivers/char/vt.c: In function `vc_allocate':
> drivers/char/vt.c:731: error: structure has no member named `vc_vt'
> drivers/char/vt.c:747: warning: `pm_register' is deprecated (declared at include/linux/pm.h:106)
> drivers/char/vt.c: In function `con_init':
> drivers/char/vt.c:2569: error: structure has no member named `vc_vt'
> make[2]: *** [drivers/char/vt.o] Fehler 1
> make[1]: *** [drivers/char] Fehler 2
> make: *** [drivers] Fehler 2
> 
> What should I do now? I'm not an linux expert.

see if it is fixed in 2.6.11-rc3-bk6 and if not, post a problem report
to the linux-kernel mailing list.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
