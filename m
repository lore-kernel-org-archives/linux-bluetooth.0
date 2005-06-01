Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] howto know whether bluez is present?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050601113500.19943.qmail@webmail52.rediffmail.com>
References: <20050601113500.19943.qmail@webmail52.rediffmail.com>
Content-Type: text/plain
Message-Id: <1117628260.31350.1.camel@pegasus>
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
Date: Wed, 01 Jun 2005 14:17:40 +0200

Hi Abhay,

> i have a basic query regarding bleuz.
> i want to know 
> 1.how to check whether bluez support is present in kernel?or how to
> enable it?

for a 2.6 kernel check with "lsmod | grep bluetooth" if the module is
loaded or with "modinfo bluetooth" is the module exists.

> 2. is ther (and if yes which ) any GUI application for the bluetooth
> in Linux that can be used with bleuz?

Look for the Gnome Bluetooth subsystem or the KDE Bluetooth framework.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
