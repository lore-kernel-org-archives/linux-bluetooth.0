Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 9 Nov 2006 09:58:41 +0100
To: bluez-devel@lists.sourceforge.net
Message-ID: <20061109085841.GA11764@physik.fu-berlin.de>
Mime-Version: 1.0
From: Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [Bluez-devel] Bluetooth ALSA: a2play plays MP3s too fast
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

Hi fellows,

after figuring out, how to set the passkey-agent for the HCI-daemon
I finally was able to connect my new SONY VGP-BRM1D bluetooth audio
headset with my Linux box and stream audio playback of mpg123 to
the headset with a2play. Here's what I did in short:

1. find headset with "hcitool scan"
2. set passkey for headset with "passkey-agent 0000 <address>"
3. connect to headset with "btsco -v -r <address>"
4. stream audio with "mpg123 --au - file.mp3 | a2play <address>"

The sound quality is just find with 44,1kHz, Stereo. But the playback
of the MP3 is just a bit too fast (high pitched) and varies with
CPU-load, i.e. getting the computer busy makes the music slow down.

I tried the various options for a2play regarding the timing stuff
(-i, -n, -p), but none helped. I also changed the value for "TICKS"
in the a2play-source (a2play.c).


Here my specs:

Kernel: Linux 2.6.19-rc5 (also 2.6.17.9)
Computer: IBM Thinkpad 240X, PIII-500, 192MB RAM
BT-Dongle: Acer Bluetooth USB
Headset: SONY VGP-BRM1D (http://www.jp.sonystyle.com/Qnavi/Detail/VGP-BRM1D.html).

Best Regards,

Adrian Glaubitz

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
