Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300801022052i2fb09d53m203f5946455d406a@mail.gmail.com>
Date: Wed, 2 Jan 2008 21:52:07 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20080103T040638-726@post.gmane.org>
MIME-Version: 1.0
References: <200801012109.19744.lists@spudulike.me.uk>
	<d89ddf300801012103l48e26e3ax379e391055e31e72@mail.gmail.com>
	<loom.20080103T040638-726@post.gmane.org>
Subject: Re: [Bluez-users] Stereo audio headset - half a second of audio,
	8 seconds of silence, then disconnection.
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

Paul

> absolutely fine for around 2-3 minutes and then audio stops working (does seem
> slightly random, but always within 2-3 minutes.)

likely this is a different problem. Does the gstreamer plugin route do
the same thing? iirc:

gst-launch filesrc location=song.mp3 ! mad ! audioconvert ! sbcenc !
a2dpsink device=00:12:0E:09:CF:9E

with a few different mp3s for good measure.

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
