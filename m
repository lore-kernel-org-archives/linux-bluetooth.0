Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Aug 2008 20:18:28 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: bluez-users@lists.sourceforge.net
Message-ID: <alpine.LNX.1.10.0808181917120.32359@nge2.ngu.pk>
MIME-Version: 1.0
Subject: [Bluez-users] bluez-4.1: Pairing Broken?
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



I changed bluez-* to the 4.x branch. Everything went pretty smooth, despite 
massive changes. After about 4 hours, I had everything in place. I go to test 
the first connection/device, and ...


share/dbus-1 # passkey-agent --default 0000 00:1A:45:01:F9:42 &

Can't register passkey agent
Method "RegisterDefaultPasskeyAgent" with signature "s" on interface
"org.bluez.Security" doesn't exist

[1] 4173
[1]  + exit 1     passkey-agent --default 0000 00:1A:45:01:F9:42



bluez-4.1/src # Can't register authorization agent

Method "RegisterDefaultAuthorizationAgent" with signature "s" on interface
"org.bluez.Security" doesn't exist


[1]  + exit 1     auth-agent




Neither passkey-agent nor auth-agent work anymore. I do not have Gnome nor KDE 
due to resource/size limits. The bluez.org website seems to indicate that 
bluez-gnome no longer works, even if I did. I tried the simple-agent script in 
the 4.1 source, and it at least runs, but doesn't do anything for pairing. It 
appears to try to ask for PIN, but requires an active terminal of its own else 
the tty input gets suspended. So it must run in the foreground - which stops 
you from entering any commands to the command line in the first place. I 
supposed I could leave tty2 open, just to pair bluetooth stuff, but even then, 
the script never actually succeeded in pairing:


bluez-4.1/src # ./simple-agent

Agent registered
RequestPinCode (/org/bluez/hci0/dev_00_1A_45_01_F9_42)
Enter PIN Code: 0000


Yes? :-\

media/ogg # hcitool con

Connections:
         > ACL 00:1A:45:01:F9:42 handle 11 state 8 lm MASTER AUTH ENCRYPT SECURE



bluetoothd[4803]: Agent registered for hci0 at :1.19:/test/agent
bluetoothd[4803]: link_key_request (sba=00:0A:3A:7C:5C:74, 
dba=00:1A:45:01:F9:42)
bluetoothd[4803]: kernel auth requirements = 0x00
bluetoothd[4803]: pin_code_request (sba=00:0A:3A:7C:5C:74, 
dba=00:1A:45:01:F9:42)
bluetoothd[4803]: adapter_create_device(00:1A:45:01:F9:42)
bluetoothd[4803]: Creating device /org/bluez/hci0/dev_00_1A_45_01_F9_42
bluetoothd[4803]: hcid_dbus_new_auth_request
bluetoothd[4803]: link_key_notify (sba=00:0A:3A:7C:5C:74, 
dba=00:1A:45:01:F9:42)
bluetoothd[4803]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[4803]: adapter_get_device(00:1A:45:01:F9:42)
bluetoothd[4803]: hcid_dbus_bonding_process_complete: removing temporary flag
bluetoothd[4803]: Got a svc srch attr req
bluetoothd[4803]: Seq type : 53
bluetoothd[4803]: Data size : 5
bluetoothd[4803]: Data type: 0x1a
bluetoothd[4803]: No of elements : 1
bluetoothd[4803]: Bytes scanned: 7
bluetoothd[4803]: Max Attr expected: 38
bluetoothd[4803]: Seq type : 53
bluetoothd[4803]: Data size : 3
bluetoothd[4803]: Data type: 0x09
bluetoothd[4803]: No of elements : 1
bluetoothd[4803]: Continuation State size : 0
bluetoothd[4803]: Entries in attr seq : 1
bluetoothd[4803]: AttrDataType : 9
bluetoothd[4803]: Response count : 1
bluetoothd[4803]: Local PDU size : 19
bluetoothd[4803]: Net PDU size : 21
bluetoothd[4803]: Sending rsp. status 0
bluetoothd[4803]: Bytes Sent : 29
bluetoothd[4803]: link_key_request (sba=00:0A:3A:7C:5C:74, 
dba=00:1A:45:01:F9:42)
bluetoothd[4803]: kernel auth requirements = 0x00
bluetoothd[4803]: stored link key type = 0x00
bluetoothd[4803]: link_key_notify (sba=00:0A:3A:7C:5C:74, 
dba=00:1A:45:01:F9:42)
bluetoothd[4803]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[4803]: hcid_dbus_bonding_process_complete: no pending auth request
bluetoothd[4803]: Accepted new client connection on unix socket (fd=22)
bluetoothd[4803]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[4803]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[4803]: Unix client disconnected (fd=22)
bluetoothd[4803]: link_key_request (sba=00:0A:3A:7C:5C:74, 
dba=00:1A:45:01:F9:42)
bluetoothd[4803]: kernel auth requirements = 0x00
bluetoothd[4803]: stored link key type = 0x00
bluetoothd[4803]: Got a svc srch attr req
bluetoothd[4803]: Seq type : 53
bluetoothd[4803]: Data size : 5
bluetoothd[4803]: Data type: 0x1a
bluetoothd[4803]: No of elements : 1
bluetoothd[4803]: Bytes scanned: 7
bluetoothd[4803]: Max Attr expected: 38
bluetoothd[4803]: Seq type : 53
bluetoothd[4803]: Data size : 3
bluetoothd[4803]: Data type: 0x09
bluetoothd[4803]: No of elements : 1
bluetoothd[4803]: Continuation State size : 0
bluetoothd[4803]: Entries in attr seq : 1
bluetoothd[4803]: AttrDataType : 9
bluetoothd[4803]: Response count : 1
bluetoothd[4803]: Local PDU size : 19
bluetoothd[4803]: Net PDU size : 21
bluetoothd[4803]: Sending rsp. status 0
bluetoothd[4803]: Bytes Sent : 29
bluetoothd[4803]: link_key_notify (sba=00:0A:3A:7C:5C:74, 
dba=00:1A:45:01:F9:42)
bluetoothd[4803]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[4803]: hcid_dbus_bonding_process_complete: no pending auth request
bluetoothd[4803]: Accepted new client connection on unix socket (fd=22)
bluetoothd[4803]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[4803]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[4803]: Unix client disconnected (fd=22)



No! :-(

media/ogg # sox -t ogg ./file.ogg -t alsa pcm.bluetooth

ALSA lib pcm_bluetooth.c:1619:(bluetooth_init) BT_GETCAPABILITIES failed : 
Input/output error(5)
sox soxio: Can't open output file `pcm.bluetooth': cannot open audio device

-2- root@vdrl media/ogg # hcitool con
Connections:


Now all I can get are the expected authentication error type messages:


ALSA lib pcm_bluetooth.c:1619:(bluetooth_init) BT_GETCAPABILITIES failed :
Input/output error(5)
sox soxio: Can't open output file `pcm.bluetooth': cannot open audio device

Nothing too exciting in the syslog -

2008-08-18T19:55:01.164898-04:00 vdrl bluetoothd[4803]: link_key_request 
(sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
2008-08-18T19:55:01.338803-04:00 vdrl bluetoothd[4803]: pin_code_request 
(sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
2008-08-18T19:55:07.390741-04:00 vdrl bluetoothd[4803]: link_key_notify 
(sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
2008-08-18T19:55:09.316338-04:00 vdrl bluetoothd[4803]: link_key_request 
(sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
2008-08-18T19:55:09.968424-04:00 vdrl bluetoothd[4803]: link_key_notify 
(sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
2008-08-18T19:55:39.174700-04:00 vdrl bluetoothd[4803]: Audio API: received 
BT_GETCAPABILITIES_REQ
2008-08-18T19:55:39.174842-04:00 vdrl bluetoothd[4803]: Audio API: sending 
BT_GETCAPABILITIES_RSP
2008-08-18T19:55:49.444579-04:00 vdrl bluetoothd[4803]: link_key_request 
(sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
2008-08-18T19:55:50.550584-04:00 vdrl bluetoothd[4803]: link_key_notify 
(sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
2008-08-18T19:55:57.245902-04:00 vdrl bluetoothd[4803]: Audio API: received 
BT_GETCAPABILITIES_REQ
2008-08-18T19:55:57.246018-04:00 vdrl bluetoothd[4803]: Audio API: sending 
BT_GETCAPABILITIES_RSP



The device is there, although it lists as "Paired = 1", it shows nothing with 
'hcitool con' when it used to show the device connected and 
secured/encrypt/etc., before it played.


./list-devices
[ /org/bluez/hci0 ]
     DiscoverableTimeout = 0
     PeriodicDiscovery = 0
     Mode = connectable
     Address = 00:0A:3A:7C:5C:74
     [ /org/bluez/hci0/dev_00_1A_45_01_F9_42 ]
         Name = Jabra BT135
         Paired = 1
         Adapter = /org/bluez/hci0
         Alias = Jabra BT135
         Connected = 0
         UUIDs =
         Address = 00:1A:45:01:F9:42
         Class = 0x200404
         Trusted = 0



Trying to turn off auth didn't work either:

hciconfig hci0 noauth

I got similar results with a phone too. Since every device I have asks to 
pair, in effect, this makes bluez-4.x unusable. So, how is everyone else 
solving this problem?




-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
