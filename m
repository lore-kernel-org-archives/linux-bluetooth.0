Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <48F1F7C0.4040705@powercraft.nl>
References: <48F1F7C0.4040705@powercraft.nl>
Date: Sun, 12 Oct 2008 14:49:20 +0100
Message-Id: <1223819361.31961.1763.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Sony Bluetooth BD Remote Control
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

On Sun, 2008-10-12 at 15:12 +0200, Jelle de Jong wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
<snip>
> Hello everybody,
> 
> I bought a bluetooth remote for a bluetooth mobile system that I am
> trying to built. (bluetooth remote, speakers, mouse, keyboard, headset, gps)
> 
> However I can't get the device to work out of the box... I have found
> some script and some tools on the internet but this is not very
> maintainable (and I could not get it to work)
> 
> I am wondering what is needed to create a good healthy maintainable
> system to get the remote working out of the box after connecting to it
> with bluez...? So how do we create out of the box support for bluetooth
> devices?
> 
> hidd[3688]: New HID device 00:1E:3D:15:0A:4F (Sony Computer

There's no hidd support for the PS3 BD remote. Use bluez-{utils,libs}
3.36, or use the latest versions of bluez and bluez-gnome (and make sure
your version has that patch[1]).

And don't use that "Linux driver" horror that requires networking...

[1]:
http://git.kernel.org/?p=bluetooth/bluez-gnome.git;a=commit;h=c99b105989a216dd4565228ba7dc3b2702f4a6ad


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
