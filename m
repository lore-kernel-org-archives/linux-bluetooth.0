Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 20 Nov 2007 14:31:07 +0200
Message-ID: <719D5CCC2F6E3644B0A9F5C9B1D0008803A90D3F@esebe104.NOE.Nokia.com>
From: <Kai.Vehmanen@nokia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] [PATCH] bluez-utils/audio: kv-multiple-periods-support
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

Hi,

here's a patch that allows pcm_bluetooth.c to support
multiple period sizes (and thus gives application some
control over the wakeup/latency requirements it has to meet).
This patch works around an alsa-lib bug/limitation (triggered
if we allow the buffersize to vary). And a consequency,
buffersize is always fixed to 3*8192 bytes.

Patch available at:
http://sofia-sip.org/~vehmanek/bluez-patches/patch-20071120-kv-multiple-
periods-support.txt

PS Tested with alsa-lib pcm.c, alsa-utils speaker-test, 
   gstreamer (gst-launch + alsasink), and pulseaudio. The A2DP headsets
   used for testing were Nokia BH-501 and Logitech Freepulse Wireless.

-- 
first.surname@nokia.com (Kai Vehmanen)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
