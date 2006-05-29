Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4462172D.3040604@ihep.ru>
References: <4462172D.3040604@ihep.ru>
Date: Mon, 29 May 2006 15:37:58 +0200
Message-Id: <1148909878.31689.68.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Intellimouse transmission lost
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

Hi Anton,

>   As I see, my mouse (MS Intellimouse for bluetooth) works automatically
> after system up without starting bluetooth daemon on my distro
> (ALT-Linux3.0).
> So, the kernel (2.6.16) determines devices themselves and initialize
> modules.
>   But everytime my bt-mouse suspends after 20-40 minutes for some
> reason, which
> I can't determine. Linux installed on Toshiba Satellite M40-289 laptop.
>   Please, help me if You have some ideas.

the Microsoft mouse disconnects after an idle time of 12 minutes. You
need to make sure that "hidd --server" is running and then the mouse
will reconnect when you use it.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
