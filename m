Return-Path: <cyrus@holtmann.org>
From: Johan <johanden@gmail.com>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 16 May 2008 19:02:57 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_B5bLIHYN/oOI5GV"
Message-Id: <200805161902.57488.johanden@gmail.com>
Subject: [Bluez-devel] Bluetooth pairing disconnects or dies or perhaps even
	goes to standy mode? Help please!
Reply-To: johanden@gmail.com,
	BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_B5bLIHYN/oOI5GV
Content-Type: multipart/alternative; boundary="Boundary-01=_B5bLI/lcn5gxgAr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_B5bLI/lcn5gxgAr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

PROBLEM:
Headset won't work. It clicks and beeps during pairing but won't register a=
ny input. After it has been paired the connection "dies".

SYMPTOMS:
I have an issue with my bluetooth connection that disconnects itself from b=
oth my Plantronics 3000 headset and my Sony Ericsson k750i. The icon in my =
systemtray turns blue as soon as I have paired my computer with headset/mob=
ile but less than second later it's gray again.=20
=46rom my mobile I'm still able to easily connect again by touching any of =
the buttons. That's typical when I use it as a remote control.
The real problem is my headset that works fine in Windows but won't work in=
 Linux.=20

HARDWARE/SOFTWARE USED:
Plantronics 3000 headset
Sony Ericsson k750i
Belkin Bluetooth USB Adapter (F8T012xx1)
Kubuntu Hardy 8.04 with packages:
bluetooth , bluez-audio , bluez-gnome , bluez-utils , kdebluetooth , libblu=
etooth2 , libkbluetooth0

REPRODUCE PROBLEM:
I have my bt usb adapter connected via usb hub. Started manually "Kbluetoot=
h" from K-menu - System. Set the bt headset in discover mode. Left click th=
e gray K-bluetooth icon in system tray. In the new window, left click on th=
e headset icon. Choose "Open with" when prompted. The headset should now be=
 connected and the K-icon should turn blue. The pop-up stating the headset =
is connected appears. 1 second later the icon turns gray again and the head=
set is disconnected. The same thing happens when trying with my mobile phon=
e.

HCIDUMP is attached in the email.=20

This is the first time I'm mailing here so if I'm doing something wrong or =
you need more information etc. then please let me know.=20

Thank you all in advance for your help, time and effort!=20

Best regards,
Johan
--Boundary-01=_B5bLI/lcn5gxgAr
Content-Type: text/html;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

<html><head><meta name="qrichtext" content="1" /></head><body style="font-size:11pt;font-family:Sans Serif">
<p>Hi,</p>
<p></p>
<p><span style="font-weight:600">PROBLEM</span>:</p>
<p>Headset won't work. It clicks and beeps during pairing but won't register any input. After it has been paired the connection &quot;dies&quot;.</p>
<p></p>
<p><span style="font-weight:600">SYMPTOMS</span>:</p>
<p>I have an issue with my bluetooth connection that disconnects itself from both my Plantronics 3000 headset and my Sony Ericsson k750i. The icon in my systemtray turns blue as soon as I have paired my computer with headset/mobile but less than second later it's gray again. </p>
<p>From my mobile I'm still able to easily connect again by touching any of the buttons. That's typical when I use it as a remote control.</p>
<p>The real problem is my headset that works fine in Windows but won't work in Linux. </p>
<p></p>
<p><span style="font-weight:600">HARDWARE/SOFTWARE USED</span>:</p>
<p>Plantronics 3000 headset</p>
<p>Sony Ericsson k750i</p>
<p>Belkin Bluetooth USB Adapter (F8T012xx1)</p>
<p>Kubuntu Hardy 8.04 with packages:</p>
<p>bluetooth , bluez-audio , bluez-gnome , bluez-utils , kdebluetooth , libbluetooth2 , libkbluetooth0</p>
<p></p>
<p><span style="font-weight:600">REPRODUCE PROBLEM</span>:</p>
<p>I have my bt usb adapter connected via usb hub. Started manually &quot;Kbluetooth&quot; from K-menu - System. Set the bt headset in discover mode. Left click the gray K-bluetooth icon in system tray. In the new window, left click on the headset icon. Choose &quot;Open with&quot; when prompted. The headset should now be connected and the K-icon should turn blue. The pop-up stating the headset is connected appears. 1 second later the icon turns gray again and the headset is disconnected. The same thing happens when trying with my mobile phone.</p>
<p></p>
<p><span style="font-weight:600">HCIDUMP</span> is attached in the email. </p>
<p></p>
<p>This is the first time I'm mailing here so if I'm doing something wrong or you need more information etc. then please let me know. </p>
<p></p>
<p>Thank you all in advance for your help, time and effort! </p>
<p></p>
<p>Best regards,</p>
<p>Johan</p>
</body></html>
--Boundary-01=_B5bLI/lcn5gxgAr--

--Boundary-00=_B5bLIHYN/oOI5GV
Content-Type: text/plain;
  charset="us-ascii";
  name="hcidump"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hcidump"

johan@Penguin:~$ sudo hcidump -X
HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
  0000: 33 8b 9e 08 00                                    3....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 01 04                                       ....
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  0000: 01 0c 85 4a 89 03 00 01  00 04 04 20 9d 4b d8     ...J....... .K.
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  0000: 01 0c 85 4a 89 03 00 01  00 04 04 20 9d 4b d4     ...J....... .K.
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  0000: 01 0c 85 4a 89 03 00 01  00 04 04 20 9d 4b d4     ...J....... .K.
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  0000: 01 0c 85 4a 89 03 00 01  00 04 04 20 9d 4b d3     ...J....... .K.
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  0000: 01 0c 85 4a 89 03 00 01  00 04 04 20 9d 4b d4     ...J....... .K.
> HCI Event: Inquiry Complete (0x01) plen 1
  0000: 00                                                .
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 0c 85 4a 89 03 00 18 cc  01 00 9d cb 01           ..J..........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 0c 85 4a 89 03 00                                 ..J...
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
  0000: 0c 85 4a 89 03 00                                 ..J...
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0c 04 00 0c 85 4a 89  03 00                    ......J...
> HCI Event: PIN Code Request (0x16) plen 6
  0000: 0c 85 4a 89 03 00                                 ..J...
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
  0000: 0c 85 4a 89 03 00 04 30  30 30 30 00 00 00 00 00  ..J....0000.....
  0010: 00 00 00 00 00 00 00                              .......
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0d 04 00 0c 85 4a 89  03 00                    ......J...
> HCI Event: Link Key Notification (0x18) plen 23
  0000: 0c 85 4a 89 03 00 a8 f6  1c 56 12 f2 95 62 f2 4a  ..J......V...b.J
  0010: 11 9b 0f 94 78 b6 00                              ....x..
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 0c 00 0c 85 4a 89 03  00 01 00                 .....J.....
< ACL data: handle 12 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
  0000: 0c 00                                             ..
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 1b 04                                       ....
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 0c 00 0f 00                                       ....
> HCI Event: Read Remote Supported Features (0x0b) plen 11
  0000: 00 0c 00 bc 28 01 00 00  00 00 00                 ....(......
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 0c 00                                 ......
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  0000: 0c 85 4a 89 03 00 02 00  00 00                    ..J.......
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 19 04                                       ....
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Info rsp: type 2 result 1
      Not supported
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> HCI Event: Remote Name Req Complete (0x07) plen 255
  0000: 00 0c 85 4a 89 03 00 4d  33 30 30 30 20 62 79 20  ...J...M3000 by
  0010: 50 6c 61 6e 74 72 6f 6e  69 63 73 00 00 00 00 00  Plantronics.....
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00     ...............
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0c 00 02 00                                    .....
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 48
< ACL data: handle 12 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1002 (PubBrwsGrp)
          max 64
          cont 00
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x0 len 0x5
          count 0
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0c 00 03 00                                    .....
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0c 00 01 00                                    .....
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 0c 00 13                                          ...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 0c 00 16                                       ....


--Boundary-00=_B5bLIHYN/oOI5GV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--Boundary-00=_B5bLIHYN/oOI5GV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_B5bLIHYN/oOI5GV--
