Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcommX and ppp
From: Marcel Holtmann <marcel@holtmann.org>
To: Rafael Vidal Aroca <rafael@3wt.com.br>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4162D886.8010406@3wt.com.br>
References: <41629C2B.4040201@3wt.com.br>
	 <1096991861.20349.73.camel@pegasus>  <4162D886.8010406@3wt.com.br>
Content-Type: text/plain
Message-Id: <1097055892.4937.3.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 06 Oct 2004 11:44:52 +0200

Hi Rafael,

>        Well, everything is fine, but my ppp is configured to give a 
> unique ip. You can check this from my peer file /etc/ppp/peers/dun that 
> follows:
> 
>     # do not require auth
> noauth
> 
> # do not use modem control lines we aren't using a real serial line
> local
> 
> # do not determinate local ip from hostname
> noipdefault
> 
> # usefull ARP proxing
> proxyarp
> 
> # do not enable default route
> nodefaultroute
> 
> # do not use ipx
> noipx
> 
> # set disconnect timeout
> idle 0
> 
> # local ip : remote ip
> 10.0.0.1:10.0.0.2
> 
> # dns
> ms-dns 10.0.0.1
> 
> # netmask
> netmask 255.255.255.0
> 
> 
>     Note the line: 10.0.0.1:10.0.0.2
> 
>     Can i change this to multiple ips? Because the problem is exactly 
> this: all devices in the same ip...

try to use 10.0.0.1: or other way around. Or you can define multiple
options.rfcommX files in /etc/ppp/ and use a bridge. There are some ways
to get this working.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
