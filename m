Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <6af20b8d0701022000j32baae52m5a563f4f3ca3e324@mail.gmail.com>
Date: Wed, 3 Jan 2007 12:00:07 +0800
From: "Tianlei Zhao" <ztl.post@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <459AED37.20008@glidos.net>
MIME-Version: 1.0
References: <57c68ddc0701012354u4137d1d3s93b28cafaa53f849@mail.gmail.com>
	<57c68ddc0701020229w6ddfaab3yf989a8e3999cbd1@mail.gmail.com>
	<20070102094414.f7b9cef1.ml133@netpole.com.br>
	<57c68ddc0701020446y3a7e70edh74f6ea5e0b05d07f@mail.gmail.com>
	<1167743069.30886.54.camel@violet> <459A60A1.80906@glidos.net>
	<1167745840.30886.77.camel@violet> <459AC8B4.7090407@glidos.net>
	<1167772692.30886.117.camel@violet> <459AED37.20008@glidos.net>
Subject: Re: [Bluez-users] problem in making multiple connections using
	single bluetooth adapter using bluez
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1076222994=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1076222994==
Content-Type: multipart/alternative;
	boundary="----=_Part_126899_30378081.1167796807448"

------=_Part_126899_30378081.1167796807448
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 1/3/07, Paul Gardiner <osronline@glidos.net> wrote:

> > ACL data: handle 42 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0041 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> < ACL data: handle 42 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0203 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7


here we have established the RFCOMM session(control channel).

 > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
>  > ACL data: handle 42 flags 0x02 dlen 17
>  > ACL data: handle 42 flags 0x01 dlen 1
>     L2CAP(d): cid 0x0041 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>       dlci 4 frame_type 0 credit_flow 15 pri 32 ack_timer 0
>       frame_size 1024 max_retrans 0 credits 7
> < ACL data: handle 42 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0203 len 4 [psm 3]
>       RFCOMM(s): DM: cr 1 dlci 4 pf 1 ilen 0 fcs 0xbc


And why a DM for channel 4 is sent as a response  of  a PN CMD for dlci 0 ?
Should this not happen ? There must be some problem of the command that
was received. Maybe we've got a corrupted command for dlci 4 and that
hcidump
didn't show it up.

 > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
>  > ACL data: handle 42 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0203
> < ACL data: handle 42 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0203
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1



This is really strange.

------=_Part_126899_30378081.1167796807448
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="gmail_quote">On 1/3/07, <b class="gmail_sendername">Paul Gardiner</b> &lt;<a href="mailto:osronline@glidos.net">osronline@glidos.net</a>&gt; wrote:</span> <br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
 &gt; ACL data: handle 42 flags 0x02 dlen 8<br> &nbsp; &nbsp; L2CAP(d): cid 0x0041 len 4 [psm 3]<br> &nbsp; &nbsp; &nbsp; RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c<br>&lt; ACL data: handle 42 flags 0x02 dlen 8<br> &nbsp; &nbsp; L2CAP(d): cid 0x0203 len 4 [psm 3]
<br> &nbsp; &nbsp; &nbsp; RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7</blockquote><div><br>here we have established the RFCOMM session(control channel).<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br> &nbsp; &nbsp; handle 42 packets 1<br>&nbsp;&gt; ACL data: handle 42 flags 0x02 dlen 17<br>&nbsp;&gt; ACL data: handle 42 flags 0x01 dlen 1<br> &nbsp; &nbsp; L2CAP(d): cid 0x0041 len 14 [psm 3]
<br> &nbsp; &nbsp; &nbsp; RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8<br> &nbsp; &nbsp; &nbsp; dlci 4 frame_type 0 credit_flow 15 pri 32 ack_timer 0<br> &nbsp; &nbsp; &nbsp; frame_size 1024 max_retrans 0 credits 7<br>&lt; ACL data: handle 42 flags 0x02 dlen 8
<br> &nbsp; &nbsp; L2CAP(d): cid 0x0203 len 4 [psm 3]<br> &nbsp; &nbsp; &nbsp; RFCOMM(s): DM: cr 1 dlci 4 pf 1 ilen 0 fcs 0xbc</blockquote><div><br>And why a DM for channel 4 is sent as a response&nbsp; of&nbsp; a PN CMD for dlci 0 ? <br>Should this not happen ? There must be some problem of the command that 
<br>was received. Maybe we&#39;ve got a corrupted command for dlci 4 and that hcidump<br>didn&#39;t show it up.<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br> &nbsp; &nbsp; handle 42 packets 1<br>&nbsp;&gt; ACL data: handle 42 flags 0x02 dlen 12<br> &nbsp; &nbsp; L2CAP(s): Disconn req: dcid 0x0041 scid 0x0203<br>&lt; ACL data: handle 42 flags 0x02 dlen 12
<br> &nbsp; &nbsp; L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0203<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br> &nbsp; &nbsp; handle 42 packets 1</blockquote></div><br><br>This is really strange. <br><br>

------=_Part_126899_30378081.1167796807448--


--===============1076222994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1076222994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1076222994==--
