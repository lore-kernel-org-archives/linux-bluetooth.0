Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Olli <olli@olli.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200602211256.42759.olli@olli.de>
Subject: [Bluez-users] Problem with authentication wit bluetooth-modem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 21 Feb 2006 12:56:42 +0100


Hi all.

I am trying to connect my linux laptop via a bluetooth dongle with a modem 
(typhoon 56k Bluetooth modem). With a windows-system this combination works 
fine.

With "hcitool scan" the modem is found correctly, but a simple 
echo "ATZ" > /dev/rfcomm0 fails with an authentication error.

I have read several documentations about bluetooth and linux and followed 
(hopefully) exactly the steps, that were described there. But I still get the 
same error every time i am trying to connect to the modem.

So, please help me........

Here comes my configuration and the output of hcidump, hcid, bluepin, 
hciconfig. If you need any further information just ask for it.

Thx and best regards,

Olli.

########################
/etc/bluetooth/hci.conf
########################
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
	# if you want a interactiv query of your pin use /usr/bin/bluepin
	# /bin/bluepincat is using the pin in the /etc/bluetooth/pin file
	# pin_helper /usr/bin/bluepin;
	pin_helper /bin/bluepin;

	# D-Bus PIN helper
	#dbus_pin_helper;
}

# Default settings for HCI devices
device {
	# Local device name
	#   %d - device id
	#   %h - host name
	name "BlueZ %h (%d)";

	# Local device class
	# e.g.
	#  0xsss100 = Computer
	#  0xsss104 = Computer Desktop
	#  0xsss108 = Computer Server
	#  0xsss10c = Computer Laptop
	# The 'sss' above defines the service-class (not quite, only the
	# first 11 bits, the next 11 define the device-class, than 2 format bits.)
	# See https://www.bluetooth.org/foundry/assignnumb/document/baseband
	# for more information.
	# 0x100bbb stands for "Object Transfer  (v-Inbox, v-Folder, ...)"
	# 0x020bbb stands for "Networking (LAN, Ad hoc, ...)"
	class 0x52010c;

	# Default packet type
	#pkt_type DH1,DM1,HV1;

	# Inquiry and Page scan
	# valid parameters: enable | disable
	iscan enable;
	pscan enable;

	# Default link mode
	#   none   - no specific policy 
	#   accept - always accept incoming connections
	#   master - become master on incoming connections,
	#            deny role switch on outgoing connections
	lm accept;

	# Default link policy
	#   none    - no specific policy
	#   rswitch - allow role switch
	#   hold    - allow hold mode
	#   sniff   - allow sniff mode
	#   park    - allow park mode
	lp rswitch,hold,sniff,park;

	# Authentication and Encryption (Security Mode 3)
	auth enable;
	#auth enable;
	encrypt disable;
}


########################
/etc/bluetooth/rfcomm.conf
########################
rfcomm0 {
	# Automatically bind the device at startup
	bind yes;

	# Bluetooth address of the device
	# olli: THIS IS THE ADDRESS OF THE MODEM:
	device 00:10:60:29:FB:20;

	# RFCOMM channel for the connection
	channel	1;

	# Description of the connection
	comment "Bluetooth 56k modem";
}


######################################
# Outpout of "hciconfig -a"
######################################
linux:/ # hciconfig -a
hci0:   Type: USB
        BD Address: 00:10:60:A9:36:16 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH
        RX bytes:2357 acl:0 sco:0 events:200 errors:0
        TX bytes:2145 acl:0 sco:0 commands:99 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ linux (0)'
        Class: 0x52010c
        Service Classes: Networking
        Device Class: Computer, Laptop
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c
        Manufacturer: Cambridge Silicon Radio (10)

########################################################
# /etc/bluetooth/pin (Here I have enterd the pin of the modem)
########################################################
PIN:1111

######################################
# output of bluepin
######################################
linux:/  # bluepin
PIN:1111
linux:/  #

#########################################################
# output 'rfcomm show' BEFORE 'echo "ATZ" > /dev/rfcomm0'
#########################################################
rfcomm0: 00:10:60:29:FB:20 channel 1 clean

#########################################################
# output of hcidump  DURING 'echo "ATZ" > /dev/rfcomm0'
#########################################################
linux:/  # hcidump -X -V -i 0
HCI sniffer - Bluetooth packet analyzer ver 1.30
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:10:60:29:FB:20 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x0c ncmd 1
    Error: Command Disallowed
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:10:60:29:FB:20
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:10:60:29:FB:20 key 4DCE16E1DF368363B2978B0076D6508E
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:10:60:29:FB:20
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 41 bdaddr 00:10:60:29:FB:20 type ACL encrypt 0x00
    Error: Authentication Failure

#########################################################
# output of hcid DURING 'echo "ATZ" > /dev/rfcomm0'
#########################################################
linux:/  # killall hcid; hcid -n
hcid: Kein Prozess abgebrochen
hcid[5729]: Bluetooth HCI daemon
hcid[5729]: Starting security manager 0
hcid[5729]: link_key_request (sba=00:10:60:A9:36:16, dba=00:10:60:29:FB:20)

#########################################################
# output 'rfcomm show' AFTER 'echo "ATZ" > /dev/rfcomm0'
#########################################################
rfcomm0: 00:10:60:29:FB:20 channel 1 closed




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
