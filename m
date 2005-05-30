Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] strange error--/drivers/bluetooth/hci_uart.c
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <c43104b305052921125244b7bb@mail.gmail.com>
References: <c43104b305052801374253576b@mail.gmail.com>
	 <1117287804.12036.141.camel@pegasus>
	 <c43104b305052921125244b7bb@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1117454454.7072.139.camel@pegasus>
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
Date: Mon, 30 May 2005 14:00:54 +0200

Hi,

> > >       h4_recv: Unknown HCI packet type 00
> > >       h4_recv: Unknown HCI packet type 34
> > >       these message offen appear
> > 
> > this message means that your UART stream is out of sync. This happen due
> > bit errors on the serial line. What kind of module is this and what
> > kernel are you using?
> My module is broadcom2035 and kernel is 2.4.18. 
> This case only happened when wlan in the same PCB borad works.
> 
> I want to know why UART stream is out of sync when wlan works. 

the 2.4.18 kernel is quite old and even with the -mh patch it is way
behind the current 2.6 kernel series.

The WiFi may introduces extra load to the UART that is used by your
Bluetooth module and thus you see the problems. I think it is hardware
specific. However with a Broadcom module you don't have any chance to
switch to BCSP as transport protocol.

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
