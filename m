Return-Path: <cyrus@holtmann.org>
Date: Sat, 28 Jun 2008 07:39:28 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <141182A5-019F-43A8-B772-AA194053CF83@gmail.com>
Message-ID: <alpine.LNX.1.10.0806280654450.811@nge2.ngu.pk>
References: <alpine.LNX.1.00.0806021644270.9709@nge2.ngu.pk>
	<141182A5-019F-43A8-B772-AA194053CF83@gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] bluez-3.22: hcid segfault
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


On Sun, 22 Jun 2008, Johan Hedberg wrote:

-> On Jun 3, 2008, at 0:56, jayjwa wrote:
-> > I researched the hcid segfault further. It seems to be in libaudio.so.
-> > These binaries were compiled with no optimization, debug symbols, and
-> > --enable-debug switch. Most of my libs have their symbols as well.
-> > 
-> > hcid[10625]: segfault at 10 ip b7c65586 sp bfe39700 error 6 in
-> > libaudio.so[b7c5b000+1e000]
-> 
-> I took a look at the code that the backtrace refers to and it has been
-> changed a little bit since 3.32. Could you try with 3.33 or even better with
-> CVS HEAD and see if the problem still exists?


bluez-utils-3.34
bluez-libs-3.34
dbus-1.2.1
linux-2.6.25.9

I had to remove the persistant info at /var/lib/bluetooth and make two tries, 
but then it does work, with a few error messages.

2008-06-28T06:47:18-04:00 vdrl kernel: Bluetooth: Core ver 2.11
2008-06-28T06:47:18-04:00 vdrl kernel: NET: Registered protocol family 31
2008-06-28T06:47:18-04:00 vdrl kernel: Bluetooth: HCI device and connection 
manager initialized
2008-06-28T06:47:18-04:00 vdrl kernel: Bluetooth: HCI socket layer initialized
2008-06-28T06:47:18-04:00 vdrl kernel: usb 3-2: New USB device found, 
idVendor=050d, idProduct=0121
2008-06-28T06:47:18-04:00 vdrl kernel: usb 3-2: New USB device strings: Mfr=1, 
Product=2, SerialNumber=0
2008-06-28T06:47:18-04:00 vdrl kernel: usb 3-2: Product: BELKIN BLUETOOTH USB 
ADAPTER CL. 1
2008-06-28T06:47:18-04:00 vdrl kernel: usb 3-2: Manufacturer: Broadcom Corp
2008-06-28T06:47:18-04:00 vdrl kernel: Bluetooth: HCI USB driver ver 2.9
2008-06-28T06:47:18-04:00 vdrl kernel: usbcore: registered new interface 
driver hci_usb
2008-06-28T06:47:30.087086-04:00 vdrl hcid[29690]: Bluetooth HCI daemon
2008-06-28T06:47:30.117071-04:00 vdrl hcid[29690]: Parsing 
/etc/bluetooth/main.conf failed: No such file or directory
2008-06-28T06:47:30.126023-04:00 vdrl hcid[29690]: Starting SDP server
2008-06-28T06:47:30-04:00 vdrl kernel: Bluetooth: L2CAP ver 2.9
2008-06-28T06:47:30-04:00 vdrl kernel: Bluetooth: L2CAP socket layer 
initialized
2008-06-28T06:47:30-04:00 vdrl kernel: Bluetooth: BNEP (Ethernet Emulation) 
ver 1.2
2008-06-28T06:47:30-04:00 vdrl kernel: Bluetooth: BNEP filters: protocol 
multicast
2008-06-28T06:47:30-04:00 vdrl kernel: Bridge firewalling registered
2008-06-28T06:47:30-04:00 vdrl kernel: pan0: Dropping NETIF_F_UFO since no 
NETIF_F_HW_CSUM feature.
2008-06-28T06:47:30.203716-04:00 vdrl hcid[29690]: bridge pan0 created
2008-06-28T06:47:30.203768-04:00 vdrl hcid[29690]: Registered manager 
path:/org/bluez/network
2008-06-28T06:47:30.219186-04:00 vdrl hcid[29690]: Registered server 
path:/org/bluez/network/nap
2008-06-28T06:47:30.227305-04:00 vdrl hcid[29690]: Registered server 
path:/org/bluez/network/gn
2008-06-28T06:47:30.235760-04:00 vdrl hcid[29690]: Registered server 
path:/org/bluez/network/panu
2008-06-28T06:47:30-04:00 vdrl kernel: Bluetooth: RFCOMM socket layer 
initialized
2008-06-28T06:47:30-04:00 vdrl kernel: Bluetooth: RFCOMM TTY layer initialized
2008-06-28T06:47:30-04:00 vdrl kernel: Bluetooth: RFCOMM ver 1.8
2008-06-28T06:47:30.258386-04:00 vdrl hcid[29690]: Registered manager 
path:/org/bluez/serial
2008-06-28T06:47:30.341767-04:00 vdrl hcid[29690]: Starting experimental 
netlink support
2008-06-28T06:47:30.341820-04:00 vdrl hcid[29690]: Failed to find Bluetooth 
netlink family
2008-06-28T06:47:30.341854-04:00 vdrl hcid[29690]: Can't init plugin 
/usr/lib/bluetooth/plugins/libnetlink.so
2008-06-28T06:47:30.354813-04:00 vdrl hcid[29690]: Registered input manager 
path:/org/bluez/input
2008-06-28T06:47:30.363906-04:00 vdrl hcid[29690]: Unix socket created: 17
2008-06-28T06:47:30.363955-04:00 vdrl hcid[29690]: Registered manager 
path:/org/bluez/audio
2008-06-28T06:47:30.382773-04:00 vdrl hcid[29690]: Loading device 
00:1A:45:01:F9:42 (headset )
2008-06-28T06:47:30.383807-04:00 vdrl hcid[29690]: HCI dev 0 registered
2008-06-28T06:47:30.393245-04:00 vdrl hcid[29690]: HCI dev 0 up
2008-06-28T06:47:30.393541-04:00 vdrl hcid[29690]: Device hci0 has been added
2008-06-28T06:47:30.399975-04:00 vdrl hcid[29690]: Starting security manager 0
2008-06-28T06:47:30.454606-04:00 vdrl hcid[29690]: Device hci0 has been 
activated
2008-06-28T06:50:14.468152-04:00 vdrl hcid[29690]: Default passkey agent 
(:1.1, /org/bluez/passkey_agent_29722) registered
2008-06-28T06:50:18.675424-04:00 vdrl hcid[29690]: Default authorization agent 
(:1.2, /org/bluez/auth_agent_29725) registered
2008-06-28T06:50:28.139157-04:00 vdrl hcid[29690]: link_key_request 
(sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)


No answer here ^^^^^^^^^^^^^^^^^

2008-06-28T06:53:01.092042-04:00 vdrl hcid[29690]: Audio API: received 
BT_GETCAPABILITIES_REQ
2008-06-28T06:53:05.042499-04:00 vdrl hcid[29690]: Audio API: sending 
BT_GETCAPABILITIES_RSP
2008-06-28T06:53:05.063284-04:00 vdrl hcid[29690]: Audio API: received 
BT_SETCONFIGURATION_REQ
2008-06-28T06:53:05.063333-04:00 vdrl hcid[29690]: config sco - device = 
00:1A:45:01:F9:42 access_mode = 2
2008-06-28T06:53:05.166825-04:00 vdrl hcid[29690]: link_key_request 
(sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
2008-06-28T06:53:05.218628-04:00 vdrl hcid[29690]: connect(): Connection 
refused (111)


...results in this here.


2008-06-28T06:53:05.218808-04:00 vdrl hcid[29690]: Audio API: sending 
BT_SETCONFIGURATION_RSP
2008-06-28T06:53:05.218843-04:00 vdrl hcid[29690]: Audio API: received 
BT_STREAMSTART_REQ
2008-06-28T06:53:05.218876-04:00 vdrl hcid[29690]: Audio API: sending 
BT_STREAMSTART_RSP
2008-06-28T06:53:05.218909-04:00 vdrl hcid[29690]: Audio API: sending 
BT_STREAMFD_IND
2008-06-28T06:53:05.218954-04:00 vdrl hcid[29690]: unix_sendmsg_fd: Bad file 
descriptor(9)
2008-06-28T06:53:05.218987-04:00 vdrl hcid[29690]: resume failed
2008-06-28T06:53:05.219020-04:00 vdrl hcid[29690]: Audio API: sending 
BT_STREAMSTART_RSP





>>From the hcid side with debugging:


hcid[29770]: Default passkey agent (:1.4, /org/bluez/passkey_agent_29801) 
registered
hcid[29770]: Default authorization agent (:1.5, /org/bluez/auth_agent_29803) 
registered
hcid[29770]: link_key_request (sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
hcid[29770]: HCIGETAUTHINFO failed (-1209832840)
hcid[29770]: kernel auth requirements = 0x00
hcid[29770]: stored link key type = 0x00


The only reference to HCIGETAUTHINFO I could find on the 'net was here:

http://www.ohloh.net/projects/bluez/commits?page=3

         Use strerror to show HCIGETAUTHINFO ioctl error

    by Johan Hedberg (Using name `jhedberg') on 2008-06-11 07:50 (4 days ago)



I killed hcid and removed the persistant info at /var/lib/bluetooth/(bt_address)
and now althought I still see the HCIGETAUTHINFO error, it does get further:

hcid[29891]: Default passkey agent (:1.7, /org/bluez/passkey_agent_29903) 
registered
hcid[29891]: Default authorization agent (:1.8, /org/bluez/auth_agent_29904) 
registered
hcid[29891]: link_key_request (sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
hcid[29891]: HCIGETAUTHINFO failed (-1210684808)
hcid[29891]: kernel auth requirements = 0x00
hcid[29891]: pin_code_request (sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
hcid[29891]: Calling PasskeyAgent.Request: name=:1.7, 
path=/org/bluez/passkey_agent_29903
hcid[29891]: hcid_dbus_new_auth_request
hcid[29891]: link_key_notify (sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
hcid[29891]: hcid_dbus_bonding_process_complete: status=00
hcid[29891]: adapter_get_device(00:1A:45:01:F9:42)
hcid[29891]: adapter_create_device(00:1A:45:01:F9:42)
hcid[29891]: Creating device /hci0/dev_00_1A_45_01_F9_42
hcid[29891]: hcid_dbus_bonding_process_complete: removing temporary flag
hcid[29891]: Got a svc srch attr req
hcid[29891]: Seq type : 53
hcid[29891]: Data size : 5
hcid[29891]: Data type: 0x1a
hcid[29891]: No of elements : 1
hcid[29891]: Bytes scanned: 7
hcid[29891]: Max Attr expected: 38
hcid[29891]: Seq type : 53
hcid[29891]: Data size : 3
hcid[29891]: Data type: 0x09
hcid[29891]: No of elements : 1
hcid[29891]: Continuation State size : 0
hcid[29891]: Entries in attr seq : 1
hcid[29891]: AttrDataType : 9
hcid[29891]: Response count : 1
hcid[29891]: Local PDU size : 19
hcid[29891]: Net PDU size : 21
hcid[29891]: Sending rsp. status 0
hcid[29891]: Bytes Sent : 29
hcid[29891]: link_key_request (sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
hcid[29891]: HCIGETAUTHINFO failed (-1210684808)
hcid[29891]: kernel auth requirements = 0x00
hcid[29891]: stored link key type = 0x00
hcid[29891]: Selecting default device
hcid[29891]: authorize request was forwarded
hcid[29891]: State changed /org/bluez/audio/device0: 
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
hcid[29891]: authorize reply
hcid[29891]: Accepted headset connection from 00:1A:45:01:F9:42 for 
/org/bluez/audio/device0
hcid[29891]: State changed /org/bluez/audio/device0: 
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
hcid[29891]: auth_agent_reply: returning
hcid[29891]: link_key_notify (sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
hcid[29891]: hcid_dbus_bonding_process_complete: status=00
hcid[29891]: hcid_dbus_bonding_process_complete: no pending auth request
hcid[29891]: Audio service discovery completed with success
hcid[29891]: Found Hansfree record
hcid[29891]: Discovered Handsfree service on RFCOMM channel 1
hcid[29891]: Found Headset record
hcid[29891]: Got a svc srch attr req
hcid[29891]: Seq type : 53
hcid[29891]: Data size : 5
hcid[29891]: Data type: 0x1a
hcid[29891]: No of elements : 1
hcid[29891]: Bytes scanned: 7
hcid[29891]: Max Attr expected: 38
hcid[29891]: Seq type : 53
hcid[29891]: Data size : 3
hcid[29891]: Data type: 0x09
hcid[29891]: No of elements : 1
hcid[29891]: Continuation State size : 0
hcid[29891]: Entries in attr seq : 1
hcid[29891]: AttrDataType : 9
hcid[29891]: Response count : 1
hcid[29891]: Local PDU size : 15
hcid[29891]: Net PDU size : 17
hcid[29891]: Sending rsp. status 0
hcid[29891]: Bytes Sent : 25
hcid[29891]: Received AT+BRSF=26
hcid[29891]: Received AT+CIND=?
hcid[29891]: Received AT+CIND?
hcid[29891]: Received AT+CMER=3, 0, 0, 1
hcid[29891]: Received AT+BTRH?
hcid[29891]: Badly formated or unrecognized command: AT+BTRH?
hcid[29891]: Received AT+VGS=09
hcid[29891]: Received AT+VGM=15


and the connection is there:

Connections:
         > ACL 00:1A:45:01:F9:42 handle 11 state 1 lm MASTER AUTH ENCRYPT 
SECURE

hcid[29891]: Accepted new client connection on unix socket (fd=23)
hcid[29891]: Audio API: received BT_GETCAPABILITIES_REQ
hcid[29891]: Audio API: sending BT_GETCAPABILITIES_RSP
hcid[29891]: Audio API: received BT_SETCONFIGURATION_REQ
hcid[29891]: config sco - device = 00:1A:45:01:F9:42 access_mode = 2
hcid[29891]: State changed /org/bluez/audio/device0: HEADSET_STATE_CONNECTED 
-> HEADSET_STATE_PLAY_IN_PROGRESS
hcid[29891]: SCO socket opened for headset /org/bluez/audio/device0
hcid[29891]: SCO fd=24
hcid[29891]: Audio API: sending BT_SETCONFIGURATION_RSP
hcid[29891]: State changed /org/bluez/audio/device0: 
HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
hcid[29891]: Audio API: received BT_STREAMSTART_REQ
hcid[29891]: Audio API: sending BT_STREAMSTART_RSP
hcid[29891]: Audio API: sending BT_STREAMFD_IND
hcid[29891]: Audio API: received BT_STREAMSTART_REQ
hcid[29891]: Audio API: sending BT_STREAMSTART_RSP
hcid[29891]: Audio API: sending BT_STREAMFD_IND
hcid[29891]: Received AT+VGM=15
hcid[29891]: Unix client disconnected (fd=23)
hcid[29891]: State changed /org/bluez/audio/device0: HEADSET_STATE_PLAYING -> 
HEADSET_STATE_CONNECTED


No ka-boom so it looks OK. As a side note, I still need the kernel sco patch 
for a device such as:

Requesting information ...
         BD Address:  00:1A:45:01:F9:42
         OUI Company: GN Netcom as (00-1A-45)
         Device Name: Jabra BT135
         LMP Version: 2.0 (0x3) LMP Subversion: 0xbfa
         Manufacturer: Cambridge Silicon Radio (10)
         Features: 0xfc 0xfe 0x0b 0x00 0x08 0x08 0x00 0x00
                 <encryption> <slot offset> <timing accuracy> <role switch>
                 <hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>
                 <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
                 <paging scheme> <transparent SCO> <AFH cap. slave>
                 <AFH cap. master>




-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
