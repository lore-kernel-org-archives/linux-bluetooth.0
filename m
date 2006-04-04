Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Thomas Arendsen Hein <thomas@intevation.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060404134851.GB5177@intevation.de>
References: <20060308164641.23944.qmail@web31111.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060308164641.23944.qmail@web31111.mail.mud.yahoo.com>
Subject: [Bluez-users] Re: Fwd: DHCP for dund
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
Date: Tue, 4 Apr 2006 15:48:52 +0200

* Yu Zhi <kuanyz@yahoo.com> [20060308 16:47]:
> I'd using dund to establush connectino with my Pocket PC. Here's the steps I'd taken:
>
>  2) Put the following lines in a file called /etc/ppp/peers/dun
>  115200
>  192.168.1.18:10.0.1.40
>  local
>  ms-dns 192.168.1.1
>  noauth
>  debug
>
> The steps work perfectly for my PDA to dialup to my linux server,
> and manage to browse the content in my webserver. However, the
> steps are only to assign fixed IP (in this case 10.0.1.40) to my
> PDA. I wish to have multiple PDA connect to the linux server, and
> hence fixed IP is not a solution.

Instead of 192.168.1.18:10.0.1.40 in /etc/ppp/dund I just use:
name dund

And in /etc/ppp/pap-secrets I have:
palm-foo palm "pass1" foo
palm-bar palm "pass2" bar

So if I log in using the PPP username 'palm-foo' (with password
'pass1') I get the hostname 'foo' assigned, with 'palm-bar' the
hostname 'bar'.

> What should I do if i wanted DHCP server support dund for my case.

I hoped somebody would answer this, but I didn't find a way to use
DHCP with PPP, too.

Thomas

-- 
Email: thomas@intevation.de
http://intevation.de/~thomas/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
