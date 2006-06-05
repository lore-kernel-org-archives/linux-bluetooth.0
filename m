Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4484AE0A.8050900@xmission.com>
Date: Mon, 05 Jun 2006 16:19:54 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] itech r35 supports mp3
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

FYI, I found my new r35 headset supports mp3 encoded streams. I changed
a2play to identify (but not use yet) mp3 support and there it is, layer
3 support built in.

too bad about the alsa plugin... audio must be decoded before being sent
to the plugin where it's re-encoded, possibly in the same format we just
decoded :(

gstreamer would realize the stream is already in a supported format and
skip those steps, but we're still stuck without a good ipc/server mixer
for gst.

Brad


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
