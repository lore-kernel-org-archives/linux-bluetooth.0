Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <474827AB.1040102@gmail.com>
Date: Sat, 24 Nov 2007 14:31:23 +0100
From: Csillag Kristof <csillag.kristof@gmail.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] using BlueZ with pulseaudio
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

Hi there!


I can figure out how to use PulseAudio with the ALSA device provided by
BlueZ.


I have BlueZ 3.22 installed & configured.


My /etc/asound.rc looks like this:


------------------------------------------

pcm.headset {
    type bluetooth
    device xx:xx:xx:xx:xx:xx
}

ctl.headset {
    type bluetooth
    device xx:xx:xx:xx:xx:xx
}

-----------------------------------


(Of course, instead of the Xes, it contains the address of my BT headset.)


I can use xmms/audacious to output sound to the alsa device "headset", and

it works all right.


However, when I try to run a PulseAudio sink on top of this device

(by adding  "load-module module-alsa-sink device=headset" to
/etc/pulse/default.pa),

I get the following error:


----------------------------------------------------------------------------------------------------------------------------------

ALSA lib ctl_bluetooth.c:150:(bluetooth_send_ctl) Unable to request new
volume value to server: Socket operation on non-socket
W: alsa-util.c: Unable to load mixer: Socket operation on non-socket
--------------------------------------------------------------------------------------------------------------------


I can run PulseAudio sinks on top of other ALSA devices, so I guess the
problem

lies in PulseAudio interfacing with the BlueTooth ALSA mixer.

How can I configure this?


How can I use this mixer anyway? I have not yet found any alsa

mixer application which lets me configure the name of the mixer device
to use.


Thank you for your help:


     Kristof Csillag



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
