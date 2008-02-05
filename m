Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300802050725w60e5c976ped6a6d83d97df0d6@mail.gmail.com>
Date: Tue, 5 Feb 2008 08:25:22 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <47A8669E.4080308@gmx.de>
MIME-Version: 1.0
References: <47A274DB.9020808@gmx.de> <1202025949.7162.10.camel@localhost>
	<47A8669E.4080308@gmx.de>
Subject: Re: [Bluez-users] BT Headset connected but no sound
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

Daniel

> I am using twinkle for SIP, but I can't get it working with bluetooth.
> Is there a way that I can see the headset as a alsa-device in
> /proc/asound/cards and that all applications can use it like a standard
> audio-device (alsamixer, etc...)?

sorry...alsa does not allow the plugin to show up in the standard list.

you should be able to choose "ALSA: other device" and type in
"bluetooth" or whatever you named the plugin in /etc/asound.conf or
~/.asounrc

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
