Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PROBLEM: Apple Powerbook and apple keyboard,
	start up sequence fails
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1100460997.6066.18.camel@localhost>
References: <1100460997.6066.18.camel@localhost>
Content-Type: text/plain
Message-Id: <1100463431.21403.73.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 14 Nov 2004 21:17:11 +0100

Hi Matthew,

> BT keyboard is connected on startup, but no keyboard output is
> happening, and capslock light does not turn on when capslock key is
> pressed.  This is not just the connection delay, as my mouse reconnects
> successfully after boot.

maybe the keyboard firmware is buggy. I read that Apple has a firmware
update for their mouse and keyboard and I think it is worth to try it.

Do you run your Bluetooth device in security mode 3?

> I believe the Apple Open firmware on the powerbook negotiates a
> connection with the keyboard on power up or boot, and leaves the
> built-in CSR USB dongle in USB HID emulation mode.  The keyboard starts
> working after I switch it on and off, and it renegotiates a connection. 

It is all on the CSR BlueCore02 chip. The Apple firmware does nothing.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
