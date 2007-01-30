Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <80236d750701300639w59ec30f0n7eeeca203a513be5@mail.gmail.com>
Date: Tue, 30 Jan 2007 15:39:45 +0100
From: "Emanuele Novelli" <ema.novelli@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <ef9938ec0701271830p6f171d9cu892458220baa9362@mail.gmail.com>
MIME-Version: 1.0
References: <80236d750701250229u61cbb820v929b8d0ad6ae3fb9@mail.gmail.com>
	<ef9938ec0701271830p6f171d9cu892458220baa9362@mail.gmail.com>
Subject: Re: [Bluez-users] multithread / multi process use
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0885668257=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0885668257==
Content-Type: multipart/alternative;
	boundary="----=_Part_24552_7512467.1170167985311"

------=_Part_24552_7512467.1170167985311
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Well I maybe I could try this, just 2 questions:

1 .can the daemon  hci manage simultenous requests from variuos
process/threads without problem ?

2 .where I can find some api docs(if any) about the hcid ?

2007/1/28, Albert Huang <albert@csail.mit.edu>:
>
> I think the proper thing to do here is to have your application use
> the D-Bus API, which should do the right thing across multiple
> processes.  Maybe someone else who's more in touch with hcid can give
> more details.
>
> -albert
>
> On 1/25/07, Emanuele Novelli <ema.novelli@gmail.com> wrote:
> > Hello I'm new here, I searched for this issue but found nothing.
> >
> > Using 2 threads or 2 process for reading a name of a 2 remote devices at
> > same time reports always the same name.
> > Is this a bug or the hci functions in library do not support concurrent
> use
> > ?
> > (using 2.6.19 kernel on FC6 and bluez libs 3.7.1)
> >
> > This is a simply way to reproduce this:
> >
> > open a 2 shells and issue 2 commands at same time
> >
> > hcitool name <bdaddress of a device close to you>
> >
> > they both report the same name
> >
> > here an HCI dump of what's happening
> >
> > 2007-01-25 11:15:06.093319 < HCI Command: Remote Name Request
> (0x01|0x0019)
> > plen 10
> >     bdaddr 00:0A:28:DF:2B:D8 mode 2 clkoffset 0x0000
> > 2007-01-25 11:15:06.114456 > HCI Event: Command Status (0x0f) plen 4
> >     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> > 2007-01-25 11:15:06.712794 < HCI Command: Remote Name Request
> (0x01|0x0019)
> > plen 10
> >     bdaddr 00:17:4B:D3:9F:5B mode 2 clkoffset 0x0000
> > 2007-01-25 11:15:06.717442 > HCI Event: Command Status (0x0f) plen 4
> >     Remote Name Request (0x01|0x0019) status 0x00 ncmd 0
> > 2007-01-25 11:15:07.238429 > HCI Event: Remote Name Req Complete (0x07)
> plen
> > 255
> >     status 0x00 bdaddr 00:0A:28:DF:2B:D8 name 'Seleso'
> > 2007-01-25 11:15:07.239434 > HCI Event: Command Status (0x0f) plen 4
> >     Unknown (0x00|0x0000) status 0x00 ncmd 1
> > 2007-01-25 11:15:10.151342 > HCI Event: Remote Name Req Complete (0x07)
> plen
> > 255
> >     status 0x00 bdaddr 00:17:4B:D3:9F:5B name 'Wince'
> >
> > the second event with the second name is tracked but never reported back
> to
> > the caller cause the unknown event received.
> > so i see the name 'Seleso' as result on both the shells
> >
> > this is the behaviour if I use the 2 command sequentially they works
> fine.
> >
> > hcitool name 00:0A:28:DF:2B:D8
> >
> > 2007-01-25 11:19:51.930394 < HCI Command: Remote Name Request
> (0x01|0x0019)
> > plen 10
> >     bdaddr 00:0A:28:DF:2B:D8 mode 2 clkoffset 0x0000
> > 2007-01-25 11:19:51.951520 > HCI Event: Command Status (0x0f) plen 4
> >     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> > 2007-01-25 11:19:52.199514 > HCI Event: Remote Name Req Complete (0x07)
> plen
> > 255
> >     status 0x00 bdaddr 00:0A:28:DF:2B:D8 name 'Seleso'
> >
> > hcitool name 00:17:4B:D3:9F:5B
> >
> > 2007-01-25 11:20:39.520967 < HCI Command: Remote Name Request
> (0x01|0x0019)
> > plen 10
> >     bdaddr 00:17:4B:D3:9F:5B mode 2 clkoffset 0x0000
> > 2007-01-25 11:20:39.542195 > HCI Event: Command Status (0x0f) plen 4
> >     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> > 2007-01-25 11:20:43.358090 > HCI Event: Remote Name Req Complete (0x07)
> plen
> > 255
> >     status 0x00 bdaddr 00:17:4B:D3:9F:5B name 'Wince'
> >
> >
> >
> >
> > Since I need to use search names and search services (FAX especially) on
> a
> > multi-threaded application i'd like to know if is this possible or
> somewhere
> > there is a issue that prevent this.
> >
> >
> >
> >
> -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> > opinions on IT & business topics through brief surveys - and earn cash
> >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> >
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> >
> >
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_24552_7512467.1170167985311
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Well I maybe I could try this, just 2 questions:<br><br>1 .can the daemon&nbsp; hci manage simultenous requests from variuos process/threads without problem ?<br><br>2 .where I can find some api docs(if any) about the hcid ?<br>
<br><div><span class="gmail_quote">2007/1/28, Albert Huang &lt;<a href="mailto:albert@csail.mit.edu">albert@csail.mit.edu</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I think the proper thing to do here is to have your application use<br>the D-Bus API, which should do the right thing across multiple<br>processes.&nbsp;&nbsp;Maybe someone else who&#39;s more in touch with hcid can give<br>more details.
<br><br>-albert<br><br>On 1/25/07, Emanuele Novelli &lt;<a href="mailto:ema.novelli@gmail.com">ema.novelli@gmail.com</a>&gt; wrote:<br>&gt; Hello I&#39;m new here, I searched for this issue but found nothing.<br>&gt;<br>&gt; Using 2 threads or 2 process for reading a name of a 2 remote devices at
<br>&gt; same time reports always the same name.<br>&gt; Is this a bug or the hci functions in library do not support concurrent use<br>&gt; ?<br>&gt; (using 2.6.19 kernel on FC6 and bluez libs 3.7.1)<br>&gt;<br>&gt; This is a simply way to reproduce this:
<br>&gt;<br>&gt; open a 2 shells and issue 2 commands at same time<br>&gt;<br>&gt; hcitool name &lt;bdaddress of a device close to you&gt;<br>&gt;<br>&gt; they both report the same name<br>&gt;<br>&gt; here an HCI dump of what&#39;s happening
<br>&gt;<br>&gt; 2007-01-25 11:15:06.093319 &lt; HCI Command: Remote Name Request (0x01|0x0019)<br>&gt; plen 10<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; bdaddr 00:0A:28:DF:2B:D8 mode 2 clkoffset 0x0000<br>&gt; 2007-01-25 11:15:06.114456 &gt; HCI Event: Command Status (0x0f) plen 4
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Remote Name Request (0x01|0x0019) status 0x00 ncmd 1<br>&gt; 2007-01-25 11:15:06.712794 &lt; HCI Command: Remote Name Request (0x01|0x0019)<br>&gt; plen 10<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; bdaddr 00:17:4B:D3:9F:5B mode 2 clkoffset 0x0000
<br>&gt; 2007-01-25 11:15:06.717442 &gt; HCI Event: Command Status (0x0f) plen 4<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Remote Name Request (0x01|0x0019) status 0x00 ncmd 0<br>&gt; 2007-01-25 11:15:07.238429 &gt; HCI Event: Remote Name Req Complete (0x07) plen
<br>&gt; 255<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:0A:28:DF:2B:D8 name &#39;Seleso&#39;<br>&gt; 2007-01-25 11:15:07.239434 &gt; HCI Event: Command Status (0x0f) plen 4<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Unknown (0x00|0x0000) status 0x00 ncmd 1<br>&gt; 2007-01-25 11:15:
10.151342 &gt; HCI Event: Remote Name Req Complete (0x07) plen<br>&gt; 255<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:17:4B:D3:9F:5B name &#39;Wince&#39;<br>&gt;<br>&gt; the second event with the second name is tracked but never reported back to
<br>&gt; the caller cause the unknown event received.<br>&gt; so i see the name &#39;Seleso&#39; as result on both the shells<br>&gt;<br>&gt; this is the behaviour if I use the 2 command sequentially they works fine.<br>&gt;
<br>&gt; hcitool name 00:0A:28:DF:2B:D8<br>&gt;<br>&gt; 2007-01-25 11:19:51.930394 &lt; HCI Command: Remote Name Request (0x01|0x0019)<br>&gt; plen 10<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; bdaddr 00:0A:28:DF:2B:D8 mode 2 clkoffset 0x0000<br>&gt; 2007-01-25 11:19:
51.951520 &gt; HCI Event: Command Status (0x0f) plen 4<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Remote Name Request (0x01|0x0019) status 0x00 ncmd 1<br>&gt; 2007-01-25 11:19:52.199514 &gt; HCI Event: Remote Name Req Complete (0x07) plen<br>&gt; 255<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:0A:28:DF:2B:D8 name &#39;Seleso&#39;<br>&gt;<br>&gt; hcitool name 00:17:4B:D3:9F:5B<br>&gt;<br>&gt; 2007-01-25 11:20:39.520967 &lt; HCI Command: Remote Name Request (0x01|0x0019)<br>&gt; plen 10
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; bdaddr 00:17:4B:D3:9F:5B mode 2 clkoffset 0x0000<br>&gt; 2007-01-25 11:20:39.542195 &gt; HCI Event: Command Status (0x0f) plen 4<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Remote Name Request (0x01|0x0019) status 0x00 ncmd 1<br>&gt; 2007-01-25 11:20:
43.358090 &gt; HCI Event: Remote Name Req Complete (0x07) plen<br>&gt; 255<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:17:4B:D3:9F:5B name &#39;Wince&#39;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt; Since I need to use search names and search services (FAX especially) on a
<br>&gt; multi-threaded application i&#39;d like to know if is this possible or somewhere<br>&gt; there is a issue that prevent this.<br>&gt;<br>&gt;<br>&gt;<br>&gt; -------------------------------------------------------------------------
<br>&gt; Take Surveys. Earn Cash. Influence the Future of IT<br>&gt; Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>&gt; opinions on IT &amp; business topics through brief surveys - and earn cash
<br>&gt; <a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>&gt;<br>&gt; _______________________________________________
<br>&gt; Bluez-users mailing list<br>&gt; <a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>&gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br>&gt;<br>&gt;<br>&gt;<br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys - and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_24552_7512467.1170167985311--


--===============0885668257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0885668257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0885668257==--
