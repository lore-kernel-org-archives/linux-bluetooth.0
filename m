Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Khaled" <khaled@ipbill.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth Voice Setting
Message-ID: <HCEOIFALKKLBLJPENPNOGEGHCAAA.khaled@ipbill.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <4396F636.4020400@csr.com>
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
Date: Wed, 7 Dec 2005 15:00:50 -0000

Hi Steven

> They're not SCO packets. They're RFCOMM packets. There are no SCO
> packets on the trace.
>
> At the AT command level, the sequence is (with explanation):
>
>   < \r\nATD0208xxxxx13;\r\n  ; dial number (I've x'd out the number)
>   > \r\nOK\r\n               ; ok, will do
>   > \r\n+CIEV: 3,2\r\n       ; outgoing call setup in progress
>   [SCO link created at HCI]
>   > \r\n+CIEV: 3,3\r\n       ; remote party alerted
>   > \r\n+CIEV: 1,1\r\n       ; call active
>   > \r\n+CIEV: 3,0\r\n       ; no longer in call setup (now in call)
>   > \r\nERROR\r\n            ; something went wrong
>   > \r\n+CIEV: 1,0\r\n       ; call inactive
>   < \r\nAT+CHUP\r\n.         ; hangup
>   [SCO link disconnect started at HCI]
>   > \r\nOK\r\n               ; ok
>   [SCO link disconnect completes at HCI]
>
> It's worth noting that the local device splits AT messages across
> multiple RFCOMM frames. This is perfectly legal as RFCOMM is a byte
> stream not a packet stream so packet boundaries are meaningless [1].
>
> The key message is the "+CIEV: 1,0" from the other side. This indicates
> that the call has been dropped. The spec seems to imply that this in
> itself is sufficient for headset to know that the call has been
> dropped and that the AT+CHUP message is used only when the headset
> wants to initiate the disconnection. However, by this point the call
> is already down so it can't hurt.
>
> Presumably the preceeding "ERROR" indication is related. Unfortunately,
> it's not possible to tell what went wrong. All the spec says is:
>
>   * ERROR
>
>     Standard error indication code. It shall be issued on detection of
>     any syntax, format or procedure error condition. [...]
>
> Everything before the ERROR message exactly matches the reference
> message sequence chart in the spec.
>
> There are no SCO packets in the trace. Ar you sure your module is set
> to route SCO over HCI (as opposed to over a PCM port). hciconfig
> revision should tell you. You should also do hciconfig -a.
> It may be that the other side has got upset that the SCO link is up
> and it's connected to the remote side, but there has been no SCO data.

I am as sure as I can be given my being novice...

Output from hciconfig -a:

hci0:   Type: USB
        BD Address: 00:09:DD:10:29:78 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:45869 acl:1418 sco:0 events:2018 errors:0
        TX bytes:27530 acl:1445 sco:0 commands:252 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x200404
        Service Classes:
        Device Class: Audio/Video, Device conforms to the Headset profile
        HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver:
0x175
        Manufacturer: Cambridge Silicon Radio (10)

Output from hciconfig hcio revision:

hci0:   Type: USB
        BD Address: 00:09:DD:10:29:78 ACL MTU: 192:8 SCO MTU: 64:8
        HCI 14.7
        Chip version: BlueCore02-External (ES2)
        Max key size: 56 bit
        SCO mapping:  HCI

Any thoughts? I was wondering why then in the trace, is there references to
SCO? see below:

> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0E:6D:34:BD:B1 class 0x000000 type SCO
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:0E:6D:34:BD:B1 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 43 bdaddr 00:0E:6D:34:BD:B1 type SCO encrypt 0x01
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 43 ptype 0x00e0
    Packet type: HV1 HV2 HV3

Kind Regards



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
