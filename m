Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <cp4a8v$959$1@sea.gmane.org>
References: <20041206225609.GA1177@zeus.galaxy.org.uk>	 <cp3mkk$m7t$1@sea.gmane.org> <1102407664.8447.20.camel@pegasus>	 <cp3rr7$1vv$1@sea.gmane.org> <1102411047.8447.28.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <1102411047.8447.28.camel@pegasus>
Subject: [Bluez-devel] Re: Problems with anycom usb dongle
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
Date: Tue, 07 Dec 2004 14:13:03 +0100

Hi Marcel,

sorry for this long post here!

 > The dongle keeps sending SCO packet, but the kernel already terminated
 > the SCO connection.
I figured out that `hciconfig hci0 down' stops the flood. No `up' is
possible afterwards. I have to replug the dongle.


 > What does "hcitool con" show when both (ACL + SCO) links were open?

(btsco's last line is RFCOMM channel 1 connected)
# hcitool con
Connections:
         < ACL 00:08:1B:00:FF:33 handle 1 state 1 lm MASTER

(pressing the button at my headset starts the SCO stream)
# hcitool con
Connections:
         < SCO 00:08:1B:00:FF:33 handle 1025 state 1 lm SLAVE
         < ACL 00:08:1B:00:FF:33 handle 1 state 1 lm MASTER



I've tested the anycom dongle with both headsets once again.
Here is a (heavy striped) output of hcidump while testing one of those:

< HCI Command: Create Connection (0x01|0x0005) plen 13
   0000: 33 ff 00 1b 08 00 18 cc  02 00 00 00 01
... (normal connect)
 > HCI Event: Connect Complete (0x03) plen 11
   0000: 00 01 04 33 ff 00 1b 08  00 00 01
 > SCO data: handle 0x0000 dlen 0
... (a lot of those packets)
 > SCO data: handle 0x0000 dlen 0
(I guess, here was my first button press)
 > SCO data: handle 0x0401 dlen 48
     0000: 58 00 60 ff f0 ff a0 ff  7c ff 98 ff d8 00 38 00
     0010: 68 00 48 ff d0 ff 6c ff  5c ff a8 ff f0 00 50 00
     0020: 70 00 38 ff c8 ff 7c ff  88 ff c0 00 20 00 70 00
... (a lot of those packets)
 > SCO data: handle 0x0401 dlen 48
     0000: f0 ff f0 ff f8 ff f8 ff  f0 ff f0 ff f0 ff f8 ff
     0010: f8 ff f8 ff f0 ff f0 ff  f8 ff f8 ff f8 ff f0 ff
     0020: f0 ff f8 ff f8 ff f8 ff  f0 ff f0 ff f8 ff f8 ff
(the second button press)
 > ACL data: handle 0x0001 flags 0x01 dlen 4
     L2CAP(d): cid 0x0041 len 17 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 12 fcs 0x5c credits 1
       0000: 41 54 2b 43 4b 50 44 3d  32 30 30 0d
**
< ACL data: handle 0x0001 flags 0x02 dlen 14
     L2CAP(d): cid 0x01c3 len 10 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
       0000: 0d 0a 4f 4b 0d 0a
**
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 01 00 01 00
< HCI Command: Disconnect (0x01|0x0006) plen 3
   0000: 01 04 13
**
 > HCI Event: Command Status (0x0f) plen 4
   0000: 00 01 06 04
**
 > HCI Event: Disconn Complete (0x05) plen 4
   0000: 00 01 04 13
 > HCI Event: Max Slots Change (0x1b) plen 3
   0000: 01 00 05
 > SCO data: handle 0x0000 dlen 0
 > SCO data: handle 0x0000 dlen 0
... flood ;)

** means between the HCI and ACL packets there was some SCO data
with a useful handle (> SCO data: handle 0x0401 dlen 48)

The SCO data between the two button presses seems ok, I think.
Nevertheless I can't hear any sound when trying to play.


Best regards,
Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
