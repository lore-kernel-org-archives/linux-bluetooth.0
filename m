Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 18 Apr 2007 18:19:53 -0700 (PDT)
From: walt shekrota <penguinacity@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1176939477.6741.26.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Message-ID: <619708.58049.qm@web62305.mail.re1.yahoo.com>
Subject: Re: [Bluez-users] security block
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1561656311=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1561656311==
Content-Type: multipart/alternative; boundary="0-1213338629-1176945593=:58049"
Content-Transfer-Encoding: 8bit

--0-1213338629-1176945593=:58049
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,
I'm a little lost why it gets it. I think some indirect reason is why pin is neg reply. '0000' is the right pin!

swordfish bluetooth # sdptool browse
Inquiring ...
Browsing 00:19:1F:29:E0:4C ...


This is the last 25% or so of the hcidump. you can see the pin refusal and the security block at the end. This is after pairing and running btsco for headset address.


> ACL data: handle 41 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0xd
          count 10
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10001
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x2 > >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "Headset"
              aid 0x0302 (unknown)
                 bool 0x1
          cont 00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0042 scid 0x0040
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0042 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:19:1F:29:E0:4C
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:19:1F:29:E0:4C
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:19:1F:29:E0:4C
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 3 status 0
      Connection refused - security block
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x13
    Reason: Remote User Terminated Connection

=========================================

Here is the tail of the log itself.

snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 5462 count: 24
snd-bt-sco: prepare ok bps: 16000 size: 5462 count: 24
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
snd-bt-sco: capture_open
snd-bt-sco: capture_prepare
snd-bt-sco: prepare ok bps: 16000 size: 5462 count: 24
snd-bt-sco: capture_prepare
snd-bt-sco: prepare ok bps: 16000 size: 5462 count: 24
snd-bt-sco: capture_trigger 1
snd-bt-sco: setting capture to bspcm
Bluetooth: SCO (Voice Link) ver 0.5
Bluetooth: SCO socket layer initialized
snd-bt-sco: capture_trigger 0
snd-bt-sco: setting capture to NULL
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL
snd-bt-sco: Disposing of previous socket count 3
snd-bt-sco: file_count is 1 (expected 3)
snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 5462 count: 24
snd-bt-sco: prepare ok bps: 16000 size: 5462 count: 24
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
hci_scodata_packet: hci0 SCO packet for unknown connection handle 44
snd-bt-sco: Disposing of previous socket count 1
hci_scodata_packet: hci0 SCO packet for unknown connection handle 49

Marcel Holtmann <marcel@holtmann.org> wrote: Hi Walt,

> Can anyone explain what might be the condition when l2cap responds
> with 'security block' as seen in the sniffer?

this can have multiple reasons. Check "hcidump -X -V" and also look at
the syslog messages from hcid.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


       
---------------------------------
Ahhh...imagining that irresistible "new car" smell?
 Check outnew cars at Yahoo! Autos.
--0-1213338629-1176945593=:58049
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,<br>I'm a little lost why it gets it. I think some indirect reason is why pin is neg reply. '0000' is the right pin!<br><br>swordfish bluetooth # sdptool browse<br>Inquiring ...<br>Browsing 00:19:1F:29:E0:4C ...<br><br><br>This is the last 25% or so of the hcidump. you can see the pin refusal and the security block at the end. This is after pairing and running btsco for headset address.<br><br><br>&gt; ACL data: handle 41 flags 0x02 dlen 22<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 18 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x2 len 0xd<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 10<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint
 0x10001<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0x2 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0006 (LangBaseAttrIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x656e uint 0x6a uint 0x100
 &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x1108 (Headset) uint 0x100 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str "Headset"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0302 (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool 0x1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&lt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0042 scid 0x0040<br>&lt; HCI Command: Read Voice Setting (0x03|0x0025) plen 0<br>&gt; HCI Event: Number of Completed
 Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 41 packets 1<br>&gt; HCI Event: Command Complete (0x0e) plen 6<br>&nbsp;&nbsp;&nbsp; Read Voice Setting (0x03|0x0025) ncmd 1<br>&nbsp;&nbsp;&nbsp; status 0x00 voice setting 0x0060<br>&lt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 3 scid 0x0041<br>&gt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0042 scid 0x0040<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 41 packets 1<br>&gt; ACL data: handle 41 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0041 result 1 status 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection pending - Authorization pending<br>&gt; HCI Event: PIN Code Request (0x16) plen 6<br>&nbsp;&nbsp;&nbsp; bdaddr 00:19:1F:29:E0:4C<br>&lt; HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6<br>&nbsp;&nbsp;&nbsp; bdaddr
 00:19:1F:29:E0:4C<br>&gt; HCI Event: Command Complete (0x0e) plen 10<br>&nbsp;&nbsp;&nbsp; PIN Code Request Negative Reply (0x01|0x000e) ncmd 1<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:19:1F:29:E0:4C<br>&gt; ACL data: handle 41 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 3 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection refused - security block<br>&gt; HCI Event: Disconn Complete (0x05) plen 4<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 41 reason 0x13<br>&nbsp;&nbsp;&nbsp; Reason: Remote User Terminated Connection<br><br>=========================================<br><br>Here is the tail of the log itself.<br><br>snd-bt-sco: playback_open<br>snd-bt-sco: prepare ok bps: 16000 size: 5462 count: 24<br>snd-bt-sco: prepare ok bps: 16000 size: 5462 count: 24<br>snd-bt-sco: playback_trigger 1<br>snd-bt-sco: setting playback to bspcm<br>snd-bt-sco: capture_open<br>snd-bt-sco: capture_prepare<br>snd-bt-sco: prepare ok bps:
 16000 size: 5462 count: 24<br>snd-bt-sco: capture_prepare<br>snd-bt-sco: prepare ok bps: 16000 size: 5462 count: 24<br>snd-bt-sco: capture_trigger 1<br>snd-bt-sco: setting capture to bspcm<br>Bluetooth: SCO (Voice Link) ver 0.5<br>Bluetooth: SCO socket layer initialized<br>snd-bt-sco: capture_trigger 0<br>snd-bt-sco: setting capture to NULL<br>snd-bt-sco: playback_trigger 0<br>snd-bt-sco: setting playback to NULL<br>snd-bt-sco: Disposing of previous socket count 3<br>snd-bt-sco: file_count is 1 (expected 3)<br>snd-bt-sco: playback_open<br>snd-bt-sco: prepare ok bps: 16000 size: 5462 count: 24<br>snd-bt-sco: prepare ok bps: 16000 size: 5462 count: 24<br>snd-bt-sco: playback_trigger 1<br>snd-bt-sco: setting playback to bspcm<br>hci_scodata_packet: hci0 SCO packet for unknown connection handle 44<br>snd-bt-sco: Disposing of previous socket count 1<br>hci_scodata_packet: hci0 SCO packet for unknown connection handle 49<br><br><b><i>Marcel Holtmann
 &lt;marcel@holtmann.org&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Hi Walt,<br><br>&gt; Can anyone explain what might be the condition when l2cap responds<br>&gt; with 'security block' as seen in the sniffer?<br><br>this can have multiple reasons. Check "hcidump -X -V" and also look at<br>the syslog messages from hcid.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br>http://sourceforge.net/powerbar/db2/<br>_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;



      <hr size=1>Ahhh...imagining that irresistible "new car" smell?<br> Check out
<a href="http://us.rd.yahoo.com/evt=48245/*http://autos.yahoo.com/new_cars.html;_ylc=X3oDMTE1YW1jcXJ2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDbmV3LWNhcnM-">new cars at Yahoo! Autos.</a>

--0-1213338629-1176945593=:58049--


--===============1561656311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1561656311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1561656311==--
