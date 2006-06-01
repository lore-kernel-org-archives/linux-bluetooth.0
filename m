Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <70DCB28C5BB04A4BBB1C8512589BAC65D4F2D8@MAIL006.mail.lan>
References: <70DCB28C5BB04A4BBB1C8512589BAC65D4F2D8@MAIL006.mail.lan>
Date: Fri, 02 Jun 2006 00:55:16 +0200
Message-Id: <1149202516.32406.0.camel@localhost>
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

> > Do you really need to use a thread to produce this behavior. 
> > I normally try to avoid any threaded programs at all. Can you 
> > please remove all extra stuff from your code (and use simply 
> > hci0 only) and try to not to use threads?
> 
> I think the problem only occurs when I'm sending and receiving at the
> same time, which could well mean that it will only occur with a threaded
> program.

can we try to reproduce this with a non-thread test program. If we can
reproduce it this way, it will be much easier to debug.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
