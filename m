Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY104-F12B090EDA55DB3EED849F4C18B0@phx.gbl>
In-Reply-To: <1105700391.17326.32.camel@justakiss>
From: "blookk -" <blookk@hotmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BCSP problem
Mime-Version: 1.0
Content-Type: text/html; charset=iso-8859-1; format=flowed
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
Date: Fri, 14 Jan 2005 17:13:30 +0000

<html><div style='background-color:'><DIV class=RTE>
<P>Hello Erwin:</P>
<P>I use a ARM7TDM, 55 MHz.</P>
<P>Thanks for your help<BR><BR></P></DIV>
<DIV></DIV>&gt;From: Erwin Authried &lt;eauth@softsys.co.at&gt;
<DIV></DIV>&gt;Reply-To: bluez-users@lists.sourceforge.net
<DIV></DIV>&gt;To: "bluez-users@lists.sourceforge.net" &lt;bluez-users@lists.sourceforge.net&gt;
<DIV></DIV>&gt;Subject: Re: [Bluez-users] BCSP problem
<DIV></DIV>&gt;Date: Fri, 14 Jan 2005 11:59:51 +0100
<DIV></DIV>&gt;
<DIV></DIV>&gt;Am Fre, den 14.01.2005 schrieb blookk - um 10:03:
<DIV></DIV>&gt; &gt; Hello Erwin:
<DIV></DIV>&gt; &gt;
<DIV></DIV>&gt; &gt; What changes have you done in hci_bcsp.c?
<DIV></DIV>&gt; &gt; Could be the error in wait_states in serial driver?
<DIV></DIV>&gt; &gt;
<DIV></DIV>&gt; &gt; I change the timeout to 1 HZ but the problem continue.
<DIV></DIV>&gt; &gt;
<DIV></DIV>&gt; &gt; Regards.
<DIV></DIV>&gt;Hi,
<DIV></DIV>&gt;I have posted the patch some time ago.
<DIV></DIV>&gt;
<DIV></DIV>&gt;http://sourceforge.net/mailarchive/message.php?msg_id=9908045
<DIV></DIV>&gt;
<DIV></DIV>&gt;Be aware that it is incomplete, it doesn't support packets with CRC. The
<DIV></DIV>&gt;patch is only useful when the incoming data rate from the uart is higher
<DIV></DIV>&gt;than the processing speed in the hci line discipline. What kind of
<DIV></DIV>&gt;machine (cpu speed?) do you use?
<DIV></DIV>&gt;
<DIV></DIV>&gt;Regards,
<DIV></DIV>&gt;Erwin
<DIV></DIV>&gt;
<DIV></DIV>&gt;
<DIV></DIV>&gt;
<DIV></DIV>&gt;
<DIV></DIV>&gt;
<DIV></DIV>&gt;
<DIV></DIV>&gt;-------------------------------------------------------
<DIV></DIV>&gt;The SF.Net email is sponsored by: Beat the post-holiday blues
<DIV></DIV>&gt;Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
<DIV></DIV>&gt;It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
<DIV></DIV>&gt;_______________________________________________
<DIV></DIV>&gt;Bluez-users mailing list
<DIV></DIV>&gt;Bluez-users@lists.sourceforge.net
<DIV></DIV>&gt;https://lists.sourceforge.net/lists/listinfo/bluez-users
<DIV></DIV></div></html>



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
