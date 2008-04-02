Return-Path: <cyrus@holtmann.org>
Message-ID: <47F3B09F.5070709@aircable.net>
Date: Wed, 02 Apr 2008 13:13:19 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47EDAEED.4000302@aircable.net>	<52DF986C-FC13-4F04-81F7-6A269B0EB0D1@holtmann.org>	<47F05CEF.8040300@aircable.net>	<200803311404.06902.denis.kenzior@trolltech.com>
	<47F3AEBC.9010407@idlum.be>
In-Reply-To: <47F3AEBC.9010407@idlum.be>
Subject: Re: [Bluez-devel] CreateProxy usage?
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

Hi Pierre-Yves,
You don't need to link against bluez AFAIK, you only link against the
sockets library which is included in libc. I'll try to write a wiki page
today, the other day I had some troubles with my electric power
provider, and forgot to make the wiki page.
But I've been able to write 2 examples on as master, the other as slave
using python and dbus, and I have C code around I can use too.
Cheers,
Manuel


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
