Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300802071452s57369e2t4de936632257b7a7@mail.gmail.com>
Date: Thu, 7 Feb 2008 15:52:49 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <47AB899D.7060609@wurmsdobler.org>
MIME-Version: 1.0
References: <47AB5665.8040101@wurmsdobler.org>
	<d89ddf300802071149x4e36a56ajac12896abda9d7cc@mail.gmail.com>
	<47AB899D.7060609@wurmsdobler.org>
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

Peter

Yes, it will work if using pcm routing. Be sure to configure
/etc/bluetooth/audio.conf for pcm routing. That's how nokia uses the
audio service in the n810.

Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
