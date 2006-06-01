Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <70DCB28C5BB04A4BBB1C8512589BAC65D4F15C@MAIL006.mail.lan>
References: <70DCB28C5BB04A4BBB1C8512589BAC65D4F15C@MAIL006.mail.lan>
Date: Thu, 01 Jun 2006 19:54:59 +0200
Message-Id: <1149184499.28511.33.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Strange behaviour
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Chris,

> > > I've upgraded one of the two machines to FC5 (bluez-libs 
> > 2.25-1), and 
> > > my test code is quite happy to run with only one bt dongle attached.
> > 
> > even with the latest FC5 kernel?
> 
> No. Now I see the same thing you do.
> Something changed here between kernel 2.6.15 and 2.6.16, then ?

then it is the socket fix. You are trying to run a getsockname() on an
unbound socket.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
