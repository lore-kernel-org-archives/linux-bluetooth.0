Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076278554.14742.112.camel@akka.yeti.nocrew.org>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076275689.14742.93.camel@akka.yeti.nocrew.org>
	 <1076277250.6869.24.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
Content-Type: text/plain
Message-Id: <1076279508.6869.54.camel@pegasus>
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
Date: Sun, 08 Feb 2004 23:31:48 +0100

Hi Fredrik,

> > It is Bluetooth we are talking about, so use "bluetooth.org" even if we
> > don't own the domain. I don't care, because it is only a name ;)
> 
> Well, please look at the names Freedeskop uses in DBus for 
> generic things like disconnect signals. They actually use the
> "freedesktop" interface. :)

please be more specific. What files are you talking about?

> > Why not a list of devices and then an extra method for every element? I
> > want to make this interface as open and as extendable as possible.
> 
> The reason is efficiency and ease of use. It's much more efficient to
> get everything in one batch when this is what's needed anyway. The
> dictionaries make this method call extremely extendable. We can also 
> add complementary method calls if needed.

What stuff do UI interfaces need to get with one call?

> > Of course, this is obvious. What format do we use for the parameter. You
> > show it as string. This means "hci0" or "11:22:33:44:55:66" or both?
> 
> I think both should be allowed. Currently only "hciX" is implemented.

Agreed. This makes it easy to come from socket programming to the D-Bus
interface, because you can use the BD_ADDR you are also using for the
socket.

Do we need a special datatype for the BD_ADDR or is string the best?

> > Now you see that I don't really like the object oriented stuff. I see no
> > need for "keytab", "nametab" etc. I see this interface more as somekind
> > of multiplexing for HCI.
> 
> This isn't about objects. It's about modularisation. The new hcid
> implementation is much more modular than the previous version, made to
> enable plugin modules/services. It's really a very good idea to keep
> conceptually different things like "key pairs" and "name lookups" apart,
> using different interfaces.

This is about objects. It is an object oriented interface. You have
objects like "device", "nametab", keytab" etc. with their methods. What
we don't have is instances like "hci0", so we have to carry the device
as an parameter.

Do we really need this? What are the advantages of objects? I prefer
differencing with the method names. For example like "get_local_name"
and "get_remote_name".

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
