Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4f436aae0702192256p8fb5182web7a3aa633eb1025@mail.gmail.com>
References: <4f436aae0702192256p8fb5182web7a3aa633eb1025@mail.gmail.com>
Date: Wed, 21 Feb 2007 13:07:35 +0100
Message-Id: <1172059655.7403.9.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bluez-utils-3.9 compilation error
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Choi,

> I get this in the 'make' phase:
> 
> libhciserver.a(dbus-common.o): In function `unregister_sdp_record':
> dbus-common.c:(.text+0x90): undefined reference to
> `sdp_device_record_unregister_binary'
> libhciserver.a(dbus-common.o): In function `register_sdp_binary':
> dbus-common.c:(.text+0x106): undefined reference to
> `sdp_device_record_register_binary'
> collect2: ld returned 1 exit status
> 
> dows anyone have any clue ?

the ChangeLog file clearly states that you need an appropriate
bluez-libs installation.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
