Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080310143609.exuwdzs9gk4w48ss@wmlab.csie.ncu.edu.tw>
References: <20080310143609.exuwdzs9gk4w48ss@wmlab.csie.ncu.edu.tw>
Date: Mon, 10 Mar 2008 23:29:20 +0000
Message-Id: <1205191760.30595.1.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] bluez-gnome access volatile
	while	adapter-changed
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


On Mon, 2008-03-10 at 14:36 +0800, Ming-I Hsieh wrote:
> Hi, all
> 
> This is a patch for this bug. This bug adddress at  
> bluetooth-device-select.c. While the dongle could be removed/inserted,  
> the gnome-applet may crash due to access a 0x0 priv.

Good catch, but wrong fix, as we shouldn't even be listening to that
signal anymore. If you could please test the patch I uploaded at:
http://bugzilla.gnome.org/show_bug.cgi?id=519791#c4

I'll post it here for Marcel to apply if it fixes the problem for you.

Cheers


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
