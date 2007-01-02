Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0701020229w6ddfaab3yf989a8e3999cbd1@mail.gmail.com>
Date: Tue, 2 Jan 2007 15:59:19 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <20070102081813.6a264b0e.ml133@netpole.com.br>
MIME-Version: 1.0
References: <57c68ddc0701012354u4137d1d3s93b28cafaa53f849@mail.gmail.com>
	<1167725398.30886.32.camel@violet>
	<57c68ddc0701020016y29fafa8duf77494bb50ac6d75@mail.gmail.com>
	<20070102081813.6a264b0e.ml133@netpole.com.br>
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
Content-Type: multipart/mixed; boundary="===============1721167056=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1721167056==
Content-Type: multipart/alternative;
	boundary="----=_Part_135996_32074689.1167733759064"

------=_Part_135996_32074689.1167733759064
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi cris,
           I tried similar thing using OBEX push client and the thing that
happened is exactly what u apprehended ...
    ->  One thread waited for the other to get completed .... sad blues
behavior.....this is exactly what is creating trouble in my application ...
i will be doing more r n d based on ur suggestion and will definitely  mail
the results ... really nice to see someone taking interest in the problem
..... also can u tell me what part of the bluez code i should look for to
make such thing supported or what do u think where the problem can be (any
intutive insight will be helpful as i am just a starter) ... i am ready to
put lot of efforts to solve this problem if its possible for me to do so ...
thanks for the reply

regards
siddhant

On 1/2/07, Cris <ml133@netpole.com.br> wrote:
>
> On Tue, 2 Jan 2007 13:46:08 +0530
> "siddhant tewari" <siddhant.tewari@gmail.com> wrote:
>
> > hi,
> >    Honest thanks to u for ur reply. Just a small question:
> >     what i am trying is technically possible???
> >     I dont have any problem in sending the code but it would be great
> pain
> > for others to understand my code and some effort for me as well in
> making it
> > more understandable for others.
>
> Hi Siddhant,
>
> If the question, whether it is technically possible, refers to the
> specifications of bluetooth, the answer is yes. Being a master (i.e.,
> the device initiating the connections) you can connect to up to 7
> other different bluetooth devices. But if the question refers to
> BlueZ, I can't tell you for sure. A few months ago I tested this and
> it failed not too gracefully. This is one of the reasons why I don't
> use libbluetooth anymore.
>
> However, there is a simple way to test it. Obex push and obex ftp are
> different profiles, but technically they use exactly the same methods
> (hci, l2cap, rfcomm, obex). Thus if one works, the other will work as
> well and vice verse. But the usage of obex ftp is much easier. Obex
> ftp uses BlueZ to set up a connection the `BlueZ' way. If you prepare
> two sessions of obex ftp to different peers but with the same file,
> and launch them as fast as you can at the same time, they must arrive
> approximately at the time. Just make sure that the peers have similar
> hardware and transmission conditions. In any case, obexftp does show
> you activity, which must be visible for both at the same time. If one
> is waiting until the other is done, you've still got the original, sad
> blues behaviour. As there is no bit of code you wrote to do so, there
> is also no bit of a chance that you committed any error. So, there is
> no need to publish your code.
>
> I'd be curious to know the result.
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

------=_Part_135996_32074689.1167733759064
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi cris,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I tried similar thing using OBEX push client and the thing that happened is exactly what u apprehended ... <br>&nbsp;&nbsp;&nbsp; -&gt;&nbsp; One thread waited for the other to get completed .... sad blues behavior.....this is exactly what is creating trouble in my application ... i will be doing more r n d based on ur suggestion and will definitely&nbsp; mail the results ... really nice to see someone taking interest in the problem ..... also can u tell me what part of the bluez code i should look for to make such thing supported or what do u think where the problem can be (any intutive insight will be helpful as i am just a starter) ... i am ready to put lot of efforts to solve this problem if its possible for me to do so ... thanks for the reply
<br><br>regards<br>siddhant<br><br><div><span class="gmail_quote">On 1/2/07, <b class="gmail_sendername">Cris</b> &lt;<a href="mailto:ml133@netpole.com.br">ml133@netpole.com.br</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Tue, 2 Jan 2007 13:46:08 +0530<br>&quot;siddhant tewari&quot; &lt;<a href="mailto:siddhant.tewari@gmail.com">siddhant.tewari@gmail.com</a>&gt; wrote:<br><br>&gt; hi,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;Honest thanks to u for ur reply. Just a small question:
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; what i am trying is technically possible???<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; I dont have any problem in sending the code but it would be great pain<br>&gt; for others to understand my code and some effort for me as well in making it
<br>&gt; more understandable for others.<br><br>Hi Siddhant,<br><br>If the question, whether it is technically possible, refers to the<br>specifications of bluetooth, the answer is yes. Being a master (i.e.,<br>the device initiating the connections) you can connect to up to 7
<br>other different bluetooth devices. But if the question refers to<br>BlueZ, I can&#39;t tell you for sure. A few months ago I tested this and<br>it failed not too gracefully. This is one of the reasons why I don&#39;t<br>
use libbluetooth anymore.<br><br>However, there is a simple way to test it. Obex push and obex ftp are<br>different profiles, but technically they use exactly the same methods<br>(hci, l2cap, rfcomm, obex). Thus if one works, the other will work as
<br>well and vice verse. But the usage of obex ftp is much easier. Obex<br>ftp uses BlueZ to set up a connection the `BlueZ&#39; way. If you prepare<br>two sessions of obex ftp to different peers but with the same file,<br>
and launch them as fast as you can at the same time, they must arrive<br>approximately at the time. Just make sure that the peers have similar<br>hardware and transmission conditions. In any case, obexftp does show<br>you activity, which must be visible for both at the same time. If one
<br>is waiting until the other is done, you&#39;ve still got the original, sad<br>blues behaviour. As there is no bit of code you wrote to do so, there<br>is also no bit of a chance that you committed any error. So, there is
<br>no need to publish your code.<br><br>I&#39;d be curious to know the result.<br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join 
SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys - and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_135996_32074689.1167733759064--


--===============1721167056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1721167056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1721167056==--
