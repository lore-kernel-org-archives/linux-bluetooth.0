Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076279508.6869.54.camel@pegasus>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076275689.14742.93.camel@akka.yeti.nocrew.org>
	 <1076277250.6869.24.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
Content-Type: text/plain
Message-Id: <1076280612.14742.147.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Sun, 08 Feb 2004 23:50:13 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel

On Sun, 2004-02-08 at 23:31, Marcel Holtmann wrote:
> please be more specific. What files are you talking about?

I'm talking about the DBus specification. See:
http://freedesktop.org/Software/dbus/doc/dbus-specification.html

Excerpt: "Before an application is able to send messages to other
applications it must send the org.freedesktop.DBus.Hello message to 
the message bus service."     ^^^^^^^^^^^^^^^^^^^^^^^^^^

I.e. the name is more about who implemented it than what it tries
to implement.

> What stuff do UI interfaces need to get with one call?

The device listning on for example the main window in the Gnome
Bluetooth Configuration tool.

> Do we need a special datatype for the BD_ADDR or is string the best?

When using DBus, I think it's a good idea to stay with generic types
like int, string, dictionary and array. Makes it easier to use a wide
range of languages too.

> This is about objects. It is an object oriented interface. You have
> objects like "device", "nametab", keytab" etc. with their methods. What
> we don't have is instances like "hci0", so we have to carry the device
> as an parameter.

But objects carry contexts. These modular interfaces carry no contexts,
and therefore cannot possibly be objects. Modular interfaces is about
keeping name spaces apart.

> Do we really need this? What are the advantages of objects? I prefer
> differencing with the method names. For example like "get_local_name"
> and "get_remote_name".

Modules is the way to extend applications. Say someday somebody decides
to do loadable modules in hcid, implementing completely new services.
Naturally, these modules ought to have their own name spaces. That's
what these interfaces are used for.

Mixing it makes a mess. :)

Fredrik
