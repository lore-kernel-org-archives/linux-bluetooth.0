Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076277250.6869.24.camel@pegasus>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076275689.14742.93.camel@akka.yeti.nocrew.org>
	 <1076277250.6869.24.camel@pegasus>
Content-Type: text/plain
Message-Id: <1076278554.14742.112.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Sun, 08 Feb 2004 23:15:54 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel

On Sun, 2004-02-08 at 22:54, Marcel Holtmann wrote:
> It is Bluetooth we are talking about, so use "bluetooth.org" even if we
> don't own the domain. I don't care, because it is only a name ;)

Well, please look at the names Freedeskop uses in DBus for 
generic things like disconnect signals. They actually use the
"freedesktop" interface. :)

> The interface is about access to a specific service or protocol, so I
> want to use "hci". The hcid is only the implementation of it. For the
> future I also think about having D-Bus interfaces for "sdp", "hid" etc.

OK.

> Why not a list of devices and then an extra method for every element? I
> want to make this interface as open and as extendable as possible.

The reason is efficiency and ease of use. It's much more efficient to
get everything in one batch when this is what's needed anyway. The
dictionaries make this method call extremely extendable. We can also 
add complementary method calls if needed.

> Of course, this is obvious. What format do we use for the parameter. You
> show it as string. This means "hci0" or "11:22:33:44:55:66" or both?

I think both should be allowed. Currently only "hciX" is implemented.

> And I prefer also to have get_name. See comment above.

OK. Adding new methods is no problem.

> We must also have something for remote names, so set_local_name,
> get_remote_name etc. would maybe better.

Agreed, but these should not be implemented in the "device" interface
because this isn't a device property.

> I don't wanna use the name "keytab". Maybe "pairing_list". Something
> like "is_paired(src, dst)" would also be nice.

OK.

> Yes, but "delete" is too generic.

Not in a "key pair" context, I think.

> Now you see that I don't really like the object oriented stuff. I see no
> need for "keytab", "nametab" etc. I see this interface more as somekind
> of multiplexing for HCI.

This isn't about objects. It's about modularisation. The new hcid
implementation is much more modular than the previous version, made to
enable plugin modules/services. It's really a very good idea to keep
conceptually different things like "key pairs" and "name lookups" apart,
using different interfaces.

> Can these signal also give us the new values? Like the HCI events. For
> example local_name_changed().

Yes, signals can carry arguments.

Fredrik
