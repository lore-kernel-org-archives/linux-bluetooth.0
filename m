Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] New PIN helper, how to include with BlueZ?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060311190606.236f7cbd.fotopiper@o2.pl>
References: <20060311190606.236f7cbd.fotopiper@o2.pl>
Content-Type: text/plain
Message-Id: <1142185809.4620.3.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 12 Mar 2006 18:50:09 +0100

Hi Radek,

> a new PIN helper has been born, and I think it's time to include it in
> the BlueZ packages (including source packages) either as a default
> helper, or as an option. The problem is neither me, nor the author have
> a good sense of how such things happen for BlueZ.

you post a patch to mailing list and it will be discussed and if it is a
sane approach it will be included. As simple as that.

> For those who haven't fallowed our discussion I will gave a short
> summary of the situation:
> 
> Dave Mielke has been working for some time on a new PIN helper for
> BlueZ, one that deals in a more complex, and in my opinion complete way,
> with the problem.
> 
> The basic approach is to have a list of pins and device addresses in a
> file, form which the helper will extract the correct PIN. If the device
> is not on the list a prompt is started on a new terminal, that asks for
> PIN (giving all the standard information). In case the terminal prompt
> is not welcomed, a secondary helper can be called (for instance the
> python script already shipped with BlueZ, or other for KDE/GPE/OPIE or
> any other). The prompt can be fully disabled. The script can be
> configured either with a config file, or by command line parameters.

The /var/lib/bluetooth/<bdaddr>/pincodes file is supported for outgoing
connection for quite some time. The default /etc/bluetooth/pin has been
already removed and the complete PIN helper script support will be
remove really soon, too. The new way for the having a flexible way of
PIN handling will be over D-Bus. At some not so far point in the future
the bluez-utils package will depend on D-Bus anyway.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
