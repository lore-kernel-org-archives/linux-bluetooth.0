Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200607312232.58278.thermal@o2.pl>
References: <200607312232.58278.thermal@o2.pl>
Date: Tue, 01 Aug 2006 00:41:16 +0200
Message-Id: <1154385676.4982.39.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] inline keyword & ansi-C compilers
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

Hi,

> Recently when I`ve tried to compile KDE (ktnef to be exact) I came upon 
> an error in your include files:

no idea what ktnef has to do with BlueZ. This seems to be the main
problem here.

> So I wrote a tiny patch to fix this:
> 
> --- bluez-libs-3.2/include/bluetooth.h  2006-07-31 20:57:08.000000000 
> +0200
> +++ /usr/include/bluetooth/bluetooth.h  2006-07-31 20:55:55.000000000 
> +0200
> @@ -109,12 +109,19 @@
>  #define BDADDR_ALL   (&(bdaddr_t) {{0xff, 0xff, 0xff, 0xff, 0xff, 
> 0xff}})
>  #define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff}})
> 
> +/* No inline keyword in the iso8988:1990 standard */
> +#ifdef __STRICT_ANSI__
> +    #define __INLINE
> +#else
> +    #define __INLINE inline
> +#endif
> +

I don't like to provide any workarounds for any crazy standard that
forcing it makes no real sense to me. However what about this:

#ifdef __STRICT_ANSI__
#define inline
#endif

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
