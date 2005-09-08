Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCID D-Bus
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb050908125079935830@mail.gmail.com>
References: <e1effdeb050908125079935830@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1126220839.5286.57.camel@blade>
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
Date: Fri, 09 Sep 2005 01:07:19 +0200

Hi Claudio,

> In the last email about bluetoothd, you suggested send patches to
> enhance hcid. I studied the hcid code and I would like align our ideas
> before start coding. My suggestions are:
> 
> 1. Develop a common code addressing all D-Bus versions

not needed, because my plan is to drop support for anything below D-Bus
version 0.5 (which should be compatible with D-Bus 0.3x) starting with
bluez-utils-0.22. My original plan was to do it in next release, but
there are some memory leak fixes and I want to get out a new version as
soon as possible. However maybe it is a good idea to drop support for
older D-Bus versions now.

It seems the only problematic distribution is Debian unstable. Every
other distribution (including Ubuntu) uses at least D-Bus 0.35.

> 2. Send signals to connection complete and disconnection

While I was adding the signals for the inquiry responses, I thought
about doing this, too. I added the needed functions for it and open the
filter for these messages. The only problem is that the disconnect uses
the ACL handle and not the device address. This means you have to keep
track of all handles. Normally the kernel does this all for us. This is
one reason for a good/new interface between the kernel and bluetoothd.
Coding everything twice is stupid.

> 3. Register a D-Bus hci object path as a initial point for bluetoothd
> and provide basic services(inquiry, auth, ...).

Go ahead. I would really welcome it.

I need a job where I can fulltime work on bluetoothd and add all the
cool things we talked about. If anyone know one or has one, let me know.

> I am sending a patch to solve the problem of D-Bus versions. Sorry,
> byte array is not being handled yet, but I will fix it. This is just a
> idea of how solve the problem of several D-Bus versions. Get the dbus
> major/minor version in the "configure" is a better approach, instead
> of check if the function dbus_message_iter_get_basic belongs to the
> dbus-1 library. If you allow change the makefiles(acinclude.m4,
> configure.in, config.h.in ) I can modify it.

I like to drop support for older D-Bus versions. After a private talk
with J5 it seems the only sane way to do.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
