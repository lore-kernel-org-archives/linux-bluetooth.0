Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <447F35F0.2060105@gnunux.info>
References: <447E0B1B.1010100@gnunux.info>  <447F35F0.2060105@gnunux.info>
Date: Thu, 01 Jun 2006 21:01:15 +0200
Message-Id: <1149188475.28511.55.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Solve : Re: Can't create HID control
	channel:	Connection refused
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

Hi Emmanuel,

> > // # hidd --connect 00:0A:3A:32:97:11
> > Can't create HID control channel: Connection refused
> > /
> > What "Connection refused" refered to ? How to solve this problem ?
> >
> > Regards.
> 
> Sorry, but my device don't support HID but BT SERIAL PORT, my keyboard 
> works fine with http://fanoush.webpark.cz/maemo/.

this code should be included in hidd, like I did with the code for the
EPoX presenter.

However I don't own any of these keyboards, so I might not start coding
the support for it.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
