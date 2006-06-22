Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <aa7ce83b0606212054hbe897cdlcf349cbe19cd7e1d@mail.gmail.com>
Date: Thu, 22 Jun 2006 13:54:40 +1000
From: "Ken Robinson" <kenrobinsonster@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <mailman.7733.1150814249.2958.bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
References: <mailman.7733.1150814249.2958.bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez-users Digest, Vol 2, Issue 26
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0725299052=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0725299052==
Content-Type: multipart/alternative;
	boundary="----=_Part_1016_30485354.1150948480851"

------=_Part_1016_30485354.1150948480851
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

An update to my earlier post below.

on the korebot
I changed the device -> class id in hcid.conf so it was 0x0203xx which meant
it was Networking /Adhoc device with an access point. I don't think this
really changed anything when I ran a pand --connect <bluetooth address>.

I then tried to reconnect several times. I found this constant connection
woke up the host computer in some way and I was able to get a bnep0
interface. I don't understand how this happens.
I then assigned ip address on both the korebot and the host computer and
made sure both interfaces were up and running. I got this message on the
korebot when I tried to ping.

      PING 192.168.1.23 (192.168.1.23): 56 data bytes
NETDEV WATCHDOG: usbf: transmit timed out
NETDEV WATCHDOG: usbf: transmit timed out
NETDEV WATCHDOG: usbf: transmit timed out
NETDEV WATCHDOG: usbf: transmit timed out
NETDEV WATCHDOG: usbf: transmit timed out
NETDEV WATCHDOG: usbf: transmit timed out
NETDEV WATCHDOG: usbf: transmit timed out

Is there some other trick to initialisation of the bnep0 interface?

oot@Possibility:/home/krobinson# hcidump
HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1691
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1691
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1691
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1691
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0042
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0042 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4
      MTU 1691
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4
      MTU 1691
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0043
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0043 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 4
      MTU 1691
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 4
      MTU 1691
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0044
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0044 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 4
      MTU 1691
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 4
      MTU 1691
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0045
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0045 scid 0x0045 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0045 flags 0x00 clen 4
      MTU 1691
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0045 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0045 flags 0x00 clen 4
      MTU 1691
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0045 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0046
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0046 scid 0x0046 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0046 flags 0x00 clen 4
      MTU 1691
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0046 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0046 flags 0x00 clen 4
      MTU 1691
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0046 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0047
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0047 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen 4
      MTU 1691
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0047 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen 4
      MTU 1691
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0047 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 11
    L2CAP(d): cid 0x0047 len 7 [psm 15]
      BNEP: Control(0x01|0)
        Setup Req(0x01) size 0x02 dst 0x1116(NAP) src 0x1115(PANU)
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Setup Rsp(0x02) res 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 17
> ACL data: handle 42 flags 0x01 dlen 3
    L2CAP(d): cid 0x0047 len 16 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x000c
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 17
> ACL data: handle 42 flags 0x01 dlen 3
    L2CAP(d): cid 0x0047 len 16 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x000c
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 17
> ACL data: handle 42 flags 0x01 dlen 3
    L2CAP(d): cid 0x0047 len 16 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x000c
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 5
> ACL data: handle 42 flags 0x01 dlen 121
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 3
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 90
> ACL data: handle 42 flags 0x01 dlen 13
    L2CAP(d): cid 0x0047 len 585 [psm 15]
      BNEP: Compressed DestOnly(0x04|0)
        dst ff:ff:ff:ff:ff:ff [proto 0x0800]
> ACL data: handle 42 flags 0x02 dlen 121
> ACL data: handle 42 flags 0x01 dlen 71
> ACL data: handle 42 flags 0x01 dlen 121
> ACL data: handle 42 flags 0x01 dlen 71
> ACL data: handle 42 flags 0x01 dlen 121
> ACL data: handle 42 flags 0x01 dlen 71
> ACL data: handle 42 flags 0x01 dlen 13
    L2CAP(d): cid 0x0047 len 585 [psm 15]
      BNEP: Compressed DestOnly(0x04|0)
        dst ff:ff:ff:ff:ff:ff [proto 0x0800]
> ACL data: handle 42 flags 0x02 dlen 121
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 3
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 90
> ACL data: handle 42 flags 0x01 dlen 121
> ACL data: handle 42 flags 0x01 dlen 71
> ACL data: handle 42 flags 0x01 dlen 13
    L2CAP(d): cid 0x0047 len 585 [psm 15]
      BNEP: Compressed DestOnly(0x04|0)
        dst ff:ff:ff:ff:ff:ff [proto 0x0800]
> ACL data: handle 42 flags 0x02 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 17
> ACL data: handle 42 flags 0x01 dlen 5
> ACL data: handle 42 flags 0x01 dlen 121
> ACL data: handle 42 flags 0x01 dlen 71
> ACL data: handle 42 flags 0x01 dlen 121
> ACL data: handle 42 flags 0x01 dlen 71
> ACL data: handle 42 flags 0x01 dlen 13
    L2CAP(d): cid 0x0047 len 585 [psm 15]
      BNEP: Compressed DestOnly(0x04|0)
        dst ff:ff:ff:ff:ff:ff [proto 0x0800]
> ACL data: handle 42 flags 0x02 dlen 32
    L2CAP(d): cid 0x0047 len 28 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x0018
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
          01:00:5e:00:00:01 - 01:00:5e:00:00:01
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 32
    L2CAP(d): cid 0x0047 len 28 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x0018
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
          01:00:5e:00:00:01 - 01:00:5e:00:00:01
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5






On 6/21/06, bluez-users-request@lists.sourceforge.net <
bluez-users-request@lists.sourceforge.net> wrote:
>
> Send Bluez-users mailing list submissions to
>         bluez-users@lists.sourceforge.net
>
> Message: 5
> Date: Wed, 21 Jun 2006 00:37:26 +1000
> From: "Ken Robinson" <kenrobinsonster@gmail.com>
> Subject: [Bluez-users] Cannot Get bnep0 on pand connect
> To: bluez-users@lists.sourceforge.net
> Message-ID:
>         <aa7ce83b0606200737m3c91d17anfce14229ca245b13@mail.gmail.com>
> Content-Type: text/plain; charset="iso-8859-1"
>
> Hi,
> I am presently trying to get a bluetooth IP connection between two linux
> boxes.
> I have made 2.25 bluez-utils and bluez-libs  for  both the  host  computer
> (a kanotix 2.6.x kernel) and at target  (a korebot with a 2.4.19 kernel
> with
> the bluez patch-2.4.19-mh18 applied)
> I have experimented on the host computer (a kanotix 2.6.x kernel) and am
> able to get a bnep0 interface.
> For the connection between host and target:
> I do the following:
> # modprobe bnep
> # pand --listen -r GN
> On the target computer I do:
> # modprobe bnep
> # pand --connect <BT address>
> I cannot get a bnep0 interface
> # ifconfig bnep0
> ifconfig: bnep0: error fetching interface information: Device not found
>
> The hcidump on the host computer is shown below. Does anyone have any
> ideas?
>
> root@Possibility:/home/krobinson# hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.23
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
>     bdaddr 00:02:72:B0:C5:FB class 0x000000 type ACL
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>     bdaddr 00:02:72:B0:C5:FB role 0x00
>     Role: Master
> > HCI Event: Command Status (0x0f) plen 4
>     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> > HCI Event: Role Change (0x12) plen 8
>     status 0x00 bdaddr 00:02:72:B0:C5:FB role 0x00
>     Role: Master
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 42 bdaddr 00:02:72:B0:C5:FB type ACL encrypt 0x00
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>     handle 42 ptype 0xcc18
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>     bdaddr 00:02:72:B0:C5:FB mode 1
> > HCI Event: Command Status (0x0f) plen 4
>     Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> > HCI Event: Connection Packet Type Changed (0x1d) plen 5
>     status 0x00 handle 42 ptype 0xcc18
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 42 slots 5
> > ACL data: handle 42 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 15 scid 0x0040
> < ACL data: handle 42 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>       Connection successful
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
> > ACL data: handle 42 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 1691
> < ACL data: handle 42 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>       Success
> < ACL data: handle 42 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 1691
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
> > ACL data: handle 42 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>       Success
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL:
> http://sourceforge.net/mailarchive/forum.php?forum=bluez-users/attachments/20060621/ede2029c/attachment.html
>
> ------------------------------
>
>
>
> ------------------------------
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
> End of Bluez-users Digest, Vol 2, Issue 26
> ******************************************
>

------=_Part_1016_30485354.1150948480851
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

An update to my earlier post below.<br>
<br>
on the korebot <br>
I changed the device -&gt; class id in hcid.conf so it was 0x0203xx
which meant it was Networking /Adhoc device with an access point. I
don't think this really changed anything when I ran a pand --connect
&lt;bluetooth address&gt;.<br>
<br>
I then tried to reconnect several times. I found this constant
connection woke up the host computer in some way and I was able to get
a bnep0 interface. I don't understand how this happens. <br>
I then assigned ip address on both the korebot and the host computer
and made sure both interfaces were up and running. I got this message
on the korebot when I tried to ping. <br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PING <a href="http://192.168.1.23">192.168.1.23</a> (<a href="http://192.168.1.23">192.168.1.23</a>): 56 data bytes<br>

NETDEV WATCHDOG: usbf: transmit timed out<br>

NETDEV WATCHDOG: usbf: transmit timed out<br>

NETDEV WATCHDOG: usbf: transmit timed out<br>

NETDEV WATCHDOG: usbf: transmit timed out<br>

NETDEV WATCHDOG: usbf: transmit timed out<br>

NETDEV WATCHDOG: usbf: transmit timed out<br>

NETDEV WATCHDOG: usbf: transmit timed out<br>
<br>
Is there some other trick to initialisation of the bnep0 interface?<br>
<br>
oot@Possibility:/home/krobinson# hcidump<br>
HCI sniffer - Bluetooth packet analyzer ver 1.23<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
&gt; HCI Event: Connect Request (0x04) plen 10<br>
&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&gt; HCI Event: Role Change (0x12) plen 8<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4<br>
&gt; HCI Event: Page Scan Repetition Mode Change (0x20) plen 7<br>
&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 15 scid 0x0040<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>
&lt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&gt; ACL data: handle 42 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 15 scid 0x0041<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>
&lt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&gt; ACL data: handle 42 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 15 scid 0x0042<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0042 result 0 status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>
&lt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&gt; ACL data: handle 42 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 15 scid 0x0043<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0043 result 0 status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>
&lt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&gt; ACL data: handle 42 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 15 scid 0x0044<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0044 result 0 status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>
&lt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&gt; ACL data: handle 42 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 15 scid 0x0045<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0045 scid 0x0045 result 0 status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0045 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>
&lt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0045 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0045 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0045 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&gt; ACL data: handle 42 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 15 scid 0x0046<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0046 scid 0x0046 result 0 status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0046 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>
&lt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0046 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0046 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0046 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&gt; ACL data: handle 42 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 15 scid 0x0047<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0047 result 0 status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>
&lt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0047 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0047 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&gt; ACL data: handle 42 flags 0x02 dlen 11<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 7 [psm 15]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BNEP: Control(0x01|0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Setup Req(0x01) size 0x02 dst 0x1116(NAP) src 0x1115(PANU)<br>
&lt; ACL data: handle 42 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 4 [psm 15]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BNEP: Control(0x01|0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Setup Rsp(0x02) res 0x0000<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 3<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 16 [psm 15]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BNEP: Control(0x01|0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Filter MultAddr Set(0x05) len 0x000c<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff<br>
&lt; ACL data: handle 42 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 4 [psm 15]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BNEP: Control(0x01|0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Filter MultAddr Rsp(0x06) res 0x0000<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 3<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 16 [psm 15]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BNEP: Control(0x01|0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Filter MultAddr Set(0x05) len 0x000c<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff<br>
&lt; ACL data: handle 42 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 4 [psm 15]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BNEP: Control(0x01|0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Filter MultAddr Rsp(0x06) res 0x0000<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 3<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 16 [psm 15]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BNEP: Control(0x01|0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Filter MultAddr Set(0x05) len 0x000c<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff<br>
&lt; ACL data: handle 42 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 4 [psm 15]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BNEP: Control(0x01|0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Filter MultAddr Rsp(0x06) res 0x0000<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 5<br>
&gt; ACL data: handle 42 flags 0x01 dlen 121<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 3<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 90<br>
&gt; ACL data: handle 42 flags 0x01 dlen 13<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 585 [psm 15]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BNEP: Compressed DestOnly(0x04|0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst ff:ff:ff:ff:ff:ff [proto 0x0800]<br>
&gt; ACL data: handle 42 flags 0x02 dlen 121<br>
&gt; ACL data: handle 42 flags 0x01 dlen 71<br>
&gt; ACL data: handle 42 flags 0x01 dlen 121<br>
&gt; ACL data: handle 42 flags 0x01 dlen 71<br>
&gt; ACL data: handle 42 flags 0x01 dlen 121<br>
&gt; ACL data: handle 42 flags 0x01 dlen 71<br>
&gt; ACL data: handle 42 flags 0x01 dlen 13<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 585 [psm 15]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BNEP: Compressed DestOnly(0x04|0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst ff:ff:ff:ff:ff:ff [proto 0x0800]<br>
&gt; ACL data: handle 42 flags 0x02 dlen 121<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 3<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 90<br>
&gt; ACL data: handle 42 flags 0x01 dlen 121<br>
&gt; ACL data: handle 42 flags 0x01 dlen 71<br>
&gt; ACL data: handle 42 flags 0x01 dlen 13<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 585 [psm 15]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BNEP: Compressed DestOnly(0x04|0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst ff:ff:ff:ff:ff:ff [proto 0x0800]<br>
&gt; ACL data: handle 42 flags 0x02 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 17<br>
&gt; ACL data: handle 42 flags 0x01 dlen 5<br>
&gt; ACL data: handle 42 flags 0x01 dlen 121<br>
&gt; ACL data: handle 42 flags 0x01 dlen 71<br>
&gt; ACL data: handle 42 flags 0x01 dlen 121<br>
&gt; ACL data: handle 42 flags 0x01 dlen 71<br>
&gt; ACL data: handle 42 flags 0x01 dlen 13<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 585 [psm 15]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BNEP: Compressed DestOnly(0x04|0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst ff:ff:ff:ff:ff:ff [proto 0x0800]<br>
&gt; ACL data: handle 42 flags 0x02 dlen 32<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 28 [psm 15]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BNEP: Control(0x01|0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Filter MultAddr Set(0x05) len 0x0018<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01:00:5e:00:00:01 - 01:00:5e:00:00:01<br>
&lt; ACL data: handle 42 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 4 [psm 15]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BNEP: Control(0x01|0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Filter MultAddr Rsp(0x06) res 0x0000<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 32<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 28 [psm 15]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BNEP: Control(0x01|0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Filter MultAddr Set(0x05) len 0x0018<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01:00:5e:00:00:01 - 01:00:5e:00:00:01<br>
&lt; ACL data: handle 42 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0047 len 4 [psm 15]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BNEP: Control(0x01|0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Filter MultAddr Rsp(0x06) res 0x0000<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
<br>
<br>
<br>
<br>
<br><br><div><span class="gmail_quote">On 6/21/06, <b class="gmail_sendername"><a href="mailto:bluez-users-request@lists.sourceforge.net">bluez-users-request@lists.sourceforge.net</a></b> &lt;<a href="mailto:bluez-users-request@lists.sourceforge.net">
bluez-users-request@lists.sourceforge.net</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Send Bluez-users mailing list submissions to
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a><br><br>Message: 5<br>Date: Wed, 21 Jun 2006 00:37:26 +1000<br>From: &quot;Ken Robinson&quot; &lt;<a href="mailto:kenrobinsonster@gmail.com">
kenrobinsonster@gmail.com</a>&gt;<br>Subject: [Bluez-users] Cannot Get bnep0 on pand connect<br>To: <a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a><br>Message-ID:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;<a href="mailto:aa7ce83b0606200737m3c91d17anfce14229ca245b13@mail.gmail.com">
aa7ce83b0606200737m3c91d17anfce14229ca245b13@mail.gmail.com</a>&gt;<br>Content-Type: text/plain; charset=&quot;iso-8859-1&quot;<br><br>Hi,<br>I am presently trying to get a bluetooth IP connection between two linux<br>boxes.
<br>I have made 2.25 bluez-utils and bluez-libs&nbsp;&nbsp;for&nbsp;&nbsp;both the&nbsp;&nbsp;host&nbsp;&nbsp;computer<br>(a kanotix 2.6.x kernel) and at target&nbsp;&nbsp;(a korebot with a 2.4.19 kernel with<br>the bluez patch-2.4.19-mh18 applied)<br>I have experimented on the host computer (a kanotix 
2.6.x kernel) and am<br>able to get a bnep0 interface.<br>For the connection between host and target:<br>I do the following:<br># modprobe bnep<br># pand --listen -r GN<br>On the target computer I do:<br># modprobe bnep<br>
# pand --connect &lt;BT address&gt;<br>I cannot get a bnep0 interface<br># ifconfig bnep0<br>ifconfig: bnep0: error fetching interface information: Device not found<br><br>The hcidump on the host computer is shown below. Does anyone have any ideas?
<br><br>root@Possibility:/home/krobinson# hcidump -X -V<br>HCI sniffer - Bluetooth packet analyzer ver 1.23<br>device: hci0 snap_len: 1028 filter: 0xffffffff<br>&gt; HCI Event: Connect Request (0x04) plen 10<br>&nbsp;&nbsp;&nbsp;&nbsp;bdaddr 00:02:72:B0:C5:FB class 0x000000 type ACL
<br>&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>&nbsp;&nbsp;&nbsp;&nbsp;bdaddr 00:02:72:B0:C5:FB role 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;Role: Master<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp;&nbsp;Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
<br>&gt; HCI Event: Role Change (0x12) plen 8<br>&nbsp;&nbsp;&nbsp;&nbsp;status 0x00 bdaddr 00:02:72:B0:C5:FB role 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;Role: Master<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br>&nbsp;&nbsp;&nbsp;&nbsp;status 0x00 handle 42 bdaddr 00:02:72:B0:C5:FB type ACL encrypt 0x00
<br>&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4<br>&nbsp;&nbsp;&nbsp;&nbsp;handle 42 ptype 0xcc18<br>&nbsp;&nbsp;&nbsp;&nbsp;Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>&gt; HCI Event: Page Scan Repetition Mode Change (0x20) plen 7<br>&nbsp;&nbsp;&nbsp;&nbsp;bdaddr 00:02:72:B0:C5:FB mode 1
<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp;&nbsp;Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1<br>&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>&nbsp;&nbsp;&nbsp;&nbsp;status 0x00 handle 42 ptype 0xcc18
<br>&nbsp;&nbsp;&nbsp;&nbsp;Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>&nbsp;&nbsp;&nbsp;&nbsp;handle 42 slots 5<br>&gt; ACL data: handle 42 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp;&nbsp;L2CAP(s): Connect req: psm 15 scid 0x0040<br>&lt; ACL data: handle 42 flags 0x02 dlen 16
<br>&nbsp;&nbsp;&nbsp;&nbsp;L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Connection successful<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp;&nbsp;handle 42 packets 1<br>&gt; ACL data: handle 42 flags 0x02 dlen 16
<br>&nbsp;&nbsp;&nbsp;&nbsp;L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MTU 1691<br>&lt; ACL data: handle 42 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp;&nbsp;L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Success<br>&lt; ACL data: handle 42 flags 0x02 dlen 16
<br>&nbsp;&nbsp;&nbsp;&nbsp;L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MTU 1691<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp;&nbsp;handle 42 packets 1<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp;&nbsp;&nbsp;&nbsp;handle 42 packets 1<br>&gt; ACL data: handle 42 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp;&nbsp;L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Success<br>-------------- next part --------------<br>An HTML attachment was scrubbed...
<br>URL: <a href="http://sourceforge.net/mailarchive/forum.php?forum=bluez-users/attachments/20060621/ede2029c/attachment.html">http://sourceforge.net/mailarchive/forum.php?forum=bluez-users/attachments/20060621/ede2029c/attachment.html
</a><br><br>------------------------------<br><br><br><br>------------------------------<br><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">
Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br><br><br>End of Bluez-users Digest, Vol 2, Issue 26
<br>******************************************<br></blockquote></div><br>

------=_Part_1016_30485354.1150948480851--


--===============0725299052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
--===============0725299052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0725299052==--
