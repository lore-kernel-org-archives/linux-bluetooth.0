Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0704120210y19335f9eyaeb6fa2838adb88a@mail.gmail.com>
Date: Thu, 12 Apr 2007 14:40:05 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1176368621.4287.1184217917@webmail.messagingengine.com>
MIME-Version: 1.0
References: <1176368621.4287.1184217917@webmail.messagingengine.com>
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
Content-Type: multipart/mixed; boundary="===============0894903524=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0894903524==
Content-Type: multipart/alternative;
	boundary="----=_Part_28262_28370893.1176369005108"

------=_Part_28262_28370893.1176369005108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

what i think is that for any kind of transfer to take place (for e.g. via
obex push or obex ftp profile) both way handshakes are necessary to
instantiate the transfer ....


  Just curious, in this case, the class 2 Bdshannot transmit

> power to class 1 BT as the distance is way out of range, but
> can class 1 BT transmit files to class 2 BT?  since to class
> 1 BT the class 2 phone is in range?
>
> --ken
>
> Message: 2
> Date: Wed, 11 Apr 2007 08:47:53 +1200
> From: Thomas Kear <thomas.kear@gmail.com>
> Subject: Re: [Bluez-users] using class 1 dongle
> To: BlueZ users <bluez-users@lists.sourceforge.net>
> Message-ID: <200704110847.58296.thomas.kear@gmail.com>
> Content-Type: text/plain; charset="iso-8859-15"
>
> On Wed, 11 Apr 2007, siddhant tewari wrote:
> >                  Really great to get a answer ... i think my mobile
> phone
> > has class 2 bt adapter ... but this issue is a real shock for me ... i
> > thought if any of the devices has a good range , communication channel
> will
> > be established and data transfer will take place , but all this theory
> goes
> > in vain .
> The problem is as simple as transmit power.  As wikipedia helpfully
> shows
> (http://en.wikipedia.org/wiki/Bluetooth#Uses), class 1 devices can have
> 40
> times the transmit power of class 2 devices, the class 1 connecting to
> class
> 2 problem comes down to that past a certain range, the class 2 device
> does
> not have a high enough transmit power for its signal to reach the
> reciever
> (2.4GHz signals are eaten particularly fast by everything in their path,
> including air).
>
> As i outlined before, the higher transmit power in a class 1 device will
> come
> coupled to a higher sensitivity reciever, but that's not going to get
> you
> 100m.  If you had got the 30-40 metres you were attempting in your
> original
> email you would have been extremely lucky.
>
> The problem is there are very few phones that come with class 1
> bluetooth,
> 100mW transmit power is a little hard on battery life.  If you want a
> challenge though, find a class1 bluetooth adapter that has a dipole
> aerial
> rather than the usual circuit board trace and attach a bigger one.
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: not available
> Type: application/pgp-signature
> Size: 189 bytes
> Desc: not available
>
> ------------------------------
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

------=_Part_28262_28370893.1176369005108
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

what i think is that for any kind of transfer to take place (for e.g. via obex push or obex ftp profile) both way handshakes are necessary to instantiate the transfer .... <br><br><br>&nbsp; Just curious, in this case, the class 2 Bdshannot transmit
<br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">power to class 1 BT as the distance is way out of range, but<br>can class 1 BT transmit files to class 2 BT?&nbsp;&nbsp;since to class
<br>1 BT the class 2 phone is in range?<br><br>--ken<br><br>Message: 2<br>Date: Wed, 11 Apr 2007 08:47:53 +1200<br>From: Thomas Kear &lt;<a href="mailto:thomas.kear@gmail.com">thomas.kear@gmail.com</a>&gt;<br>Subject: Re: [Bluez-users] using class 1 dongle
<br>To: BlueZ users &lt;<a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a>&gt;<br>Message-ID: &lt;<a href="mailto:200704110847.58296.thomas.kear@gmail.com">200704110847.58296.thomas.kear@gmail.com
</a>&gt;<br>Content-Type: text/plain; charset=&quot;iso-8859-15&quot;<br><br>On Wed, 11 Apr 2007, siddhant tewari wrote:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Really great to get a answer ... i think my mobile phone<br>&gt; has class 2 bt adapter ... but this issue is a real shock for me ... i
<br>&gt; thought if any of the devices has a good range , communication channel will<br>&gt; be established and data transfer will take place , but all this theory goes<br>&gt; in vain .<br>The problem is as simple as transmit power.&nbsp;&nbsp;As wikipedia helpfully
<br>shows<br>(<a href="http://en.wikipedia.org/wiki/Bluetooth#Uses">http://en.wikipedia.org/wiki/Bluetooth#Uses</a>), class 1 devices can have<br>40<br>times the transmit power of class 2 devices, the class 1 connecting to
<br>class<br>2 problem comes down to that past a certain range, the class 2 device<br>does<br>not have a high enough transmit power for its signal to reach the<br>reciever<br>(2.4GHz signals are eaten particularly fast by everything in their path,
<br>including air).<br><br>As i outlined before, the higher transmit power in a class 1 device will<br>come<br>coupled to a higher sensitivity reciever, but that&#39;s not going to get<br>you<br>100m.&nbsp;&nbsp;If you had got the 30-40 metres you were attempting in your
<br>original<br>email you would have been extremely lucky.<br><br>The problem is there are very few phones that come with class 1<br>bluetooth,<br>100mW transmit power is a little hard on battery life.&nbsp;&nbsp;If you want a<br>challenge though, find a class1 bluetooth adapter that has a dipole
<br>aerial<br>rather than the usual circuit board trace and attach a bigger one.<br>-------------- next part --------------<br>A non-text attachment was scrubbed...<br>Name: not available<br>Type: application/pgp-signature
<br>Size: 189 bytes<br>Desc: not available<br><br>------------------------------<br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join 
SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_28262_28370893.1176369005108--


--===============0894903524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0894903524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0894903524==--
