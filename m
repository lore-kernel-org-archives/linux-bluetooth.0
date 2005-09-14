Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] FYI: obex server with support for put/get obexftp
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1126703658.16166.32.camel@station6.example.com>
References: <1126640851.2890.8.camel@panic>
	 <1126703658.16166.32.camel@station6.example.com>
Content-Type: text/plain
Message-Id: <1126704925.2617.7.camel@panic>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 14 Sep 2005 15:35:25 +0200

Marcel,

> I like to have something like this as btobexd inside the bluez-utils. My
> time is too limited (again) to fully review the source code, but I think
> it is a good idea to have something like this inside the base.

sure, I mainly wrote this because there is no btobexd

> The scripting part is a nice idea, but I think parts of it should
> support native FTP and INBOX push. What do you think about extending it

the scripting part is mainly to have better user control over things
like security (who is allowed to connect etc.) or GUI notification

> to a full Bluetooth FTP daemon that also supports OPP/BIP/BPP to some
> extend.

of course why not, I just need some more free time and the specs for
BIP/BPP :)

> And since FUSE is mainline now, I am willing to implement a btfs, but my
> current ideas with btfs are a little bit more advanced.

oh btfs, I also started rewriting this completely I guess our ideas are
not so different for this ... so this will also happen when I have more
time :-)


... Collin

--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
All software sucks equally, but some software is more equal.



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
