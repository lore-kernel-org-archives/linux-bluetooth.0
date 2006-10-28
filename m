Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 28 Oct 2006 23:12:25 +0200
From: "Dr. Johannes Zellner" <johannes@zellner.org>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20061028211225.GA11907@zellner.org>
MIME-Version: 1.0
Subject: [Bluez-devel] bluetooth-alsa works with aplay but not with xmms
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

Hi,

http://bluetooth-alsa.sf.net/ says that this would be an appropriate
mailing list for questions concerning bluetooth-alsa.

I followed the instructions on

    https://help.ubuntu.com/community/BluetoothAudio

to connect to my mono headset (Jabra 250) with the alsa-plugin (no
additional kernel modules). The method with defining a headset pcm
device in ~/.asoundrc and /usr/bin/headsetd works when using

    aplay -D headset bla.wav

But when I use xmms I get tons of messages like

    DEBUG: sco_pointer: returning bt_headset->hw_ptr=0

and no sound on the headset.

Any ideas?

-- 
Johannes

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
