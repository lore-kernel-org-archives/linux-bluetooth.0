Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY107-W467598E882F42FE079C35D8FA0@phx.gbl>
From: Adolfo Bulfoni <iaquintovski@hotmail.com>
To: "bluez-devel@lists.sourceforge.net" <bluez-devel@lists.sourceforge.net>
Date: Mon, 31 Mar 2008 12:22:33 +0200
MIME-Version: 1.0
Subject: [Bluez-devel] restart periodic inquiry
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



Hi all,

I'm currently working with DBUS and GLIB. I have made a function that calls StartPeriodicDiscovery(). Everything works fine but, at certain point, I want to stop and restart it and here problems arise: when I call StopPeriodicDiscovery() my program exits and I can't call again StartPeriodicDiscovery. My program exits just after the StopPeriodicInquiry() is performed, and I dont call the g_main_loop_quit(loop) function. Is it a normal behaviour?
For me it is necessary to restart the inquiry procedure in some cases. Is there a way to restart the periodic discovery or should I move to the normal inquiry procedure? With the standard inquiry procedure I could call CancelInquiry and then I could start the inquiry procedure again.
Thanks all!

Adolfo
_________________________________________________________________
Cerchi una palestra vicino a casa? La trovi con Live Search Maps
 http://maps.live.it
-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
