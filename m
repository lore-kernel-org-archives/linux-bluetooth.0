Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Can ping, nothing else
Message-ID: <20040613013726.GA13267@gmx.net>
References: <20040612150207.T12604-100000@m-net.arbornet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040612150207.T12604-100000@m-net.arbornet.org>
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
Date: Sun, 13 Jun 2004 03:37:26 +0200

On  0, Thea <thea@m-net.arbornet.org> wrote:
> Forgive me if this question has been asked before. I've gotten pppd to
> establish a connection to my t610 mobile phone through bluez. I get pair
> of addresses and can properly ping and resolve hosts. Nice, but I can't
> actually connect to hosts. This is something I don't know how to deal
> with. If I telnet to <nameserver> 53, it times-out; if I telnet to
> www.google.com 80, it times-out; if I ping www.altavista.com, it works
> fine. What's happening here?
> 
> I'm running linux 2.6, stock-generic on an ibook.
> Just ask if you want to see any configuration files

I suggest you talk about DUP.
When PPP Connection etablishment works, it is very likely a layer higer
than bluetooth stack. You don't setup a ppp connection to your handy,
but to the ISP peer.

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
