Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <4492D0E1.5090806@marples.net>
References: <4492B0C9.6010305@marples.net>  <4492D0E1.5090806@marples.net>
Date: Sat, 17 Jun 2006 12:19:11 +0200
Message-Id: <1150539551.17539.11.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] rfcomm device blocking/data available behaviour
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

Hi Dave,

> Replying to myself here, but moving over to the python library, the 
> following code _works_;
> 
> import bluetooth
> 
> s=bluetooth.BluetoothSocket( bluetooth.RFCOMM )
> s.connect(("xx:xx:xx:xx:xx:xx",1))
> s.send('ATZ\r')
> while 1:
>     c=s.recv(1)
>     print "Got",len(c),"Detail:",ord(c),c
> 
> ...so, I can only conclude that it's something to do with the device 
> emulation side of things.  Hope this is helpful to someone.

the RFCOMM TTY devices are not in raw mode by default. You need to do
that by yourself. However every application should now what's the best
mode to use the device and cat is simply too dumb.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
