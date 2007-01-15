Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45ABC674.6000402@xmission.com>
References: <45ABC674.6000402@xmission.com>
Date: Mon, 15 Jan 2007 19:35:46 +0100
Message-Id: <1168886146.31200.12.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] no-install clients in sbc project
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

Hi Brad,

> Is there a better way to put sbcenc and sbcdec into the sbc project and
> have them link than this? It seems a little underhanded to link libsbc.a
> this way:
> 
> Index: src/Makefile.am
> ===================================================================
> RCS file: /cvsroot/sbc/sbc/src/Makefile.am,v
> retrieving revision 1.3
> diff -u -r1.3 Makefile.am
> --- src/Makefile.am     18 Feb 2006 22:19:47 -0000      1.3
> +++ src/Makefile.am     15 Jan 2007 18:20:44 -0000
> @@ -1,4 +1,6 @@
> 
> -bin_PROGRAMS = sbcinfo
> +bin_PROGRAMS = sbcinfo sbcenc sbcdec
> +sbcenc_LDADD = ../lib/.libs/libsbc.a
> +sbcdec_LDADD = ../lib/.libs/libsbc.a
> 
>  MAINTAINERCLEANFILES = Makefile.in

that is totally wrong. Tell me what you are trying to achieve and I tell
you the autoconf/automake trick.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
