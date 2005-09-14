Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] FYI: obex server with support for put/get obexftp
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1126640851.2890.8.camel@panic>
References: <1126640851.2890.8.camel@panic>
Content-Type: text/plain
Message-Id: <1126703658.16166.32.camel@station6.example.com>
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
Date: Wed, 14 Sep 2005 15:14:18 +0200

Hi Collin,

> maybe some of you are interested ...
> 
> sobexsrv - or the scripting OBEX server
>         
> is a Linux OBEX server with support for OPUSH put/get and OBEXFTP. The
> server is currently Bluetooth only and build ontop of openobex and BlueZ
> (of course).
>         
> The server handles only the basic OBEX operations and calls an external
> executable for all the application-logic (like OBEXFTP). The basic
> script included in the package can do OPUSH put/get and OBEXFTP. 
>         
> The code is in early development so watch out for bugs!
>         
> Download it here http://www.mulliner.org/bluetooth/sobexsrv-0.1.tar.gz

I like to have something like this as btobexd inside the bluez-utils. My
time is too limited (again) to fully review the source code, but I think
it is a good idea to have something like this inside the base.

The scripting part is a nice idea, but I think parts of it should
support native FTP and INBOX push. What do you think about extending it
to a full Bluetooth FTP daemon that also supports OPP/BIP/BPP to some
extend.

And since FUSE is mainline now, I am willing to implement a btfs, but my
current ideas with btfs are a little bit more advanced.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
