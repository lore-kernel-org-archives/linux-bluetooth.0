Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Frederic Dalleau <frederic.dalleau@access-company.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300707221847w263a72eas8015380edc66edb9@mail.gmail.com>
References: <46A34096.7050306@gmx.de>
	<d89ddf300707221847w263a72eas8015380edc66edb9@mail.gmail.com>
Date: Wed, 25 Jul 2007 14:14:59 +0200
Message-Id: <1185365699.2745.19.camel@ubuntu.mpl.access-company.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluetooth-alsa: Motorola DC800 works with
	btsco	but not with plugz
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Brad,

> The "a2dpd2" plugin works a little differently (with the same daemon)
> and it would be worth trying.
> 
Hi I finally removed the a2dpd2.

> I wrote the a2play app but Frederic wrote a2dpd so I'm not sure what
> the significance of retrieve_data_from underrun would be.
It is an underrun from the application. That's strange as it works with
HT820.


Thomas,

Only thing I found about dc800 is that it is an a2dp source that you
connect to hifi to listen music with an headset like ht820. This role is
not supported in a2dpd. Only a2play from btsco will work with this.

Does it support also sink role?

Frederic.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
