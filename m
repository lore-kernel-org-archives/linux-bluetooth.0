Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <c43104b305052921125244b7bb@mail.gmail.com>
From: peng zhihuai <pengzhihuai@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] strange error--/drivers/bluetooth/hci_uart.c
In-Reply-To: <1117287804.12036.141.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c43104b305052801374253576b@mail.gmail.com>
	 <1117287804.12036.141.camel@pegasus>
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
Date: Mon, 30 May 2005 12:12:52 +0800

Thank you for your reply.
2005/5/28, Marcel Holtmann <marcel@holtmann.org>:
> Hi,
>=20
> >       h4_recv: Unknown HCI packet type 00
> >       h4_recv: Unknown HCI packet type 34
> >       these message offen appear
>=20
> this message means that your UART stream is out of sync. This happen due
> bit errors on the serial line. What kind of module is this and what
> kernel are you using?
My module is broadcom2035 and kernel is 2.4.18.=20
This case only happened when wlan in the same PCB borad works.

I want to know why UART stream is out of sync when wlan works.=20
Any hlep is appreciated.


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
