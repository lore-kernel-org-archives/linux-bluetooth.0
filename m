Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] bluez and asterisk
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <HCEOIFALKKLBLJPENPNOAEELCAAA.khaled@ipbill.com>
References: <HCEOIFALKKLBLJPENPNOAEELCAAA.khaled@ipbill.com>
Content-Type: text/plain
Message-Id: <1131633682.25312.17.camel@blade>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 10 Nov 2005 15:41:22 +0100

Hi Khaled,

> > make sure that "hcid" is running as root
> 
> Hcid was not running, after starting it I ran rfcomm connect again but this
> time it gave a Can't connect RFCOMM socket: connection refused' error, which
> means pin is wrong?
> How can I disable the pin feature?

you can't. Run "hcidump -X -V" and make sure that the PIN helper works.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
