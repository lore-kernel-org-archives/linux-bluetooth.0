Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Raul Jimeno Mouzo" <pichas23@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <LAW11-F1213ocBCkKqL00077993@hotmail.com>
Subject: [Bluez-users] pppd, bluez and phone
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 03 Jan 2004 14:03:59 +0100

Hi,

I don`t speak english. I have a problem with the Bluetooth connection 
between my computer and my phone.
I want assign one IP to my p800. I do:

PVI-Raul:/# hciconfig -a
hci0:   Type: USB
        BD Address: 00:06:A2:05:A2:40 ACL MTU: 339:4  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:63 acl:0 sco:0 events:7 errors:0
        TX bytes:27 acl:0 sco:0 commands:7 errors:0
        Features: 0xff 0xff 0x3d 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x90 LMP Ver: 1.1 (0x1) LMP Subver: 0x90
        Manufacturer: Transilica, Inc. (24)

PVI-Raul:/# hcitool scan
Scanning ...
        00:0A:D9:5D:67:B6       P800

PVI-Raul:/# l2ping 00:0A:D9:5D:67:B6
Ping: 00:0A:D9:5D:67:B6 from 00:06:A2:05:A2:40 (data size 20) ...
0 bytes from 00:0A:D9:5D:67:B6 id 200 time 31.59ms
0 bytes from 00:0A:D9:5D:67:B6 id 201 time 31.83ms
2 sent, 2 received, 0% loss

PVI-Raul:/# sdptool browse 00:0A:D9:5D:67:B6
Browsing 00:0A:D9:5D:67:B6 ...
Service Name: Voice gateway
Service Description: Voice gateway
Service Provider: Sony Ericsson
Service RecHandle: 0x10000
Service Class ID List:
  "Headset Audio Gateway" (0x1112)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

Service Name: OBEX Object Push
Service RecHandle: 0x10001
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: Bluetooth Serial Port
Service Description: Bluetooth Serial Port
Service Provider: Symbian Ltd.
Service RecHandle: 0x10002
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

Service Name: Dial-up Networking
Service Description: Dial-up Networking
Service Provider: Sony Ericsson
Service RecHandle: 0x10003
Service Class ID List:
  "Dialup Networking" (0x1103)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 4
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100

PVI-Raul:/# rfcomm bind 1 00:0A:D9:5D:67:B6 1
PVI-Raul:/# rfcomm
rfcomm1: 00:0A:D9:5D:67:B6 channel 1 clean
PVI-Raul:/# pppd call options_p800

And my files:

/etc/ppp/options

asyncmap 0
noauth
crtscts
local
lock
passive
debug
proxyarp
lcp-echo-interval 30
lcp-echo-failure 4
noipx

/etc/ppp/peers/options_p800

noauth
crtscts
local
lock
passive
debug
proxyarp
/dev/rfcomm1
115200
user ppp
192.168.5.1:192.168.5.8

And /var/log/system

Jan  3 12:47:36 PVI-Raul pppd[400]: pppd 2.4.1 started by root, uid 0
Jan  3 12:47:39 PVI-Raul pppd[400]: using channel 1
Jan  3 12:47:39 PVI-Raul pppd[400]: Using interface ppp0
Jan  3 12:47:39 PVI-Raul pppd[400]: Connect: ppp0 <--> /dev/rfcomm1
Jan  3 12:47:40 PVI-Raul pppd[400]: sent [LCP ConfReq id=0x1 <asyncmap 0x0> 
<magic 0x6861a893> <pcomp> <accomp>]
Jan  3 12:47:40 PVI-Raul pppd[400]: Hangup (SIGHUP)
Jan  3 12:47:40 PVI-Raul pppd[400]: Modem hangup
Jan  3 12:47:40 PVI-Raul pppd[400]: Connection terminated.
Jan  3 12:47:40 PVI-Raul pppd[400]: Exit.

I don't know because.Thank you.

_________________________________________________________________
Reserva y planifica tu viaje online. http://www.msn.es/Viajes/



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
