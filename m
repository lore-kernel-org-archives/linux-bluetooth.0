Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Richard MacCormac <richhelene@onetel.com>
To: bluez-users@lists.sourceforge.net
Date: Sat, 20 Jan 2007 20:51:15 +0000
MIME-Version: 1.0
Message-Id: <200701202051.16024.richhelene@onetel.com>
Subject: [Bluez-users] a2dpd problems
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

Hi.  I have built both plugz and btsco from CVS.  a2play works fine, but I 
cannot seem to make a2dpd work as described.  Starting a2dpd (as a non-root 
user) gives me this:

>$ a2dpd

A2DPD[791.698]: make_daemon_process: (errno=13:Permission denied)a2dpd [Jan 13 
2007 13:10:39] starting ...
A2DPD[791.698]: init_uinput: (errno=2:No such file or directory)Cannot 
open /dev/input/uinput
A2DPD[791.698]: main: a2dpd addr=00:07:A4:D5:3A:E2 timer=10000 us [Jan 13 2007 
13:10:39]
A2DPD[791.698]: a2dpd_signal_init:
A2DPD[791.700]: a2dpd_signal_init: (errno=2:No such file or directory)Getting 
on DBUS
A2DPD[791.701]: a2dpd_signal_init: OK
A2DPD[791.702]: a2dpd_signal_set_socket: Signal socket set to 10
A2DPD[791.703]: a2dpd_thread_handler: Registering object 
path: /com/access/a2dpd
A2DPD[791.703]: a2dpd_thread_handler: Acquiring service: com.access.a2dpd
A2DPD[791.704]: a2dpd_thread_handler: Failed to acquire service[2]: Connection 
":1.25" is not allowed to own the service "com.access.a2dpd" due to security 
policies in the configuration file
A2DPD[791.703]: a2dpd_signal_state: Disconnected
A2DPD[791.704]: a2dp_alloc:
A2DPD[791.704]: a2dp_alloc: (a2dp = 0x808ba48)
A2DPD[791.704]: a2dp_new: 00:07:A4:D5:3A:E2, 44100
A2DPD[791.705]: a2dp_new: State AVDTP_STATE_DISCONNECTED
A2DPD[791.705]: alsa_new:
A2DPD[791.705]: alsa_new: Frame rate is 44100
A2DPD[791.708]: alsa_new: snd_pcm_open()==1
A2DPD[791.709]: alsa_new: snd_pcm_hw_params_malloc()==1
A2DPD[791.709]: alsa_new: snd_pcm_hw_params_any()==1
A2DPD[791.709]: alsa_new: snd_pcm_hw_params_set_access()==1
A2DPD[791.710]: alsa_new: snd_pcm_hw_params_set_format()==1
A2DPD[791.710]: alsa_new: snd_pcm_hw_params_set_rate()==1
A2DPD[791.710]: alsa_new: snd_pcm_hw_params_set_channels()==1
A2DPD[791.710]: alsa_new: snd_pcm_hw_params()==1
A2DPD[791.711]: alsa_new: snd_pcm_prepare()==1
A2DPD[791.711]: alsa_new: params freed
A2DPD[791.711]: alsa_new: returning 0x80837f0
A2DPD[791.711]: sco_new:
A2DPD[791.711]: sco_new: State SCO_STATE_DISCONNECTED
A2DPD[791.711]: sco_state_disconnect: Filtering state : already disconnected
A2DPD[791.711]: a2dp_handler: Bluetooth Device Settings [44100 hz, 2 channels, 
16 bits]
A2DPD[791.711]: avrcp_listener: avrcp: Accepting incoming connection



And when starting XMMS with a2dpd as the audio device, this happens:

A2DPD[946.547]: main_loop: New client 15
A2DPD[946.547]: main_loop: Got index 0
A2DPD[946.547]: poll_incoming_clients_sockets: PLAYBACK thread client_index=0, 
socket=15, id=0 started (44100 Hz, 2 channels, 16 bits)
A2DPD[946.548]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[946.548]: a2dpd_signal_state: Connecting 00:07:A4:D5:3A:E2
A2DPD[946.548]: a2dp_state_machine: Role is INITIATOR
A2DPD[946.558]: a2dp_state_machine: (errno=115:Operation now in progress)State 
AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[946.576]: a2dp_handler: Sound stream dry
A2DPD[946.630]: a2dp_handler: Sound stream dry
A2DPD[946.683]: a2dp_handler: Sound stream dry
A2DPD[946.691]: a2dp_handler: Sound stream dry
A2DPD[946.720]: a2dp_handler: Sound stream dry
A2DPD[946.770]: a2dp_handler: Sound stream dry
A2DPD[946.781]: a2dp_handler: Sound stream dry
A2DPD[946.810]: a2dp_handler: Sound stream dry
A2DPD[946.839]: a2dp_handler: Sound stream dry
A2DPD[946.871]: a2dp_handler: Sound stream dry
A2DPD[946.900]: a2dp_handler: Sound stream dry
A2DPD[946.929]: a2dp_handler: Sound stream dry
A2DPD[946.973]: a2dp_handler: Sound stream dry
A2DPD[946.993]: a2dp_handler: Sound stream dry

... etc, etc, until I either stop the XMMS playback or kill a2dpd.  The unit I 
am sending to is behaving as if it is receiving something, so I reckon the 
hardware is working OK and I have a snag in the alsa setup somewhere. 


Has anyone any suggestion?  I'd like to get a2dpd to work rather than using 
a2play all the time.

Thanks,

Richard

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
