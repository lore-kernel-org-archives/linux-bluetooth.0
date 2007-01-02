Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0701020016y29fafa8duf77494bb50ac6d75@mail.gmail.com>
Date: Tue, 2 Jan 2007 13:46:08 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1167725398.30886.32.camel@violet>
MIME-Version: 1.0
References: <57c68ddc0701012354u4137d1d3s93b28cafaa53f849@mail.gmail.com>
	<1167725398.30886.32.camel@violet>
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
Content-Type: multipart/mixed; boundary="===============1029567265=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1029567265==
Content-Type: multipart/alternative;
	boundary="----=_Part_135382_16499703.1167725768190"

------=_Part_135382_16499703.1167725768190
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,
   Honest thanks to u for ur reply. Just a small question:
    what i am trying is technically possible???
    I dont have any problem in sending the code but it would be great pain
for others to understand my code and some effort for me as well in making it
more understandable for others.

  Again thanking u for the advise.

regards
siddhant

On 1/2/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi,
>
> >     I am trying to open multiple connections by connecting to OBEX
> > push servers on different mobiles using single blue tooth adapter. The
> > steps that i am taking right now are as follows:-
> >
> > i) Detecting bluetooth devices.
> > ii) Sending data to any detected device through a different process (i
> > do a fork in the main program). This new process first sets up  a
> > RFCOMM channel to the devices OBEX push server and then sends data to
> > it through using open obex API.
> >
> > But the above scheme  is not working correctly. Can someone tell me
> > the mistake i am making and how should i correct it. Please help me as
> > i find my  self quite clueless abt to how to proceed now. Also it
> > would be great help if anyone can even give me a direction in which i
> > should proceed now.
>
> you should start using "hcidump -X -V" as root to see what actually
> happens. And without seeing the code, we can't tell you anything.
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
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_135382_16499703.1167725768190
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,<br>&nbsp;&nbsp; Honest thanks to u for ur reply. Just a small question:<br>&nbsp;&nbsp;&nbsp; what i am trying is technically possible???<br>&nbsp;&nbsp;&nbsp; I dont have any problem in sending the code but it would be great pain for others to understand my code and some effort for me as well in making it more understandable for others.
<br><br>&nbsp; Again thanking u for the advise.<br><br>regards<br>siddhant<br><br><div><span class="gmail_quote">On 1/2/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; I am trying to open multiple connections by connecting to OBEX
<br>&gt; push servers on different mobiles using single blue tooth adapter. The<br>&gt; steps that i am taking right now are as follows:-<br>&gt;<br>&gt; i) Detecting bluetooth devices.<br>&gt; ii) Sending data to any detected device through a different process (i
<br>&gt; do a fork in the main program). This new process first sets up&nbsp;&nbsp;a<br>&gt; RFCOMM channel to the devices OBEX push server and then sends data to<br>&gt; it through using open obex API.<br>&gt;<br>&gt; But the above scheme&nbsp;&nbsp;is not working correctly. Can someone tell me
<br>&gt; the mistake i am making and how should i correct it. Please help me as<br>&gt; i find my&nbsp;&nbsp;self quite clueless abt to how to proceed now. Also it<br>&gt; would be great help if anyone can even give me a direction in which i
<br>&gt; should proceed now.<br><br>you should start using &quot;hcidump -X -V&quot; as root to see what actually<br>happens. And without seeing the code, we can&#39;t tell you anything.<br><br>Regards<br><br>Marcel<br><br>
<br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys - and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_135382_16499703.1167725768190--


--===============1029567265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1029567265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1029567265==--
