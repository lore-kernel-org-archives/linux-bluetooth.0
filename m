Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] IBM Thinkpad A31p and Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: jvp@lateapex.net
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200309121505.h8CF5fW04857@localhost.lateapex.net>
References: <200309121505.h8CF5fW04857@localhost.lateapex.net>
Content-Type: text/plain
Message-Id: <1063401632.28890.268.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 12 Sep 2003 23:20:26 +0200

Hi Jason,

> I'm trying to get the Bluez bluetooth drivers working in kernel 2.4.22 on my
> new IBM Thinkpad A31p.  The laptop has a built-in (miniPCI?) bluetooth
> controller in it, but I'm uncertain of the brand/model/etc.

the Bluetooth adapter in this notebook is a USB based from CSR and it
should work perfect with the hci_usb driver. Have you switched the
Bluetooth device on?

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
