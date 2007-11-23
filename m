Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Johannes Kapune <listen@kapune.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Fri, 23 Nov 2007 19:51:57 +0100
Message-Id: <1195843917.16086.8.camel@johannes-02.kapune.lokal>
Mime-Version: 1.0
Subject: [Bluez-devel] permission denied when start a2dpd
Reply-To: listen@kapune.de,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hello,
when I start on comandline a2dpd I get this output with errors.
I think there is a problem with rights. What can I do to examine?

I use opensuse 10.3
The headset is paired under opensuse. I have to pair it one time under
a2dpd? I read something like that.


Johannes


A2DPD[18:40:31.072]: init_ipc: Selected IPC: unix, addr=127.0.0.1,
bcst=127.0.0.
255, port=21453
A2DPD[18:40:31.072]: main: a2dpd [Nov 17 2007 10:50:42] starting ...
A2DPD[18:40:31.072]: main: (errno=13:Permission denied)a2dpd
addr=00:0A:94:A0:59
:3B timer=0 us [Nov 17 2007 10:50:42]
A2DPD[18:40:31.072]: a2dpd_signal_init: Getting on DBUS
A2DPD[18:40:31.074]: a2dpd_signal_init: Installing watch
A2DPD[18:40:31.075]: add_dbus_watch: Added watch 0 0x80a6780 disabled
A2DPD[18:40:31.075]: add_dbus_watch: Added watch 1 0x80a67a8 enabled
A2DPD[18:40:31.075]: a2dpd_signal_init: Registering object
path: /com/access/a2d
pd
A2DPD[18:40:31.075]: a2dpd_signal_init: Acquiring service:
com.access.a2dpd
A2DPD[18:40:31.076]: a2dpd_signal_init: OK
A2DPD[18:40:31.076]: a2dpd_signal_init: OK
A2DPD[18:40:31.096]: a2dpd_register_sdp: Start
A2DPD[18:40:31.096]: add_avrtg:
A2DPD[18:40:31.097]: add_a2source:
A2DPD[18:40:31.101]: a2dpd_register_sdp: OK
A2DPD[18:40:31.101]: main_loop:
A2DPD[18:40:31.101]: make_server_socket:
A2DPD[18:40:31.102]: a2dp_make_listen_socket: (errno=13:Permission
denied)Cannot
 bind socket 6 for psm 25
A2DPD[18:40:31.102]: main_loop: *** Cannot get AVDTP socket, incoming
AVDTP conn
ections are impossible ***
A2DPD[18:40:31.102]: a2dpd_signal_state: Started 00:0A:94:A0:59:3B
A2DPD[18:40:31.102]: bta2dpdevicenew:
A2DPD[18:40:31.102]: a2dpd_signal_address_changed: 00:0A:94:A0:59:3B
A2DPD[18:40:31.103]: a2dpd_signal_set_socket: Signal socket set to 6
A2DPD[18:40:31.103]: a2dpd_signal_state: Disconnected
A2DPD[18:40:31.104]: a2dp_alloc:
A2DPD[18:40:31.104]: a2dp_alloc: (a2dp = 0x80aa120)
A2DPD[18:40:31.104]: a2dp_new: 00:0A:94:A0:59:3B, 44100
A2DPD[18:40:31.104]: a2dp_new: State AVDTP_STATE_DISCONNECTED
A2DPD[18:40:31.104]: alsa_new:
A2DPD[18:40:31.104]: alsa_new: device=plughw:0,0, framerate=44100
A2DPD[18:40:31.104]: alsa_new: State ALSA_STATE_DISCONNECTED
A2DPD[18:40:31.104]: alsa_new: returning 0x80ac2b8
A2DPD[18:40:31.105]: sco_new:
A2DPD[18:40:31.105]: sco_new: State SCO_STATE_DISCONNECTED
A2DPD[18:40:31.105]: sco_state_disconnect: Filtering state : already
disconnecte                                              d
A2DPD[18:40:31.105]: main_loop: Bluetooth Device Settings [44100 hz, 2
channels,                                               16 bits]
A2DPD[18:40:31.106]: a2dp_make_listen_socket: (errno=13:Permission
denied)Cannot                                               bind socket
8 for psm 23
A2DPD[18:40:31.106]: avrcp_new: Listening for AVRCP on socket -1
A2DPD[18:40:31.106]: avrcp_new: 0x80ac3c8



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
