Return-Path: <cyrus@holtmann.org>
From: SA <sa@claborn.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Tue, 5 Feb 2008 15:42:11 -0600
References: <200801242256.33910.sa@claborn.net>
	<200802051233.33098.sa@claborn.net>
	<d89ddf300802051041j76801e4n5214d01bf01b48e3@mail.gmail.com>
In-Reply-To: <d89ddf300802051041j76801e4n5214d01bf01b48e3@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200802051542.11330.sa@claborn.net>
Subject: Re: [Bluez-users] How to setup a headset as an audio device?
	Getting "Device busy" errors
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Tuesday 05 February 2008 12:41:55 Brad Midgley wrote:
> SA
>
> edit /etc/bluetooth/audio.service and make sure you've enabled
> autostart. restart bluetooth if you changed the file. I'll make sure
> this is mentioned in the wiki.
>
> Brad

Thanks Brad.

Ok so now I removed the device pairing and I had in the KDE "Paired/Trusted 
Devices" manager and edited /etc/bluetooth/audio.service so that it now 
contains this:

[Bluetooth Service]
Identifier=audio
Name=Audio service
Description=Bluetooth Audio service
Autostart=true


I got the "Autostart=true" from searching the wiki, it showed up on 3 pages 
about devices.

I restarted /etc/init.d/bluetooth, and then restarted kbluetooth, paired with 
the device again, it showed as connected for a little while and the logs 
in /var/log/messages are a little better but still it is not working. Here 
is /var/log/messages output:

Feb  5 14:31:49 citrine hcid[27467]: Stopping SDP server
Feb  5 14:31:49 citrine input[27472]: Unregistered manager path
Feb  5 14:31:49 citrine input[27472]: Exit
Feb  5 14:31:49 citrine hcid[27467]: Unregister path: /org/bluez/hci0
Feb  5 14:31:49 citrine hcid[27467]: Unregister path: /org/bluez
Feb  5 14:31:49 citrine hcid[27467]: Shutting down local server
Feb  5 14:31:49 citrine hcid[27467]: Exit
Feb  5 14:31:56 citrine hcid[3221]: Bluetooth HCI daemon
Feb  5 14:31:56 citrine hcid[3221]: HCI dev 0 registered
Feb  5 14:31:56 citrine hcid[3221]: HCI dev 0 already up
Feb  5 14:31:56 citrine hcid[3221]: Device hci0 has been added
Feb  5 14:31:56 citrine hcid[3221]: Starting security manager 0
Feb  5 14:31:56 citrine hcid[3221]: Device hci0 has been activated
Feb  5 14:31:56 citrine hcid[3221]: Starting SDP server
Feb  5 14:31:56 citrine hcid[3221]: Created local server at 
unix:abstract=/var/run/dbus-mae3pi2H4O,guid=4669817f7f51de8b3db2c00047a8c7bc
Feb  5 14:31:56 citrine audio[3234]: Bluetooth Audio daemon
Feb  5 14:31:56 citrine 
audio[3234]: /etc/bluetooth/audio.conf: /etc/bluetooth/audio.conf: No such 
file or directory
Feb  5 14:31:56 citrine syslog-ng[2307]: last message repeated 3 times
Feb  5 14:31:56 citrine audio[3234]: Config options: DisableHFP=true, 
SCORouting=HCI, SourceCount=1
Feb  5 14:31:56 citrine audio[3234]: Can't bind unix socket: Address already 
in use (98)
Feb  5 14:31:56 citrine audio[3234]: Unable to setup unix socket
Feb  5 14:31:56 citrine input[3233]: Bluetooth Input daemon
Feb  5 14:31:56 citrine input[3233]: Registered input manager 
path:/org/bluez/input
Feb  5 14:31:56 citrine hcid[3221]: Sending GetConnectionUnixProcessID failed: 
Could not get PID of name ':1.1951': no such name
Feb  5 14:31:56 citrine hcid[3221]: Could not get PID of :1.1951


Feb  5 14:33:54 citrine hcid[3221]: Default passkey agent 
(:1.1953, /org/kde/kbluetooth_1234) registered
Feb  5 14:33:54 citrine hcid[3221]: Default authorization agent 
(:1.1953, /org/kde/kbluetooth_auth_1234) registered
Feb  5 14:34:19 citrine input[3233]: /org/bluez/input: 
org.bluez.input.Manager.ListDevices()
Feb  5 14:34:19 citrine input[3233]: /org/bluez/input: 
org.bluez.input.Manager.ListDevices()
Feb  5 14:34:55 citrine input[3233]: /org/bluez/input: 
org.bluez.input.Manager.CreateDevice()
Feb  5 14:34:56 citrine input[3233]: Created input 
device: /org/bluez/input/wearable0
Feb  5 14:34:58 citrine input[3233]: /org/bluez/input/wearable0: 
org.bluez.input.Device.Connect()
Feb  5 14:34:58 citrine input[3233]: RFCOMM connection in progress: 
00:0D:3C:6F:0E:89 channel:2
Feb  5 14:34:58 citrine hcid[3221]: link_key_request (sba=00:0D:88:9E:DF:D6, 
dba=00:0D:3C:6F:0E:89)
Feb  5 14:34:58 citrine hcid[3221]: pin_code_request (sba=00:0D:88:9E:DF:D6, 
dba=00:0D:3C:6F:0E:89)
Feb  5 14:35:05 citrine hcid[3221]: link_key_notify (sba=00:0D:88:9E:DF:D6, 
dba=00:0D:3C:6F:0E:89)
Feb  5 14:35:06 citrine input[3233]: Can't open input device: No such file or 
directory (2)

Feb  5 14:35:09 citrine audio[2248]: Accepted new client connection on unix 
socket (fd=8)
Feb  5 14:35:09 citrine audio[2248]: Package PKT_TYPE_CFG_REQ:0
Feb  5 14:35:09 citrine audio[2248]: State changed /org/bluez/audio/device0: 
DISCONNECTED -> CONNECTING
Feb  5 14:35:10 citrine audio[2248]: get_handles_reply: Unable to get handle 
array from reply
Feb  5 14:35:10 citrine audio[2248]: State changed /org/bluez/audio/device0: 
CONNECTING -> DISCONNECTED
Feb  5 14:35:10 citrine audio[2248]: Unix client disconnected (fd=8)


Feb  5 14:35:12 citrine audio[2248]: Accepted new client connection on unix 
socket (fd=8)
Feb  5 14:35:12 citrine audio[2248]: Package PKT_TYPE_CFG_REQ:0
Feb  5 14:35:12 citrine audio[2248]: State changed /org/bluez/audio/device0: 
DISCONNECTED -> CONNECTING
Feb  5 14:35:12 citrine audio[2248]: get_handles_reply: Unable to get handle 
array from reply
Feb  5 14:35:12 citrine audio[2248]: State changed /org/bluez/audio/device0: 
CONNECTING -> DISCONNECTED
Feb  5 14:35:12 citrine audio[2248]: Unix client disconnected (fd=8)
Feb  5 14:35:21 citrine audio[2248]: Accepted new client connection on unix 
socket (fd=8)
Feb  5 14:35:21 citrine audio[2248]: Package PKT_TYPE_CFG_REQ:0
Feb  5 14:35:21 citrine audio[2248]: State changed /org/bluez/audio/device0: 
DISCONNECTED -> CONNECTING
Feb  5 14:35:22 citrine audio[2248]: get_handles_reply: Unable to get handle 
array from reply
Feb  5 14:35:22 citrine audio[2248]: State changed /org/bluez/audio/device0: 
CONNECTING -> DISCONNECTED
Feb  5 14:35:22 citrine audio[2248]: Unix client disconnected (fd=8)
Feb  5 14:35:24 citrine audio[2248]: Accepted new client connection on unix 
socket (fd=8)
Feb  5 14:35:24 citrine audio[2248]: Package PKT_TYPE_CFG_REQ:0
Feb  5 14:35:24 citrine audio[2248]: State changed /org/bluez/audio/device0: 
DISCONNECTED -> CONNECTING
Feb  5 14:35:24 citrine audio[2248]: get_handles_reply: Unable to get handle 
array from reply
Feb  5 14:35:24 citrine audio[2248]: State changed /org/bluez/audio/device0: 
CONNECTING -> DISCONNECTED
Feb  5 14:35:24 citrine audio[2248]: Unix client disconnected (fd=8)

Feb  5 14:36:10 citrine input[3233]: /org/bluez/input: 
org.bluez.input.Manager.ListDevices()
Feb  5 14:36:10 citrine input[3233]: /org/bluez/input/wearable0: 
org.bluez.input.Device.IsConnected()
Feb  5 14:36:10 citrine input[3233]: /org/bluez/input/wearable0: 
org.bluez.input.Device.GetAddress()
Feb  5 14:36:10 citrine input[3233]: /org/bluez/input/wearable0: 
org.bluez.input.Device.IsConnected()
Feb  5 14:37:07 citrine audio[2248]: Accepted new client connection on unix 
socket (fd=8)
Feb  5 14:37:07 citrine audio[2248]: Package PKT_TYPE_CFG_REQ:0
Feb  5 14:37:07 citrine audio[2248]: State changed /org/bluez/audio/device0: 
DISCONNECTED -> CONNECTING
Feb  5 14:37:11 citrine audio[2248]: get_handles_reply: Unable to get handle 
array from reply
Feb  5 14:37:11 citrine audio[2248]: State changed /org/bluez/audio/device0: 
CONNECTING -> DISCONNECTED
Feb  5 14:37:11 citrine audio[2248]: Unix client disconnected (fd=8)


aplay still gives errors:


:~> aplay -v -D bluetooth /work/tmp/hcikfs.wav
ALSA lib pcm_bluetooth.c:1108:(bluetooth_cfg) Error 22 while configuring 
device
aplay: main:546: audio open error: Invalid argument


I tried it a second time too.

Someone suggested I add this to my .asoundrc:


pcm.my_bt_convert {
     type plug
     slave {
        pcm "bluetooth"
     }
}



And use:

aplay -v -D my_bt_convert /work/tmp/hcikfs.wav


But I get the same errors:

==> messages <==
Feb  5 15:36:05 citrine input[3437]: /org/bluez/input: 
org.bluez.input.Manager.ListDevices()
Feb  5 15:36:05 citrine input[3437]: /org/bluez/input: 
org.bluez.input.Manager.ListDevices()
Feb  5 15:36:27 citrine input[3437]: /org/bluez/input: 
org.bluez.input.Manager.ListDevices()
Feb  5 15:36:42 citrine syslog-ng[2307]: last message repeated 3 times
Feb  5 15:36:42 citrine input[3437]: /org/bluez/input: 
org.bluez.input.Manager.CreateDevice()
Feb  5 15:36:43 citrine input[3437]: Created input 
device: /org/bluez/input/wearable0
Feb  5 15:36:44 citrine input[3437]: /org/bluez/input/wearable0: 
org.bluez.input.Device.Connect()
Feb  5 15:36:44 citrine input[3437]: RFCOMM connection in progress: 
00:0D:3C:6F:0E:89 channel:2
Feb  5 15:36:44 citrine hcid[3433]: link_key_request (sba=00:0D:88:9E:DF:D6, 
dba=00:0D:3C:6F:0E:89)
Feb  5 15:36:44 citrine hcid[3433]: pin_code_request (sba=00:0D:88:9E:DF:D6, 
dba=00:0D:3C:6F:0E:89)
Feb  5 15:36:48 citrine hcid[3433]: link_key_notify (sba=00:0D:88:9E:DF:D6, 
dba=00:0D:3C:6F:0E:89)
Feb  5 15:36:48 citrine input[3437]: Can't open input device: No such file or 
directory (2)

==> warn <==
Feb  5 15:36:48 citrine input[3437]: Can't open input device: No such file or 
directory (2)

==> messages <==
Feb  5 15:37:00 citrine input[3437]: /org/bluez/input: 
org.bluez.input.Manager.ListDevices()
Feb  5 15:37:00 citrine input[3437]: /org/bluez/input/wearable0: 
org.bluez.input.Device.IsConnected()
Feb  5 15:37:00 citrine input[3437]: /org/bluez/input/wearable0: 
org.bluez.input.Device.GetAddress()
Feb  5 15:37:00 citrine input[3437]: /org/bluez/input/wearable0: 
org.bluez.input.Device.IsConnected()
Feb  5 15:37:00 citrine input[3437]: /org/bluez/input: 
org.bluez.input.Manager.ListDevices()
Feb  5 15:37:00 citrine input[3437]: /org/bluez/input/wearable0: 
org.bluez.input.Device.GetAddress()
Feb  5 15:37:00 citrine input[3437]: /org/bluez/input/wearable0: 
org.bluez.input.Device.Connect()
Feb  5 15:37:00 citrine input[3437]: RFCOMM connection in progress: 
00:0D:3C:6F:0E:89 channel:2
Feb  5 15:37:01 citrine hcid[3433]: link_key_request (sba=00:0D:88:9E:DF:D6, 
dba=00:0D:3C:6F:0E:89)
Feb  5 15:37:01 citrine input[3437]: Can't open input device: No such file or 
directory (2)
Feb  5 15:37:02 citrine audio[3438]: Accepted new client connection on unix 
socket (fd=8)
Feb  5 15:37:02 citrine audio[3438]: Package PKT_TYPE_CFG_REQ:0
Feb  5 15:37:02 citrine audio[3438]: Got path /org/bluez/hci0 for adapter with 
address 00:0D:88:9E:DF:D6
Feb  5 15:37:02 citrine audio[3438]: Audio service discovery completed with 
success
Feb  5 15:37:02 citrine audio[3438]: Selecting default device
Feb  5 15:37:02 citrine audio[3438]: No known services for device
Feb  5 15:37:02 citrine audio[3438]: Unix client disconnected (fd=8)

==> warn <==
Feb  5 15:36:48 citrine input[3437]: Can't open input device: No such file or 
directory (2)
Feb  5 15:37:02 citrine audio[3438]: No known services for device



-- 

----------------------
System Administrator - Cedar Creek Software
http://www.cedarcreeksoftware.com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
