Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] dongle manufacturers
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <427898EC.7040200@gmx.ch>
References: <4277B273.3010706@gmx.ch> <1115152035.8496.15.camel@pegasus>
	 <427898EC.7040200@gmx.ch>
Content-Type: text/plain
Message-Id: <1115200453.8496.80.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 04 May 2005 11:54:13 +0200

Hi Marco,

> >>I just bought two SiliconWave bt1.2 USB Dongles (Anycom and arp datacon).
> >>
> >>What's the supportstate of SiliconWave?
> > 
> > if it is the ROM version then all of them return the wrong inquiry with
> > RSSI event. I have a kernel workaround for that ready, but it is not
> > public at the moment.
> 
> how do I know if it's the rom version?

what does "hciconfig hci0 version features" tells you.

> they are pretty new, maybee that's already fixed.

Actually I doubt it. However you set the inquiry mode to 1 and check by
yourself the size of the returned inquiry result events.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
