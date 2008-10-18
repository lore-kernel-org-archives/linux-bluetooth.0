Return-Path: <cyrus@holtmann.org>
Message-ID: <48FA49A4.9040908@powercraft.nl>
Date: Sat, 18 Oct 2008 22:40:04 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <mailman.81198.1224358186.3608.bluez-users@lists.sourceforge.net>
	<89b6ba3a0810181248u29129a09v50c7befde6741e5b@mail.gmail.com>
In-Reply-To: <89b6ba3a0810181248u29129a09v50c7befde6741e5b@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------010606010901070507090803"
Subject: Re: [Bluez-users] Motorola S9 and BlueZ 4.14
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010606010901070507090803
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patryk Zawadzki wrote:
> Starting the bluetoothd daemon and pressing the headset power button I
> get the following (the headset is paired but it does not make a
> difference):
> 
> bluetoothd[21459]: link_key_request (sba=00:1D:60:69:91:18,
<snip>
> removing from list
> 
> Any ideas of possible causes of the "stream state change failed:
> Input/output error"?
> 

I also have trouble with this headset and the bluez-utils and
bluez-gnome, both git builds of 24 hours old.

Please see the logs,

Any ideas?

Best regards,

Jelle




--------------010606010901070507090803
Content-Type: application/x-sh;
 name="setup-bluetooth-motorola-s9.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setup-bluetooth-motorola-s9.sh"

#!/bin/bash

echo 'pcm.headset {
    type bluetooth
    #~ device 00:0D:18:A0:35:70
    #~ device 00:53:53:FB:7E:9C # Nokia BH-801
    #~ device 00:0C:55:D1:C9:78 # Motorola S805
    device 00:0D:FD:18:6E:3C # Motorola S9
    #~ device 20:07:09:15:A9:5A # Samsung WEP210
    profile hifi
    #~ profile voice
    #profile auto
}
pcm.softvol {
    type softvol
    slave.pcm headset
    control.name Headset
    control.card 0
}
pcm.!default {
    #~ type hw
    #~ card 0
    type plug
    slave.pcm softvol
}' > ~/.asoundrc

sudo /etc/init.d/bluetooth restart
sudo /etc/init.d/alsa-utils restart

exit


--------------010606010901070507090803
Content-Type: text/x-log;
 name="bluetoothd.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluetoothd.log"

connected bluetooth headset with bluetooth-applet without any issues set
the device trusted. Did the same thing for my logitech bluetooth presenter mouse.

then rebooted the computer, when i try to do speaker-test -c2 i can hear
a short burst of sound then the sound stops, tried it sevral times...

The bluetooth presenter mouse indicates with green flashing lights it is
connected, but the mouse does nothing on the screen....

========================================================================

sudo /usr/sbin/bluetoothd --nodaemon --debug
bluetoothd[3325]: Bluetooth daemon
bluetoothd[3325]: Enabling debug information
bluetoothd[3325]: parsing main.conf
bluetoothd[3325]: offmode=NoScan
bluetoothd[3325]: discovto=0
bluetoothd[3325]: pageto=8192
bluetoothd[3325]: name=%h-%d
bluetoothd[3325]: class=0x000100
bluetoothd[3325]: inqmode=0
bluetoothd[3325]: Starting SDP server
bluetoothd[3325]: Loading plugins /usr/lib/bluetooth/plugins
bluetoothd[3325]: /usr/lib/bluetooth/plugins/service.so
bluetoothd[3325]: /usr/lib/bluetooth/plugins/hal.so
bluetoothd[3325]: /usr/lib/bluetooth/plugins/network.so
bluetoothd[3325]: Parsing /etc/bluetooth/network.conf failed: No such file or directory
bluetoothd[3325]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[3325]: bridge pan0 created
bluetoothd[3325]: /usr/lib/bluetooth/plugins/serial.so
bluetoothd[3325]: /usr/lib/bluetooth/plugins/input.so
bluetoothd[3325]: Parsing /etc/bluetooth/input.conf failed: No such file or directory
bluetoothd[3325]: /usr/lib/bluetooth/plugins/audio.so
bluetoothd[3325]: Unix socket created: 12
bluetoothd[3325]: Telephony plugin initialized
bluetoothd[3325]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes"
bluetoothd[3325]: HCI dev 0 registered
bluetoothd[3325]: child 3349 forked
bluetoothd[3325]: HCI dev 0 already up
bluetoothd[3325]: service_probe: path /org/bluez/hci0
bluetoothd[3325]: Registered interface org.bluez.Service on path /org/bluez/hci0
bluetoothd[3325]: network_server_probe: path /org/bluez/hci0
bluetoothd[3325]: Adding record with handle 0x10000
bluetoothd[3325]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00001115-0000-1000-8000-00805f9
bluetoothd[3325]: register_server_record: got record id 0x10000
bluetoothd[3325]: Registered interface org.bluez.NetworkPeer on path /org/bluez/hci0
bluetoothd[3325]: network_server_probe: path /org/bluez/hci0
bluetoothd[3325]: Adding record with handle 0x10001
bluetoothd[3325]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00001117-0000-1000-8000-00805f9
bluetoothd[3325]: register_server_record: got record id 0x10001
bluetoothd[3325]: Registered interface org.bluez.NetworkHub on path /org/bluez/hci0
bluetoothd[3325]: network_server_probe: path /org/bluez/hci0
bluetoothd[3325]: Adding record with handle 0x10002
bluetoothd[3325]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00001116-0000-1000-8000-00805f9
bluetoothd[3325]: register_server_record: got record id 0x10002
bluetoothd[3325]: Registered interface org.bluez.NetworkRouter on path /org/bluez/hci0
bluetoothd[3325]: proxy_probe: path /org/bluez/hci0
bluetoothd[3325]: Registered interface org.bluez.SerialProxyManager on path /org/bluez/hci0
bluetoothd[3325]: headset_server_probe: path /org/bluez/hci0
bluetoothd[3325]: audio.conf: Key file does not have key 'Master'
bluetoothd[3325]: Adding record with handle 0x10003
bluetoothd[3325]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3325]: audio.conf: Key file does not have key 'SCORouting'
bluetoothd[3325]: a2dp_server_probe: path /org/bluez/hci0
bluetoothd[3325]: audio.conf: Key file does not have key 'Disable'
bluetoothd[3325]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[3325]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[3325]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[3325]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[3325]: audio.conf: Key file does not have key 'Master'
bluetoothd[3325]: SEP 0xb9150088 registered: type:0 codec:0 seid:1
bluetoothd[3325]: Adding record with handle 0x10004
bluetoothd[3325]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[3325]: avrcp_server_probe: path /org/bluez/hci0
bluetoothd[3325]: audio.conf: Key file does not have key 'Master'
bluetoothd[3325]: Adding record with handle 0x10005
bluetoothd[3325]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3325]: Adding record with handle 0x10006
bluetoothd[3325]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3325]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3325]: Adapter /org/bluez/hci0 has been enabled
bluetoothd[3325]: Starting security manager 0
bluetoothd[3325]: child 3349 exited
bluetoothd[3325]: Computer is classified as laptop
bluetoothd[3325]: Current device class is 0x0a0100
bluetoothd[3325]: Setting 0x00010c for major/minor device class
bluetoothd[3325]: Agent registered for hci0 at :1.11:/org/bluez/agent/hci0
bluetoothd[3325]: Discovery session 0xb914bc90 with :1.13 activated
bluetoothd[3325]: session_ref(0xb914bc90): ref=1
bluetoothd[3325]: session_unref(0xb914bc90): ref=0
bluetoothd[3325]: Discovery session 0xb914bc90 with :1.13 deactivated
bluetoothd[3325]: Stopping discovery
bluetoothd[3325]: bonding_request_new(00:0D:FD:18:6E:3C)
bluetoothd[3325]: adapter_get_device(00:0D:FD:18:6E:3C)
bluetoothd[3325]: adapter_create_device(00:0D:FD:18:6E:3C)
bluetoothd[3325]: Creating device /org/bluez/hci0/dev_00_0D_FD_18_6E_3C
bluetoothd[3325]: Temporary agent registered for hci0/00:0D:FD:18:6E:3C at :1.13:/org/bluez/agent/wizard
bluetoothd[3325]: pin_code_request (sba=00:15:AF:F4:E9:E0, dba=00:0D:FD:18:6E:3C)
bluetoothd[3325]: hcid_dbus_new_auth_request
bluetoothd[3325]: link_key_notify (sba=00:15:AF:F4:E9:E0, dba=00:0D:FD:18:6E:3C)
bluetoothd[3325]: adapter_get_device(00:0D:FD:18:6E:3C)
bluetoothd[3325]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[3325]: adapter_get_device(00:0D:FD:18:6E:3C)
bluetoothd[3325]: Releasing agent :1.13, /org/bluez/agent/wizard
bluetoothd[3325]: Probe drivers for /org/bluez/hci0/dev_00_0D_FD_18_6E_3C
bluetoothd[3325]: headset_probe: path /org/bluez/hci0/dev_00_0D_FD_18_6E_3C
bluetoothd[3325]: Registered interface org.bluez.Input on path /org/bluez/hci0/dev_00_0D_FD_18_6E_3C
bluetoothd[3325]: adapter_get_device(00:0D:FD:18:6E:3C)
bluetoothd[3325]: Found Headset record
bluetoothd[3325]: Discovered Headset service on RFCOMM channel 2
bluetoothd[3325]: Registered interface org.bluez.Headset on path /org/bluez/hci0/dev_00_0D_FD_18_6E_3C
bluetoothd[3325]: audio handle_uuid: server not enabled for 0000111e-0000-1000-8000-00805f9b34fb (0x111e)
bluetoothd[3325]: Found Audio Sink
bluetoothd[3325]: Registered interface org.bluez.AudioSink on path /org/bluez/hci0/dev_00_0D_FD_18_6E_3C
bluetoothd[3325]: Found AV Target
bluetoothd[3325]: Registered interface org.bluez.Control on path /org/bluez/hci0/dev_00_0D_FD_18_6E_3C
bluetoothd[3325]: Found AV Remote
bluetoothd[3325]: Accepted new client connection on unix socket (fd=21)
bluetoothd[3325]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[3325]: avdtp_ref(0xb9151048): ref=2
bluetoothd[3325]: link_key_request (sba=00:15:AF:F4:E9:E0, dba=00:0D:FD:18:6E:3C)
bluetoothd[3325]: kernel auth requirements = 0x00
bluetoothd[3325]: stored link key type = 0x00
bluetoothd[3325]: adapter_get_device(00:0D:FD:18:6E:3C)
bluetoothd[3325]: AVDTP: connected signaling channel to 00:0D:FD:18:6E:3C
bluetoothd[3325]: session_cb
bluetoothd[3325]: DISCOVER request succeeded
bluetoothd[3325]: seid 1 type 1 media 0 in use 0
bluetoothd[3325]: seid 2 type 1 media 0 in use 0
bluetoothd[3325]: session_cb
bluetoothd[3325]: GET_CAPABILITIES request succeeded
bluetoothd[3325]: seid 1 type 1 media 0
bluetoothd[3325]: session_cb
bluetoothd[3325]: GET_CAPABILITIES request succeeded
bluetoothd[3325]: seid 2 type 1 media 0
bluetoothd[3325]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[3325]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[3325]: config a2dp - device = 00:0D:FD:18:6E:3C access_mode = 2
bluetoothd[3325]: codec sbc - frequency = 1 channel_mode = 8 allocation = 1 subbands = 1 blocks = 1 bitpool = 29
bluetoothd[3325]: a2dp_source_config: selected SEP 0xb9150088
bluetoothd[3325]: avdtp_ref(0xb9151048): ref=3
bluetoothd[3325]: setup_ref(0xb914ba50): ref=1
bluetoothd[3325]: avdtp_set_configuration(0xb9151048): int_seid=1, acp_seid=1
bluetoothd[3325]: session_cb
bluetoothd[3325]: SET_CONFIGURATION request succeeded
bluetoothd[3325]: Source 0xb9150088: Set_Configuration_Cfm
bluetoothd[3325]: avdtp_ref(0xb9151048): ref=4
bluetoothd[3325]: stream state changed: IDLE -> CONFIGURED
bluetoothd[3325]: session_cb
bluetoothd[3325]: OPEN request succeeded
bluetoothd[3325]: AVCTP: connected to 00:0D:FD:18:6E:3C
bluetoothd[3325]: Can't open input device: No such file or directory (2)
bluetoothd[3325]: AVRCP: failed to init uinput for 00:0D:FD:18:6E:3C
bluetoothd[3325]: AVDTP: connected transport channel to 00:0D:FD:18:6E:3C
bluetoothd[3325]: Source 0xb9150088: Open_Cfm
bluetoothd[3325]: setup_ref(0xb914ba50): ref=2
bluetoothd[3325]: SEP 0xb9150088 locked
bluetoothd[3325]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[3325]: setup_unref(0xb914ba50): ref=1
bluetoothd[3325]: setup_unref(0xb914ba50): ref=0
bluetoothd[3325]: setup_free(0xb914ba50)
bluetoothd[3325]: avdtp_unref(0xb9151048): ref=3
bluetoothd[3325]: stream state changed: CONFIGURED -> OPEN
bluetoothd[3325]: Audio API: received BT_STREAMSTART_REQ
bluetoothd[3325]: avdtp_ref(0xb9151048): ref=4
bluetoothd[3325]: setup_ref(0xb914b1b0): ref=1
bluetoothd[3325]: session_cb
bluetoothd[3325]: START request succeeded
bluetoothd[3325]: Source 0xb9150088: Start_Cfm
bluetoothd[3325]: setup_ref(0xb914b1b0): ref=2
bluetoothd[3325]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[3325]: Audio API: sending BT_STREAMFD_IND
bluetoothd[3325]: setup_unref(0xb914b1b0): ref=1
bluetoothd[3325]: setup_unref(0xb914b1b0): ref=0
bluetoothd[3325]: setup_free(0xb914b1b0)
bluetoothd[3325]: avdtp_unref(0xb9151048): ref=3
bluetoothd[3325]: stream state changed: OPEN -> STREAMING
bluetoothd[3325]: Unix client disconnected (fd=21)
bluetoothd[3325]: SEP 0xb9150088 unlocked
bluetoothd[3325]: avdtp_unref(0xb9151048): ref=2
bluetoothd[3325]: session_cb
bluetoothd[3325]: SUSPEND request succeeded
bluetoothd[3325]: stream state changed: STREAMING -> OPEN
bluetoothd[3325]: Source 0xb9150088: Suspend_Cfm
bluetoothd[3325]: Accepted new client connection on unix socket (fd=21)
bluetoothd[3325]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[3325]: avdtp_ref(0xb9151048): ref=3
bluetoothd[3325]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[3325]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[3325]: config a2dp - device = 00:0D:FD:18:6E:3C access_mode = 2
bluetoothd[3325]: codec sbc - frequency = 1 channel_mode = 1 allocation = 1 subbands = 1 blocks = 1 bitpool = 44
bluetoothd[3325]: a2dp_source_config: selected SEP 0xb9150088
bluetoothd[3325]: avdtp_ref(0xb9151048): ref=4
bluetoothd[3325]: setup_ref(0xb9149a60): ref=1
bluetoothd[3325]: session_cb
bluetoothd[3325]: CLOSE request succeeded
bluetoothd[3325]: stream state changed: OPEN -> CLOSING
bluetoothd[3325]: Source 0xb9150088: Close_Cfm
bluetoothd[3325]: stream state changed: CLOSING -> IDLE
bluetoothd[3325]: avdtp_unref(0xb9151048): ref=3
bluetoothd[3325]: avdtp_set_configuration(0xb9151048): int_seid=1, acp_seid=1
bluetoothd[3325]: session_cb
bluetoothd[3325]: SET_CONFIGURATION request succeeded
bluetoothd[3325]: Source 0xb9150088: Set_Configuration_Cfm
bluetoothd[3325]: avdtp_ref(0xb9151048): ref=4
bluetoothd[3325]: stream state changed: IDLE -> CONFIGURED
bluetoothd[3325]: session_cb
bluetoothd[3325]: OPEN request succeeded
bluetoothd[3325]: AVDTP: connected transport channel to 00:0D:FD:18:6E:3C
bluetoothd[3325]: Source 0xb9150088: Open_Cfm
bluetoothd[3325]: setup_ref(0xb9149a60): ref=2
bluetoothd[3325]: SEP 0xb9150088 locked
bluetoothd[3325]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[3325]: setup_unref(0xb9149a60): ref=1
bluetoothd[3325]: setup_unref(0xb9149a60): ref=0
bluetoothd[3325]: setup_free(0xb9149a60)
bluetoothd[3325]: avdtp_unref(0xb9151048): ref=3
bluetoothd[3325]: stream state changed: CONFIGURED -> OPEN
bluetoothd[3325]: Audio API: received BT_STREAMSTART_REQ
bluetoothd[3325]: avdtp_ref(0xb9151048): ref=4
bluetoothd[3325]: setup_ref(0xb9149a60): ref=1
bluetoothd[3325]: session_cb
bluetoothd[3325]: START request succeeded
bluetoothd[3325]: Source 0xb9150088: Start_Cfm
bluetoothd[3325]: setup_ref(0xb9149a60): ref=2
bluetoothd[3325]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[3325]: Audio API: sending BT_STREAMFD_IND
bluetoothd[3325]: setup_unref(0xb9149a60): ref=1
bluetoothd[3325]: setup_unref(0xb9149a60): ref=0
bluetoothd[3325]: setup_free(0xb9149a60)
bluetoothd[3325]: avdtp_unref(0xb9151048): ref=3
bluetoothd[3325]: stream state changed: OPEN -> STREAMING
bluetoothd[3325]: Unix client disconnected (fd=21)
bluetoothd[3325]: SEP 0xb9150088 unlocked
bluetoothd[3325]: avdtp_unref(0xb9151048): ref=2
bluetoothd[3325]: session_cb
bluetoothd[3325]: SUSPEND request succeeded
bluetoothd[3325]: stream state changed: STREAMING -> OPEN
bluetoothd[3325]: Source 0xb9150088: Suspend_Cfm
bluetoothd[3325]: session_cb
bluetoothd[3325]: CLOSE request succeeded
bluetoothd[3325]: stream state changed: OPEN -> CLOSING
bluetoothd[3325]: Source 0xb9150088: Close_Cfm
bluetoothd[3325]: stream state changed: CLOSING -> IDLE
bluetoothd[3325]: avdtp_unref(0xb9151048): ref=1
bluetoothd[3325]: Disconnected from 00:0D:FD:18:6E:3C
bluetoothd[3325]: avdtp_unref(0xb9151048): ref=0
bluetoothd[3325]: avdtp_unref(0xb9151048): freeing session and removing from list

========================================================================

bluetoothd[2294]: Bluetooth daemon
bluetoothd[2294]: Enabling debug information
bluetoothd[2294]: parsing main.conf
bluetoothd[2294]: offmode=NoScan
bluetoothd[2294]: discovto=0
bluetoothd[2294]: pageto=8192
bluetoothd[2294]: name=%h-%d
bluetoothd[2294]: class=0x000100
bluetoothd[2294]: inqmode=0
bluetoothd[2294]: Starting SDP server
bluetoothd[2294]: Loading plugins /usr/lib/bluetooth/plugins
bluetoothd[2294]: /usr/lib/bluetooth/plugins/service.so
bluetoothd[2294]: /usr/lib/bluetooth/plugins/hal.so
bluetoothd[2294]: /usr/lib/bluetooth/plugins/network.so
bluetoothd[2294]: Parsing /etc/bluetooth/network.conf failed: No such file or directory
bluetoothd[2294]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[2294]: bridge pan0 created
bluetoothd[2294]: /usr/lib/bluetooth/plugins/serial.so
bluetoothd[2294]: /usr/lib/bluetooth/plugins/input.so
bluetoothd[2294]: Parsing /etc/bluetooth/input.conf failed: No such file or directory
bluetoothd[2294]: /usr/lib/bluetooth/plugins/audio.so
bluetoothd[2294]: Unix socket created: 12
bluetoothd[2294]: Telephony plugin initialized
bluetoothd[2294]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes"
bluetoothd[2294]: HCI dev 0 registered
bluetoothd[2294]: child 2321 forked
bluetoothd[2294]: child 2321 exited
bluetoothd[2294]: HCI dev 0 up
bluetoothd[2294]: service_probe: path /org/bluez/hci0
bluetoothd[2294]: Registered interface org.bluez.Service on path /org/bluez/hci0
bluetoothd[2294]: network_server_probe: path /org/bluez/hci0
bluetoothd[2294]: Adding record with handle 0x10000
bluetoothd[2294]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00001115-0000-1000-8000-00805f9
bluetoothd[2294]: register_server_record: got record id 0x10000
bluetoothd[2294]: Registered interface org.bluez.NetworkPeer on path /org/bluez/hci0
bluetoothd[2294]: network_server_probe: path /org/bluez/hci0
bluetoothd[2294]: Adding record with handle 0x10001
bluetoothd[2294]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00001117-0000-1000-8000-00805f9
bluetoothd[2294]: register_server_record: got record id 0x10001
bluetoothd[2294]: Registered interface org.bluez.NetworkHub on path /org/bluez/hci0
bluetoothd[2294]: network_server_probe: path /org/bluez/hci0
bluetoothd[2294]: Adding record with handle 0x10002
bluetoothd[2294]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00001116-0000-1000-8000-00805f9
bluetoothd[2294]: register_server_record: got record id 0x10002
bluetoothd[2294]: Registered interface org.bluez.NetworkRouter on path /org/bluez/hci0
bluetoothd[2294]: proxy_probe: path /org/bluez/hci0
bluetoothd[2294]: Registered interface org.bluez.SerialProxyManager on path /org/bluez/hci0
bluetoothd[2294]: headset_server_probe: path /org/bluez/hci0
bluetoothd[2294]: audio.conf: Key file does not have key 'Master'
bluetoothd[2294]: Adding record with handle 0x10003
bluetoothd[2294]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[2294]: audio.conf: Key file does not have key 'SCORouting'
bluetoothd[2294]: a2dp_server_probe: path /org/bluez/hci0
bluetoothd[2294]: audio.conf: Key file does not have key 'Disable'
bluetoothd[2294]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[2294]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[2294]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[2294]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[2294]: audio.conf: Key file does not have key 'Master'
bluetoothd[2294]: SEP 0xb98b3098 registered: type:0 codec:0 seid:1
bluetoothd[2294]: Adding record with handle 0x10004
bluetoothd[2294]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[2294]: avrcp_server_probe: path /org/bluez/hci0
bluetoothd[2294]: audio.conf: Key file does not have key 'Master'
bluetoothd[2294]: Adding record with handle 0x10005
bluetoothd[2294]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[2294]: Adding record with handle 0x10006
bluetoothd[2294]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2294]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[2294]: Creating device /org/bluez/hci0/dev_00_0D_FD_18_6E_3C
bluetoothd[2294]: Probe drivers for /org/bluez/hci0/dev_00_0D_FD_18_6E_3C
bluetoothd[2294]: headset_probe: path /org/bluez/hci0/dev_00_0D_FD_18_6E_3C
bluetoothd[2294]: Registered interface org.bluez.Input on path /org/bluez/hci0/dev_00_0D_FD_18_6E_3C
bluetoothd[2294]: adapter_get_device(00:0D:FD:18:6E:3C)
bluetoothd[2294]: Found Headset record
bluetoothd[2294]: Discovered Headset service on RFCOMM channel 2
bluetoothd[2294]: Registered interface org.bluez.Headset on path /org/bluez/hci0/dev_00_0D_FD_18_6E_3C
bluetoothd[2294]: audio handle_uuid: server not enabled for 0000111e-0000-1000-8000-00805f9b34fb (0x111e)
bluetoothd[2294]: Found Audio Sink
bluetoothd[2294]: Registered interface org.bluez.AudioSink on path /org/bluez/hci0/dev_00_0D_FD_18_6E_3C
bluetoothd[2294]: Found AV Target
bluetoothd[2294]: Registered interface org.bluez.Control on path /org/bluez/hci0/dev_00_0D_FD_18_6E_3C
bluetoothd[2294]: Found AV Remote
bluetoothd[2294]: Creating device /org/bluez/hci0/dev_00_07_61_0F_4A_60
bluetoothd[2294]: Probe drivers for /org/bluez/hci0/dev_00_07_61_0F_4A_60
bluetoothd[2294]: hid_device_probe: path /org/bluez/hci0/dev_00_07_61_0F_4A_60
bluetoothd[2294]: Registered interface org.bluez.Input on path /org/bluez/hci0/dev_00_07_61_0F_4A_60
bluetoothd[2294]: Adapter /org/bluez/hci0 has been enabled
bluetoothd[2294]: Starting security manager 0
bluetoothd[2294]: Computer is classified as laptop
bluetoothd[2294]: Current device class is 0x0a010c
bluetoothd[2294]: Setting 0x00010c for major/minor device class
bluetoothd[2294]: Accepted new client connection on unix socket (fd=21)
bluetoothd[2294]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2294]: avdtp_ref(0xb98b4700): ref=2
bluetoothd[2294]: link_key_request (sba=00:15:AF:F4:E9:E0, dba=00:0D:FD:18:6E:3C)
bluetoothd[2294]: kernel auth requirements = 0x00
bluetoothd[2294]: stored link key type = 0x00
bluetoothd[2294]: adapter_get_device(00:0D:FD:18:6E:3C)
bluetoothd[2294]: AVDTP: connected signaling channel to 00:0D:FD:18:6E:3C
bluetoothd[2294]: session_cb
bluetoothd[2294]: DISCOVER request succeeded
bluetoothd[2294]: seid 1 type 1 media 0 in use 0
bluetoothd[2294]: seid 2 type 1 media 0 in use 0
bluetoothd[2294]: session_cb
bluetoothd[2294]: GET_CAPABILITIES request succeeded
bluetoothd[2294]: seid 1 type 1 media 0
bluetoothd[2294]: session_cb
bluetoothd[2294]: GET_CAPABILITIES request succeeded
bluetoothd[2294]: seid 2 type 1 media 0
bluetoothd[2294]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2294]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2294]: config a2dp - device = 00:0D:FD:18:6E:3C access_mode = 2
bluetoothd[2294]: codec sbc - frequency = 1 channel_mode = 1 allocation = 1 subbands = 1 blocks = 1 bitpool = 44
bluetoothd[2294]: a2dp_source_config: selected SEP 0xb98b3098
bluetoothd[2294]: avdtp_ref(0xb98b4700): ref=3
bluetoothd[2294]: setup_ref(0xb98b5398): ref=1
bluetoothd[2294]: avdtp_set_configuration(0xb98b4700): int_seid=1, acp_seid=1
bluetoothd[2294]: session_cb
bluetoothd[2294]: SET_CONFIGURATION request succeeded
bluetoothd[2294]: Source 0xb98b3098: Set_Configuration_Cfm
bluetoothd[2294]: avdtp_ref(0xb98b4700): ref=4
bluetoothd[2294]: stream state changed: IDLE -> CONFIGURED
bluetoothd[2294]: session_cb
bluetoothd[2294]: OPEN request succeeded
bluetoothd[2294]: AVCTP: connected to 00:0D:FD:18:6E:3C
bluetoothd[2294]: Can't open input device: No such file or directory (2)
bluetoothd[2294]: AVRCP: failed to init uinput for 00:0D:FD:18:6E:3C
bluetoothd[2294]: AVDTP: connected transport channel to 00:0D:FD:18:6E:3C
bluetoothd[2294]: Source 0xb98b3098: Open_Cfm
bluetoothd[2294]: setup_ref(0xb98b5398): ref=2
bluetoothd[2294]: SEP 0xb98b3098 locked
bluetoothd[2294]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2294]: setup_unref(0xb98b5398): ref=1
bluetoothd[2294]: setup_unref(0xb98b5398): ref=0
bluetoothd[2294]: setup_free(0xb98b5398)
bluetoothd[2294]: avdtp_unref(0xb98b4700): ref=3
bluetoothd[2294]: stream state changed: CONFIGURED -> OPEN
bluetoothd[2294]: Audio API: received BT_STREAMSTART_REQ
bluetoothd[2294]: avdtp_ref(0xb98b4700): ref=4
bluetoothd[2294]: setup_ref(0xb98b4050): ref=1
bluetoothd[2294]: session_cb
bluetoothd[2294]: START request succeeded
bluetoothd[2294]: Source 0xb98b3098: Start_Cfm
bluetoothd[2294]: setup_ref(0xb98b4050): ref=2
bluetoothd[2294]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[2294]: Audio API: sending BT_STREAMFD_IND
bluetoothd[2294]: setup_unref(0xb98b4050): ref=1
bluetoothd[2294]: setup_unref(0xb98b4050): ref=0
bluetoothd[2294]: setup_free(0xb98b4050)
bluetoothd[2294]: avdtp_unref(0xb98b4700): ref=3
bluetoothd[2294]: stream state changed: OPEN -> STREAMING
bluetoothd[2294]: Unix client disconnected (fd=21)
bluetoothd[2294]: SEP 0xb98b3098 unlocked
bluetoothd[2294]: avdtp_unref(0xb98b4700): ref=2
bluetoothd[2294]: Accepted new client connection on unix socket (fd=21)
bluetoothd[2294]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2294]: avdtp_ref(0xb98b4700): ref=3
bluetoothd[2294]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2294]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2294]: config a2dp - device = 00:0D:FD:18:6E:3C access_mode = 2
bluetoothd[2294]: codec sbc - frequency = 1 channel_mode = 1 allocation = 1 subbands = 1 blocks = 1 bitpool = 44
bluetoothd[2294]: a2dp_source_config: selected SEP 0xb98b3098
bluetoothd[2294]: avdtp_ref(0xb98b4700): ref=4
bluetoothd[2294]: setup_ref(0xb98b5460): ref=1
bluetoothd[2294]: setup_ref(0xb98b5460): ref=2
bluetoothd[2294]: SEP 0xb98b3098 locked
bluetoothd[2294]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2294]: setup_unref(0xb98b5460): ref=1
bluetoothd[2294]: setup_unref(0xb98b5460): ref=0
bluetoothd[2294]: setup_free(0xb98b5460)
bluetoothd[2294]: avdtp_unref(0xb98b4700): ref=3
bluetoothd[2294]: Audio API: received BT_STREAMSTART_REQ
bluetoothd[2294]: avdtp_ref(0xb98b4700): ref=4
bluetoothd[2294]: setup_ref(0xb98b5460): ref=1
bluetoothd[2294]: session_cb
bluetoothd[2294]: SUSPEND request succeeded
bluetoothd[2294]: stream state changed: STREAMING -> OPEN
bluetoothd[2294]: Source 0xb98b3098: Suspend_Cfm
bluetoothd[2294]: setup_ref(0xb98b5460): ref=2
bluetoothd[2294]: setup_unref(0xb98b5460): ref=1
bluetoothd[2294]: session_cb
bluetoothd[2294]: START request succeeded
bluetoothd[2294]: Source 0xb98b3098: Start_Cfm
bluetoothd[2294]: setup_ref(0xb98b5460): ref=2
bluetoothd[2294]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[2294]: Audio API: sending BT_STREAMFD_IND
bluetoothd[2294]: setup_unref(0xb98b5460): ref=1
bluetoothd[2294]: setup_unref(0xb98b5460): ref=0
bluetoothd[2294]: setup_free(0xb98b5460)
bluetoothd[2294]: avdtp_unref(0xb98b4700): ref=3
bluetoothd[2294]: stream state changed: OPEN -> STREAMING
bluetoothd[2294]: Unix client disconnected (fd=21)
bluetoothd[2294]: SEP 0xb98b3098 unlocked
bluetoothd[2294]: avdtp_unref(0xb98b4700): ref=2
bluetoothd[2294]: session_cb
bluetoothd[2294]: SUSPEND request succeeded
bluetoothd[2294]: stream state changed: STREAMING -> OPEN
bluetoothd[2294]: Source 0xb98b3098: Suspend_Cfm
bluetoothd[2294]: Accepted new client connection on unix socket (fd=21)
bluetoothd[2294]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2294]: avdtp_ref(0xb98b4700): ref=3
bluetoothd[2294]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2294]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2294]: config a2dp - device = 00:0D:FD:18:6E:3C access_mode = 2
bluetoothd[2294]: codec sbc - frequency = 1 channel_mode = 1 allocation = 1 subbands = 1 blocks = 1 bitpool = 44
bluetoothd[2294]: a2dp_source_config: selected SEP 0xb98b3098
bluetoothd[2294]: avdtp_ref(0xb98b4700): ref=4
bluetoothd[2294]: setup_ref(0xb98b16c0): ref=1
bluetoothd[2294]: setup_ref(0xb98b16c0): ref=2
bluetoothd[2294]: SEP 0xb98b3098 locked
bluetoothd[2294]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2294]: setup_unref(0xb98b16c0): ref=1
bluetoothd[2294]: setup_unref(0xb98b16c0): ref=0
bluetoothd[2294]: setup_free(0xb98b16c0)
bluetoothd[2294]: avdtp_unref(0xb98b4700): ref=3
bluetoothd[2294]: Audio API: received BT_STREAMSTART_REQ
bluetoothd[2294]: avdtp_ref(0xb98b4700): ref=4
bluetoothd[2294]: setup_ref(0xb98b16c0): ref=1
bluetoothd[2294]: session_cb
bluetoothd[2294]: START request succeeded
bluetoothd[2294]: Source 0xb98b3098: Start_Cfm
bluetoothd[2294]: setup_ref(0xb98b16c0): ref=2
bluetoothd[2294]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[2294]: Audio API: sending BT_STREAMFD_IND
bluetoothd[2294]: setup_unref(0xb98b16c0): ref=1
bluetoothd[2294]: setup_unref(0xb98b16c0): ref=0
bluetoothd[2294]: setup_free(0xb98b16c0)
bluetoothd[2294]: avdtp_unref(0xb98b4700): ref=3
bluetoothd[2294]: stream state changed: OPEN -> STREAMING
bluetoothd[2294]: Unix client disconnected (fd=21)
bluetoothd[2294]: SEP 0xb98b3098 unlocked
bluetoothd[2294]: avdtp_unref(0xb98b4700): ref=2
bluetoothd[2294]: session_cb
bluetoothd[2294]: SUSPEND request succeeded
bluetoothd[2294]: stream state changed: STREAMING -> OPEN
bluetoothd[2294]: Source 0xb98b3098: Suspend_Cfm
bluetoothd[2294]: Accepted new client connection on unix socket (fd=21)
bluetoothd[2294]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2294]: avdtp_ref(0xb98b4700): ref=3
bluetoothd[2294]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2294]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2294]: config a2dp - device = 00:0D:FD:18:6E:3C access_mode = 2
bluetoothd[2294]: codec sbc - frequency = 1 channel_mode = 1 allocation = 1 subbands = 1 blocks = 1 bitpool = 44
bluetoothd[2294]: a2dp_source_config: selected SEP 0xb98b3098
bluetoothd[2294]: avdtp_ref(0xb98b4700): ref=4
bluetoothd[2294]: setup_ref(0xb98b16c0): ref=1
bluetoothd[2294]: setup_ref(0xb98b16c0): ref=2
bluetoothd[2294]: SEP 0xb98b3098 locked
bluetoothd[2294]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2294]: setup_unref(0xb98b16c0): ref=1
bluetoothd[2294]: setup_unref(0xb98b16c0): ref=0
bluetoothd[2294]: setup_free(0xb98b16c0)
bluetoothd[2294]: avdtp_unref(0xb98b4700): ref=3
bluetoothd[2294]: Audio API: received BT_STREAMSTART_REQ
bluetoothd[2294]: avdtp_ref(0xb98b4700): ref=4
bluetoothd[2294]: setup_ref(0xb98b16c0): ref=1
bluetoothd[2294]: session_cb
bluetoothd[2294]: START request succeeded
bluetoothd[2294]: Source 0xb98b3098: Start_Cfm
bluetoothd[2294]: setup_ref(0xb98b16c0): ref=2
bluetoothd[2294]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[2294]: Audio API: sending BT_STREAMFD_IND
bluetoothd[2294]: setup_unref(0xb98b16c0): ref=1
bluetoothd[2294]: setup_unref(0xb98b16c0): ref=0
bluetoothd[2294]: setup_free(0xb98b16c0)
bluetoothd[2294]: avdtp_unref(0xb98b4700): ref=3
bluetoothd[2294]: stream state changed: OPEN -> STREAMING
bluetoothd[2294]: Unix client disconnected (fd=21)
bluetoothd[2294]: SEP 0xb98b3098 unlocked
bluetoothd[2294]: avdtp_unref(0xb98b4700): ref=2
bluetoothd[2294]: session_cb
bluetoothd[2294]: SUSPEND request succeeded
bluetoothd[2294]: stream state changed: STREAMING -> OPEN
bluetoothd[2294]: Source 0xb98b3098: Suspend_Cfm
bluetoothd[2294]: session_cb
bluetoothd[2294]: CLOSE request succeeded
bluetoothd[2294]: stream state changed: OPEN -> CLOSING
bluetoothd[2294]: Source 0xb98b3098: Close_Cfm
bluetoothd[2294]: stream state changed: CLOSING -> IDLE
bluetoothd[2294]: avdtp_unref(0xb98b4700): ref=1
bluetoothd[2294]: Disconnected from 00:0D:FD:18:6E:3C
bluetoothd[2294]: avdtp_unref(0xb98b4700): ref=0
bluetoothd[2294]: avdtp_unref(0xb98b4700): freeing session and removing from list

--------------010606010901070507090803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------010606010901070507090803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------010606010901070507090803--
