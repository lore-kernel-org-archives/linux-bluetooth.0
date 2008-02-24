Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Sun, 24 Feb 2008 18:37:41 +0000
Message-Id: <1203878261.2754.140.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] Option for more-"gnomey" settings
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

Heya,

As you know, I have a problem with a few settings in bluez-gnome not
matching up with the philosophy/target for GNOME.

Right now it's:
- "Use HAL" settings, and associated device selection
- Sharing properties, which conflict with gnome-user-share (where we
want to have most of the sharing preferences for GNOME, including
sharing the screen using vino, etc.)

Would you accept a patch to add a --enable-gnome to configure to hide
those settings away when bluez-gnome is compiled for use in the GNOME
desktop? Or would you prefer a run-time option?

Cheers


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
