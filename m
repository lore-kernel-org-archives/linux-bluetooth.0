Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300707221847w263a72eas8015380edc66edb9@mail.gmail.com>
Date: Sun, 22 Jul 2007 19:47:45 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <46A34096.7050306@gmx.de>
MIME-Version: 1.0
References: <46A34096.7050306@gmx.de>
Subject: Re: [Bluez-users] bluetooth-alsa: Motorola DC800 works with btsco
	but not with plugz
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

Thomas,

The "a2dpd2" plugin works a little differently (with the same daemon)
and it would be worth trying.

I wrote the a2play app but Frederic wrote a2dpd so I'm not sure what
the significance of retrieve_data_from underrun would be.

If you post the a2dpd log with your message, you're more likely to get
some comments on it. The bug area in bluetooth-alsa is only checked
infrequently.

Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
