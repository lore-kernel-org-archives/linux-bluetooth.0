Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 16 Jan 2007 11:07:29 -0800 (PST)
From: Steve Romanow <slestak989@yahoo.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <547254.75348.qm@web35613.mail.mud.yahoo.com>
Subject: Re: [Bluez-devel] Compilation Problem Plugz
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


>I'll attach my generated Makefile... can you see why mine would work and
>yours does not?
>
>Brad

Brad,

I had same problem with a Kubuntu Edgy install using automake 1.4

Didnt work for me until I added @DBUS_CFLAGS@ to the AM_CFLAGS in
plugz/alsa-plugins/a2dpd/Makefile.am

HTH,

Slestak


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
