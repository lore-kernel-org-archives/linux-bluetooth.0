Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060730152448.42415.qmail@web51409.mail.yahoo.com>
Date: Sun, 30 Jul 2006 08:24:48 -0700 (PDT)
From: manojt ambe <mp_tambe@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-users] rfcomm connection disconnects immediately
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1568458690=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1568458690==
Content-Type: multipart/alternative; boundary="0-112205384-1154273088=:39283"
Content-Transfer-Encoding: 8bit

--0-112205384-1154273088=:39283
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,
   
  I am using a C program to connect RFCOMM channel to headset.
  How do i find out which RFCOMM channel is supported by headset HS850? Is there any bluez command i can use? 
   
  Pls. let me know.
   
  regards,
  Manoj
   
   
   
   
  Date: Sat, 29 Jul 2006 14:53:28 +0200
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] rfcomm connection disconnects immediately
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <1154177608.25939.8.camel@localhost>
Content-Type: text/plain

Hi Manoj,

> I am trying to make RFcomm connection with Motorola
> HS850 through a DBT120 dongle. I am using linux
> 2.4.21-40 kernel and bluez 3.1 .
> I see that the rfcomm connection gets disconnected
> immediately. Is this how it is supposed to work? I
> have pasted hcidump below.

it would be best if you switch to a recent 2.6 kernel instead of using
an old 2.4 kernel.

What commands are using to connect to that headset? Are you sure that
you are using the correct RFCOMM channel.

Regards

Marcel




 		
---------------------------------
Do you Yahoo!?
 Everyone is raving about the  all-new Yahoo! Mail Beta.
--0-112205384-1154273088=:39283
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi Marcel,</div>  <div>&nbsp;</div>  <div>I am using a C program to connect RFCOMM channel to headset.</div>  <div>How do i find out which RFCOMM channel is supported by headset HS850? Is there any bluez command i can use? </div>  <div>&nbsp;</div>  <div>Pls. let me know.</div>  <div>&nbsp;</div>  <div>regards,</div>  <div>Manoj</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>Date: Sat, 29 Jul 2006 14:53:28 +0200<BR>From: Marcel Holtmann &lt;<A href="http://us.f514.mail.yahoo.com/ym/Compose?To=marcel@holtmann.org&amp;YY=77208&amp;y5beta=yes&amp;y5beta=yes&amp;order=down&amp;sort=date&amp;pos=0&amp;view=a&amp;head=b"><FONT color=#003399>marcel@holtmann.org</FONT></A>&gt;<BR>Subject: Re: [Bluez-users] rfcomm connection disconnects immediately<BR>To: BlueZ users &lt;<A
 href="http://us.f514.mail.yahoo.com/ym/Compose?To=bluez-users@lists.sourceforge.net&amp;YY=77208&amp;y5beta=yes&amp;y5beta=yes&amp;order=down&amp;sort=date&amp;pos=0&amp;view=a&amp;head=b"><FONT color=#003399>bluez-users@lists.sourceforge.net</FONT></A>&gt;<BR>Message-ID: &lt;1154177608.25939.8.camel@localhost&gt;<BR>Content-Type: text/plain<BR><BR>Hi Manoj,<BR><BR>&gt; I am trying to make RFcomm connection with Motorola<BR>&gt; HS850 through a DBT120 dongle. I am using linux<BR>&gt; 2.4.21-40 kernel and bluez 3.1 .<BR>&gt; I see that the rfcomm connection gets disconnected<BR>&gt; immediately. Is this how it is supposed to work? I<BR>&gt; have pasted hcidump below.<BR><BR>it would be best if you switch to a recent 2.6 kernel instead of using<BR>an old 2.4 kernel.<BR><BR>What commands are using to connect to that headset? Are you sure that<BR>you are using the correct RFCOMM channel.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR></div><p>&#32;
		<hr size=1>Do you Yahoo!?<br> Everyone is raving about the <a href="http://us.rd.yahoo.com/evt=42297/*http://advision.webevents.yahoo.com/handraisers"> all-new Yahoo! Mail Beta.</a>
--0-112205384-1154273088=:39283--


--===============1568458690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1568458690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1568458690==--
