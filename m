Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Jun 2011 14:24:26 +0200
From: YuGiOhJCJ Mailing-List <yugiohjcj-mailinglist@laposte.net>
To: Takeshi Hamasaki <takeshi.ken.hamasaki@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluetooth headset on linux
Message-Id: <20110613142426.cbbd0862.yugiohjcj-mailinglist@laposte.net>
In-Reply-To: <BANLkTi=L44VBVA1aO-V4mD=3495yLxMdwA@mail.gmail.com>
References: <1307874927.6198.2.camel@localhost>
	<BANLkTim6_pgow2+an11ktfHz49RAoJHK=w@mail.gmail.com>
	<20110612173139.63533a90.yugiohjcj-mailinglist@laposte.net>
	<BANLkTi=L44VBVA1aO-V4mD=3495yLxMdwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Indeed it solves my compile problem, thank you :-)
---
# An echo program that protects backslashes.
ECHO="printf %s\\n"
echo="echo"
---
I add the line :
echo="echo"
after the line :
ECHO="printf %s\\n"
in the file :
libtool

So now I have installed bluetooth-alsa and I think it can help me to make my bluetooth headset works.

I do this :
$ sudo a2dpd
A2DPD[14:19:26.370]: init_ipc: Selected IPC: unix, addr=127.0.0.1, bcst=127.0.0.255, port=21453
A2DPD[14:19:26.370]: main: a2dpd [Jun 13 2011 13:46:06] starting ...
A2DPD[14:19:26.371]: main: (errno=9:Bad file descriptor)a2dpd addr=00:1E:7C:01:0A:5E timer=0 us [Jun 13 2011 13:46:06]
A2DPD[14:19:26.371]: a2dpd_signal_init: Getting on DBUS
A2DPD[14:19:26.373]: a2dpd_signal_init: Installing watch
A2DPD[14:19:26.373]: add_dbus_watch: Added watch 0 0x8d67858 disabled
A2DPD[14:19:26.373]: add_dbus_watch: Added watch 1 0x8d67880 enabled
A2DPD[14:19:26.373]: a2dpd_signal_init: Registering object path: /com/access/a2dpd
A2DPD[14:19:26.374]: a2dpd_signal_init: Acquiring service: com.access.a2dpd
A2DPD[14:19:26.375]: a2dpd_signal_init: OK
A2DPD[14:19:26.375]: a2dpd_signal_init: OK
A2DPD[14:19:26.375]: a2dpd_register_sdp: Start
A2DPD[14:19:26.375]: add_avrtg: 
A2DPD[14:19:26.375]: add_a2source: 
A2DPD[14:19:26.376]: a2dpd_register_sdp: OK
A2DPD[14:19:26.376]: main_loop: 
A2DPD[14:19:26.376]: make_server_socket: 
A2DPD[14:19:26.376]: a2dpd_signal_state: Started 00:1E:7C:01:0A:5E
A2DPD[14:19:26.376]: bta2dpdevicenew: 
A2DPD[14:19:26.377]: a2dpd_signal_address_changed: 00:1E:7C:01:0A:5E
A2DPD[14:19:26.377]: a2dpd_signal_set_socket: Signal socket set to 7
A2DPD[14:19:26.379]: a2dpd_signal_state: Disconnected 
A2DPD[14:19:26.379]: a2dp_alloc: 
A2DPD[14:19:26.379]: a2dp_alloc: (a2dp = 0x8d6b2e0)
A2DPD[14:19:26.379]: a2dp_new: 00:1E:7C:01:0A:5E, 44100
A2DPD[14:19:26.379]: a2dp_new: State AVDTP_STATE_DISCONNECTED
A2DPD[14:19:26.380]: alsa_new: 
A2DPD[14:19:26.380]: alsa_new: device=plughw:0,0, framerate=44100
A2DPD[14:19:26.380]: alsa_new: State ALSA_STATE_DISCONNECTED
A2DPD[14:19:26.380]: alsa_new: returning 0x8d6d478
A2DPD[14:19:26.380]: sco_new: 
A2DPD[14:19:26.380]: sco_new: State SCO_STATE_DISCONNECTED
A2DPD[14:19:26.380]: sco_state_disconnect: Filtering state : already disconnected
A2DPD[14:19:26.380]: main_loop: Bluetooth Device Settings [44100 hz, 2 channels, 16 bits]
A2DPD[14:19:26.381]: avrcp_new: Listening for AVRCP on socket 9
A2DPD[14:19:26.382]: avrcp_new: 0x8d6d588

Then I run the vlc player and I hear nothing in my headset (I think the binding isn't done with my computer and my headset).

My vlcrc file :
$ cat ~/.vlc/vlcrc | grep alsa
[alsa] # ALSA audio output
#alsadev=default
alsadev=a2dpd

My ~/.asoundrc file :
$ cat ~/.asoundrc
pcm.a2dpd {
	type a2dpd
}

My ~/.a2dprc file :
$ cat ~/.a2dprc | grep address
# This is now deprecated and should not be used, moreover, if the address is changed using dbus
# Your bluetooth headset address
#address=00:08:F4:30:07:64
address=00:1E:7C:01:0A:5E

I don't understand why my headset doesn't work... What can I do?

On Mon, 13 Jun 2011 15:57:41 +0900
Takeshi Hamasaki <takeshi.ken.hamasaki@gmail.com> wrote:

> 
> Hi,
> 
> 2011/6/13 YuGiOhJCJ Mailing-List <yugiohjcj-mailinglist@laposte.net>:
> > Ok, so you think this is probably because I use the last version of bluez that I get this compile error.
> 
> No. Not only libbluetooth-dev but build tools were also old
> at that libbluetooth.so.2* time.
> For successful build of plugz, find line:
> 
> ECHO="echo"
> 
> in libtool and add next line under or above that:
> 
> echo="echo"
> 
> I found this solution during googling with keywords "$echo libtool" .
> I saw that make command finished with success status but did not installed them.
> If you find some progress beyond that, please let us know.
> 
> Cheers!
> 
> Oh, I should add this:
> I don't have libbluetooth.so.2* installed.
> I also use bluez 4.94, and my distro is Debian squeeze/wheezy.
> -- 
> Takeshi Hamasaki
> 

