Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <462DD3B5.8060702@access-company.com>
Date: Tue, 24 Apr 2007 11:53:57 +0200
From: Frederic Dalleau <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <6849c8890704200342k23f7e54ckaf0920197c4e5e1a@mail.gmail.com>
	<6849c8890704240209q46c5ec3ai47241251f7142ebf@mail.gmail.com>
In-Reply-To: <6849c8890704240209q46c5ec3ai47241251f7142ebf@mail.gmail.com>
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
thank you for the softvol trick.
It looks like you already have a2dpd running.
maybe killall a2dpd before could help


TJ wrote:
> Hi (Third attempt to reach the list),
>
> While I have got headsetd working fine, but I can't get a2dpd to run.
> It gives the following messages:
>
> A2DPD[17:06:13.085]: init_ipc: Selected IPC: unix, addr=127.0.0.1,
> bcst=127.0.0.255, port=21453
> A2DPD[17:06:13.085]: make_daemon_process: a2dpd [Apr 17 2007 09:46:05]
> starting ...
> A2DPD[17:06:13.085]: main: (errno=9:Bad file descriptor)a2dpd
> addr=00:13:17:C5:39:94 timer=4000 us [Apr 17 2007 09:46:12]
> A2DPD[17:06:13.085]: a2dpd_signal_init: Getting on DBUS
> A2DPD[17:06:13.086]: a2dpd_signal_init: Installing watch
> A2DPD[17:06:13.086]: add_dbus_watch: Added watch 0 0x809b960 disabled
> A2DPD[17:06:13.086]: add_dbus_watch: Added watch 1 0x809b988 enabled
> A2DPD[17:06:13.086]: a2dpd_signal_init: Registering object
> path: /com/access/a2dpd
> A2DPD[17:06:13.086]: a2dpd_signal_init: Acquiring service: com.access.a2dpd
> A2DPD[17:06:13.087]: a2dpd_signal_init: OK
> A2DPD[17:06:13.087]: a2dpd_signal_init: OK
> A2DPD[17:06:13.087]: a2dpd_register_sdp: OK
> A2DPD[17:06:13.087]: add_avrtg:
> A2DPD[17:06:13.088]: add_a2source:
> A2DPD[17:06:13.088]: main_loop:
> A2DPD[17:06:13.088]: make_server_socket:
> A2DPD[17:06:13.088]: a2dp_make_listen_socket: (errno=13:Permission
> denied)Cannot bind socket 6 for psm 25
> A2DPD[17:06:13.088]: main_loop: Cannot get AVDTP socket
> A2DPD[17:06:14.091]: main_loop:
> A2DPD[17:06:14.091]: make_server_socket:
> A2DPD[17:06:14.091]: main_loop: (errno=98:Address already in use)Cannot get
> UNIX socket
> A2DPD[17:06:15.095]: main_loop:
> A2DPD[17:06:15.095]: make_server_socket:
> A2DPD[17:06:15.095]: main_loop: (errno=98:Address already in use)Cannot get
> UNIX socket
> A2DPD[17:06:16.099]: main_loop:
> A2DPD[17:06:16.099]: make_server_socket:
> A2DPD[17:06:16.099]: main_loop: (errno=98:Address already in use)Cannot get
> UNIX socket
>
> This is from CVS on 2007-04-17, I did an update today (2007-04-19) but there
> doesn't seem to be any changes.
>
> Using libsbc 0.0cvs20070327-1 (Debian testing package)
>
> This is on Debian testing with bluez-utils 3.7-1, linux kernel 2.6.20.
>
> I should say that I installed plugz into my home directory and I run all the
> daemons as my user not root. I have PATH, LD_*, etc setup and I created
> symlinks in /usr/lib/alsa-lib to the files in the alsa-lib under my home
> dir, since I didn't know how else to tell ALSA where to look.
>
>
> On a more positive note here is an asoundrc to give you a headset volume
> control in the alsa mixer:
>
> pcm.!default {
>         type softvol
>         slave {
>                 pcm "headset"
>         }
>
>         control {
>                 name "Bluetooth Headset"
>                 card 0
>                 count 1
>         }
> }
>
> Add this to the asoundrc shipped with plugz, you don't have to call
> it !default. You can now use any alsa mixer app to control volume (and so
> create key bindings). Obviously this means you can disable soft mixer in
> xmms and tell it to use "Bluetooth Headset".
>
> Make sure that the control name (here "Bluetooth Headset") doesn't already
> exist in your mixer as a real (hw) control.
>
> Thanks for any help.
>
> Thorben.
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
