Return-Path: <cyrus@holtmann.org>
From: Brian Sammon <bluez-users@brisammon.fastmail.fm>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-reply-to: <47AB5665.8040101@wurmsdobler.org> 
References: <47AB5665.8040101@wurmsdobler.org>
Mime-Version: 1.0
Date: Thu, 07 Feb 2008 20:06:39 -0500
Message-Id: <E1JNHhP-0003Yf-Fl@necz1>
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

I found it easier to focus on pairing the devices, before I worry about 
playing sound.
Do you have them paired?
To figure that out, look in /var/lib/bluetooth/ .  There should be a directory 
named for the MAC address of the bluetooth adaptor (local device).  In that 
directory should be a file "linkkeys" which will list all the devices that it 
is paired with.  In particular, you hope that the file contains the MAC 
address of the headset.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
