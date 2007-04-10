Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0704100617s3beb9f5cq52cc594522d27d08@mail.gmail.com>
Date: Tue, 10 Apr 2007 18:47:28 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <2b1fa7660704080119s2275a60dm40655cbf9d6b3ba7@mail.gmail.com>
MIME-Version: 1.0
References: <57c68ddc0704071440m7b05678fs5c3bea4d2cf28a4c@mail.gmail.com>
	<2b1fa7660704080119s2275a60dm40655cbf9d6b3ba7@mail.gmail.com>
Subject: Re: [Bluez-users] using class 1 dongle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0533584759=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0533584759==
Content-Type: multipart/alternative;
	boundary="----=_Part_22645_5170963.1176211048451"

------=_Part_22645_5170963.1176211048451
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Thomas,
                 Really great to get a answer ... i think my mobile phone
has class 2 bt adapter ... but this issue is a real shock for me ... i
thought if any of the devices has a good range , communication channel will
be established and data transfer will take place , but all this theory goes
in vain .

Can u tell  why this things happen (both the devices should be class 1 ) or
where can i look  for the reasons for such a behavior, because i need to
inform this to one of my project head and knowing the reason will always
help ......

waiting for reply

regards
siddhant

On 4/8/07, Thomas Kear <thomas.kear@gmail.com> wrote:
>
> The "100 metre" range depends on both devices being class 1.  If you
> have a class 1 device talking to a class 2 (10m) device, your maximum
> range may be higher than 10 metres due to the increased transmit power
> and recieve sensitivity, but won't be anything like 100m.
>
> Unlike 802.11 there is no user-adjustable transmit power either,
> you're stuck with the dongle figuring that out for you.
>
> If your phone is class1 (a few are, but 99.5% are class2) then you
> genuinely have an issue, which could be as simple as a wall in the way
> which is blocking the signal, or as difficult as your neighbour having
> a leaking microwave oven.
>
> On 08/04/07, siddhant tewari <siddhant.tewari@gmail.com> wrote:
> > hi,
> >    I am using class 1 dongle which says it has 100 mt range , but to my
> > surprise using this dongle i cannot search my mobile phone which are
> even
> > around 30 - 40 mts.
> >
> > Are there any special commands which should be issued to the
> microprocessor
> > in the dongle so that its full range can be exploited.
> >
> > and
> >
> > Are there any set of instruction by which i can verify the range of the
> > dongle.
> >
> > Also can anyone tell me about the class 1 dongle they use , their
> experience
> > and the range to which their dongle can detect devices.
> >
> > regards
> > siddhant
> >
> >
> -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> > opinions on IT & business topics through brief surveys-and earn cash
> >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> >
>
>
> --
> Thomas Kear
> thomas.kear@gmail.com
> +6421996496
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

------=_Part_22645_5170963.1176211048451
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Thomas,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Really great to get a answer ... i think my mobile phone has class 2 bt adapter ... but this issue is a real shock for me ... i thought if any of the devices has a good range , communication channel will be established and data transfer will take place , but all this theory goes in vain . 
<br><br>Can u tell&nbsp; why this things happen (both the devices should be class 1 ) or where can i look&nbsp; for the reasons for such a behavior, because i need to inform this to one of my project head and knowing the reason will always help ......
<br><br>waiting for reply <br><br>regards<br>siddhant<br><br><div><span class="gmail_quote">On 4/8/07, <b class="gmail_sendername">Thomas Kear</b> &lt;<a href="mailto:thomas.kear@gmail.com">thomas.kear@gmail.com</a>&gt; wrote:
</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">The &quot;100 metre&quot; range depends on both devices being class 1.&nbsp;&nbsp;If you<br>have a class 1 device talking to a class 2 (10m) device, your maximum
<br>range may be higher than 10 metres due to the increased transmit power<br>and recieve sensitivity, but won&#39;t be anything like 100m.<br><br>Unlike 802.11 there is no user-adjustable transmit power either,<br>you&#39;re stuck with the dongle figuring that out for you.
<br><br>If your phone is class1 (a few are, but 99.5% are class2) then you<br>genuinely have an issue, which could be as simple as a wall in the way<br>which is blocking the signal, or as difficult as your neighbour having
<br>a leaking microwave oven.<br><br>On 08/04/07, siddhant tewari &lt;<a href="mailto:siddhant.tewari@gmail.com">siddhant.tewari@gmail.com</a>&gt; wrote:<br>&gt; hi,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;I am using class 1 dongle which says it has 100 mt range , but to my
<br>&gt; surprise using this dongle i cannot search my mobile phone which are even<br>&gt; around 30 - 40 mts.<br>&gt;<br>&gt; Are there any special commands which should be issued to the microprocessor<br>&gt; in the dongle so that its full range can be exploited.
<br>&gt;<br>&gt; and<br>&gt;<br>&gt; Are there any set of instruction by which i can verify the range of the<br>&gt; dongle.<br>&gt;<br>&gt; Also can anyone tell me about the class 1 dongle they use , their experience<br>
&gt; and the range to which their dongle can detect devices.<br>&gt;<br>&gt; regards<br>&gt; siddhant<br>&gt;<br>&gt; -------------------------------------------------------------------------<br>&gt; Take Surveys. Earn Cash. Influence the Future of IT
<br>&gt; Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>&gt; opinions on IT &amp; business topics through brief surveys-and earn cash<br>&gt; <a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>&gt; _______________________________________________<br>&gt; Bluez-users mailing list<br>&gt; <a href="mailto:Bluez-users@lists.sourceforge.net">
Bluez-users@lists.sourceforge.net</a><br>&gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>&gt;<br>&gt;<br><br><br>--<br>Thomas Kear<br>
<a href="mailto:thomas.kear@gmail.com">thomas.kear@gmail.com</a><br>+6421996496<br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join 
SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_22645_5170963.1176211048451--


--===============0533584759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0533584759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0533584759==--
