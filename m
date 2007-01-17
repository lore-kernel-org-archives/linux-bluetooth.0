Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <2e9fc96f0701170803k2fc9b253vf62bf4abaa515d74@mail.gmail.com>
Date: Wed, 17 Jan 2007 21:33:26 +0530
From: "Prabhu nath" <gprabhunath@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1168957800.8918.20.camel@violet>
MIME-Version: 1.0
References: <1d1502880701122216v187542ecx45af28f4da86323e@mail.gmail.com>
	<1168867650.5728.11.camel@violet>
	<2e9fc96f0701160623i44199950u8005dc70a9176975@mail.gmail.com>
	<1168957800.8918.20.camel@violet>
Subject: Re: [Bluez-users] Object Push from Nokia N93 to BlueZ fails
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1535454094=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1535454094==
Content-Type: multipart/alternative;
	boundary="----=_Part_19950_32778056.1169049806664"

------=_Part_19950_32778056.1169049806664
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,
          This time I am running only obexftpd, I even tried by removing all
conf from rfcomm.conf but No Luck, I am running into same issue, Yet again I
am not able to push file from Nokia to BlueZ, but I am able to Push file
from Motorola to BlueZ.

hcidump :- Nokia_to_BlueZ :
http://brochevarevarura.googlepages.com/n93_to_bluez

hcidump :- Moto_to_BlueZ :
http://brochevarevarura.googlepages.com/motoq_to_bluez

Thanks,
Prabhu



On 1/16/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Parbhu,
>
> >          I started the rfcomm to listen on channel 9. Now, when I
> > transfer file from Nokia N93 to my
> >          PC.
> >           It hangs. hcidump will give a segmentation fault.
> >           My configuration :
> > http://gprabhunath.googlepages.com/bluez_conf
> >
> >           hcidump : http://gprabhunath.googlepages.com/home
> >
> >           I did the following.
> >           * Edited rfcomm.conf and hcid.conf (Ref: My configuration)
> >           * started hcid and sdpd (service bluetooth start)
> >           * started rfcomm to listen on channel 9 (rfcomm -i hci0
> > listen 2 9)
> >           * started obexftpd (obexftpd -b -c /tmp/inbox)
>
> you should only use obexftpd and not "rfcommm listen". The rfcomm
> command will only create a TTY on successful connect, but then don't do
> the needed OBEX connection for the push.
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

------=_Part_19950_32778056.1169049806664
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Marcel, </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This time I am running only obexftpd,&nbsp;I even tried by removing all conf from rfcomm.conf but No Luck, I am running into same issue, Yet again I am not able to push file from Nokia to BlueZ, but I am able to Push file from Motorola to BlueZ. 
</div>
<div>&nbsp;</div>
<div>hcidump :- Nokia_to_BlueZ : <a href="http://brochevarevarura.googlepages.com/n93_to_bluez">http://brochevarevarura.googlepages.com/n93_to_bluez</a></div>
<div>&nbsp;</div>
<div>hcidump :- Moto_to_BlueZ : <a href="http://brochevarevarura.googlepages.com/motoq_to_bluez">http://brochevarevarura.googlepages.com/motoq_to_bluez</a></div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Prabhu</div>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 1/16/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Parbhu,<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I started the rfcomm to listen on channel 9. Now, when I<br>&gt; transfer file from Nokia N93 to my
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PC.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; It hangs. hcidump will give a segmentation fault.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; My configuration :<br>&gt; <a href="http://gprabhunath.googlepages.com/bluez_conf">http://gprabhunath.googlepages.com/bluez_conf
</a><br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hcidump : <a href="http://gprabhunath.googlepages.com/home">http://gprabhunath.googlepages.com/home</a><br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I did the following.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Edited rfcomm.conf and 
hcid.conf (Ref: My configuration)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * started hcid and sdpd (service bluetooth start)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * started rfcomm to listen on channel 9 (rfcomm -i hci0<br>&gt; listen 2 9)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * started obexftpd (obexftpd -b -c /tmp/inbox)
<br><br>you should only use obexftpd and not &quot;rfcommm listen&quot;. The rfcomm<br>command will only create a TTY on successful connect, but then don&#39;t do<br>the needed OBEX connection for the push.<br><br>Regards
<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys - and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_19950_32778056.1169049806664--


--===============1535454094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1535454094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1535454094==--
