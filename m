Return-Path: <cyrus@holtmann.org>
Date: Sat, 31 May 2008 04:29:40 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <DB4454DF-1BB6-48C6-9868-53EF65E3271E@holtmann.org>
Message-ID: <alpine.LNX.1.00.0805310402120.8061@nge2.ngu.pk>
References: <alpine.LNX.1.00.0805280355410.22621@nge2.ngu.pk>
	<DB4454DF-1BB6-48C6-9868-53EF65E3271E@holtmann.org>
MIME-Version: 1.0
Subject: Re: [Bluez-users] bluez-utils-3.32: something broke?
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




On Thu, 29 May 2008, Marcel Holtmann wrote:

-> > 2.6.25.3 w/sco patch built with gcc-4.3.0, x86.
-> 
-> The SCO patch should not be needed at all.


After reversing the patch and rebuilting 2.6.25.4, I can most certainly say it 
is needed for SCO-only headsets being sent to from eSCO/SCO bluetooth 
adapters.

2008-05-31T04:08:58-04:00 vdrl kernel: usb 3-2: new full speed USB device 
using uhci_hcd and address 2
2008-05-31T04:08:58-04:00 vdrl kernel: usb 3-2: configuration #1 chosen from 1 
choice
2008-05-31T04:08:58-04:00 vdrl kernel: usb 3-2: New USB device found, 
idVendor=050d, idProduct=0121
2008-05-31T04:08:58-04:00 vdrl kernel: usb 3-2: New USB device strings: Mfr=1, 
Product=2, SerialNumber=0
2008-05-31T04:08:58-04:00 vdrl kernel: usb 3-2: Product: BELKIN BLUETOOTH USB 
ADAPTER CL. 1
2008-05-31T04:08:58-04:00 vdrl kernel: usb 3-2: Manufacturer: Broadcom Corp
2008-05-31T04:09:52.396255-04:00 vdrl hcid[1916]: Bluetooth HCI daemon
2008-05-31T04:09:52.429271-04:00 vdrl hcid[1916]: HCI dev 0 registered
2008-05-31T04:09:52.429877-04:00 vdrl hcid[1916]: Starting SDP server
2008-05-31T04:09:52.496084-04:00 vdrl hcid[1916]: Can't create GN bridge
2008-05-31T04:09:52.496250-04:00 vdrl hcid[1916]: Registered manager 
path:/org/bluez/network
2008-05-31T04:09:52.511086-04:00 vdrl hcid[1916]: Registered server 
path:/org/bluez/network/nap
2008-05-31T04:09:52.511435-04:00 vdrl hcid[1916]: Registered server 
path:/org/bluez/network/gn
2008-05-31T04:09:52.511734-04:00 vdrl hcid[1916]: Registered server 
path:/org/bluez/network/panu
2008-05-31T04:09:52.520654-04:00 vdrl hcid[1916]: Registering service
2008-05-31T04:09:52.539779-04:00 vdrl hcid[1916]: Registered manager 
path:/org/bluez/serial
2008-05-31T04:09:52.539969-04:00 vdrl hcid[1916]: Registering service
2008-05-31T04:09:52.542778-04:00 vdrl hcid[1916]: Registered input manager 
path:/org/bluez/input
2008-05-31T04:09:52.543005-04:00 vdrl hcid[1916]: Registering service
2008-05-31T04:09:52.565451-04:00 vdrl hcid[1916]: Unix socket created: 18
2008-05-31T04:09:52.587640-04:00 vdrl hcid[1916]: Registered manager 
path:/org/bluez/audio
2008-05-31T04:09:52.603416-04:00 vdrl hcid[1916]: Loading device 
00:1A:45:01:F9:42 (headset )
2008-05-31T04:09:52.611591-04:00 vdrl hcid[1916]: Setting 00:1A:45:01:F9:42 as 
default device
2008-05-31T04:09:52.611709-04:00 vdrl hcid[1916]: Registering service
2008-05-31T04:09:52.612459-04:00 vdrl hcid[1916]: HCI dev 0 up
2008-05-31T04:09:52.612588-04:00 vdrl hcid[1916]: Device hci0 has been added
2008-05-31T04:09:52.618162-04:00 vdrl hcid[1916]: Starting security manager 0
2008-05-31T04:09:52.651570-04:00 vdrl hcid[1916]: Device hci0 has been 
activated
2008-05-31T04:09:55.140881-04:00 vdrl hcid[1916]: Default passkey agent (:1.5, 
/org/bluez/passkey_agent_1919) registered
2008-05-31T04:09:59.939386-04:00 vdrl hcid[1916]: Default authorization agent 
(:1.6, /org/bluez/auth_agent_1920) registered
2008-05-31T04:10:21.442155-04:00 vdrl hcid[1916]: link_key_request 
(sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
2008-05-31T04:10:22.553064-04:00 vdrl hcid[1916]: link_key_notify 
(sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
2008-05-31T04:10:27.911891-04:00 vdrl hcid[1916]: Badly formated or 
unrecognized command: AT+BTRH?
2008-05-31T04:10:53.210714-04:00 vdrl hcid[1916]: Audio API: received 
BT_GETCAPABILITIES_REQ
2008-05-31T04:10:53.210855-04:00 vdrl hcid[1916]: Audio API: sending 
BT_GETCAPABILITIES_RSP
2008-05-31T04:10:53.225439-04:00 vdrl hcid[1916]: Audio API: received 
BT_SETCONFIGURATION_REQ
2008-05-31T04:10:53.225556-04:00 vdrl hcid[1916]: config sco - device = 
00:1A:45:01:F9:42 access_mode = 2
2008-05-31T04:10:53-04:00 vdrl kernel: hci_scodata_packet: hci0 SCO packet for 
unknown connection handle 1
2008-05-31T04:10:53-04:00 vdrl kernel: hci_scodata_packet: hci0 SCO packet for 
unknown connection handle 1
2008-05-31T04:10:53-04:00 vdrl kernel: hci_scodata_packet: hci0 SCO packet for 
unknown connection handle 1
2008-05-31T04:10:53-04:00 vdrl kernel: hci_scodata_packet: hci0 SCO packet for 
unknown connection handle 1
2008-05-31T04:10:53-04:00 vdrl kernel: hci_scodata_packet: hci0 SCO packet for 
unknown connection handle 1
2008-05-31T04:10:53-04:00 vdrl kernel: hci_scodata_packet: hci0 SCO packet for 
unknown connection handle 1
2008-05-31T04:10:53-04:00 vdrl kernel: hci_scodata_packet: hci0 SCO packet for 
unknown connection handle 1
2008-05-31T04:10:53-04:00 vdrl kernel: hci_scodata_packet: hci0 SCO packet for 
unknown connection handle 1
2008-05-31T04:10:53-04:00 vdrl kernel: hci_scodata_packet: hci0 SCO packet for 
unknown connection handle 1
2008-05-31T04:10:53-04:00 vdrl kernel: hci_scodata_packet: hci0 SCO packet for 
unknown connection handle 1
2008-05-31T04:10:53-04:00 vdrl kernel: hci_scodata_packet: hci0 SCO packet for 
unknown connection handle 1
2008-05-31T04:10:53-04:00 vdrl kernel: hci_scodata_packet: hci0 SCO packet for 
unknown connection handle 1
2008-05-31T04:10:53-04:00 vdrl kernel: hci_scodata_packet: hci0 SCO packet for 
unknown connection handle 1

...



( continues endlessly. I had to pull the dongle to stop it. I also need
   to look up duplicate mesg reporting limiting in rsyslog ;)  )


usb 2-2: USB disconnect, address 2


This is the patch I've been using for awhile now:


--- linux-2.6.23/net/bluetooth/hci_event.c.orig 2008-02-26 12:46:36.000000000+0900
+++ linux-2.6.23/net/bluetooth/hci_event.c      2008-02-26 12:47:23.000000000+0900
@@ -1313,8 +1313,15 @@
         hci_dev_lock(hdev);

         conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
-       if (!conn)
-               goto unlock;
+       if (!conn) {
+               __u8 link_type = (ev->link_type == ESCO_LINK) ? SCO_LINK : ESCO_LINK;
+
+               conn = hci_conn_hash_lookup_ba(hdev, link_type, &ev->bdaddr);
+               if (conn)
+                       conn->type = ev->link_type;
+               else
+                       goto unlock;
+       }

         if (!ev->status) {
                 conn->handle = __le16_to_cpu(ev->handle);



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
