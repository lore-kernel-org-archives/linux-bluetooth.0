Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5eee8c670706130615j3e1fd63dwf3ff1edabe4d701a@mail.gmail.com>
Date: Wed, 13 Jun 2007 14:15:40 +0100
From: "Odysseus Flappington" <deriziotis@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300706030809u6f971992hf29f463facf56e71@mail.gmail.com>
MIME-Version: 1.0
References: <5eee8c670706030625o6aad300al5b1848f4e9394ebd@mail.gmail.com>
	<d89ddf300706030809u6f971992hf29f463facf56e71@mail.gmail.com>
Subject: Re: [Bluez-users] a2dp stream + bluetooth mouse not working at same
	time
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1152019512=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1152019512==
Content-Type: multipart/alternative;
	boundary="----=_Part_23442_2831425.1181740540435"

------=_Part_23442_2831425.1181740540435
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

One last thing that might be worth mentioning in case anyone comes across a
similar problem, and is looking through the archives for a solution.

I was having, what I thought was a completely unrelated problem, regarding
the speakers crackling when streaming music. This was before I installed any
other bluetooth devices and with an out-of-the box set of Orange speakers
and Ubuntu 7.04.

When streaming from my laptop, I was getting quite a heavy crackle coming
from the speakers. To the point that it was annoying, especially when
listening to anything with electric guitars in it. If I played music using a
cable, the crackle would disappear completely. I tried streaming using a
Sony Ericsson k800i, which supports the a2dp profile, and the crackle was
just barely there, only much fainter than the one when streaming from the
laptop.

After applying Brad's fix, the crackle has nearly completely disappeared. It
may even be less than what it was when streaming through the Ericsson (an
'officially' supported phone). So it seems the master/slave configuration
could also have been causing that problem.

Once again thanks very much Brad, and community support rocks!

Alex


On 03/06/07, Brad Midgley < bmidgley@gmail.com> wrote:
>
> hey
>
>
> > The only issue is, whenever I connect and move the mouse (using hidd)
> > while I'm streaming music using a2dpd, the music starts cutting out and
> > jumping until I stop moving the mouse.
>
>
> I'm not sure why it would be happening. I had this same problem when
> streaming to a combo headset but I believe it's because the headset wanted
> to be the master device by default. The laptop's adapter was cutting out
> because of the inefficiency of the scatternet (laptop was master to mouse
> but slave to headset). It helped to force master mode in that case. To try
> that, put "master" in hcid.conf's lm setting and you take "rswitch" out of
> the lp setting.
>
> Are there any other bluetooth devices involved, even if they aren't
> active?
>
> Brad
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>

------=_Part_23442_2831425.1181740540435
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

One last thing that might be worth mentioning in case anyone comes across a similar problem, and is looking through the archives for a solution.<br><br>I was having, what I thought was a completely unrelated problem, regarding the speakers crackling when streaming music. This was before I installed any other bluetooth devices and with an out-of-the box set of Orange speakers and Ubuntu 
7.04.<br><br>When streaming from my laptop, I was getting quite a heavy crackle coming from the speakers. To the point that it was annoying, <span style="font-style: italic;">

especially </span>when
listening to anything with electric guitars in it. If I played music
using a cable, the crackle would disappear completely. I tried streaming
using a Sony Ericsson k800i, which supports the a2dp profile, and the
crackle was just barely there, only much fainter than the one when streaming from
the laptop.
<br><br>After applying Brad&#39;s fix, the crackle has nearly completely disappeared. It may even be less than what it was when streaming through the Ericsson (an &#39;officially&#39; supported phone). So it seems the master/slave configuration could also have been causing that problem.
<br><br>Once again thanks very much Brad, and community support rocks!<br><br>Alex<br><br><br><div><span class="gmail_quote">On 03/06/07, <b class="gmail_sendername">Brad Midgley</b> &lt;<a href="mailto:bmidgley@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

bmidgley@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">hey<br><br><div><span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<br>The
only issue is, whenever I connect and move the mouse (using hidd) while I&#39;m streaming music
using a2dpd, the music starts cutting out and jumping until I stop moving the mouse.</blockquote></span><div><br>I&#39;m not sure why it would be happening. I had this same problem when streaming to a combo headset but I believe it&#39;s because the headset wanted to be the master device by default. The laptop&#39;s adapter was cutting out because of the inefficiency of the scatternet (laptop was master to mouse but slave to headset). It helped to force master mode in that case. To try that, put &quot;master&quot; in 
hcid.conf&#39;s lm
setting and you take &quot;rswitch&quot; out of the lp setting.<br><br>Are there any other bluetooth devices involved, even if they aren&#39;t active?<br><br>Brad<br></div><br></div><br>
<br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.
<br><a href="http://sourceforge.net/powerbar/db2/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-users mailing list
<br><a href="mailto:Bluez-users@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br><br></blockquote></div><br>

------=_Part_23442_2831425.1181740540435--


--===============1152019512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1152019512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1152019512==--
