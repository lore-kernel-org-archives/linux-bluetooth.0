Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050228040651.78126.qmail@web60910.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] Re: sdp problem
To: bluez-users@lists.sourceforge.net
In-Reply-To: <cvi5l2$q7m$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1736119236-1109563611=:77476"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 28 Feb 2005 12:06:51 +0800 (CST)

--0-1736119236-1109563611=:77476
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi Soraberri!
    I wish to know how to implement the basic service profiles such as SIM Access, headset, handsfree, file transfer and Object Push so that the Linux PC can listen for the T610 client to connect to the PC? Thank you very much.
Michael

soraberri <421246@posta.unizar.es> wrote:
Hi,

Ka Kin Cheung wrote:
> Hi!
> The strange thing is here:
> For Linux, when my phone searched for my PC, the PC can be found and 
> then added in the "My device" list, but when I looked at "Service list", 
> none service can be found. Then I opened Windows XP and the bluetooth 
> dongle driver was installed in my PC. Then I press "update" key to 
> update services, and I found headset, synchronisation, object push and 
> file transfer in the "Service list" for my Windows PC. So, how can I do 
> for sdp in my Linux PC as my project is done on Linux? Thank you very 
> much for your kindness.
> Michael

You can advertise standard services in Linux using 'sdptool add ...' but
advertising is not the same as offering... To offer a real service, an
application has to be implemented and listening for clients at the
appropiate network protocols and ports. Maybe what it is happening in
windows is that most basic profiles are already implemented and
correctly advertised. With BlueZ you can also advertise them in order
to be seen by a remote device, but they won't work until you don't
implement them. I hope this helps.

regards,
Luis



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



---------------------------------
Yahoo! ¤u¨ã¦C - ¤º¸m¨¾¤î¼u¥Xµøµ¡¤u¯à¡I

--0-1736119236-1109563611=:77476
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Hi Soraberri!</DIV>
<DIV>&nbsp;&nbsp;&nbsp; I wish to know how to implement the basic service profiles such as SIM Access, headset, handsfree, file transfer and Object Push so that the Linux PC can listen for the T610 client to connect to the PC? Thank you very much.</DIV>
<DIV>Michael<BR><BR><B><I>soraberri &lt;421246@posta.unizar.es&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi,<BR><BR>Ka Kin Cheung wrote:<BR>&gt; Hi!<BR>&gt; The strange thing is here:<BR>&gt; For Linux, when my phone searched for my PC, the PC can be found and <BR>&gt; then added in the "My device" list, but when I looked at "Service list", <BR>&gt; none service can be found. Then I opened Windows XP and the bluetooth <BR>&gt; dongle driver was installed in my PC. Then I press "update" key to <BR>&gt; update services, and I found headset, synchronisation, object push and <BR>&gt; file transfer in the "Service list" for my Windows PC. So, how can I do <BR>&gt; for sdp in my Linux PC as my project is done on Linux? Thank you very <BR>&gt; much for your kindness.<BR>&gt; Michael<BR><BR>You can advertise standard services in Linux using 'sdptool add ...' but<BR>advertising is not the same as offering... To offer a real service, an<BR>application has to be implemented and listening fo
 r
 clients at the<BR>appropiate network protocols and ports. Maybe what it is happening in<BR>windows is that most basic profiles are already implemented and<BR>correctly advertised. With BlueZ you can also advertise them in order<BR>to be seen by a remote device, but they won't work until you don't<BR>implement them. I hope this helps.<BR><BR>regards,<BR>Luis<BR><BR><BR><BR>-------------------------------------------------------<BR>SF email is sponsored by - The IT Product Guide<BR>Read honest &amp; candid reviews on hundreds of IT Products from real users.<BR>Discover which products truly live up to the hype. Start reading now.<BR>http://ads.osdn.com/?ad_id=6595&amp;alloc_id=14396&amp;op=click<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><p><br><hr size=1>Yahoo! ¤u¨ã¦C - <a href=http://hk.toolbar.yahoo.com>¤º¸m¨¾¤î¼u¥Xµøµ¡¤u¯à</a>¡
 I<br>
--0-1736119236-1109563611=:77476--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
