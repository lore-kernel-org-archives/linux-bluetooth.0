Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6af20b8d0701020116q53944d1ct6825712e761d3afc@mail.gmail.com>
Date: Tue, 2 Jan 2007 17:16:28 +0800
From: "Tianlei Zhao" <ztl.post@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4f436aae0612241219n2904ee46p7dfe9328afddf254@mail.gmail.com>
MIME-Version: 1.0
References: <4f436aae0612241219n2904ee46p7dfe9328afddf254@mail.gmail.com>
Subject: Re: [Bluez-devel] hci data flow
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1653462431=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1653462431==
Content-Type: multipart/alternative;
	boundary="----=_Part_116839_30243312.1167729388151"

------=_Part_116839_30243312.1167729388151
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

You can resort to the book "Linux Network Architecture" which has a skeletal
description of linux bluetooth stack.

On 12/25/06, Choi Sonim <choisonim@gmail.com> wrote:
>
> Hi all,
>
> I'm trying to understand the full loop of low level data flow
> when using a serial bluetooth device.
> Can someone please explain it in terms of kernel file names / functions ?
>
> User writing -> hci_sock_sendmsg -> hci_sched_tx ?
>
> User reading -> hci_sock_recvmsg -> ?
>
> where are the regular serial/uart functions are called ?
> where are the hci_ldisc.c functions called ?
>
>

------=_Part_116839_30243312.1167729388151
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

You can resort to the book &quot;Linux Network Architecture&quot; which has a skeletal<br>description of linux bluetooth stack.<br><br><div><span class="gmail_quote">On 12/25/06, <b class="gmail_sendername">Choi Sonim</b> &lt;
<a href="mailto:choisonim@gmail.com">choisonim@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi all,<br><br>
I&#39;m trying to understand the full loop of low level data flow<br>when using a serial bluetooth device.<br>Can someone please explain it in terms of kernel file names / functions ?<br><br>User writing -&gt; hci_sock_sendmsg -&gt; hci_sched_tx ?
<br><br>User reading -&gt; hci_sock_recvmsg -&gt; ?<br><br>where are the regular serial/uart functions are called ?<br>where are the hci_ldisc.c functions called ?<br><br></blockquote></div><br>

------=_Part_116839_30243312.1167729388151--


--===============1653462431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1653462431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1653462431==--
