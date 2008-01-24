Return-Path: <cyrus@holtmann.org>
Message-ID: <5eee8c670801240322y265a6838we5de45ca22ba0501@mail.gmail.com>
Date: Thu, 24 Jan 2008 11:22:48 +0000
From: "Odysseus Flappington" <deriziotis@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Bluetooth dongle not reconnecting
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0071265980=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0071265980==
Content-Type: multipart/alternative;
	boundary="----=_Part_23325_29675283.1201173768446"

------=_Part_23325_29675283.1201173768446
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I posted this last week sometime, but here it is again in the hopes my
desperation will yield results.

I can pair my bluetooth mouse and keyboard perfectly fine, but after
rebooting, hidd doesn't re-establish the connections. I've tried
re-connecting manually, but the only way to get them working again, is by
re-pairing. I've tested other dongles which re-connect perfectly fine.

My dmesg displays the following messages whenever I move the mouse:

[  169.162683] hci_acldata_packet: hci0 ACL packet for unknown connection
handle 42
[  169.173697] hci_acldata_packet: hci0 ACL packet for unknown connection
handle 42
[  169.185666] hci_acldata_packet: hci0 ACL packet for unknown connection
handle 42
[  169.196648] hci_acldata_packet: hci0 ACL packet for unknown connection
handle 42
[  169.207684] hci_acldata_packet: hci0 ACL packet for unknown connection
handle 42
[  169.218657] hci_acldata_packet: hci0 ACL packet for unknown connection
handle 42
[  169.230635] hci_acldata_packet: hci0 ACL packet for unknown connection
handle 42
[  169.231635] hci_acldata_packet: hci0 ACL packet for unknown connection
handle 42
[  169.241628] hci_acldata_packet: hci0 ACL packet for unknown connection
handle 42
[  169.252655] hci_acldata_packet: hci0 ACL packet for unknown connection
handle 42
[  169.263642] hci_acldata_packet: hci0 ACL packet for unknown connection
handle 42
[  169.275601] hci_acldata_packet: hci0 ACL packet for unknown connection
handle 42
[  169.286629] hci_acldata_packet: hci0 ACL packet for unknown connection
handle 42

And my hcidump -X -V displays the following:

> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: a1 02 00 03 fd 00                                 ......
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: a1 02 00 03 fd 00                                 ......
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: a1 02 00 01 00 00                                 ......
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: a1 02 00 02 fe 00                                 ......
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: a1 02 00 01 ff 00                                 ......
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: a1 02 00 02 ff 00                                 ......
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: a1 02 00 01 00 00                                 ......
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: a1 02 00 01 00 00                                 ......
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x00 interval 0
    Mode: Active
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x02 interval 112
    Mode: Sniff

If I do a sudo hidd --connect [MAC] I get the following:

Can't get device information: Operation already in progress

I'm using an Edimax EB-DGC2 USB 2.0 bluetooth dongle running on Ubuntu
7.10with bluez-utils
3.19-0ubuntu3.

This is a shame, since the Edimax manufacturer's website actually advertises
linux compatibility (
http://www.edimax.co.uk/en/produce_detail.php?pd_id=127&pl1_id=13&pl2_id=43),
but state they don't develop or maintain the drivers. Perhaps they can be
contacted to help provide specs to solve the problem?

Many thanks,
Alex

------=_Part_23325_29675283.1201173768446
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I posted this last week sometime, but here it is again in the hopes my desperation will yield results.<br><br>I can pair my bluetooth mouse and keyboard perfectly fine, but after rebooting, hidd doesn&#39;t re-establish the connections. I&#39;ve tried re-connecting manually, but the only way to get them working again, is by re-pairing. I&#39;ve tested other dongles which re-connect perfectly fine.
<br><br>My dmesg displays the following messages whenever I move the mouse:<br><br>[&nbsp; 169.162683] hci_acldata_packet: hci0 ACL packet for unknown connection handle 42<br>[&nbsp; 169.173697] hci_acldata_packet: hci0 ACL packet for unknown connection handle 42
<br>
[&nbsp; 169.185666] hci_acldata_packet: hci0 ACL packet for unknown connection handle 42
<br>[&nbsp; 169.196648] hci_acldata_packet: hci0 ACL packet for unknown connection handle 42<br>[&nbsp; 169.207684] hci_acldata_packet: hci0 ACL packet for unknown connection handle 42<br>[&nbsp; 169.218657] hci_acldata_packet: hci0 ACL packet for unknown connection handle 42
<br>[&nbsp; 169.230635] hci_acldata_packet: hci0 ACL packet for unknown connection handle 42<br>[&nbsp; 169.231635] hci_acldata_packet: hci0 ACL packet for unknown connection handle 42<br>[&nbsp; 169.241628] hci_acldata_packet: hci0 ACL packet for unknown connection handle 42
<br>[&nbsp; 169.252655] hci_acldata_packet: hci0 ACL packet for unknown connection handle 42<br>[&nbsp; 169.263642] hci_acldata_packet: hci0 ACL packet for unknown connection handle 42<br>[&nbsp; 169.275601] hci_acldata_packet: hci0 ACL packet for unknown connection handle 42
<br>[&nbsp; 169.286629] hci_acldata_packet: hci0 ACL packet for unknown connection handle 42<br><br>And my hcidump -X -V displays the following:<br><br>&gt; ACL data: handle 42 flags 0x02 dlen 10<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 6 [psm 0]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: a1 02 00 03 fd 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......
<br>&gt; ACL data: handle 42 flags 0x02 dlen 10<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 6 [psm 0]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: a1 02 00 03 fd 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>&gt; ACL data: handle 42 flags 0x02 dlen 10<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 6 [psm 0]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: a1 02 00 01 00 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>&gt; ACL data: handle 42 flags 0x02 dlen 10<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 6 [psm 0]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: a1 02 00 02 fe 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......
<br>&gt; ACL data: handle 42 flags 0x02 dlen 10<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 6 [psm 0]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: a1 02 00 01 ff 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>&gt; ACL data: handle 42 flags 0x02 dlen 10<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 6 [psm 0]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: a1 02 00 02 ff 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>&gt; ACL data: handle 42 flags 0x02 dlen 10<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 6 [psm 0]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: a1 02 00 01 00 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......
<br>&gt; ACL data: handle 42 flags 0x02 dlen 10<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 6 [psm 0]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: a1 02 00 01 00 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>&gt; HCI Event: Mode Change (0x14) plen 6<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 42 mode 0x00 interval 0
<br>&nbsp;&nbsp;&nbsp; Mode: Active<br>&gt; HCI Event: Mode Change (0x14) plen 6<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 42 mode 0x02 interval 112<br>&nbsp;&nbsp;&nbsp; Mode: Sniff<br><br>If I do a sudo hidd --connect [MAC] I get the following:<br><br>Can&#39;t get device information: Operation already in progress
<br><br>I&#39;m using an Edimax EB-DGC2 USB 2.0 bluetooth dongle running on Ubuntu 7.10 with bluez-utils 3.19-0ubuntu3.<br><br>This is a shame, since the Edimax manufacturer&#39;s website actually advertises linux compatibility (
<a href="http://www.edimax.co.uk/en/produce_detail.php?pd_id=127&amp;pl1_id=13&amp;pl2_id=43" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://www.edimax.co.uk/en/produce_detail.php?pd_id=127&amp;pl1_id=13&amp;pl2_id=43
</a>), but state they don&#39;t develop or maintain the drivers. Perhaps they can be contacted to help provide specs to solve the problem?
<br><br>Many thanks,<br>Alex<br><br>

------=_Part_23325_29675283.1201173768446--


--===============0071265980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0071265980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0071265980==--
