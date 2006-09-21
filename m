Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60609211241r54ccbf5k7da10f8ffaa5a695@mail.gmail.com>
Date: Thu, 21 Sep 2006 12:41:41 -0700
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1158867330.11194.50.camel@localhost>
MIME-Version: 1.0
References: <be976db60609211230m6333bca7x4778a76f23bfbc8a@mail.gmail.com>
	<1158867330.11194.50.camel@localhost>
Subject: Re: [Bluez-users] RFCOMM error
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0963923210=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0963923210==
Content-Type: multipart/alternative;
	boundary="----=_Part_15346_3447813.1158867701184"

------=_Part_15346_3447813.1158867701184
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Many thanks.  That fixed the problem....

Mark

On 9/21/06, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Mark,
>
> > I have a an RFCOMM server process listening on one box.  From a Linux
> > laptop,
> > I just wrote a simple RFCOMM client to connect to it.  Very simple,
> > via AF_BLUETOOTH, SOCK_SEQPACKET and
> > BTPROTO_RFCOMM.
> >
> > I got back errno as Bad File Descriptor.  When I strace it, I saw this
> > line:
> >
> >    socket(PF_BLUETOOTH, SOCK_SEQPACKET, 3) = -1  ESOCKTNOSUPPORT
> > (Socket type not supported).
> >
> > What does that mean?  Did I construct the socket wrong?
>
> for RFCOMM it must be SOCK_STREAM.
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
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_15346_3447813.1158867701184
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><br>Many thanks.&nbsp; That fixed the problem....</div>
<div>&nbsp;</div>
<div>Mark<br>&nbsp;</div>
<div><span class="gmail_quote">On 9/21/06, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Mark,<br><br>&gt; I have a an RFCOMM server process listening on one box.&nbsp;&nbsp;From a Linux<br>&gt; laptop,
<br>&gt; I just wrote a simple RFCOMM client to connect to it.&nbsp;&nbsp;Very simple,<br>&gt; via AF_BLUETOOTH, SOCK_SEQPACKET and<br>&gt; BTPROTO_RFCOMM.<br>&gt;<br>&gt; I got back errno as Bad File Descriptor.&nbsp;&nbsp;When I strace it, I saw this
<br>&gt; line:<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;socket(PF_BLUETOOTH, SOCK_SEQPACKET, 3) = -1&nbsp;&nbsp;ESOCKTNOSUPPORT<br>&gt; (Socket type not supported).<br>&gt;<br>&gt; What does that mean?&nbsp;&nbsp;Did I construct the socket wrong?<br><br>for RFCOMM it must be SOCK_STREAM.
<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys -- and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_15346_3447813.1158867701184--


--===============0963923210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0963923210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0963923210==--
