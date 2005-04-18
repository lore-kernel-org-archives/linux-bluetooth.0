Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Cannot create L2CAP socket
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050418141520.70316.qmail@web15501.mail.cnb.yahoo.com>
References: <20050418141520.70316.qmail@web15501.mail.cnb.yahoo.com>
Content-Type: text/plain
Message-Id: <1113835360.16233.95.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 18 Apr 2005 16:42:40 +0200

Hi,

> when I tried to connect to the GN by typing the
> command "pand --connect BTADDR",It failed .The
> /var/log/message shows the following :
> 
> kernel: application bug: pand(5128) has SIGCHLD set to
> SIG_IGN but calls wait().
> kernel: (see the NOTES section of 'man 2 wait').
> Workaround activated.
> modprobe: modprobe: Can't locate module bt-proto-0
> pand[5128]: Cannot create L2CAP socket. No such file
> or directory(2)
> 
> I'm a beginner of bluez,I don't know why this happened
> .What can I do to solve this problem ?

call "modprobe l2cap".

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
