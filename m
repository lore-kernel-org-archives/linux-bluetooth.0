Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Geoff Shang <geoff@hitsandpieces.net>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.64.0604020557560.738@data.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bluez-users] Pan connection dies
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
Date: Sun, 2 Apr 2006 06:32:27 +1000 (EST)

Hi,

Having gotten my PAN to work, I'm having trouble keeping it alive.  From 
time to time, and the time varies from days to hours, the link to the 
computer in the next room dies.

On the NAP side, I get the following errors on the active console:

hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection 6E:A0:B2:72:02:00
hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection 6E:A0:B2:72:02:00

Nothing of note seems to happen on the PANU side, except acknowledgement 
that the connection has died.

This seems to result in the bluetooth adaptor on the NAP side being put 
into an odd state.  Subsequent attempts to reestablish the connection fail 
until I physically disconnect the dongle and reconnect it.  When I 
disconnect it, the following appears on the console:

usb-uhci.c: process_transfer: fixed toggle

Once I plug it back in again, all is well until the next time.

I'm running kernel 2.4.32 on both ends, with the same generic brand dongle 
at each end also.  I'm running bluez libs and utils version 2.25.

hci0:   Type: USB
         BD Address: <removed for security> ACL MTU: 192:8 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:1643814 acl:6762 sco:0 events:139336 errors:0
         TX bytes:32350592 acl:168674 sco:0 commands:16 errors:0
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: ACCEPT MASTER
         Name: 'data (0)'
         Class: 0x3e0100
         Service Classes: Networking, Rendering, Capturing
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 
0x20d
         Manufacturer: Cambridge Silicon Radio (10)

Whilst on the subject of pans, I've got a few questions:

1.  If I'm just going to connect PCs, does it matter whether I make the 
server act as a GN or NAP?  If so, which is better?  I have to say I'm not 
clear on what the difference is.

2.  I tend to get average ping times of about 50 ms over the link, and 
pretty slow transfer rates, to the point where high bitrate MP3 files don't 
always play cleanly.  Is this normal?  What kinds of bitrates can I expect 
over a bluetooth connection?

3.  If I want to also use my bluetooth dongle for other applications (e.g. 
a headset), will this eat into my transfer rates still further?

One other question which may not be related at all.  The person using the 
PANU machine keeps seeing the following on their console:

Apr  2 01:29:49 janeway kernel: usb-uhci.c: iso_find_start: gap in seamless 
isochronous scheduling

Is this likely to be a bluetooth thing or something else?

A syslog dump of the PAN connection dying appears below:

>From NAP:

Apr  2 01:56:12 data kernel: NETDEV WATCHDOG: bnep0: transmit timed out
Apr  2 01:56:43 data last message repeated 8 times
Apr  2 01:57:32 data last message repeated 12 times
Apr  2 01:57:32 data kernel: hci_acl_tx_to: hci0 ACL tx timeout
Apr  2 01:57:32 data kernel: hci_acl_tx_to: hci0 killing stalled ACL 
connection
6E:A0:B2:72:02:00
Apr  2 01:57:32 data kernel: pan0: port 1(bnep0) entering disabled state
Apr  2 01:57:32 data kernel: pan0: port 1(bnep0) entering disabled state
Apr  2 01:57:32 data kernel: device bnep0 left promiscuous mode
Apr  2 01:57:34 data /etc/hotplug/net.agent: invoke ifdown bnep0
Apr  2 01:58:12 data kernel: usb.c: USB disconnect on device 00:07.2-2 
address 16
Apr  2 01:58:12 data kernel: usb-uhci.c: process_transfer: fixed toggle
Apr  2 01:58:12 data kernel: usb-uhci.c: process_transfer: fixed toggle
Apr  2 01:58:12 data hcid[11449]: HCI dev 0 down
Apr  2 01:58:12 data hcid[11449]: Stoping security manager 0
Apr  2 01:58:12 data hcid[11449]: HCI dev 0 unregistered
Apr  2 01:58:12 data /sbin/hotplug: no runnable 
/etc/hotplug/bluetooth.agent is
installed
Apr  2 01:58:15 data kernel: hub.c: new USB device 00:07.2-2, assigned 
address 17
Apr  2 01:58:16 data hcid[11449]: HCI dev 0 registered
Apr  2 01:58:16 data hcid[11449]: HCI dev 0 up
Apr  2 01:58:16 data hcid[11449]: Starting security manager 0
Apr  2 01:58:16 data /sbin/hotplug: no runnable 
/etc/hotplug/bluetooth.agent is
installed
Apr  2 01:58:19 data /etc/hotplug/usb.agent: Setup hci_usb for USB product 
a12/1
/525
Apr  2 01:58:19 data last message repeated 2 times
Apr  2 01:58:20 data /etc/hotplug/usb.agent: missing kernel or user mode 
driver
hci_usb
Apr  2 01:58:21 data last message repeated 2 times
Apr  2 01:58:23 data pand[12814]: New connection from 00:02:72:B2:A0:6E 
bnep0
Apr  2 01:58:23 data /etc/hotplug/net.agent: invoke ifup bnep0
Apr  2 01:58:23 data kernel: device bnep0 entered promiscuous mode
Apr  2 01:58:23 data kernel: pan0: port 1(bnep0) entering learning state
Apr  2 01:58:23 data kernel: pan0: port 1(bnep0) entering forwarding state
Apr  2 01:58:23 data kernel: pan0: topology change detected, propagating


>From PANU:

Apr  2 01:57:35 janeway pand[15112]: bnep0 disconnected : Connection reset 
by peer
<snip out lots of NFS complaining>
Apr  2 01:57:40 janeway pand[15112]: Connecting to <address of NAP removed 
for security>
<snipped more complaints from NFS>
Apr  2 01:58:20 janeway pand[15112]: Connect to <address of NAP> failed. 
Connection timed out(110)
Apr  2 01:58:25 janeway pand[15112]: Connecting to <address of NAP>
Apr  2 01:58:26 janeway pand[15112]: bnep0 connected

NB: There's no guarantee that the clocks of these 2 PCs are in sync (that's 
on my todo list).

Any help appreciated.

Geoff.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
