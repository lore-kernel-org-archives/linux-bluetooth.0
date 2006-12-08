Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <457901E9.6070309@xmission.com>
Date: Thu, 07 Dec 2006 23:10:49 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] alsa plugin querying stream states
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hey

We can connect headsets from a gui and the plan is to have signals
generated when that happens, but if an audio client is launched *after*
the streams are opened or started, its plugin needs to be able to find
out the state of things on startup so it can route audio properly.

This would mean some more methods unless you can see another way:

                array{string} ListActiveStreams()

                boolean IsHeadset(string stream)

                        Return true if the stream represents a
                        headset.

                boolean IsSink(string stream)

                        Return true if the stream represents
                        A2DP headphones.

                boolean IsPlaying(string stream)

                        Return true if the stream is in a playing
                        state.

As long as these are here, we might simplify Connect to return both
kinds of streams for combo headset/a2dp sets.

		array{string} Connect(string bdaddr)

then the array of streams returned can be queried by the methods above.

I really hope we're converging on something... a really simple solution
has been elusive.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
