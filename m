Return-Path: <cyrus@holtmann.org>
From: Wolfram Joost <bluez@frokaschwei.de>
To: bluez-devel@lists.sourceforge.net
Date: Sun, 4 May 2008 22:10:42 +0200
MIME-Version: 1.0
Message-Id: <200805042210.42828@mail.frokaschwei.de>
Subject: [Bluez-devel] bluez-utils 3.30, uClibc, hcid, plugin handling
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

I had some trouble using hcid from bluez-utils 3.30 on my openwrt-router.
Openwrt uses uClibc, not glibc.

I discovered the following two problems:

1. In eglib/gmodule.c, function g_module_open, line 29 dlopen is used.
The flags for dlopen come from hcid/plugin.c, function plugin_init, line 94.
The flag-value is 0. According to the manpage of dlopen
(http://www.kernel.org/pub/linux/docs/manpages/man-pages-2.79.tar.bz2),
one of RTLD_LAZY or RTLD_NOW has to be set. uClibc checks this and returns an error.

2. hcid needs to be linked with -rdynamic or --export-dynamic. Some functions
in the hcid-executable are used by the plugins. Without -rdynamic uClibc
doesn't resolve the symbols in the plugins resulting in a NULL pointer
dereference and a SIGSEGV. Again, its documented in the man-page of
dlopen.

Wolfram

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
