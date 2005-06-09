Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050609135738.3514.qmail@web52808.mail.yahoo.com>
From: Naved Aziz <no2alikebd@yahoo.com>
Subject: Re: [Bluez-users] BlueZ on ETRAX 100LX devboard 82+
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42A82B4F.90805@gmx.ch>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-77934844-1118325457=:3110"
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
Date: Thu, 9 Jun 2005 06:57:37 -0700 (PDT)

--0-77934844-1118325457=:3110
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marco,
 
Thanks for your reply; I really appreciate it =)
 
So you're saying that you programmed, as in write the code, for the rfcomm protocol, while keeping the other (working) BlueZ stuff (meaning the other utilities like sdptool) on the board?  I will eventually have to write some applcation using rfcomm in order to exchange files and stuff with phones, but now, I am actually at a loss as to how to progress.  As a cherry on top, it has been only a couple of weeks since I have begun working with Linux.  
 
Marco, it would mean a lot to me if you could provide me with some guidance as to how to get rfcomm working on the devboard 82+.  I am a total newbie at this, so if you could give me a step-by-step guide as to how to set up the Axis board with rfcomm support, I would be forever in your debt =)
 
Thanks and sincerely,
 
Naved  

Marco Trudel <mtrudel@gmx.ch> wrote:
Hello

There're (a lot) of mails about this topic in the archive. I don't 
remember directly how they ended, but if you've to program the rfcomm 
stuff yourself anyway, you're probably best of if you do it from beginning.
I had more or less the same problem when I started. I never was able to 
use the rfcomm utility, it never worked for me. So I programmed 
everything myself from the beginning on...

regards
Marco

Naved Aziz wrote:
> Hi,
> 
> I am currently working on the Axis devboard 82+ for a project that 
> requires bluetooth support on the board. The kernel for the SDK 
> (obtained from the axis developer website) has support for BlueZ, and I 
> have been able to compile the kernel and flash the image onto the board 
> without any errors (the linux kernel used is 2.4.29). The basic stack 
> functions like sdptool, hcitool, l2ping, work fine. 
> 
> However, the problem is with rfcomm. I cannot connect to any remote 
> devices (I have tried with Nokia 6600), attempting which gives the 
> "Can't create RFCOMM socket: resource currently unavailable"), cannot 
> bind ("Can't create device list: Operation not supported"), cannot 
> release, etc. Has anyone faced this problem with RFCOMM on this board? 
> I have also tried porting Axis's openBT stack, which I could not compile 
> into the kernel at all.
> 
> I am totally new at Linux, and would greatly appreciate any help that 
> someone can provide.
> 
> Sincerely and desperately,
> 
> Naved
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam? Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
> 



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games. How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy. 
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

		
---------------------------------
Discover Yahoo!
 Get on-the-go sports scores, stock quotes, news & more. Check it out!
--0-77934844-1118325457=:3110
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hi Marco,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks for your reply; I really appreciate it =)</DIV>
<DIV>&nbsp;</DIV>
<DIV>So you're saying that you programmed, as in write the code, for the rfcomm&nbsp;protocol, while keeping the other (working) BlueZ stuff&nbsp;(meaning the other utilities like sdptool)&nbsp;on the board?&nbsp; I will eventually have to write some applcation using rfcomm in order to exchange files and stuff with phones, but now, I am actually at a loss as to how to progress.&nbsp; As a cherry on top, it has been only&nbsp;a couple of weeks since I have begun working with Linux.&nbsp; </DIV>
<DIV>&nbsp;</DIV>
<DIV>Marco, it would mean a lot to me if you could provide me with some guidance as to how to get rfcomm working on the devboard 82+.&nbsp; I am a total newbie at this, so&nbsp;if you could give me a step-by-step guide&nbsp;as&nbsp;to how to set up the Axis board with rfcomm support, I would be forever in your debt =)</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks and sincerely,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Naved&nbsp;&nbsp;<BR><BR><B><I>Marco Trudel &lt;mtrudel@gmx.ch&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hello<BR><BR>There're (a lot) of mails about this topic in the archive. I don't <BR>remember directly how they ended, but if you've to program the rfcomm <BR>stuff yourself anyway, you're probably best of if you do it from beginning.<BR>I had more or less the same problem when I started. I never was able to <BR>use the rfcomm utility, it never worked for me. So I programmed <BR>everything myself from the beginning on...<BR><BR>regards<BR>Marco<BR><BR>Naved Aziz wrote:<BR>&gt; Hi,<BR>&gt; <BR>&gt; I am currently working on the Axis devboard 82+ for a project that <BR>&gt; requires bluetooth support on the board. The kernel for the SDK <BR>&gt; (obtained from the axis developer website) has support for BlueZ, and I <BR>&gt; have been able to compile the kernel and flash the image onto the board <BR>&gt; without any errors (the linux kernel used is 2.4.29). The basic stack <BR>&g
 t;
 functions like sdptool, hcitool, l2ping, work fine. <BR>&gt; <BR>&gt; However, the problem is with rfcomm. I cannot connect to any remote <BR>&gt; devices (I have tried with Nokia 6600), attempting which gives the <BR>&gt; "Can't create RFCOMM socket: resource currently unavailable"), cannot <BR>&gt; bind ("Can't create device list: Operation not supported"), cannot <BR>&gt; release, etc. Has anyone faced this problem with RFCOMM on this board? <BR>&gt; I have also tried porting Axis's openBT stack, which I could not compile <BR>&gt; into the kernel at all.<BR>&gt; <BR>&gt; I am totally new at Linux, and would greatly appreciate any help that <BR>&gt; someone can provide.<BR>&gt; <BR>&gt; Sincerely and desperately,<BR>&gt; <BR>&gt; Naved<BR>&gt; <BR>&gt; __________________________________________________<BR>&gt; Do You Yahoo!?<BR>&gt; Tired of spam? Yahoo! Mail has the best spam protection around<BR>&gt; http://mail.yahoo.com<BR>&gt;
 <BR><BR><BR><BR>-------------------------------------------------------<BR>This SF.Net email is sponsored by: NEC IT Guy Games. How far can you shotput<BR>a projector? How fast can you ride your desk chair down the office luge track?<BR>If you want to score the big prize, get to know the little guy. <BR>Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><p>
		<hr size=1>Discover Yahoo!<br> 
Get on-the-go sports scores, stock quotes, news & more. <a href="http://us.rd.yahoo.com/evt=32661/*http://discover.yahoo.com/mobile.html">Check it out!</a>
--0-77934844-1118325457=:3110--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
