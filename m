Return-Path: <cyrus@holtmann.org>
Date: Sun, 9 Nov 2008 16:38:06 -0800 (PST)
From: Damon Hastings <damonhastings@yahoo.com>
Subject: Re: Possible to send audio to multiple bluetooth headsets at once?
To: BlueZ development <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <141958.62968.qm@web81804.mail.mud.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Thanks for your quick reply -- I wish I had posted here days ago!  Say, am I supposed to be sending my response only to you, or to the whole mailing list?

Well, you probably got me a few steps closer (that I *never* would have figured out on my own), but I'm afraid the behavior of bluetoothd is unchanged.  I've only tried it with bluez 4.17 -- should I try an earlier version?

I created /etc/bluetooth/audio.conf with these contents:

  [Headset]
  MaxConnections=2

I also tried adding that to /etc/bluetooth/main.conf, and I tried adding MaxConnections=2 to the [General] section there as well.  I also tried MaxConnected=2 due to a suspicious message "audio.conf: Key file does not have key 'MaxConnected'" that I got from bluetoothd; debug mode seems to give messages like that for keys which could (should?) have been in the conf files but weren't.  And I added 'profile "voice"' to both PCMs in my .asoundrc.  

None of this seemed to substantially change bluetoothd's behavior.  Here's the full output of "/usr/sbin/bluetoothd -d -n" running as root during one of my attempts, with my own actions annotated in <> angle brackets.  This is starting from scratch (i.e. no stored pairings, so I have to re-enter both PINs):

bluetoothd[3103]: Bluetooth daemon
bluetoothd[3103]: Enabling debug information
bluetoothd[3103]: parsing main.conf
bluetoothd[3103]: offmode=NoScan
bluetoothd[3103]: discovto=0
bluetoothd[3103]: pageto=8192
bluetoothd[3103]: name=%h-%d
bluetoothd[3103]: class=0x000100
bluetoothd[3103]: inqmode=0
bluetoothd[3103]: Starting SDP server
bluetoothd[3103]: Loading plugins /usr/lib/bluetooth/plugins
bluetoothd[3103]: Unix socket created: 11
bluetoothd[3103]: audio.conf: Key file does not have key 'HFP'
bluetoothd[3103]: Telephony plugin initialized
bluetoothd[3103]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[3103]: Parsing /etc/bluetooth/input.conf failed: No such file or directory
bluetoothd[3103]: Parsing /etc/bluetooth/network.conf failed: No such file or directory
bluetoothd[3103]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[3103]: bridge pan0 created
bluetoothd[3103]: HCI dev 0 registered
bluetoothd[3103]: child 3109 forked
bluetoothd[3103]: HCI dev 0 already up
bluetoothd[3103]: headset_server_probe: path /org/bluez/hci0
bluetoothd[3103]: audio.conf: Key file does not have key 'Master'
bluetoothd[3103]: Adding record with handle 0x10000
bluetoothd[3103]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3103]: audio.conf: Key file does not have key 'SCORouting'
bluetoothd[3103]: Adding record with handle 0x10001
bluetoothd[3103]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3103]: a2dp_server_probe: path /org/bluez/hci0
bluetoothd[3103]: audio.conf: Key file does not have key 'Disable'
bluetoothd[3103]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[3103]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[3103]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[3103]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[3103]: audio.conf: Key file does not have key 'Master'
bluetoothd[3103]: SEP 0xb840b6e0 registered: type:0 codec:0 seid:1
bluetoothd[3103]: Adding record with handle 0x10002
bluetoothd[3103]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[3103]: avrcp_server_probe: path /org/bluez/hci0
bluetoothd[3103]: audio.conf: Key file does not have key 'Master'
bluetoothd[3103]: Adding record with handle 0x10003
bluetoothd[3103]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3103]: Adding record with handle 0x10004
bluetoothd[3103]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3103]: proxy_probe: path /org/bluez/hci0
bluetoothd[3103]: Registered interface org.bluez.SerialProxyManager on path /org/bluez/hci0
bluetoothd[3103]: service_probe: path /org/bluez/hci0
bluetoothd[3103]: Registered interface org.bluez.Service on path /org/bluez/hci0
bluetoothd[3103]: network_server_probe: path /org/bluez/hci0
bluetoothd[3103]: Adding record with handle 0x10005
bluetoothd[3103]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00001115-0000-1000-8000-00805f9
bluetoothd[3103]: register_server_record: got record id 0x10005
bluetoothd[3103]: Registered interface org.bluez.NetworkPeer on path /org/bluez/hci0
bluetoothd[3103]: network_server_probe: path /org/bluez/hci0
bluetoothd[3103]: Adding record with handle 0x10006
bluetoothd[3103]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00001117-0000-1000-8000-00805f9
bluetoothd[3103]: register_server_record: got record id 0x10006
bluetoothd[3103]: Registered interface org.bluez.NetworkHub on path /org/bluez/hci0
bluetoothd[3103]: network_server_probe: path /org/bluez/hci0
bluetoothd[3103]: Adding record with handle 0x10007
bluetoothd[3103]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3103]: Record pattern UUID 00001116-0000-1000-8000-00805f9
bluetoothd[3103]: register_server_record: got record id 0x10007
bluetoothd[3103]: Registered interface org.bluez.NetworkRouter on path /org/bluez/hci0
bluetoothd[3103]: Adapter /org/bluez/hci0 has been enabled
bluetoothd[3103]: Starting security manager 0
bluetoothd[3103]: child 3109 exited
bluetoothd[3103]: Computer is classified as desktop
bluetoothd[3103]: Current device class is 0x4a0104
bluetoothd[3103]: Setting 0x000104 for major/minor device class
bluetoothd[3103]: Agent registered for hci0 at :1.21:/org/bluez/agent/hci0

<turned on the Jabra BT2040 headset>

bluetoothd[3103]: adapter_get_device(00:1A:45:31:47:69)
bluetoothd[3103]: adapter_create_device(00:1A:45:31:47:69)
bluetoothd[3103]: Creating device /org/bluez/hci0/dev_00_1A_45_31_47_69
bluetoothd[3103]: link_key_request (sba=00:15:83:02:4F:E7, dba=00:1A:45:31:47:69)
bluetoothd[3103]: kernel auth requirements = 0x00
bluetoothd[3103]: pin_code_request (sba=00:15:83:02:4F:E7, dba=00:1A:45:31:47:69)
bluetoothd[3103]: hcid_dbus_new_auth_request

<entered PIN>

bluetoothd[3103]: link_key_notify (sba=00:15:83:02:4F:E7, dba=00:1A:45:31:47:69)
bluetoothd[3103]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[3103]: adapter_get_device(00:1A:45:31:47:69)
bluetoothd[3103]: adapter_get_device(00:1A:45:31:47:69)
bluetoothd[3103]: Probe drivers for /org/bluez/hci0/dev_00_1A_45_31_47_69
bluetoothd[3103]: adapter_get_device(00:1A:45:31:47:69)
bluetoothd[3103]: Found Headset record
bluetoothd[3103]: Discovered Headset service on RFCOMM channel 2
bluetoothd[3103]: Registered interface org.bluez.Headset on path /org/bluez/hci0/dev_00_1A_45_31_47_69
bluetoothd[3103]: Found Handsfree record
bluetoothd[3103]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[3103]: headset_probe: path /org/bluez/hci0/dev_00_1A_45_31_47_69
bluetoothd[3103]: Registered interface org.bluez.Input on path /org/bluez/hci0/dev_00_1A_45_31_47_69

<turned on the Motorola H680 headset>

bluetoothd[3103]: adapter_get_device(00:1A:0E:B8:B3:7F)
bluetoothd[3103]: adapter_create_device(00:1A:0E:B8:B3:7F)
bluetoothd[3103]: Creating device /org/bluez/hci0/dev_00_1A_0E_B8_B3_7F
bluetoothd[3103]: link_key_request (sba=00:15:83:02:4F:E7, dba=00:1A:0E:B8:B3:7F)
bluetoothd[3103]: kernel auth requirements = 0x00
bluetoothd[3103]: pin_code_request (sba=00:15:83:02:4F:E7, dba=00:1A:0E:B8:B3:7F)
bluetoothd[3103]: hcid_dbus_new_auth_request

<entered PIN>

bluetoothd[3103]: link_key_notify (sba=00:15:83:02:4F:E7, dba=00:1A:0E:B8:B3:7F)
bluetoothd[3103]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[3103]: adapter_get_device(00:1A:0E:B8:B3:7F)
bluetoothd[3103]: adapter_get_device(00:1A:0E:B8:B3:7F)
bluetoothd[3103]: link_key_request (sba=00:15:83:02:4F:E7, dba=00:1A:0E:B8:B3:7F)
bluetoothd[3103]: kernel auth requirements = 0x00
bluetoothd[3103]: stored link key type = 0x00
bluetoothd[3103]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[3103]: adapter_get_device(00:1A:0E:B8:B3:7F)
bluetoothd[3103]: hcid_dbus_bonding_process_complete: no pending auth request
bluetoothd[3103]: adapter_get_device(00:1A:0E:B8:B3:7F)
bluetoothd[3103]: Probe drivers for /org/bluez/hci0/dev_00_1A_0E_B8_B3_7F
bluetoothd[3103]: Found Handsfree record
bluetoothd[3103]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[3103]: Registered interface org.bluez.Headset on path /org/bluez/hci0/dev_00_1A_0E_B8_B3_7F
bluetoothd[3103]: State changed /org/bluez/hci0/dev_00_1A_0E_B8_B3_7F: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[3103]: Accepted headset connection from 00:1A:0E:B8:B3:7F for /org/bluez/hci0/dev_00_1A_0E_B8_B3_7F
bluetoothd[3103]: Received AT+BRSF=26
bluetoothd[3103]: HFP HF features: "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[3103]: Received AT+CIND=?
bluetoothd[3103]: Received AT+CIND?
bluetoothd[3103]: Probe drivers for /org/bluez/hci0/dev_00_1A_0E_B8_B3_7F
bluetoothd[3103]: Found Headset record
bluetoothd[3103]: Found Handsfree record
bluetoothd[3103]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[3103]: headset_probe: path /org/bluez/hci0/dev_00_1A_0E_B8_B3_7F
bluetoothd[3103]: Registered interface org.bluez.Input on path /org/bluez/hci0/dev_00_1A_0E_B8_B3_7F
bluetoothd[3103]: Received AT+CMER=3, 0, 0, 1
bluetoothd[3103]: Event reporting (CMER): mode=3, ind=1
bluetoothd[3103]: HFP Service Level Connection established
bluetoothd[3103]: telephony-dummy: device 0xb8421d20 connected
bluetoothd[3103]: State changed /org/bluez/hci0/dev_00_1A_0E_B8_B3_7F: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[3103]: Received AT+BTRH?
bluetoothd[3103]: Received AT+VGS=05

<started aplay on the Jabra>

bluetoothd[3103]: Accepted new client connection on unix socket (fd=23)
bluetoothd[3103]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[3103]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[3103]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[3103]: config sco - device = 00:1A:45:31:47:69 access_mode = 2
bluetoothd[3103]: /org/bluez/hci0/dev_00_1A_45_31_47_69: Connecting to 00:1A:45:31:47:69 channel 1
bluetoothd[3103]: State changed /org/bluez/hci0/dev_00_1A_45_31_47_69: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[3103]: adapter_get_device(00:1A:45:31:47:69)
bluetoothd[3103]: link_key_request (sba=00:15:83:02:4F:E7, dba=00:1A:45:31:47:69)
bluetoothd[3103]: kernel auth requirements = 0x00
bluetoothd[3103]: stored link key type = 0x00
bluetoothd[3103]: /org/bluez/hci0/dev_00_1A_45_31_47_69: Connected to 00:1A:45:31:47:69
bluetoothd[3103]: Received AT+BRSF=26
bluetoothd[3103]: HFP HF features: "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[3103]: Received AT+CIND=?
bluetoothd[3103]: Received AT+CIND?
bluetoothd[3103]: Received AT+CMER=3, 0, 0, 1
bluetoothd[3103]: Event reporting (CMER): mode=3, ind=1
bluetoothd[3103]: HFP Service Level Connection established
bluetoothd[3103]: telephony-dummy: device 0xb84107c0 connected
bluetoothd[3103]: State changed /org/bluez/hci0/dev_00_1A_45_31_47_69: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[3103]: State changed /org/bluez/hci0/dev_00_1A_45_31_47_69: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[3103]: Received AT+BTRH?
bluetoothd[3103]: SCO socket opened for headset /org/bluez/hci0/dev_00_1A_45_31_47_69
bluetoothd[3103]: SCO fd=26
bluetoothd[3103]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[3103]: State changed /org/bluez/hci0/dev_00_1A_45_31_47_69: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[3103]: Audio API: received BT_STREAMSTART_REQ
bluetoothd[3103]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[3103]: Audio API: sending BT_STREAMFD_IND
bluetoothd[3103]: Received AT+VGS=08
bluetoothd[3103]: Received AT+VGM=08

<with aplay still outputting to the Jabra, I now start another aplay in
 a separate window outputting to the Motorola>

bluetoothd[3103]: Accepted new client connection on unix socket (fd=27)
bluetoothd[3103]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[3103]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[3103]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[3103]: config sco - device = 00:1A:0E:B8:B3:7F access_mode = 2
bluetoothd[3103]: connect: Operation not permitted (1)
bluetoothd[3103]: config failed
bluetoothd[3103]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[3103]: Unix client disconnected (fd=27)

<I hit ctrl-c in my bluetoothd window to kill bluetoothd>

bluetoothd[3103]: Cleanup plugins
bluetoothd[3103]: bridge pan0 removed
bluetoothd[3103]: Stopping SDP server
bluetoothd[3103]: Exit

I was confused by one thing from above: it says "HFP Service Level Connection established" after I run aplay; but I thought I was using HSP, not HFP.  This inspired me to try duplicating your [Headset] section and renaming it to [HFP] -- but that, too, made no difference.  I don't even know whether or not [HFP] accepts a MaxConnections/MaxConnected key.


--- On Sun, 11/9/08, Johan Hedberg <johan.hedberg@gmail.com> wrote:

> From: Johan Hedberg <johan.hedberg@gmail.com>
> Subject: Re: Possible to send audio to multiple bluetooth headsets at once?
> To: "BlueZ development" <linux-bluetooth@vger.kernel.org>
> Date: Sunday, November 9, 2008, 1:35 AM
> Hi Damon,
> 
> In theory what you're trying to do should be possible,
> though you  
> might run into bandwidth issues (and there's not much
> BlueZ can do to  
> help with that). However, you do need some configuration
> file changes  
> since the defaults are for one headset only. If you're
> trying to use  
> HSP/HFP add MaxConnections=2 to the [Headset] section in
> /etc/ 
> bluetooth/audio.conf. If you're trying to use A2DP add
> SBCSources=2 to  
> the [A2DP] section of the same file. You might also want to
> experiment  
> with forcing BlueZ to use the profile you want in the case
> of multi- 
> profile headsets. For HSP/HFP you need profile=voice in
> your .asoundrc  
> entries and for A2DP you need profile=hifi.
> 
> Johan
> 
> --
> To unsubscribe from this list: send the line
> "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html




      
