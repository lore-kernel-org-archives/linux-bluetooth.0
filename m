Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] New keytab storage
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075565012.14644.176.camel@akka.yeti.nocrew.org>
References: <1075506991.14644.114.camel@akka.yeti.nocrew.org>
	 <1075509170.3594.36.camel@pegasus>
	 <1075510549.14644.135.camel@akka.yeti.nocrew.org>
	 <1075511922.3594.49.camel@pegasus>
	 <1075541234.14644.149.camel@akka.yeti.nocrew.org>
	 <1075562590.2720.13.camel@pegasus>
	 <1075563628.14644.161.camel@akka.yeti.nocrew.org>
	 <1075564322.2720.42.camel@pegasus>
	 <1075565012.14644.176.camel@akka.yeti.nocrew.org>
Content-Type: text/plain
Message-Id: <1075572088.2720.59.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 31 Jan 2004 19:01:28 +0100

Hi Fredrik,

> > But I think we should discuss some design goals of the new device manager.
> 
> Great idea. What's your plan for it?

one of my big goals is to have a library with a much improved API. This
means that all HCI related functions use the hci_* prefix and follow the
naming scheme from the HCI part of the Bluetooth specification. But the
HCI part should not be used for common applications. These applications
should use bt_* functions that offer an enhanced functionality. For
example setting the local name. The hci_* part only send the HCI
command, while the bt_* stuff also stores the name in a database so it
can be restored after reboot. I think you get the idea.

> > I don't see what kind of mess in "glib-ectomy" you mean, but go ahead
> > and send a patch for it. 
> 
> Some bads, I think:
> 
>   - The API can be improved
>   - Tons of ugly (even in opionon) typedef:s
>   - No style

in the early days the hcid depends on glib and this code is a small
compat layer to be free from the glib. I wrote a similar replacement for
utils2. May you want to take a look at the helper library.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
