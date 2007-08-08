Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Hugues Lafarge <Hugues.Lafarge@afp.com>
Date: Wed, 08 Aug 2007 14:32:25 +0200
Message-ID: <874pjamckm.fsf@merlot.par.afp.com>
MIME-Version: 1.0
Subject: [Bluez-devel] trying to get my Plantronics M2500 headset working
	with a2dpd (second try)
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


Hi everyone,

Please forgive me if this is not the right place for this kind of
request for help, but i've sent this same message to the bluez-users
mailing list two weeks ago and got no reply, so that's why i'm
retrying on bluez-devel this time.

I'm new to both lists, so please bear with me if i'm not exposing my problem
the right way, and let me know how to improve myself ;-)

I've recently got my hands on a Plantronics M2500 headset and i'm trying to
make it work on my laptop (HP Compaq nc8230).

* I'm running debian unstable with a stock 2.6.22 kernel:

$ uname -a
Linux phugues 2.6.22-1-686 #1 SMP Mon Jul 23 13:23:02 UTC 2007 i686 GNU/Linux

* I'm using sbc & plugz from CVS.

* My /etc/asound.conf file contains the following:

pcm.headset {
	@args [BDADDR TIMEOUT]
	
	# The Bluetooth device address for target headset, used for Audio Gateway (PC) initiated connections
        # Please note that this value is ignored when the connection is Headset initiated
	@args.BDADDR {
		type string
		default "00:03:89:64:73:40"
	}

	# This value represents how long we will try to reach the headset, until we give up.
	# Value is in milliseconds
	@args.TIMEOUT {
		type integer
		default 6000
	}

	type        sco
	bdaddr      $BDADDR
	timeout     $TIMEOUT
}

ctl.headset {
	type sco
}

# Simplest a2dpd possible
pcm.a2dpdsimple {
	type a2dpd
}

# More complex a2dpd, not yet recommended but worth a try!
# This entry allows the plugin to appear in mixer applications
# This way, the sound level can be controlled by software outside the player
# This worked very well last time! 2007-jun

pcm.a2dpd {
	type plug
	slave.pcm "a2dpdsoftvol"
}

pcm.a2dpdsoftvol {
	type softvol
	slave {
		pcm "a2dpdplug"
	}

	control {
		name "Bluetooth Headset"
		card 0
		count 1
	}
}

pcm.a2dpdplug {
	type a2dpd
}

* I've started a2dpd using the following command:

$ sudo a2dpd --verbose --debug

A2DPD[11:19:22.563]: init_ipc: Selected IPC: unix, addr=127.0.0.1, bcst=127.0.0.255, port=21453
A2DPD[11:19:22.563]: main: a2dpd [Jul 27 2007 11:16:41] starting ...
A2DPD[11:19:22.563]: main: (errno=9:Bad file descriptor)a2dpd addr=00:03:89:64:73:40 timer=0 us [Jul 27 2007 11:16:41]
A2DPD[11:19:22.564]: a2dpd_signal_init: Getting on DBUS
A2DPD[11:19:22.568]: a2dpd_signal_init: Installing watch
A2DPD[11:19:22.568]: add_dbus_watch: Added watch 0 0x80b5830 disabled
A2DPD[11:19:22.568]: add_dbus_watch: Added watch 1 0x80b5858 enabled
A2DPD[11:19:22.568]: a2dpd_signal_init: Registering object path: /com/access/a2dpd
A2DPD[11:19:22.568]: a2dpd_signal_init: Acquiring service: com.access.a2dpd
A2DPD[11:19:22.570]: a2dpd_signal_init: OK
A2DPD[11:19:22.570]: a2dpd_signal_init: OK
A2DPD[11:19:22.570]: a2dpd_register_sdp: Start
A2DPD[11:19:22.570]: add_avrtg:
A2DPD[11:19:22.570]: add_a2source:
A2DPD[11:19:22.570]: a2dpd_register_sdp: OK
A2DPD[11:19:22.570]: main_loop:
A2DPD[11:19:22.571]: make_server_socket:
A2DPD[11:19:22.571]: a2dpd_signal_state: Started 00:03:89:64:73:40
A2DPD[11:19:22.571]: bta2dpdevicenew:
A2DPD[11:19:22.571]: a2dpd_signal_address_changed: 00:03:89:64:73:40
A2DPD[11:19:22.571]: a2dpd_signal_set_socket: Signal socket set to 7
A2DPD[11:19:22.572]: a2dpd_signal_state: Disconnected
A2DPD[11:19:22.572]: a2dp_alloc:
A2DPD[11:19:22.572]: a2dp_alloc: (a2dp = 0x80b91f0)
A2DPD[11:19:22.573]: a2dp_new: 00:03:89:64:73:40, 44100
A2DPD[11:19:22.573]: a2dp_new: State AVDTP_STATE_DISCONNECTED
A2DPD[11:19:22.573]: alsa_new:
A2DPD[11:19:22.573]: alsa_new: device=plughw:0,0, framerate=44100
A2DPD[11:19:22.573]: alsa_new: State ALSA_STATE_DISCONNECTED
A2DPD[11:19:22.573]: alsa_new: returning 0x80bb388
A2DPD[11:19:22.573]: sco_new:
A2DPD[11:19:22.573]: sco_new: State SCO_STATE_DISCONNECTED
A2DPD[11:19:22.573]: sco_state_disconnect: Filtering state : already disconnected
A2DPD[11:19:22.573]: main_loop: Bluetooth Device Settings [44100 hz, 2 channels, 16 bits]
A2DPD[11:19:22.574]: avrcp_new: Listening for AVRCP on socket 9
A2DPD[11:19:22.574]: avrcp_new: 0x80bb498

* i've also started headsetd with:

$ sudo  headsetd -n
headsetd[20822]: Bluetooth headset daemon version 0.5

* then when i'm trying to send a WAV file to my headset with:

phugues$ aplay -D headset /usr/share/wengophone/sounds/ringin.wav

i get the following answer:

Playing WAVE '/usr/share/wengophone/sounds/ringin.wav' : Signed 16 bit Little Endian, Rate 11025 Hz, Mono
Warning: rate is not accurate (requested = 11025Hz, got = 8000Hz)
         please, try the plug plugin (-Dplug:headset)
ALSA lib pcm_sco.c:277:(sco_headset_hw_params) Unable to set number of SCO buffers : please upgrade your Kernel !
aplay: set_params:961: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 3000
PERIOD_SIZE: 24
PERIOD_BYTES: 48
PERIODS: 167
BUFFER_TIME: 501000
BUFFER_SIZE: 4008
BUFFER_BYTES: 8016
TICK_TIME: [0 0]

i also get the following traces from headsetd 

headsetd[20822]: Configuration phase ended: target bdaddr is 00:03:89:64:73:40, timeout is 6000 ms
headsetd[20822]: Changing state: Idle-->Paging
headsetd[20822]: Changing state: Paging-->Connecting
headsetd[20822]: Changing state: Connecting-->Ready
headsetd[20822]: Changing state: Ready-->Opening
headsetd[20822]: SCO channel opened handle=0x0001 mtu=16
headsetd[20822]: Changing state: Opening-->Streaming
headsetd[20822]: Appli closed socket
headsetd[20822]: Changing state: Streaming-->Zombie
headsetd[20822]: Nobody uses SCO channel anymore, closing it.
headsetd[20822]: Changing state: Zombie-->Connected

My questions are the following:

- is there something i'm doing the wrong way ?

- if not, what does the "please upgrade your Kernel !" message really mean ?

I doubt that my kernel my be not current enough, but maybe i should compile/install some
additional module in it ?!

I thought that a2dpd did not need any kernel module added contrary to the btsco, but
perhaps i was wrong ?

Any help or advice would be greatly welcome.

Thanks in advance.

-- 
Hugues Lafarge                    || Email: Hugues.Lafarge@afp.com
Agence France Presse              || Phone: +33 1 40 41 77 15
4 rue de la bourse, 75002 Paris   ||   Fax: +33 1 40 41 79 24



This e-mail, and any file transmitted with it, is confidential and  intended solely for the use of the individual or entity to whom it is addressed. If you have received this email in error, please  contact the sender and delete the email from your system. If you are  not the named addressee you should not disseminate, distribute or copy  this email.

For more information on Agence France-Presse, please visit our web site at http://www.afp.com


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
