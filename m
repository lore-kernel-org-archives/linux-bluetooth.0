Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3F82A016.2050901@grupopie.com>
From: Paulo Marques <pmarques@grupopie.com>
MIME-Version: 1.0
To: theo.beisch@gmx.de
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] help for bluez and bridge configuration needed
References: <200310062337.37090.root <>>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 07 Oct 2003 12:14:30 +0100



Theo Beisch wrote:

> I am using a 2.4.2 kernel (SuSE 8.2) and the bridge within it to tie a 
> bluetooth PAN and my Laptop together under one IP address which must come 
> from a DHCP server as I am using the constellation in various networks.
> 


This kernel is quite old. You really should upgrade the kernel...


> ...
> 
> While before pings to the local machine work ok and I get constant periodic 
> reponses, after the bnep0 interface becomes part of the bridge, ping stops 
> about every 5 instances, no longer displays the ping'd machine's name and 
> goes down with response frequency (from normally one a second to one response 
> every 10 or so seconds). While the response frequency remains low, after 8-10 
> no-name resolution pings, the machine name comes back with each ping. and so 
> on....

I had similar problems with a very similar setup.

The problem is that when the bnep0 interface enters the bridge, the bridge's 
"mac address" changes. You can see that happening doing a "ifconfig pan0" before 
the bnep0 joining the bridge and after, to see the hardware address of the pan0 
interface.

I tried to solve this by issuing "arping's" so that other machines on the 
network would be warned about the new hardware address, but unfortunately never 
got this to work properly... :(

It has been quite a while since i've tried this, though. So maybe in recent 
versions the bridging layer doesn't change the hardware address anymore?

If you have better luck than me, please let me know.

-- 
Paulo Marques
Software Development Department - Restinfor, Lda.
Phone: +351 252 290600, Fax: +351 252 290601
Web: www.grupopie.com

"In a world without walls and fences who needs windows and gates?"



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
