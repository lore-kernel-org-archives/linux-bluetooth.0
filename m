Return-Path: <cyrus@holtmann.org>
To: bluez-users@lists.sourceforge.net
From: Paul Rushworth <paul@rushworth.co.nz>
Date: Thu, 3 Jan 2008 07:08:55 +0000 (UTC)
Message-ID: <loom.20080103T070304-65@post.gmane.org>
References: <200801012109.19744.lists@spudulike.me.uk>
	<d89ddf300801012103l48e26e3ax379e391055e31e72@mail.gmail.com>
	<loom.20080103T040638-726@post.gmane.org>
	<d89ddf300801022052i2fb09d53m203f5946455d406a@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users]
	=?utf-8?q?Stereo_audio_headset_-_half_a_second_of_a?=
	=?utf-8?q?udio=2C=098_seconds_of_silence=2C_then_disconnection=2E?=
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

Brad Midgley <bmidgley <at> gmail.com> writes:


> 
> likely this is a different problem. Does the gstreamer plugin route do
> the same thing? iirc:
> 
> gst-launch filesrc location=song.mp3 ! mad ! audioconvert ! sbcenc !
> a2dpsink device=00:12:0E:09:CF:9E
> 
> with a few different mp3s for good measure.
> 

The same thing happens; it disconnects after about 3 minutes:


19:59:40  audio[7031]: stream state changed: OPEN -> STREAMING
20:02:34  audio[7031]: session_cb
20:02:34  audio[7031]: Received CLOSE_CMD
20:02:34  audio[7031]: SBC Source: Close_Ind
20:02:34  audio[7031]: stream state changed: STREAMING -> CLOSING
20:02:34  audio[7031]: stream state changed: CLOSING -> IDLE
20:02:34  audio[7031]: avdtp_unref(0x806b588): ref=2
20:02:34  audio[7031]: SBC Source SEP 0x80694b8 unlocked
20:02:34  audio[7031]: avdtp_unref(0x806b588): ref=1
20:02:34  audio[7031]: Unix client disconnected (fd=11)
20:02:34  audio[7031]: session_cb
20:02:34  audio[7031]: Disconnected from 00:12:0E:09:CF:9E
20:02:34  audio[7031]: avdtp_unref(0x806b588): ref=0
20:02:34  audio[7031]: avdtp_unref(0x806b588): freeing session and 
removing from list
20:02:35  NetworkManager: <debug> [1199343755.068464] 
nm_hal_device_removed():
Device removed (hal udi is '/org/freedesktop/Hal/devices/
usb_device_ffffffff_ffffffff_noserial_bluetooth_hci_bluetooth_hci').



Ubuntu 7.10 (2.6.22-14-generic) with bluez from the Gutsy repo's,
for what its worth.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
