Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <be976db60609211230m6333bca7x4778a76f23bfbc8a@mail.gmail.com>
References: <be976db60609211230m6333bca7x4778a76f23bfbc8a@mail.gmail.com>
Date: Thu, 21 Sep 2006 21:35:30 +0200
Message-Id: <1158867330.11194.50.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] RFCOMM error
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Mark,

> I have a an RFCOMM server process listening on one box.  From a Linux
> laptop,
> I just wrote a simple RFCOMM client to connect to it.  Very simple,
> via AF_BLUETOOTH, SOCK_SEQPACKET and
> BTPROTO_RFCOMM.
>  
> I got back errno as Bad File Descriptor.  When I strace it, I saw this
> line:
>  
>    socket(PF_BLUETOOTH, SOCK_SEQPACKET, 3) = -1  ESOCKTNOSUPPORT
> (Socket type not supported).
>  
> What does that mean?  Did I construct the socket wrong?

for RFCOMM it must be SOCK_STREAM.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
