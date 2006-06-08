Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <549053140606060015h1f95955ao63714bd03df53998@mail.gmail.com>
References: <549053140606021732w4263c5c2g93efa4cdf9a7614d@mail.gmail.com>
	<1149362263.1977.4.camel@localhost>
	<549053140606031339i43cee0a7h8622f83d76370504@mail.gmail.com>
	<1149371447.1977.13.camel@localhost>
	<549053140606060015h1f95955ao63714bd03df53998@mail.gmail.com>
Date: Thu, 08 Jun 2006 09:13:27 +0200
Message-Id: <1149750807.27331.1.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] PM325 by LG cell phone
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

Hi Carl,

> carl@asus17:~$ sudo rfcomm connect 0 08:00:37:03:EF:36 4
> Can't connect RFCOMM socket: Connection refused 

run "hcidump -X -V" as root to see what's going on.

> I am not sure I have paired.  If I did, does rebooting phone or linux
> end that 'session' ?

Maybe the channel numbers changed or you need to reactivate the DUN
service.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
