Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40A25476.7080609@mWare.ca>
From: Mykel <Mykel@mWare.ca>
MIME-Version: 1.0
To: Rob Taft <rtaft@sensis.com>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] DHCPD and Bluetooth
References: <004501c4383b$36b36950$80c8fea9@Perigee.Perigeellc.com>
In-Reply-To: <004501c4383b$36b36950$80c8fea9@Perigee.Perigeellc.com>
Content-Type: multipart/alternative;
 boundary="------------070105090201060102060705"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 12 May 2004 12:44:38 -0400

This is a multi-part message in MIME format.
--------------070105090201060102060705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I know Slackware has hotplug scripts. You might want to look there.

Myke


Rob Taft wrote:

> I currently have a setup where I have a Bluetooth adapter on a Linux 
> box, and one on Windows.  Everything is configured properly.  I 
> connect from the Windows Bluetooth adapter to the Linux one via "Local 
> Area Connection 2" in XP over TCP/IP.  I manually type "ifconfig bnep0 
> 192.168.3.1" to assign the adapter an IP, then I have to restart DHCPD 
> to acquire an IP address over Bluetooth.  This all works great.
>  
> My first question is:  Is there a way to recognize when a connection 
> is made, so I can create a script or some code to automatically set 
> bnep0 to 192.168.3.1 and restart the dhcp server?
>  
> I only have 2 Bluetooth adapters.  What if I used a 3rd from windows 
> to connect to Linux at the same time another one is connected.  Will 
> it allow multiple connections?  Will it show up as bnep1 or still use 
> bnep0?
>  
>  
>  
> Rob Taft, Software Engineer
> Perigee, A Division of Sensis Corporation
> rtaft@sensis.com <mailto:rtaft@sensis.com>
> 315-453-7842, Ext. 25



--------------070105090201060102060705
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
I know Slackware has hotplug scripts. You might want to look there. <br>
<br>
Myke<br>
<br>
<br>
Rob Taft wrote:
<blockquote
 cite="mid004501c4383b$36b36950$80c8fea9@Perigee.Perigeellc.com"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta content="MSHTML 6.00.2800.1400" name="GENERATOR">
  <style></style>
  <div><font face="Arial" size="2">I currently have a setup where I
have a Bluetooth adapter on a Linux box, and one on Windows.&nbsp;
Everything is configured properly.&nbsp; I connect from the Windows
Bluetooth adapter to the Linux one via "Local Area Connection 2" in XP
over TCP/IP.&nbsp; I manually type "ifconfig bnep0 192.168.3.1" to assign
the adapter an IP, then I have to restart DHCPD to acquire an IP
address over Bluetooth.&nbsp; This all works great.</font></div>
  <div>&nbsp;</div>
  <div><font face="Arial" size="2">My first question is:&nbsp; Is there a
way to recognize when a connection is made, so I can create a script or
some code to automatically set bnep0 to 192.168.3.1 and restart the
dhcp server?</font></div>
  <div>&nbsp;</div>
  <div><font face="Arial" size="2">I only have 2 Bluetooth adapters.&nbsp;
What if I used a 3rd from windows to connect to Linux at the same time
another one is connected.&nbsp; Will it allow multiple connections?&nbsp; Will it
show up as bnep1 or still use bnep0?</font></div>
  <div>&nbsp;</div>
  <div>&nbsp;</div>
  <div>&nbsp;</div>
  <div><font face="Arial" size="2">Rob Taft, Software Engineer<br>
Perigee, A Division of Sensis Corporation<br>
  <a href="mailto:rtaft@sensis.com">rtaft@sensis.com</a><br>
315-453-7842, Ext. 25</font></div>
</blockquote>
<br>
</body>
</html>

--------------070105090201060102060705--


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
