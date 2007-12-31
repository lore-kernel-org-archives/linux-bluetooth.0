Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300712301602x44c7bf04kec26fa3777615fe9@mail.gmail.com>
Date: Sun, 30 Dec 2007 17:02:28 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] default link mode/policy vs. audio
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

Hey

I would like to get a2dp audio without gaps, ideally without adding
master to the default link mode and taking rswitch out of the default
link policy.

When I run bluetooth dun, mouse, and a2dp all at once, I get gaps if
the phone or headset are in the master role. The gaps are terrible (1s
audio, 3s gap) if both the phone and headset are master. Unfortunately
that is what I end up with under a default hcid.conf. The gaps last
less than a second and occur every 30 seconds or so if only one or the
other is master.

Without a way to tell the audio and serial services to prefer using
the master role, it looks like the global config in hcid.conf is
necessary. It is a global sort of problem since dun is totally
unrelated to audio and it ends up being a source of trouble.

fwiw, the adapter on my laptop is a bluecore2 and I'm using cvs head utils.

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
