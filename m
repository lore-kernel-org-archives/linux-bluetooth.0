Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076342741.5263.134.camel@kalkyl.roxen.com>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076275689.14742.93.camel@akka.yeti.nocrew.org>
	 <1076277250.6869.24.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
	 <1076280612.14742.147.camel@akka.yeti.nocrew.org>
	 <1076282343.6869.65.camel@pegasus>
	 <1076284317.14742.179.camel@akka.yeti.nocrew.org>
	 <1076287085.6869.70.camel@pegasus>
	 <1076311376.14742.202.camel@akka.yeti.nocrew.org>
	 <1076321200.6869.75.camel@pegasus>
	 <1076322129.5263.28.camel@kalkyl.roxen.com>
	 <1076323138.6869.93.camel@pegasus>
	 <1076323602.5263.41.camel@kalkyl.roxen.com>
	 <1076324584.6869.109.camel@pegasus>
	 <1076327592.5263.64.camel@kalkyl.roxen.com>
	 <1076331669.6869.164.camel@pegasus>
	 <1076333024.5263.116.camel@kalkyl.roxen.com>
	 <1076341569.6869.200.camel@pegasus>
	 <1076342741.5263.134.camel@kalkyl.roxen.com>
Content-Type: text/plain
Message-Id: <1076344242.6869.231.camel@pegasus>
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
Date: Mon, 09 Feb 2004 17:30:42 +0100

Hi Fredrik,

> > ask yourself what's the indentation of hcid.conf and how should a
> > computer program know about it. Of course this is possible to handle,
> > but it is always a mess.
> 
> hcid can have some standard indentation style but it can also support
> the "--marcel-style" flag for your personal formating preferences. ;)

you don't got my point here. If a system administrator modifies some
settings in complex files like hcid.conf, everyone uses its own
identation and style to make it best readable for themself. And nobody
likes if a program changes a value and introduces some odd styles.

Config files like hcid.conf are build this way, because they can contain
complex configuration. Only the administrator should edit such files.

> > No. If we use a uniform storage, there is no need for a D-Bus interface,
> > because the application can modify the storage directly. 
> 
> "Plain text files" and "DBus interface" do not exclude each other. It
> would be great to have them both, because they serve different pruposes:

No they don't, but with an D-Bus interface we don't need to have
knowledge about these files, because this is the job of the program that
provides us with this D-Bus interface.

> Plain text files are great for admins, debugging, diagnostics etc.
> 
> DBus is great for system tools, Gnome, KDE etc. Besides, the DBus
> interfaces provide a lot more services than just maintaining files.

I was never talking about D-Bus for file maintaining. I talked about a
general interface for different tasks. If it comes to link keys or name
caches, of couse these must be stored somewhere. But you can also store
them on a SQL database in another country. Who cares? That is beyond the
interface and its the job of the program that provides this interface.

> > One of the main ideas is to abstract from the storage of the information.
> 
> Agreed. But storage abstraction does not implicate storage obfuscation,
> does it? :)

As already said, I have no problem with plain text files. But hcid.conf
is a configuration file and should only read once at startup. All other
modification have to stored in a configuration storage. If we have stuff
that overlaps, we must find a solution for it.

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
