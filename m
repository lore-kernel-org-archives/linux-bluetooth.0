Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076280612.14742.147.camel@akka.yeti.nocrew.org>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076275689.14742.93.camel@akka.yeti.nocrew.org>
	 <1076277250.6869.24.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
	 <1076280612.14742.147.camel@akka.yeti.nocrew.org>
Content-Type: text/plain
Message-Id: <1076282343.6869.65.camel@pegasus>
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
Date: Mon, 09 Feb 2004 00:19:03 +0100

Hi Fredrik,

> I'm talking about the DBus specification. See:
> http://freedesktop.org/Software/dbus/doc/dbus-specification.html
> 
> Excerpt: "Before an application is able to send messages to other
> applications it must send the org.freedesktop.DBus.Hello message to 
> the message bus service."     ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> I.e. the name is more about who implemented it than what it tries
> to implement.

We try to implement Bluetooth so "org.bluetooth" is ok ;)

> > This is about objects. It is an object oriented interface. You have
> > objects like "device", "nametab", keytab" etc. with their methods. What
> > we don't have is instances like "hci0", so we have to carry the device
> > as an parameter.
> 
> But objects carry contexts. These modular interfaces carry no contexts,
> and therefore cannot possibly be objects. Modular interfaces is about
> keeping name spaces apart.

Do you mean contexts or contents?

> > Do we really need this? What are the advantages of objects? I prefer
> > differencing with the method names. For example like "get_local_name"
> > and "get_remote_name".
> 
> Modules is the way to extend applications. Say someday somebody decides
> to do loadable modules in hcid, implementing completely new services.
> Naturally, these modules ought to have their own name spaces. That's
> what these interfaces are used for.

I am not really convinced about your argument, because I prefer to have
more in common with the HCI specification. But the HCI don't have any
namespace. Let me think about.

Lets talk about the namespaces you are thinking of. What makes sense to
separate?

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
