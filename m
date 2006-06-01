Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <70DCB28C5BB04A4BBB1C8512589BAC65D4F163@MAIL006.mail.lan>
References: <70DCB28C5BB04A4BBB1C8512589BAC65D4F163@MAIL006.mail.lan>
Date: Thu, 01 Jun 2006 23:11:24 +0200
Message-Id: <1149196284.28511.73.camel@localhost>
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

> > > even with the latest FC5 kernel?
> > 
> > No. Now I see the same thing you do.
> 
> I take that back - sorry.
> 
> I actually didn't have a dongle attached. With a single dongle attached,
> my test code does still start fine.

I hacked up the code to avoid this test and simply go ahead with hci0
and I can see that something weird is going on. However I have no idea
what it is and your code is not easy to follow.

Do you really need to use a thread to produce this behavior. I normally
try to avoid any threaded programs at all. Can you please remove all
extra stuff from your code (and use simply hci0 only) and try to not to
use threads?

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
