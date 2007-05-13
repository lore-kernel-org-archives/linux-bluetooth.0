Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5b9417770705130105n9f840b1h8defa90189896e4f@mail.gmail.com>
Date: Sun, 13 May 2007 03:05:27 -0500
From: "John H." <mistamaila@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <7.0.1.0.2.20070513113019.03ac1868@dubai.oilfield.slb.com>
MIME-Version: 1.0
References: <5b9417770705130014nbe2f703xd78e93ae9ce9e178@mail.gmail.com>
	<7.0.1.0.2.20070513113019.03ac1868@dubai.oilfield.slb.com>
Subject: Re: [Bluez-devel] problems with motorola h700 and a2dp
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

So I don't need a2dpd running?

Skype lists
hdaintel
phoneline
a2dpd

How do I get plugz listed?

On 5/13/07, John Frankish <frankish@dubai.oilfield.slb.com> wrote:
> Skype should use plugz (two way communication) and not a2dpd (one way
> communication), no?
>
> BTW, I can make Skype work with btsco but the connection is refused with plugz.
>
> Regards
> John
>
> At 11:14 13-05-07, you wrote:
> >Got it working fine with XP and skype.
> >
> >I have bluetooth stuff working in Linux, such as with my smartphone.
> >Also, gnome paired the h700 and this machine.
> >
> >Skype lets me choose a2dpd for input and output.  I am using this site
> >to get things working...
> >http://bluetooth-alsa.sourceforge.net/build.html
> >
> >However, a2dpd says this for user....
> >a2dpd
> >A2DPD[02:13:15.264]: init_ipc: Selected IPC: unix, addr=127.0.0.1,
> >bcst=127.0.0.255, port=21453
> >A2DPD[02:13:15.264]: make_daemon_process: a2dpd [May 12 2007 23:06:44]
> >starting ...
> >A2DPD[02:13:15.264]: main: (errno=13:Permission denied)a2dpd
> >addr=00:16:8F:F9:97:BB timer=999 us [May 12 2007 23:06:51]
> >A2DPD[02:13:15.264]: a2dpd_signal_init: Getting on DBUS
> >A2DPD[02:13:15.266]: a2dpd_signal_init: Installing watch
> >A2DPD[02:13:15.266]: add_dbus_watch: Added watch 0 0x9543948 disabled
> >A2DPD[02:13:15.266]: add_dbus_watch: Added watch 1 0x9543970 enabled
> >A2DPD[02:13:15.266]: a2dpd_signal_init: Registering object path:
> >/com/access/a2dpd
> >A2DPD[02:13:15.266]: a2dpd_signal_init: Acquiring service: com.access.a2dpd
> >A2DPD[02:13:15.267]: a2dpd_signal_init: OK
> >A2DPD[02:13:15.267]: a2dpd_signal_init: OK
> >A2DPD[02:13:15.267]: a2dpd_register_sdp: Start
> >A2DPD[02:13:15.267]: add_avrtg:
> >A2DPD[02:13:15.268]: add_a2source:
> >A2DPD[02:13:15.268]: a2dpd_register_sdp: OK
> >A2DPD[02:13:15.268]: main_loop:
> >A2DPD[02:13:15.268]: make_server_socket:
> >A2DPD[02:13:15.268]: a2dp_make_listen_socket: (errno=13:Permission
> >denied)Cannot bind socket 6 for psm 25
> >A2DPD[02:13:15.268]: main_loop: Cannot get AVDTP socket
> >A2DPD[02:13:16.269]: main_loop:
> >A2DPD[02:13:16.269]: make_server_socket:
> >A2DPD[02:13:16.269]: main_loop: (errno=98:Address already in
> >use)Cannot get UNIX socket
> >A2DPD[02:13:17.271]: main_loop:
> >A2DPD[02:13:17.271]: make_server_socket:
> >A2DPD[02:13:17.271]: main_loop: (errno=98:Address already in
> >use)Cannot get UNIX socket
> >A2DPD[02:13:17.908]: sigint_handler: handling SIGINT
> >A2DPD[02:13:17.908]: main_loop: (errno=4:Interrupted system call)
> >A2DPD[02:13:17.908]: make_server_socket:
> >A2DPD[02:13:17.908]: main_loop: (errno=98:Address already in
> >use)Cannot get UNIX socket
> >A2DPD[02:13:18.113]: sigint_handler: handling SIGINT
> >A2DPD[02:13:18.113]: main_loop: (errno=4:Interrupted system call)
> >A2DPD[02:13:18.113]: make_server_socket:
> >A2DPD[02:13:18.113]: main_loop: (errno=98:Address already in
> >use)Cannot get UNIX socket
> >
> >
> >but for root, says this... however, xmms doesn't see a2dpd, and skype
> >says can't use it... what am i doing wrong?
> >
> >a2dpd
> >A2DPD[02:14:06.038]: init_ipc: Selected IPC: unix, addr=127.0.0.1,
> >bcst=127.0.0.255, port=21453
> >A2DPD[02:14:06.039]: make_daemon_process: a2dpd [May 12 2007 23:06:44]
> >starting ...
> >A2DPD[02:14:06.039]: main: (errno=9:Bad file descriptor)a2dpd
> >addr=00:16:8F:F9:97:BB timer=999 us [May 12 2007 23:06:51]
> >A2DPD[02:14:06.039]: a2dpd_signal_init: Getting on DBUS
> >A2DPD[02:14:06.042]: a2dpd_signal_init: Installing watch
> >A2DPD[02:14:06.042]: add_dbus_watch: Added watch 0 0x870f948 disabled
> >A2DPD[02:14:06.042]: add_dbus_watch: Added watch 1 0x870f970 enabled
> >A2DPD[02:14:06.042]: a2dpd_signal_init: Registering object path:
> >/com/access/a2dpd
> >A2DPD[02:14:06.042]: a2dpd_signal_init: Acquiring service: com.access.a2dpd
> >A2DPD[02:14:06.044]: a2dpd_signal_init: OK
> >A2DPD[02:14:06.044]: a2dpd_signal_init: OK
> >A2DPD[02:14:06.044]: a2dpd_register_sdp: Start
> >A2DPD[02:14:06.044]: add_avrtg:
> >A2DPD[02:14:06.044]: add_a2source:
> >A2DPD[02:14:06.045]: a2dpd_register_sdp: OK
> >A2DPD[02:14:06.045]: main_loop:
> >A2DPD[02:14:06.045]: make_server_socket:
> >A2DPD[02:14:06.045]: bta2dpdevicenew:
> >A2DPD[02:14:06.045]: a2dpd_signal_address_changed: 00:16:8F:F9:97:BB
> >A2DPD[02:14:06.045]: a2dpd_signal_set_socket: Signal socket set to 7
> >A2DPD[02:14:06.046]: a2dpd_signal_state: Disconnected
> >A2DPD[02:14:06.046]: a2dp_alloc:
> >A2DPD[02:14:06.046]: a2dp_alloc: (a2dp = 0x87132a0)
> >A2DPD[02:14:06.046]: a2dp_new: 00:16:8F:F9:97:BB, 8000
> >A2DPD[02:14:06.046]: a2dp_new: State AVDTP_STATE_DISCONNECTED
> >A2DPD[02:14:06.046]: alsa_new:
> >A2DPD[02:14:06.046]: alsa_new: device=plughw:0,0, framerate=8000
> >A2DPD[02:14:06.046]: alsa_new: State ALSA_STATE_DISCONNECTED
> >A2DPD[02:14:06.046]: alsa_new: returning 0x8715428
> >A2DPD[02:14:06.046]: sco_new:
> >A2DPD[02:14:06.046]: sco_new: State SCO_STATE_DISCONNECTED
> >A2DPD[02:14:06.046]: sco_state_disconnect: Filtering state : already
> >disconnected
> >A2DPD[02:14:06.046]: main_loop: Bluetooth Device Settings [8000 hz, 2
> >channels, 16 bits]
> >A2DPD[02:14:06.047]: avrcp_new: Listening for AVRCP on socket 9
> >A2DPD[02:14:06.047]: avrcp_new: 0x8715568
> >
> >-------------------------------------------------------------------------
> >This SF.net email is sponsored by DB2 Express
> >Download DB2 Express C - the FREE version of DB2 express and take
> >control of your XML. No limits. Just data. Click to get it now.
> >http://sourceforge.net/powerbar/db2/
> >_______________________________________________
> >Bluez-devel mailing list
> >Bluez-devel@lists.sourceforge.net
> >https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
