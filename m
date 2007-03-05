Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0703050126n2696b8a7h7a4d36f605e6d2cc@mail.gmail.com>
Date: Mon, 5 Mar 2007 14:56:58 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1172921500.24446.10.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <57c68ddc0702282245x777b63e0la3156781ed55804f@mail.gmail.com>
	<1172921500.24446.10.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] rfcomm channel and ioctl
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0879620020=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0879620020==
Content-Type: multipart/alternative;
	boundary="----=_Part_127079_3294384.1173086818878"

------=_Part_127079_3294384.1173086818878
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,
          Thanks very much for the reply ... rfcomm sockets are working
perfectly .... rctest.c  example really eased out the things for me.

           I would like to contribute for the bluez development , if thats
possible please suggest ways in which i can do that , may be for the start i
can fix small bugs with known solution.

regards
siddhant

On 3/3/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Siddhant,
>
> >    Can someone tell me about tutorial describing how rfcomm and ioct
> > work in linux and about the underlying structure in kernel.
>
> no such thing exists. However RFCOMM programming is like programming
> TCP/IP and the rctest.c and attest.c files have code examples. The ioctl
> of RFCOMM are only needed for virtual TTY devices. Check the rfcomm
> utility source code to see how they work.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_127079_3294384.1173086818878
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks very much for the reply ... rfcomm sockets are working perfectly .... rctest.c&nbsp; example really eased out the things for me. <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I would like to contribute for the bluez development , if thats possible please suggest ways in which i can do that , may be for the start i can fix small bugs with known solution.
<br><br>regards<br>siddhant<br><br><div><span class="gmail_quote">On 3/3/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Siddhant,<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;Can someone tell me about tutorial describing how rfcomm and ioct<br>&gt; work in linux and about the underlying structure in kernel.<br><br>no such thing exists. However RFCOMM programming is like programming
<br>TCP/IP and the rctest.c and attest.c files have code examples. The ioctl<br>of RFCOMM are only needed for virtual TTY devices. Check the rfcomm<br>utility source code to see how they work.<br><br>Regards<br><br>Marcel
<br><br><br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>

------=_Part_127079_3294384.1173086818878--


--===============0879620020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0879620020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0879620020==--
