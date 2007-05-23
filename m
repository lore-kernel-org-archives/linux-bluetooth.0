Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1179933855.3629.75.camel@cookie.hadess.net>
References: <1179933855.3629.75.camel@cookie.hadess.net>
Date: Wed, 23 May 2007 17:51:11 +0200
Message-Id: <1179935471.19944.6.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: twaugh@redhat.com
Subject: Re: [Bluez-devel] CUPS plugin discovery bits
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Bastien,

> Here's a patch against CVS bluez-utils to add discovery to the CUPS
> backend. With this, it means that most CUPS front-end will be able to
> list visible printers when adding a new one, be it through the web
> interface or other front-ends (like Fedora' system-config-printer).
> 
> It adds D-Bus and glib as dependencies for the backend (not that it
> matters that much...).

it actually does. We provide an eGlib for embedded systems and so when
compiled with GLib, we only use that function subset.

And second you use the GLib D-Bus bindings. I am not willing to create
these dependencies for a "daemon" package.

Another small thing is that DisocverDevices() will automatically take
care of the name resolving for you. So no need to call GetRemoteName().
You will get the RemoteNameUpdated() signal.

The thing that worries me is when you start CUPS it will list through
all backends and make them list. So on every boot the system will scan
for devices in range and that can slow down the system boot. So this
might not be a good idea. Actually that is the reason why we wanna go
for a printing service in the future.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
