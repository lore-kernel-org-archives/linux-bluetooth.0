Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050228152830.78812.qmail@web60903.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] SDP service
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1109599768.17256.72.camel@pegasus>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-314700677-1109604510=:77439"
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
Date: Mon, 28 Feb 2005 23:28:30 +0800 (CST)

--0-314700677-1109604510=:77439
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi Marcel!
    My config of bluez tools are as follows:
bluez-utils-2.15
bluez-libs-2.15
bluez-sdp-1.5-1.i386.rpm
bluez-pan-1.1-1.i386.rpm
bluez-hcidump-1.18
bluez-hciemu-1.1
    Is there any tool that have newer version than I've installed? Or is there any problem about the sdp/pan installation?
Michael

Marcel Holtmann <marcel@holtmann.org> wrote:
Hi Michael,

> I'm configuring BlueZ's SDP. But when I searched
> my home's and lab's Linux PC respectively, the
> services provided by my lab's PC is more than that by
> my home one, with the following that my home's PC
> doesn't apply: SAP (SIM Access) and HF (Handsfree).
> Also, I doesn't find any service that represents
> "synchronization". Therefore, even though I added T610
> as "handsfree device", and the "connect" item is
> displayed in my home's PC's selection list, when I
> tried to connect to my PC, the "Bluetooth connection
> failed" dialog appeared. The tools and libraries
> installed in my home's and lab's PCs are the same,
> with utils, libs, pan rpm, sdp rpm, and hcidump all
> most updated version. What is the problem, and how can
> I do?

if you use the old bluez-{sdp|pan} packages then this is your first
mistake. They are no longer supported and not needed anymore.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



---------------------------------
Yahoo! 工具列 - 內置防止彈出視窗工能！

--0-314700677-1109604510=:77439
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Hi Marcel!</DIV>
<DIV>&nbsp;&nbsp;&nbsp; My config of bluez tools are as follows:</DIV>
<DIV>bluez-utils-2.15</DIV>
<DIV>bluez-libs-2.15</DIV>
<DIV>bluez-sdp-1.5-1.i386.rpm</DIV>
<DIV>bluez-pan-1.1-1.i386.rpm</DIV>
<DIV>bluez-hcidump-1.18</DIV>
<DIV>bluez-hciemu-1.1</DIV>
<DIV>&nbsp;&nbsp;&nbsp; Is there any tool that have newer version than I've installed? Or is there any problem about the sdp/pan installation?<BR>Michael</DIV>
<DIV><BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi Michael,<BR><BR>&gt; I'm configuring BlueZ's SDP. But when I searched<BR>&gt; my home's and lab's Linux PC respectively, the<BR>&gt; services provided by my lab's PC is more than that by<BR>&gt; my home one, with the following that my home's PC<BR>&gt; doesn't apply: SAP (SIM Access) and HF (Handsfree).<BR>&gt; Also, I doesn't find any service that represents<BR>&gt; "synchronization". Therefore, even though I added T610<BR>&gt; as "handsfree device", and the "connect" item is<BR>&gt; displayed in my home's PC's selection list, when I<BR>&gt; tried to connect to my PC, the "Bluetooth connection<BR>&gt; failed" dialog appeared. The tools and libraries<BR>&gt; installed in my home's and lab's PCs are the same,<BR>&gt; with utils, libs, pan rpm, sdp rpm, and hcidump all<BR>&gt; most updated version. What is the problem, and how can<BR>&gt; I do?<BR><BR>if you use the old
 bluez-{sdp|pan} packages then this is your first<BR>mistake. They are no longer supported and not needed anymore.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR><BR>-------------------------------------------------------<BR>SF email is sponsored by - The IT Product Guide<BR>Read honest &amp; candid reviews on hundreds of IT Products from real users.<BR>Discover which products truly live up to the hype. Start reading now.<BR>http://ads.osdn.com/?ad_id=6595&amp;alloc_id=14396&amp;op=click<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><p><br><hr size=1>Yahoo! 工具列 - <a href=http://hk.toolbar.yahoo.com>內置防止彈出視窗工能</a>！<br>
--0-314700677-1109604510=:77439--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
