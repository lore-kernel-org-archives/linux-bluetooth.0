Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <ddea76ce0703310624h7db4f1d1n689ea1ed2062b382@mail.gmail.com>
References: <ddea76ce0703310624h7db4f1d1n689ea1ed2062b382@mail.gmail.com>
Date: Sat, 31 Mar 2007 15:32:05 +0200
Message-Id: <1175347925.5815.236.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] BlueZ, testing socket
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

Hi Meenakshi,

> This code below connects to the server socket and selects the protocol
> to be used (L2CAP), opens the socket for that protocol, creates a
> bluetooth address object and sets its port to the PSM and binds the
> socket to this address, tells the sockets to listen for incoming
> connections, creates a blank socket and pass it to the listening
> socket through accept (When this call completes the socket passed in a
> parameter is now fully connected and can be used to send and receive
> data) 
> 
> QUESTION: How do I test this socket works? I want to send a messge
> like "Hello World". Please help...anyone

you should have a look at l2test.c and rctest.c from bluez-utils.
However the simple answer is to use read() and write() on that specific
socket descriptor.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
