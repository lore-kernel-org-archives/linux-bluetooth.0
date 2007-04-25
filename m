Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: TJ <tj.trevelyan@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Wed, 25 Apr 2007 14:56:56 +0100
References: <6849c8890704200342k23f7e54ckaf0920197c4e5e1a@mail.gmail.com>
	<6849c8890704240209q46c5ec3ai47241251f7142ebf@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <20070425135658.8296AF6020@mail1.norse.ukerna.ac.uk>
Subject: Re: [Bluez-users] A2DPD fails to init with a2dp_make_listen_socket:
	(errno=13:Permission denied)Cannot bind socket
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

> 
> While I have got headsetd working fine, but I can't get a2dpd to run.
> It gives the following messages:
> 
...
> 
> This is from CVS on 2007-04-17, I did an update today (2007-04-19) but
> there doesn't seem to be any changes.
> 
> Using libsbc 0.0cvs20070327-1 (Debian testing package)
> 
> This is on Debian testing with bluez-utils 3.7-1, linux kernel 2.6.20.
> 
> I should say that I installed plugz into my home directory and I run all
> the daemons as my user not root. I have PATH, LD_*, etc setup and I
> created symlinks in /usr/lib/alsa-lib to the files in the alsa-lib under
> my home dir, since I didn't know how else to tell ALSA where to look.
> 

It appears to run OK as root (from my homedir):
~$ sudo Linux/bin/a2dpd --nofork --file .a2dprc

A2DPD[14:50:01.264]: main: Config file .a2dprc
A2DPD[14:50:01.265]: init_ipc: Selected IPC: unix, addr=127.0.0.1,
bcst=127.0.0.255, port=21453
A2DPD[14:50:01.265]: make_daemon_process: a2dpd [Apr 17 2007 09:46:05]
starting ...
A2DPD[14:50:01.265]: main: (errno=9:Bad file descriptor)Linux/bin/a2dpd
addr=00:13:17:C5:39:94 timer=4000 us [Apr 17 2007 09:46:12]
A2DPD[14:50:01.265]: a2dpd_signal_init: Getting on DBUS
A2DPD[14:50:01.266]: a2dpd_signal_init: Installing watch
A2DPD[14:50:01.266]: add_dbus_watch: Added watch 0 0x809b8e0 disabled
A2DPD[14:50:01.267]: add_dbus_watch: Added watch 1 0x809b908 enabled
A2DPD[14:50:01.267]: a2dpd_signal_init: Registering object
path: /com/access/a2dpd
A2DPD[14:50:01.267]: a2dpd_signal_init: Acquiring service: com.access.a2dpd
A2DPD[14:50:01.267]: a2dpd_signal_init: OK
A2DPD[14:50:01.267]: a2dpd_signal_init: OK
A2DPD[14:50:01.267]: a2dpd_register_sdp: OK
A2DPD[14:50:01.267]: add_avrtg:
A2DPD[14:50:01.268]: add_a2source:
A2DPD[14:50:01.268]: main_loop:
A2DPD[14:50:01.268]: make_server_socket:
A2DPD[14:50:01.268]: bta2dpdevicenew:
A2DPD[14:50:01.268]: a2dpd_signal_address_changed: 00:13:17:C5:39:94
A2DPD[14:50:01.268]: a2dpd_signal_set_socket: Signal socket set to 7
A2DPD[14:50:01.269]: a2dpd_signal_state: Disconnected
A2DPD[14:50:01.269]: a2dp_alloc:
A2DPD[14:50:01.269]: a2dp_alloc: (a2dp = 0x80a92c0)
A2DPD[14:50:01.269]: a2dp_new: 00:13:17:C5:39:94, 44100
A2DPD[14:50:01.269]: a2dp_new: State AVDTP_STATE_DISCONNECTED
A2DPD[14:50:01.269]: alsa_new:
A2DPD[14:50:01.269]: alsa_new: device=plughw:0,0, framerate=44100
A2DPD[14:50:01.269]: alsa_new: State ALSA_STATE_DISCONNECTED
A2DPD[14:50:01.269]: alsa_new: returning 0x80ab448
A2DPD[14:50:01.269]: sco_new:
A2DPD[14:50:01.269]: sco_new: State SCO_STATE_DISCONNECTED
A2DPD[14:50:01.269]: sco_state_disconnect: Filtering state : already
disconnected
A2DPD[14:50:01.269]: main_loop: Bluetooth Device Settings [44100 hz, 2
channels, 16 bits]
A2DPD[14:50:01.270]: avrcp_new: Listening for AVRCP on socket 9
A2DPD[14:50:01.270]: avrcp_new: 0x80ab558

Surely it must be possible to run as a normal users? don't the docs say
_not_ to run a2pdp as root. While running as root I can play anything from
my user, only if the playing app is running as root, which is not at all
ideal.

I would assume this is a permissions issue. Obviously my user can write
to /tmp, and headsetd runs fine as my user to bluetooth/alsa comms must be
ok?

So what is causing this?

Thorben



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
