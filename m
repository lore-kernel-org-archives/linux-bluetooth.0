Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <42a1c7990707101509p6d2a0721l955637f9114ba55a@mail.gmail.com>
Date: Tue, 10 Jul 2007 15:09:18 -0700
From: "Rajesh Tripathi" <rajesh.tripathi@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Problem in rfcomm connect : Operation now in progress
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1377877322=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1377877322==
Content-Type: multipart/alternative;
	boundary="----=_Part_207460_9848232.1184105358890"

------=_Part_207460_9848232.1184105358890
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I have been trying to connect to some bluetooth devices on linux kernel 2.6.
I have all the bluez utilities and libs installed. I am able to perform
basic queries using commands like "hcitool scan" and "hcitool info". However
I am not able to connect to any of the devices using "rfcomm connect"
command.

I also tried writing small code to connect to devices using sockets, but I
am getting exactly the same error. I searched both on the bluez mailing list
and google, but I was not able to find anything similar. Here are the
details of the commands I ran and the hcidump.


Commands:
__________________________________________________________________________________________________________________________________

rajesh@rkumar6-DESK:/etc/bluetooth$ uname -a
Linux rkumar6-DESK 2.6.20-16-generic #2 SMP Thu Jun 7 20:19:32 UTC 2007 i686
GNU/Linux


rajesh@rkumar6-DESK:/etc/bluetooth$ sudo hcitool info 00:02:5B:00:F0:07
Requesting information ...
        BD Address:  00:02:5B:00:F0:07
        Device Name: Imote2
        LMP Version: 2.0 (0x3) LMP Subversion: 0xa5e
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0x19 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset>

                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2
packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>

                <power control> <transparent SCO> <broadcast encrypt>
                <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
                <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
                <extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave>
                <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
                <AFH cap. master> <AFH class. master> <extended features>


rajesh@rkumar6-DESK:/etc/bluetooth$ sudo rfcomm connect /dev/rfcomm0
00:02:5B:00:F0:07 1
Password:
Can't connect RFCOMM socket: Operation now in progress


The corresponding hcidump to the above command:
__________________________________________________________________
rajesh@rkumar6-DESK:~/BlueToothDocs/exp$ sudo hcidump
HCI sniffer - Bluetooth packet analyzer ver 1.33
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< ACL data: handle 3 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> HCI Event: Command Status (0x0f) plen 4
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Command Complete (0x0e) plen 6
> HCI Event: Read Remote Supported Features (0x0b) plen 11
< HCI Command: Sniff Mode (0x02|0x0003) plen 10
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Mode Change (0x14) plen 6
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4

Running it again gives the same error

rajesh@rkumar6-DESK:/etc/bluetooth$ sudo rfcomm connect /dev/rfcomm0
00:02:5B:00:F0:07 1
Can't connect RFCOMM socket: Operation now in progress

I wrote a small code to use sockets to connect to the device, but could not.
I tried setting O_NONBLOCK true and connecting .. it does not help. I get
the same error 115 "Operation in progress."

Thanks for your time!

With warm regards,
Rajesh

------=_Part_207460_9848232.1184105358890
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I have been trying to connect to some bluetooth devices on linux kernel 2.6. I have all the bluez utilities and libs installed. I am able to perform basic queries using commands like &quot;hcitool scan&quot; and &quot;hcitool info&quot;. However I am not able to connect to any of the devices using &quot;rfcomm connect&quot; command. 
<br><br>I also tried writing small code to connect to devices using sockets, but I am getting exactly the same error. I searched both on the bluez mailing list and google, but I was not able to find anything similar. Here are the details of the commands I ran and the hcidump. 
<br><br><br>Commands:<br>__________________________________________________________________________________________________________________________________<br><br>rajesh@rkumar6-DESK:/etc/bluetooth$ uname -a<br>Linux rkumar6-DESK 
2.6.20-16-generic #2 SMP Thu Jun 7 20:19:32 UTC 2007 i686 GNU/Linux<br><br><br>rajesh@rkumar6-DESK:/etc/bluetooth$ sudo hcitool info 00:02:5B:00:F0:07<br>Requesting information ...<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 00:02:5B:00:F0:07
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Name: Imote2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 2.0 (0x3) LMP Subversion: 0xa5e<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x8f 0xfe 0x9b 0x19 0x00 0x80<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt; &lt;slot offset&gt; 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; &lt;sniff mode&gt; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;park state&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO link&gt; &lt;HV2 packets&gt; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt; &lt;paging scheme&gt; 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;power control&gt; &lt;transparent SCO&gt; &lt;broadcast encrypt&gt; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;EDR ACL 2 Mbps&gt; &lt;EDR ACL 3 Mbps&gt; &lt;enhanced iscan&gt; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;interlaced iscan&gt; &lt;interlaced pscan&gt; &lt;inquiry with RSSI&gt; 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;extended SCO&gt; &lt;EV4 packets&gt; &lt;EV5 packets&gt; &lt;AFH cap. slave&gt; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;AFH class. slave&gt; &lt;3-slot EDR ACL&gt; &lt;5-slot EDR ACL&gt; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;AFH cap. master&gt; &lt;AFH class. master&gt; &lt;extended features&gt; 
<br><br><br>rajesh@rkumar6-DESK:/etc/bluetooth$ sudo rfcomm connect /dev/rfcomm0 00:02:5B:00:F0:07 1<br>Password:<br>Can&#39;t connect RFCOMM socket: Operation now in progress<br><br><br>The corresponding hcidump to the above command:
<br>__________________________________________________________________<br>rajesh@rkumar6-DESK:~/BlueToothDocs/exp$ sudo hcidump<br>HCI sniffer - Bluetooth packet analyzer ver 1.33<br>device: hci0 snap_len: 1028 filter: 0xffffffff
<br>&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br>&lt; ACL data: handle 3 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 3 scid 0x0040
<br>&lt; HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>&gt; HCI Event: Command Complete (0x0e) plen 6
<br>&gt; HCI Event: Read Remote Supported Features (0x0b) plen 11<br>&lt; HCI Command: Sniff Mode (0x02|0x0003) plen 10<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&gt; HCI Event: Mode Change (0x14) plen 6<br>&lt; HCI Command: Disconnect (0x01|0x0006) plen 3
<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&gt; HCI Event: Disconn Complete (0x05) plen 4<br><br>Running it again gives the same error<br><br>rajesh@rkumar6-DESK:/etc/bluetooth$ sudo rfcomm connect /dev/rfcomm0 00:02:5B:00:F0:07 1
<br>Can&#39;t connect RFCOMM socket: Operation now in progress<br><br>I wrote a small code to use sockets to connect to the device, but could not. I tried setting O_NONBLOCK true and connecting .. it does not help. I get the same error 115 &quot;Operation in progress.&quot;
<br><br>Thanks for your time!<br><br>With warm regards,<br>Rajesh<br>

------=_Part_207460_9848232.1184105358890--


--===============1377877322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1377877322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1377877322==--
