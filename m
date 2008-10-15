Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <48F6301E.30607@powercraft.nl>
References: <48F1F7C0.4040705@powercraft.nl>
	<1223819361.31961.1763.camel@cookie.hadess.net>
	<48F5E741.7020907@powercraft.nl>
	<1224078893.5268.2962.camel@cookie.hadess.net>
	<1224083365.5268.3130.camel@cookie.hadess.net>
	<1224083803.4764.8.camel@californication>
	<48F6301E.30607@powercraft.nl>
Date: Wed, 15 Oct 2008 23:05:43 +0100
Message-Id: <1224108343.5268.3679.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Re:  Sony Bluetooth BD Remote Control
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Wed, 2008-10-15 at 20:02 +0200, Jelle de Jong wrote:
<snip>
> Thank you all for the patches and the support, after rebuilding
> everything and trying things out. The bluetooth-applet wizzard system
> tolled me it connected successfully. See the log below.
> 
> However how can I know actually use the device? I tried xbindings --key
> to catch a key and bind it to something useful. I feel like I am back to
> point one with the old hidd system...

Then you need something that can listen to the event from the Linux
input layer device. On Fedora it will probably be through lirc, and
gnome-lirc-properties:
http://bugzilla.gnome.org/show_bug.cgi?id=555802

If your setup isn't customised, you should at least see some keys as
having keysyms under X. Launch xev and press the "Play" key.

But you'll see that something like lirc will be necessary to take full
advantage of the remote.

Cheers


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
