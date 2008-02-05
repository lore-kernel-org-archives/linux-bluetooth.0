Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300802051041j76801e4n5214d01bf01b48e3@mail.gmail.com>
Date: Tue, 5 Feb 2008 11:41:55 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <200802051233.33098.sa@claborn.net>
MIME-Version: 1.0
References: <200801242256.33910.sa@claborn.net>
	<20080205030256.E1739@3miasto.net.pl>
	<200802051229.19004.sa@claborn.net>
	<200802051233.33098.sa@claborn.net>
Subject: Re: [Bluez-users] How to setup a headset as an audio device?
	Getting "Device busy" errors
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

SA

edit /etc/bluetooth/audio.service and make sure you've enabled
autostart. restart bluetooth if you changed the file. I'll make sure
this is mentioned in the wiki.

Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
