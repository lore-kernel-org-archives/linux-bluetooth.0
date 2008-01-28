Return-Path: <cyrus@holtmann.org>
Message-ID: <5eee8c670801280407l543226d1of2498bc4736eb0d6@mail.gmail.com>
Date: Mon, 28 Jan 2008 12:07:38 +0000
From: "Odysseus Flappington" <deriziotis@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <5eee8c670801240322y265a6838we5de45ca22ba0501@mail.gmail.com>
MIME-Version: 1.0
References: <5eee8c670801240322y265a6838we5de45ca22ba0501@mail.gmail.com>
Subject: Re: [Bluez-users] Bluetooth dongle not reconnecting
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0768793824=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0768793824==
Content-Type: multipart/alternative;
	boundary="----=_Part_8182_27337466.1201522058743"

------=_Part_8182_27337466.1201522058743
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

Ok, so I've managed to fix this issue by issuing the following command:

sudo hciconfig hci0 reset

after which the kb/mouse will reconnect. Once I issue that command, the
errors in dmesg stop coming up as well. Placing this command in a startup
script sorts it out completely. I am however, having an issue with the
keyboard and mouse not working at the same time, but I don't think it is
because of this issue.

I do suspect that this is an issue for all external usb devices on ubuntu
only, since my internal laptop adapters work fine. And also, I haven't seen
any reports of this issue on other dists.

I've looked around a bit and found the following bugs:

https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/79394
https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/133690
https://bugs.launchpad.net/ubuntu/+source/gnome-bluetooth/+bug/110375

I've also tested this on two different usb adapters (the Edimax EB-DGC2 and
Trust BT120 usb which was on the Bluetooth Hardware support for Bluez list
http://www.linuxgod.net/bluez-dev.html). Behaviour is identical.

I will investigate using hciconfig hci0 down and then up to see if that does
the same as reset, and maybe triage a couple of those bugs.

Regards,
Alex



On 24/01/2008, Odysseus Flappington <deriziotis@gmail.com> wrote:
>
> I posted this last week sometime, but here it is again in the hopes my
> desperation will yield results.
>
> I can pair my bluetooth mouse and keyboard perfectly fine, but after
> rebooting, hidd doesn't re-establish the connections. I've tried
> re-connecting manually, but the only way to get them working again, is by
> re-pairing. I've tested other dongles which re-connect perfectly fine.
>
> My dmesg displays the following messages whenever I move the mouse:
>
> [  169.162683] hci_acldata_packet: hci0 ACL packet for unknown connection
> handle 42
> [  169.173697] hci_acldata_packet: hci0 ACL packet for unknown connection
> handle 42
> [  169.185666] hci_acldata_packet: hci0 ACL packet for unknown connection
> handle 42
> [  169.196648] hci_acldata_packet: hci0 ACL packet for unknown connection
> handle 42
> [  169.207684] hci_acldata_packet: hci0 ACL packet for unknown connection
> handle 42
> [  169.218657] hci_acldata_packet: hci0 ACL packet for unknown connection
> handle 42
> [  169.230635] hci_acldata_packet: hci0 ACL packet for unknown connection
> handle 42
> [  169.231635] hci_acldata_packet: hci0 ACL packet for unknown connection
> handle 42
> [  169.241628] hci_acldata_packet: hci0 ACL packet for unknown connection
> handle 42
> [  169.252655] hci_acldata_packet: hci0 ACL packet for unknown connection
> handle 42
> [  169.263642] hci_acldata_packet: hci0 ACL packet for unknown connection
> handle 42
> [  169.275601] hci_acldata_packet: hci0 ACL packet for unknown connection
> handle 42
> [  169.286629] hci_acldata_packet: hci0 ACL packet for unknown connection
> handle 42
>
> And my hcidump -X -V displays the following:
>
> > ACL data: handle 42 flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       0000: a1 02 00 03 fd 00                                 ......
> > ACL data: handle 42 flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       0000: a1 02 00 03 fd 00                                 ......
> > ACL data: handle 42 flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       0000: a1 02 00 01 00 00                                 ......
> > ACL data: handle 42 flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       0000: a1 02 00 02 fe 00                                 ......
> > ACL data: handle 42 flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       0000: a1 02 00 01 ff 00                                 ......
> > ACL data: handle 42 flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       0000: a1 02 00 02 ff 00                                 ......
> > ACL data: handle 42 flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       0000: a1 02 00 01 00 00                                 ......
> > ACL data: handle 42 flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       0000: a1 02 00 01 00 00                                 ......
> > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 42 mode 0x00 interval 0
>     Mode: Active
> > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 42 mode 0x02 interval 112
>     Mode: Sniff
>
> If I do a sudo hidd --connect [MAC] I get the following:
>
> Can't get device information: Operation already in progress
>
> I'm using an Edimax EB-DGC2 USB 2.0 bluetooth dongle running on Ubuntu
> 7.10 with bluez-utils 3.19-0ubuntu3.
>
> This is a shame, since the Edimax manufacturer's website actually
> advertises linux compatibility ( http://www.edimax.co.uk/en/produce_detail.php?pd_id=127&pl1_id=13&pl2_id=43
> ), but state they don't develop or maintain the drivers. Perhaps they can
> be contacted to help provide specs to solve the problem?
>
> Many thanks,
> Alex
>
>

------=_Part_8182_27337466.1201522058743
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br><br>Ok, so I&#39;ve managed to fix this issue by issuing the following command:<br><br>sudo hciconfig hci0 reset<br><br>after which the kb/mouse will reconnect. Once I issue that command, the errors in dmesg stop coming up as well. Placing this command in a startup script sorts it out completely. I am however, having an issue with the keyboard and mouse not working at the same time, but I don&#39;t think it is because of this issue.<br>

<br>I do suspect that this is an issue for all external usb devices on ubuntu only, since my internal laptop adapters work fine. And also, I haven&#39;t seen any reports of this issue on other dists.<br><br>I&#39;ve looked around a bit and found the following bugs:<br>

<br><a href="https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/79394" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/79394</a><br>
<a href="https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/133690" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/133690</a><br>
<a href="https://bugs.launchpad.net/ubuntu/+source/gnome-bluetooth/+bug/110375" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">https://bugs.launchpad.net/ubuntu/+source/gnome-bluetooth/+bug/110375</a><br>
<br>I&#39;ve also tested this on two different usb adapters (the Edimax EB-DGC2 and Trust BT120 usb which was on the Bluetooth Hardware support for Bluez list
<a href="http://www.linuxgod.net/bluez-dev.html" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://www.linuxgod.net/bluez-dev.html</a>). Behaviour is
identical.<br><br>I will investigate using hciconfig hci0 down and then up to see if that does the same as reset, and maybe triage a couple of those bugs.<br><br>Regards,<br>Alex<br><br><br><br><div><span class="gmail_quote">On 24/01/2008, <b class="gmail_sendername">Odysseus Flappington</b> &lt;<a href="mailto:deriziotis@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">deriziotis@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

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
</blockquote></div><br>

------=_Part_8182_27337466.1201522058743--


--===============0768793824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0768793824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0768793824==--
