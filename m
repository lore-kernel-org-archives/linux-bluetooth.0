Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: Simi Winiker <simi@winiker.ch>
Subject: Re: [Bluez-users] Selection of PtP connection type
Cc: bluez-users@lists.sourceforge.net
References: <200402230026.24596.pavouk@pavouk.org> <1077521957.1788.7.camel@kant.winiker.ch>
In-Reply-To: <1077521957.1788.7.camel@kant.winiker.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200402240031.54845.pavouk@pavouk.org>
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
Date: Tue, 24 Feb 2004 00:31:54 +0100

Hello,

> In my opinion you should use the PAN Profile to connect the devices. If
> you don't want to share the internet connection of your mandrake box,
> you do not need to worry about bridging. As a rough summary:

Thanks, I now use PAN.

> 1) Install bluez-pan on both sides

It was done from package...

> 2) Issue "pand -s -r NAP" on the mandrake box

Yes it works.

> 3) make "pand -c aa:bb:cc:dd:ee:00" on the zaurus (replace the part
> after -c with the bluetooth address of the mandrake box

Yes it works too.

I created /etc/sysconfig/network-scripts/ifcfg-bnep0
-------------------------
DEVICE=bnep0
BOOTPROTO=static
IPADDR=192.168.130.1
NETMASK=255.255.255.0
ONBOOT=no
-------------------------
When I want to connect, I must run on desktop  "pand -s -rNAP", next run
"connect" on Zaurus, and next "ifup bnep0" on desktop.

How can I automate process on desktop side?
Marcel writes about hcid and bluetooth.agent.
Are there some examples or links to official documentation?
Man with examples would be great ;-)

> And by the way, PPP over BNEP does not make sense.
This is probably my mistake from this document:
http://www.cs.ucla.edu/~cclljj/work/ucla/bluez/pand_dund.html

Thank you and Marcel for great help.

Best regards,

Pavel Ruzicka



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
