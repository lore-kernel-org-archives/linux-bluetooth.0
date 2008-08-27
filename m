Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Aug 2008 19:27:37 +0600
From: "Murat D. Kadirov" <banderols@gmail.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20080827132737.GA5484@darkstar>
Mime-Version: 1.0
Subject: [Bluez-users] Does not work BT headset
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

Subj. I want to use my Jabra BT-125I with VoIP. I have
kernel 2.6.25.16
bluez-libs-3.26
bluez-utils-3.26

root@darkstar:~# hciconfig -a
hci0:	Type: USB
BD Address: 00:02:5B:0B:62:DC ACL MTU: 310:10 SCO MTU: 64:8
UP RUNNING PSCAN ISCAN 
RX bytes:6905 acl:115 sco:0 events:243 errors:0
TX bytes:3023 acl:102 sco:0 commands:80 errors:0
Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
Link policy: RSWITCH HOLD SNIFF PARK 
Link mode: SLAVE ACCEPT 
Name: 'BlueZ (0)'
Class: 0x000100
Service Classes: Unspecified
Device Class: Computer, Uncategorized
HCI Ver: 2.0 (0x3) HCI Rev: 0xc5c LMP Ver: 2.0 (0x3) LMP Subver: 0xc5c
Manufacturer: Cambridge Silicon Radio (10)

murat[~]$ cat .asoundrc 
pcm.bluetooth {
   type bluetooth
   device 00:16:8F:DA:83:75
}

root@darkstar:~# cat /etc/bluetooth/passkeys/default
0000

/etc/rc.d/rc.bluetooth start

in /var/log/message:

Aug 27 19:08:09 darkstar hcid[5728]: Bluetooth HCI daemon
Aug 27 19:08:09 darkstar sdpd[5730]: Bluetooth SDP daemon
Aug 27 19:08:09 darkstar sdpd[5730]: Starting SDP server
Aug 27 19:08:09 darkstar hcid[5728]: HCI dev 0 registered
Aug 27 19:08:09 darkstar hcid[5728]: HCI dev 0 already up
Aug 27 19:08:09 darkstar hcid[5728]: Device hci0 has been added
Aug 27 19:08:09 darkstar hcid[5728]: Starting security manager 0
Aug 27 19:08:10 darkstar hcid[5728]: Device hci0 has been activated
Aug 27 19:08:10 darkstar hcid[5728]: Created local server at
unix:abstract=/var/run/dbus-PGjXVjD9xD,guid=daeabde0d6b435052d3bea3e48b551ba
Aug 27 19:08:10 darkstar input[5740]: Bluetooth Input daemon
Aug 27 19:08:10 darkstar audio[5741]: Bluetooth Audio daemon
Aug 27 19:08:10 darkstar input[5740]: Registered input manager
path:/org/bluez/input
Aug 27 19:08:10 darkstar audio[5741]: Unix socket created: 5
Aug 27 19:08:10 darkstar hcid[5728]: Default passkey agent (:1.43,
/org/bluez/passkey_agent_5737) registered
Aug 27 19:08:10 darkstar audio[5741]: Registered manager
path:/org/bluez/audio
Aug 27 19:08:10 darkstar audio[5741]: Loading device 00:16:8F:DA:83:75
(headset )
Aug 27 19:08:10 darkstar audio[5741]: Setting 00:16:8F:DA:83:75 as
default device

in /var/log/debug:

Aug 27 19:08:10 darkstar audio[5741]: audio.conf:
/etc/bluetooth/audio.conf: key Enable not found
Aug 27 19:08:10 darkstar audio[5741]: audio.conf:
/etc/bluetooth/audio.conf: key Disable not found
Aug 27 19:08:10 darkstar audio[5741]: add_service_record: got record id
0x10000
Aug 27 19:08:10 darkstar audio[5741]: audio.conf:
/etc/bluetooth/audio.conf: key Disable not found
Aug 27 19:08:10 darkstar audio[5741]: audio.conf:
/etc/bluetooth/audio.conf: group A2DP not found
Aug 27 19:08:10 darkstar last message repeated 3 times
Aug 27 19:08:10 darkstar audio[5741]: SEP 0x8069130 registered: type:0
codec:0 seid:1
Aug 27 19:08:10 darkstar audio[5741]: add_service_record: got record id
0x10001
Aug 27 19:08:10 darkstar audio[5741]: add_service_record: got record id
0x10002
Aug 27 19:08:10 darkstar audio[5741]: add_service_record: got record id
0x10003
Aug 27 19:08:10 darkstar audio[5741]: Got path /org/bluez/hci0 for
adapter with address 00:02:5B:0B:62:DC
Aug 27 19:08:10 darkstar audio[5741]: Selecting default device

When I connect headset and run mplayer -ao alsa:device=bluetooth track_01.mp3
Very silent whistle is audible.

in /var/log/messages:

Aug 27 19:12:12 darkstar hcid[5728]: link_key_request
(sba=00:02:5B:0B:62:DC, dba=00:16:8F:DA:83:75)
Aug 27 19:12:13 darkstar hcid[5728]: link_key_notify
(sba=00:02:5B:0B:62:DC, dba=00:16:8F:DA:83:75)
Aug 27 19:14:09 darkstar audio[5741]: Audio API: received
BT_GETCAPABILITIES_REQ
Aug 27 19:14:09 darkstar audio[5741]: Audio API: sending
BT_GETCAPABILITIES_RSP
Aug 27 19:14:09 darkstar audio[5741]: Audio API: received
BT_SETCONFIGURATION_REQ
Aug 27 19:14:09 darkstar audio[5741]: config sco - device =
00:16:8F:DA:83:75 access_mode = 2
Aug 27 19:14:10 darkstar hcid[5728]: link_key_request
(sba=00:02:5B:0B:62:DC, dba=00:16:8F:DA:83:75)
Aug 27 19:14:51 darkstar audio[5741]: Audio API: sending
BT_SETCONFIGURATION_RSP

in /var/log/syslog

Aug 27 19:12:13 darkstar audio[5741]: Access denied: Authorization agent
does not exist
Aug 27 19:14:51 darkstar audio[5741]: connect(): Connection timed out
(110)
Aug 27 19:14:51 darkstar audio[5741]: config failed

in /var/log/debug

Aug 27 19:12:13 darkstar audio[5741]: Requesting authorization for
device 00:16:8F:DA:83:75, UUID 00001112-0000-1000-8000-00805F9B34FB
Aug 27 19:12:13 darkstar audio[5741]: State changed
/org/bluez/audio/device0: HEADSET_STATE_DISCONNECTED ->
HEADSET_STATE_CONNECT_IN_PROGRESS
Aug 27 19:12:13 darkstar audio[5741]: State changed
/org/bluez/audio/device0: HEADSET_STATE_CONNECT_IN_PROGRESS ->
HEADSET_STATE_DISCONNECTED
Aug 27 19:14:09 darkstar audio[5741]: Accepted new client connection on
unix socket (fd=9)
Aug 27 19:14:09 darkstar audio[5741]: State changed
/org/bluez/audio/device0: HEADSET_STATE_DISCONNECTED ->
HEADSET_STATE_CONNECT_IN_PROGRESS
Aug 27 19:14:10 darkstar audio[5741]: /org/bluez/audio/device0:
Connecting to 00:16:8F:DA:83:75 channel 2

What have I made not correctly? I have goggled very much, but did not
find anything helpful. Anyone have tips that can help?
Thanks.

-- 
Murat D. Kadirov

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
