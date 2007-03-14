Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0703140039k3c249569s771e1a07459ea7cc@mail.gmail.com>
Date: Wed, 14 Mar 2007 13:09:35 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <45F7972D.7080709@yahoo.com.au>
MIME-Version: 1.0
References: <57c68ddc0703130100v68ef402dx647e81460d5ff189@mail.gmail.com>
	<45F7972D.7080709@yahoo.com.au>
Subject: Re: [Bluez-users] suitable BT USB dongle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0901832093=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0901832093==
Content-Type: multipart/alternative;
	boundary="----=_Part_45569_17086278.1173857975964"

------=_Part_45569_17086278.1173857975964
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi bluez.mexon,

                    Thanks for the reply especially for the fine details
which would have taken some effort to jolt down. I think you have answered
all of my questions very clearly.

I would need class 1 dongle , as there is a need to establish connection
with devices which may be 100mt apart.

Thanks again for the reply.

regards
siddhant

On 3/14/07, bluez.mexon@spamgourmet.com <bluez.mexon@spamgourmet.com> wrote:
>
> siddhant tewari - siddhant.tewari@gmail.com wrote:
> > hi Marcel,
> >              Can you suggest which BT USB dongle i should use , which
> can
> > support all the latest bluetooth 2.0 specification features namely:-
> >
> >              i) EDR.
> >              ii) Multiple Connections.
> >
> > With bluez.
>
> Since no-one else has piped up, and I've recently been through this
> myself, here's my experience...
>
> First, you want a dongle with the CSR (Cambridge Silicon Radio)
> "Bluecore" chipset.  There are various versions of Bluecore, the latest
> seems to be Bluecore 4.  CSR chips seems to be more stable and just
> generally work better.  Also, since the bluez developers all prefer CSR
> chips, the equipment they buy for themselves tends to be CSR, which
> means bluez tends to be better supported with CSR.
>
> Of course that now raises the question, how can you know which dongles
> are CSR?  And it's not easy.  There's some information here from the
> last time I asked:
>
>
> http://sourceforge.net/mailarchive/forum.php?thread_id=31657125&forum_id=1883
>
> If you get a Bluetooth 2.0 dongle, then you definitely have EDR (unless
> I've spectacularly misunderstood something).  EDR is basically the whole
> point of Bluetooth 2.0.
>
> Similarly, every bluetooth dongle, no matter what version, should
> support multiple connections.  Mainly this is up to the software to
> support elegantly.
>
> Having said that though, I recently bought a dongle and tried to use it
> with a bluetooth headset (high quality audio, A2DP) and a mouse
> simultaneously.  If I was using the mouse, the audio kept cutting out.
> I don't know if this is the fault of the hardware or the software.  But
> in any case, multiple connections were working, it's just that they
> weren't working fast enough for A2DP.  Maybe if it was a Bluetooth 2.0
> dongle this would have worked better.
>
> And the last question is, what range do you need?  My experience has
> been that if the devices are in the same room, a class 2 device is
> enough, but if you want to communicate between rooms, get a class 1
> device.  Most bluetooth dongles are class 2, so if you need class 1 it
> might be harder to find something.
>
> Hope this helps, and I hope other people reading the list will jump in
> to correct anything I've got wrong.
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_45569_17086278.1173857975964
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi bluez.mexon,<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks for the reply especially for the fine details which would have taken some effort to jolt down. I think you have answered all of my questions very clearly.<br><br>I would need class 1 dongle , as there is a need to establish connection with devices which may be 100mt apart.
<br><br>Thanks again for the reply.<br><br>regards<br>siddhant<br><br><div><span class="gmail_quote">On 3/14/07, <b class="gmail_sendername"><a href="mailto:bluez.mexon@spamgourmet.com">bluez.mexon@spamgourmet.com</a></b>
 &lt;<a href="mailto:bluez.mexon@spamgourmet.com">bluez.mexon@spamgourmet.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
siddhant tewari - <a href="mailto:siddhant.tewari@gmail.com">siddhant.tewari@gmail.com</a> wrote:<br>&gt; hi Marcel,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Can you suggest which BT USB dongle i should use , which can<br>&gt; support all the latest bluetooth 
2.0 specification features namely:-<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i) EDR.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ii) Multiple Connections.<br>&gt;<br>&gt; With bluez.<br><br>Since no-one else has piped up, and I&#39;ve recently been through this
<br>myself, here&#39;s my experience...<br><br>First, you want a dongle with the CSR (Cambridge Silicon Radio)<br>&quot;Bluecore&quot; chipset.&nbsp;&nbsp;There are various versions of Bluecore, the latest<br>seems to be Bluecore 4.&nbsp;&nbsp;CSR chips seems to be more stable and just
<br>generally work better.&nbsp;&nbsp;Also, since the bluez developers all prefer CSR<br>chips, the equipment they buy for themselves tends to be CSR, which<br>means bluez tends to be better supported with CSR.<br><br>Of course that now raises the question, how can you know which dongles
<br>are CSR?&nbsp;&nbsp;And it&#39;s not easy.&nbsp;&nbsp;There&#39;s some information here from the<br>last time I asked:<br><br><a href="http://sourceforge.net/mailarchive/forum.php?thread_id=31657125&amp;forum_id=1883">http://sourceforge.net/mailarchive/forum.php?thread_id=31657125&amp;forum_id=1883
</a><br><br>If you get a Bluetooth 2.0 dongle, then you definitely have EDR (unless<br>I&#39;ve spectacularly misunderstood something).&nbsp;&nbsp;EDR is basically the whole<br>point of Bluetooth 2.0.<br><br>Similarly, every bluetooth dongle, no matter what version, should
<br>support multiple connections.&nbsp;&nbsp;Mainly this is up to the software to<br>support elegantly.<br><br>Having said that though, I recently bought a dongle and tried to use it<br>with a bluetooth headset (high quality audio, A2DP) and a mouse
<br>simultaneously.&nbsp;&nbsp;If I was using the mouse, the audio kept cutting out.<br>I don&#39;t know if this is the fault of the hardware or the software.&nbsp;&nbsp;But<br>in any case, multiple connections were working, it&#39;s just that they
<br>weren&#39;t working fast enough for A2DP.&nbsp;&nbsp;Maybe if it was a Bluetooth 2.0<br>dongle this would have worked better.<br><br>And the last question is, what range do you need?&nbsp;&nbsp;My experience has<br>been that if the devices are in the same room, a class 2 device is
<br>enough, but if you want to communicate between rooms, get a class 1<br>device.&nbsp;&nbsp;Most bluetooth dongles are class 2, so if you need class 1 it<br>might be harder to find something.<br><br>Hope this helps, and I hope other people reading the list will jump in
<br>to correct anything I&#39;ve got wrong.<br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_45569_17086278.1173857975964--


--===============0901832093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0901832093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0901832093==--
