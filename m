Return-Path: <cyrus@holtmann.org>
Message-Id: <E7A0FBBA-A2CF-4B87-B4CA-B05CD6BF5600@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <47AC1B43.40807@wurmsdobler.org>
Mime-Version: 1.0 (Apple Message framework v915)
Date: Fri, 8 Feb 2008 11:26:36 +0200
References: <47AB5665.8040101@wurmsdobler.org> <E1JNHhP-0003Yf-Fl@necz1>
	<47AC1B43.40807@wurmsdobler.org>
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


On Feb 8, 2008, at 11:05, Peter Wurmsdobler wrote:
>> Do you have them paired?
> Well here I am not so sure. I know that this is necessary, but how  
> can I
> make pairing happen? is there an hcitool command?

The preferred way would be to use the BlueZ D-Bus interface, but I'm  
not aware of any nice UI to do it (e.g. the bluetooth-wizard from  
bluez-gnome is still incomplete). You can however find some examples  
of running dbus-send from the command line and example python scripts  
here:
http://wiki.bluez.org/wiki/HOWTO/Bonding

Johan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
