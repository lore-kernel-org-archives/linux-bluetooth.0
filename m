Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110614141739.d8cbdc50.yugiohjcj-mailinglist@laposte.net>
References: <20110614141739.d8cbdc50.yugiohjcj-mailinglist@laposte.net>
Date: Tue, 14 Jun 2011 16:07:43 +0300
Message-ID: <BANLkTimNPmcF3N454wR1MCdQ00skisihPQ@mail.gmail.com>
Subject: Re: bluetooth headset Philips SHB9000
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: YuGiOhJCJ Mailing-List <yugiohjcj-mailinglist@laposte.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jun 14, 2011 at 3:17 PM, YuGiOhJCJ Mailing-List
<yugiohjcj-mailinglist@laposte.net> wrote:
>
> Hello,
>
> It's me again, I try new ways to use my bluetooth headset Philips SHB9000 on Linux but it failed.
>
> My bluetooth headset is Philips SHB9000 :
> $ hcitool scan
> Scanning ...
>        00:1E:7C:01:0A:5E       Philips SHB9000
>
> I use bluez 4.94. I found 4 tools (hcitool, rfcomm, a2dpd and sdptool) to use my bluetooth headset but each tool failed.
>
> When I try to bind with hcitool my computer with my headset, it failed :
> $ hcitool dev
> Devices:
>        hci0    00:22:43:B7:BB:F0
> $ sudo hcitool cc 00:1E:7C:01:0A:5E
> $ hcitool con
> Connections:
> As you can see, there is no connections...
>
> When I try to bind with rfcomm my computer with my headset, it failed :
> $ rfcomm
> rfcomm0: 00:1E:7C:01:0A:5E channel 0 clean
> $ sudo rfcomm release hci0
> $ rfcomm
> $ sudo rfcomm -A -E bind 00:22:43:B7:BB:F0 00:1E:7C:01:0A:5E
> $ rfcomm
> rfcomm0: 00:1E:7C:01:0A:5E channel 1 clean
> $ sudo rfcomm -A -E connect 00:22:43:B7:BB:F0 00:1E:7C:01:0A:5E
> Can't connect RFCOMM socket: Operation now in progress
>
> When I try to bind with a2dpd my computer with my headset, it failed :
> $ sudo a2dpd
> A2DPD[14:19:26.370]: init_ipc: Selected IPC: unix, addr=127.0.0.1, bcst=127.0.0.255, port=21453
> A2DPD[14:19:26.370]: main: a2dpd [Jun 13 2011 13:46:06] starting ...
> A2DPD[14:19:26.371]: main: (errno=9:Bad file descriptor)a2dpd addr=00:1E:7C:01:0A:5E timer=0 us [Jun 13 2011 13:46:06]
> A2DPD[14:19:26.371]: a2dpd_signal_init: Getting on DBUS
> A2DPD[14:19:26.373]: a2dpd_signal_init: Installing watch
> A2DPD[14:19:26.373]: add_dbus_watch: Added watch 0 0x8d67858 disabled
> A2DPD[14:19:26.373]: add_dbus_watch: Added watch 1 0x8d67880 enabled
> A2DPD[14:19:26.373]: a2dpd_signal_init: Registering object path: /com/access/a2dpd
> A2DPD[14:19:26.374]: a2dpd_signal_init: Acquiring service: com.access.a2dpd
> A2DPD[14:19:26.375]: a2dpd_signal_init: OK
> A2DPD[14:19:26.375]: a2dpd_signal_init: OK
> A2DPD[14:19:26.375]: a2dpd_register_sdp: Start
> A2DPD[14:19:26.375]: add_avrtg:
> A2DPD[14:19:26.375]: add_a2source:
> A2DPD[14:19:26.376]: a2dpd_register_sdp: OK
> A2DPD[14:19:26.376]: main_loop:
> A2DPD[14:19:26.376]: make_server_socket:
> A2DPD[14:19:26.376]: a2dpd_signal_state: Started 00:1E:7C:01:0A:5E
> A2DPD[14:19:26.376]: bta2dpdevicenew:
> A2DPD[14:19:26.377]: a2dpd_signal_address_changed: 00:1E:7C:01:0A:5E
> A2DPD[14:19:26.377]: a2dpd_signal_set_socket: Signal socket set to 7
> A2DPD[14:19:26.379]: a2dpd_signal_state: Disconnected
> A2DPD[14:19:26.379]: a2dp_alloc:
> A2DPD[14:19:26.379]: a2dp_alloc: (a2dp = 0x8d6b2e0)
> A2DPD[14:19:26.379]: a2dp_new: 00:1E:7C:01:0A:5E, 44100
> A2DPD[14:19:26.379]: a2dp_new: State AVDTP_STATE_DISCONNECTED
> A2DPD[14:19:26.380]: alsa_new:
> A2DPD[14:19:26.380]: alsa_new: device=plughw:0,0, framerate=44100
> A2DPD[14:19:26.380]: alsa_new: State ALSA_STATE_DISCONNECTED
> A2DPD[14:19:26.380]: alsa_new: returning 0x8d6d478
> A2DPD[14:19:26.380]: sco_new:
> A2DPD[14:19:26.380]: sco_new: State SCO_STATE_DISCONNECTED
> A2DPD[14:19:26.380]: sco_state_disconnect: Filtering state : already disconnected
> A2DPD[14:19:26.380]: main_loop: Bluetooth Device Settings [44100 hz, 2 channels, 16 bits]
> A2DPD[14:19:26.381]: avrcp_new: Listening for AVRCP on socket 9
> A2DPD[14:19:26.382]: avrcp_new: 0x8d6d588
> I have no error but it doesn't work.
>
> When I try to bind with sdptool my computer with my headset, it failed :
> $ sdptool browse 00:1E:7C:01:0A:5E
> Browsing 00:1E:7C:01:0A:5E ...
> But if I give an other address, there is an error, so the headset is found :
> $ sdptool browse 00:1E:7C:01:0A:5F
> Failed to connect to SDP server on 00:1E:7C:01:0A:5F: Host is down
>
> I read documentation[1][2][3][4][5][6][7][8][9] but I can't find a way to use my headset on Linux. Can you help me with my  bluetooth headset on linux, please?
>
> Thank you.
>
> [1]http://bluetooth-alsa.sourceforge.net/build.html
> [2]http://www.linux.ie/articles/bluetoothheadset.php
> [3]http://forums.overclockers.com.au/showthread.php?t=694010
> [4]https://help.ubuntu.com/community/BluetoothAudio
> [5]http://gablog.eu/online/node/80
> [6]http://forums.debian.net/viewtopic.php?t=12497
> [7]http://penguincopter.blogspot.com/2009/07/linux-bluetooth-komorka-internet.html
> [8]http://forums.opensuse.org/english/get-technical-help-here/multimedia/446585-bluetooth-audio-alsa-phonon-kde.html
> [9]http://blog.bulix.org/index.php/blog/1008

Those are all old components to use an a2dp device with linux, a2dpd
is no longer needed nowadays you basically need bluetoothd (signaling)
and PulseAudio (streaming). There was some announcement on bluez.org
back on 2008 about this integration as you can see it here
http://www.bluez.org/bluez-and-pulseaudio/, there is also some support
to use with gstreamer and alsa (not recommended). Also note that with
recent Linux distribution this should work without much effort e.g
gnome you basically need to pair, connect and set the headset as
default output.

-- 
Luiz Augusto von Dentz
Computer Engineer
