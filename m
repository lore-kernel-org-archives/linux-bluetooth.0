Return-Path: <cyrus@holtmann.org>
Message-ID: <47AC2216.6030600@wurmsdobler.org>
Date: Fri, 08 Feb 2008 09:34:14 +0000
From: Peter Wurmsdobler <peter@wurmsdobler.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <47AB5665.8040101@wurmsdobler.org>
	<E1JNHhP-0003Yf-Fl@necz1>	<47AC1B43.40807@wurmsdobler.org>
	<E7A0FBBA-A2CF-4B87-B4CA-B05CD6BF5600@gmail.com>
In-Reply-To: <E7A0FBBA-A2CF-4B87-B4CA-B05CD6BF5600@gmail.com>
Subject: Re: [Bluez-users] Headset, ALSA and other issues
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello Johan,
> The preferred way would be to use the BlueZ D-Bus interface, but I'm  
> not aware of any nice UI to do it (e.g. the bluetooth-wizard from  
> bluez-gnome is still incomplete). 
I had this wizard running on the desktop, but I am not very happy with 
it as it is not clear how it happens, what happens and also it is not 
predictible enough.

> You can however find some examples  
> of running dbus-send from the command line and example python scripts  
> here:
> http://wiki.bluez.org/wiki/HOWTO/Bonding
Thanks, I will have a look at it.

If a "client" would send requests on the dbus, who would be the 
receiver? WOuld it have to be hcid?

As mentioned earlier, the entire bt system appears to me very woolly; 
difficult to get a grip onit.

peter



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
