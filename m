Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: jamal <hadi@cyberus.ca>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-TUN6U/yt+LgqMxlLDDuA"
Message-Id: <1134131269.5714.32.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] Motorola HS801 headset question
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 09 Dec 2005 07:27:49 -0500


--=-TUN6U/yt+LgqMxlLDDuA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

folks,


I am experimenting with getting my Motorola HS801 headset working.
Unfortunately it is also my first attempt to play with bluetoot h- so there maybe 
a lot of background iam missing.
I plan to use this eventually to send/recv phone calls.

1) I loaded the module

root@jzny2:/usr/src/btsco-0.4 # lsmod
Module                  Size  Used by
snd_bt_sco             13088  0
snd_hwdep               9376  1 snd_bt_sco
sco                    15108  0
hci_usb                14856  3
rfcomm                 40732  1
l2cap                  25476  5 rfcomm
speedstep_centrino      8148  1
freq_table              4612  1 speedstep_centrino
cpufreq_userspace       4572  1
pcmcia                 39056  2
container               4608  0
yenta_socket           26252  2
rsrc_nonstatic         12544  1 yenta_socket
pcmcia_core            42768  3 pcmcia,yenta_socket,rsrc_nonstatic
i2c_i801                9100  0
i2c_core               21392  1 i2c_i801
snd_intel8x0           33856  0
snd_ac97_codec         86524  1 snd_intel8x0
snd_pcm_oss            53152  0
snd_mixer_oss          19712  1 snd_pcm_oss
snd_pcm                91656  4
snd_bt_sco,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              24964  1 snd_pcm
snd                    53604  8
snd_bt_sco,snd_hwdep,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               9568  1 snd
snd_page_alloc         11016  3 snd_bt_sco,snd_intel8x0,snd_pcm
ehci_hcd               34696  0
uhci_hcd               34064  0
usbcore               121980  4 hci_usb,ehci_hcd,uhci_hcd
intel_agp              23580  1
agpgart                36168  1 intel_agp
tsdev                   7744  0
evdev                   9472  0
md_mod                 65488  0
dm_mod                 60220  0
psmouse                35332  0

2) root@jzny2:/usr/src/btsco-0.4 # hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0C:76:47:80:E0 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 16.4
        Chip version: BlueCore02
        Max key size: 56 bit
        SCO mapping:  HCI

3) root@jzny2:~ # hcitool name 00:0B:2E:42:D1:95
Motorola HS801

4) hciconfig hci0 voice 0x0060
worked ...

5) root@jzny2:/usr/src/btsco-0.4 # hcitool info 00:0B:2E:42:D1:95

Requesting information ...
Can't create connection: Input/output error

So i re-run the command with  hcidump -X in another window and i see:

--------
hadi@jzny2:/usr/src/linux-2.6.13.4$ hcidump -X
HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 0d 29 00 95 d1 42 2e 0b  00 01 00                 .)...B.....
----------

6) run the user space tool ..

root@jzny2:/usr/src/btsco-0.4 # btsco -v 00:0B:2E:42:D1:95
btsco v0.4
Device is 1:0
Error: Failed to connect to SDP server: Connection refused
Assuming channel 2

Voice setting: 0x0060
Can't connect RFCOMM channel: Connection refused


hcidump -X in another window and i see:

---
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 0d 29 00 95 d1 42 2e 0b  00 01 00                 .)...B.....
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 25 0c 00 60 00                                 .%..`.
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 0d 2a 00 95 d1 42 2e 0b  00 01 00                 .*...B.....
-------

I am running ubuntu. kernel 2.6.13.4; libbluetooth 2.11-1; bluez-utils
2.10-ubuntu

For some good reasons i cant upgrade the kernel on this laptop.


root@jzny2:/usr/src/btsco-0.4 #  hciconfig -a
hci0:   Type: USB
        BD Address: 00:0C:76:47:80:E0 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:5418 acl:0 sco:0 events:201 errors:0
        TX bytes:2372 acl:0 sco:0 commands:124 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'jzny2-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
        Manufacturer: Cambridge Silicon Radio (10)

--
root@jzny2:/usr/src/btsco-0.4 # modinfo hci_usb
filename:       /lib/modules/2.6.13.4/kernel/drivers/bluetooth/hci_usb.ko
parmtype:       ignore:bool
parm:           ignore:Ignore devices from the matching table
parmtype:       reset:bool
parm:           reset:Send HCI reset command on initialization
parmtype:       isoc:int
parm:           isoc:Set isochronous transfers for SCO over HCI support
author:         Maxim Krasnyansky <maxk@qualcomm.com>, Marcel Holtmann <marcel@holtmann.org>
description:    Bluetooth HCI USB driver ver 2.8
version:        2.8
license:        GPL
vermagic:       2.6.13.4 PENTIUM4 gcc-3.3
depends:        usbcore
alias:          usb:v*p*d*dcE0dsc01dp01ic*isc*ip*
alias:          usb:v057Cp3800d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v04BFp030Ad*dc*dsc*dp*ic*isc*ip*
alias:          usb:v044Ep3001d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v044Ep3002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0BDBp1002d*dc*dsc*dp*ic*isc*ip*
srcversion:     7695BA81AD723B8322FC98E


I have also attached my config files.

Let me know what else is needed. Again apologies for perhaps asking 
pre-newbie questions.

cheers,
jamal

--=-TUN6U/yt+LgqMxlLDDuA
Content-Disposition: attachment; filename=hcid.conf
Content-Type: text/plain; name=hcid.conf; charset=UTF-8
Content-Transfer-Encoding: 7bit

#
# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.4 2004/04/29 20:14:21 holtmann Exp $
#

# HCId options
options {
	# Automatically initialize new devices
	autoinit yes;

	# Security Manager mode
	#   none - Security manager disabled
	#   auto - Use local PIN for incoming connections
	#   user - Always ask user for a PIN
	#
	security auto;

	# Pairing mode
	#   none  - Pairing disabled
	#   multi - Allow pairing with already paired devices
	#   once  - Pair once and deny successive attempts
	pairing multi;

	# PIN helper
	pin_helper /usr/bin/bluez-pin;

	# D-Bus PIN helper
	#dbus_pin_helper;
}

# Default settings for HCI devices
device {
	# Local device name
	#   %d - device id
	#   %h - host name
	name "%h-%d";

	# Local device class
	class 0x100;

	# Default packet type
	#pkt_type DH1,DM1,HV1;

	# Inquiry and Page scan
	iscan enable; pscan enable;

	# Default link mode
	#   none   - no specific policy 
	#   accept - always accept incoming connections
	#   master - become master on incoming connections,
	#            deny role switch on outgoing connections
	#
	#lm accept,master;
	#
	lm accept;

	# Default link policy
	#   none    - no specific policy
	#   rswitch - allow role switch
	#   hold    - allow hold mode
	#   sniff   - allow sniff mode
	#   park    - allow park mode
	#
	#lp hold,sniff;
	#
	lp rswitch,hold,sniff,park;

	# Authentication and Encryption
	#auth enable;
	#encrypt enable;
}

--=-TUN6U/yt+LgqMxlLDDuA
Content-Disposition: attachment; filename=hcid.conf
Content-Type: text/plain; name=hcid.conf; charset=UTF-8
Content-Transfer-Encoding: 7bit

#
# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.4 2004/04/29 20:14:21 holtmann Exp $
#

# HCId options
options {
	# Automatically initialize new devices
	autoinit yes;

	# Security Manager mode
	#   none - Security manager disabled
	#   auto - Use local PIN for incoming connections
	#   user - Always ask user for a PIN
	#
	security auto;

	# Pairing mode
	#   none  - Pairing disabled
	#   multi - Allow pairing with already paired devices
	#   once  - Pair once and deny successive attempts
	pairing multi;

	# PIN helper
	pin_helper /usr/bin/bluez-pin;

	# D-Bus PIN helper
	#dbus_pin_helper;
}

# Default settings for HCI devices
device {
	# Local device name
	#   %d - device id
	#   %h - host name
	name "%h-%d";

	# Local device class
	class 0x100;

	# Default packet type
	#pkt_type DH1,DM1,HV1;

	# Inquiry and Page scan
	iscan enable; pscan enable;

	# Default link mode
	#   none   - no specific policy 
	#   accept - always accept incoming connections
	#   master - become master on incoming connections,
	#            deny role switch on outgoing connections
	#
	#lm accept,master;
	#
	lm accept;

	# Default link policy
	#   none    - no specific policy
	#   rswitch - allow role switch
	#   hold    - allow hold mode
	#   sniff   - allow sniff mode
	#   park    - allow park mode
	#
	#lp hold,sniff;
	#
	lp rswitch,hold,sniff,park;

	# Authentication and Encryption
	#auth enable;
	#encrypt enable;
}

--=-TUN6U/yt+LgqMxlLDDuA--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
