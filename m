Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <432beae0705121900q237f835ahf6d2ac63c619415@mail.gmail.com>
Date: Sat, 12 May 2007 19:00:05 -0700
From: "Justin Patrin" <papercrane@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <432beae0705121846x7b181d3fm180205dfa783e975@mail.gmail.com>
MIME-Version: 1.0
References: <432beae0705121846x7b181d3fm180205dfa783e975@mail.gmail.com>
Subject: Re: [Bluez-devel] Problems connecting to a bluetooth headset
Reply-To: papercrane@reversefold.com,
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

On 5/12/07, Justin Patrin <papercrane@gmail.com> wrote:
> I just got a Plantronics Pulsar 260 headset which supports A2DP,
> AVRCP, and the headset protocols. I've successfully used it for a2dp
> on Mac OS X 10.4 with some hacks[1]. I have also paired it with
> various cell phones and tested the headset functionality. However, I
> cann't get it to pair or work at all with Linux. I have tested only
> with a Linksys USBBT100 USB adapter so far. I will be getting 2 belkin
> adapters soon as well that I will try with.
>
> I have tried everything I can think of and searched high and low on
> the internet but have found no help. Here's various info which may
> help:
>
> # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:0C:41:E2:18:BC ACL MTU: 192:8 SCO MTU: 64:8
>         UP RUNNING PSCAN
>         RX bytes:1701 acl:0 sco:0 events:56 errors:0
>         TX bytes:458 acl:0 sco:0 commands:34 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering, Capturing, Object
> Transfer, Audio
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)
> # hcitool scan
> Scanning ...
>         00:03:89:C4:04:6F       260Plantronics

# hcitool info 00:03:89:C4:04:6F
Requesting information ...
        BD Address:  00:03:89:C4:04:6F
        Device Name: 260Plantronics
        LMP Version: 2.0 (0x3) LMP Subversion: 0xb12
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO> <broadcast encrypt>
                <enhanced iscan> <interlaced iscan> <interlaced pscan>
                <inquiry with RSSI> <AFH cap. slave> <AFH class. slave>
                <AFH cap. master> <AFH class. master> <extended features>

> # hcitool cc 00:03:89:C4:04:6F
> # hcitool conn
> Connections:
>         < ACL 00:03:89:C4:04:6F handle 42 state 1 lm MASTER
> # hcitool conn
> Connections:
> #
>
> Yes, no output with hcitool cc. hcitool conn shows a connection right
> after the cc but not right after that. I have tried setting the pin in
> /etc/hcid.conf and tried setting the pin_helper to a shell script
> which just outputs PIN:0000 (the pin for the headset). The output of
> hcitool cc doesn't change whether the headset is in discovery mode or
> not. If the headset isn't on hcitool "hangs" and then gives an I/O
> error, as I'd expect.
>
> Running a2dpd, with the instructions on the site[2] as a user gives me
> binding errors and doesn't respond to Ctrl-C (I have to kill -9 the
> process).
> # a2dpd
> A2DPD[18:44:14.787]: init_ipc: Selected IPC: unix, addr=127.0.0.1,
> bcst=127.0.0.255, port=21453
> A2DPD[18:44:14.787]: make_daemon_process: a2dpd [May 12 2007 13:56:48]
> starting ...
> A2DPD[18:44:14.787]: main: (errno=13:Permission denied)a2dpd
> addr=00:03:89:C4:04:6F timer=4000 us [May 12 2007 13:56:53]
> A2DPD[18:44:14.787]: a2dpd_signal_init: Getting on DBUS
> A2DPD[18:44:14.788]: a2dpd_signal_init: Installing watch
> A2DPD[18:44:14.788]: add_dbus_watch: Added watch 0 0x80a17c0 disabled
> A2DPD[18:44:14.789]: add_dbus_watch: Added watch 1 0x80a17e8 enabled
> A2DPD[18:44:14.789]: a2dpd_signal_init: Registering object path:
> /com/access/a2dpd
> A2DPD[18:44:14.789]: a2dpd_signal_init: Acquiring service: com.access.a2dpd
> A2DPD[18:44:14.789]: a2dpd_signal_init: OK
> A2DPD[18:44:14.789]: a2dpd_signal_init: OK
> A2DPD[18:44:14.789]: a2dpd_register_sdp: Start
> A2DPD[18:44:14.789]: add_avrtg:
> A2DPD[18:44:14.790]: add_a2source:
> A2DPD[18:44:14.790]: a2dpd_register_sdp: OK
> A2DPD[18:44:14.790]: main_loop:
> A2DPD[18:44:14.790]: make_server_socket:
> A2DPD[18:44:14.790]: a2dp_make_listen_socket: (errno=13:Permission
> denied)Cannot bind socket 6 for psm 25
> A2DPD[18:44:14.790]: main_loop: Cannot get AVDTP socket
> A2DPD[18:44:15.798]: main_loop:
> A2DPD[18:44:15.798]: make_server_socket:
> A2DPD[18:44:15.798]: main_loop: (errno=98:Address already in
> use)Cannot get UNIX socket
> A2DPD[18:44:16.806]: main_loop:
> A2DPD[18:44:16.806]: make_server_socket:
> A2DPD[18:44:16.806]: main_loop: (errno=98:Address already in
> use)Cannot get UNIX socket
>
> Running a2dpd as root (with the config files copied) shows everything
> disconnecting:
> # a2dpd
> A2DPD[18:45:01.307]: init_ipc: Selected IPC: unix, addr=127.0.0.1,
> bcst=127.0.0.255, port=21453
> A2DPD[18:45:01.307]: make_daemon_process: a2dpd [May 12 2007 13:56:48]
> starting ...
> A2DPD[18:45:01.308]: main: (errno=9:Bad file descriptor)a2dpd
> addr=00:03:89:C4:04:6F timer=4000 us [May 12 2007 13:56:53]
> A2DPD[18:45:01.308]: a2dpd_signal_init: Getting on DBUS
> A2DPD[18:45:01.309]: a2dpd_signal_init: Installing watch
> A2DPD[18:45:01.309]: add_dbus_watch: Added watch 0 0x80a17c0 disabled
> A2DPD[18:45:01.309]: add_dbus_watch: Added watch 1 0x80a17e8 enabled
> A2DPD[18:45:01.309]: a2dpd_signal_init: Registering object path:
> /com/access/a2dpd
> A2DPD[18:45:01.309]: a2dpd_signal_init: Acquiring service: com.access.a2dpd
> A2DPD[18:45:01.310]: a2dpd_signal_init: OK
> A2DPD[18:45:01.310]: a2dpd_signal_init: OK
> A2DPD[18:45:01.310]: a2dpd_register_sdp: Start
> A2DPD[18:45:01.310]: add_avrtg:
> A2DPD[18:45:01.310]: add_a2source:
> A2DPD[18:45:01.310]: a2dpd_register_sdp: OK
> A2DPD[18:45:01.311]: main_loop:
> A2DPD[18:45:01.311]: make_server_socket:
> A2DPD[18:45:01.311]: bta2dpdevicenew:
> A2DPD[18:45:01.311]: a2dpd_signal_address_changed: 00:03:89:C4:04:6F
> A2DPD[18:45:01.311]: a2dpd_signal_set_socket: Signal socket set to 7
> A2DPD[18:45:01.312]: a2dpd_signal_state: Disconnected
> A2DPD[18:45:01.312]: a2dp_alloc:
> A2DPD[18:45:01.312]: a2dp_alloc: (a2dp = 0x80a5158)
> A2DPD[18:45:01.312]: a2dp_new: 00:03:89:C4:04:6F, 44100
> A2DPD[18:45:01.312]: a2dp_new: State AVDTP_STATE_DISCONNECTED
> A2DPD[18:45:01.312]: alsa_new:
> A2DPD[18:45:01.312]: alsa_new: device=plughw:0,0, framerate=44100
> A2DPD[18:45:01.312]: alsa_new: State ALSA_STATE_DISCONNECTED
> A2DPD[18:45:01.312]: alsa_new: returning 0x80a72e0
> A2DPD[18:45:01.312]: sco_new:
> A2DPD[18:45:01.313]: sco_new: State SCO_STATE_DISCONNECTED
> A2DPD[18:45:01.313]: sco_state_disconnect: Filtering state : already
> disconnected
> A2DPD[18:45:01.313]: main_loop: Bluetooth Device Settings [44100 hz, 2
> channels, 16 bits]
> A2DPD[18:45:01.313]: avrcp_new: Listening for AVRCP on socket 9
> A2DPD[18:45:01.313]: avrcp_new: 0x80a73f0
>
> The same things happen whether I run these on my Gentoo Athlon system
> or my Sharp Zaurus (arm). Both have bluez-utils/libs-3.9 and sbc and
> plugz from cvs.
>
>
> [1] http://david.connolly.name/blog/hub/mac/2007/02/23/Stereo-Bluetooth-Profile-A2DP-on-Mac-OS-X-Tiger.html
> [2] http://bluetooth-alsa.sourceforge.net/build.html
>
> --
> Justin Patrin
>


-- 
Justin Patrin

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
