Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] DHCPD and Bluetooth
References: <004501c4383b$36b36950$80c8fea9@Perigee.Perigeellc.com> <40A25476.7080609@mWare.ca> <007e01c4384a$64f7e700$80c8fea9@Perigee.Perigeellc.com>
In-Reply-To: <007e01c4384a$64f7e700$80c8fea9@Perigee.Perigeellc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200405122103.08265.cijoml@volny.cz>
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
Date: Wed, 12 May 2004 21:03:07 +0200

On Wednesday 12 of May 2004 19:55, Rob Taft wrote:
> Changing my OS isn't exactly an option at this point.

All distributions have hotplug scripts inside. Just use you package system and 
install it

Michal

>   ----- Original Message -----
>   From: Mykel
>   To: Rob Taft
>   Cc: bluez-users@lists.sourceforge.net
>   Sent: Wednesday, May 12, 2004 12:44 PM
>   Subject: Re: [Bluez-users] DHCPD and Bluetooth
>
>
>   I know Slackware has hotplug scripts. You might want to look there.
>
>   Myke
>
>
>   Rob Taft wrote:
>     I currently have a setup where I have a Bluetooth adapter on a Linux
> box, and one on Windows.  Everything is configured properly.  I connect
> from the Windows Bluetooth adapter to the Linux one via "Local Area
> Connection 2" in XP over TCP/IP.  I manually type "ifconfig bnep0
> 192.168.3.1" to assign the adapter an IP, then I have to restart DHCPD to
> acquire an IP address over Bluetooth.  This all works great.
>
>     My first question is:  Is there a way to recognize when a connection is
> made, so I can create a script or some code to automatically set bnep0 to
> 192.168.3.1 and restart the dhcp server?
>
>     I only have 2 Bluetooth adapters.  What if I used a 3rd from windows to
> connect to Linux at the same time another one is connected.  Will it allow
> multiple connections?  Will it show up as bnep1 or still use bnep0?
>
>
>
>     Rob Taft, Software Engineer
>     Perigee, A Division of Sensis Corporation
>     rtaft@sensis.com
>     315-453-7842, Ext. 25


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
