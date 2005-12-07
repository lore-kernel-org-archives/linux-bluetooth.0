Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Khaled" <khaled@ipbill.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth Voice Setting
Message-ID: <HCEOIFALKKLBLJPENPNOKEGGCAAA.khaled@ipbill.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1133957382.3752.12.camel@blade>
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
Date: Wed, 7 Dec 2005 12:18:18 -0000


Hi Marcel,

> > > if you wanna emulate a headset then you need to add Headset profile
> > > records and not Headset Audio Gateway records.
> >
> > I mean to use the handsfree profile, so that I can speak into
> my computer
> > through a headset (earphone and mic), sorry if I was unclear earlier.
>
> if you wanna use a headset with your computer you don't really need any
> additional service records.

But why dont I get any sound at the computer? Is there something to do with
the sound settings on my computer? it uses alsa and is functional already -
do I need to do anything specific for this purpose?

>From the following I understand that once the SCO link is established (when
a phone call is made), HV3 SCO packets are transmitted with voice data, but
then what do the subsequent mean? I assume they are incoming HV3 packets?
Then the local host gives up the reserved bandwidth for sco and disconnects?
But then why does it the error 0x13 and remote user disconnects message?
Were there any packets transmitted at all? Why the "i....ERROR..>"?

---EXTRACT---

> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 43 ptype 0x0080
    Packet type: HV3
> ACL data: handle 40 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 0]
      0000: 69 ef 1d 0d 0a 2b 43 49  45 56 3a 20 33 2c 33 0d  i....+CIEV:
3,3.
      0010: 0a 3e                                             .>
> ACL data: handle 40 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 0]
      0000: 69 ef 1d 0d 0a 2b 43 49  45 56 3a 20 31 2c 31 0d  i....+CIEV:
1,1.
      0010: 0a 3e                                             .>
> ACL data: handle 40 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 0]
      0000: 69 ef 1d 0d 0a 2b 43 49  45 56 3a 20 33 2c 30 0d  i....+CIEV:
3,0.
      0010: 0a 3e                                             .>
> ACL data: handle 40 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 0]
      0000: 69 ef 13 0d 0a 45 52 52  4f 52 0d 0a 3e           i....ERROR..>
> ACL data: handle 40 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 0]
      0000: 69 ef 1d 0d 0a 2b 43 49  45 56 3a 20 31 2c 30 0d  i....+CIEV:
1,0.
      0010: 0a 3e                                             .>
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 0]
      0000: 6b ef 05 0d 0a e4                                 k.....
< ACL data: handle 40 flags 0x02 dlen 15
    L2CAP(d): cid 0x0040 len 11 [psm 0]
      0000: 6b ef 0f 41 54 2b 43 48  55 50 e4                 k..AT+CHUP.
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 0]
      0000: 6b ef 05 0d 0a e4                                 k.....
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 0]
      0000: 69 ff 01 03 22                                    i..."
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 43 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 0]
      0000: 69 ef 0d 0d 0a 4f 4b 0d  0a 3e                    i....OK..>
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 43 reason 0x16
    Reason: Connection Terminated by Local Host

---EXTRACT---

Kind Regards

Khaled



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
