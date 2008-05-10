Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <482586CE.50107@in.tum.de>
References: <482586CE.50107@in.tum.de>
Date: Sat, 10 May 2008 14:57:10 +0200
Message-Id: <1210424230.16390.4.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bluez dbus
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

Hi Aleksander,

> would someone please explain to me why does bluez support D-Bus? What 
> are the advantages by using dbus instead of simply linking and using the 
> bluez C library?

a C library has no concept of privilege separation. Every client would
have to be setuid-root since there are tasks that require root
privileges. Without a suid-root client, we would need a message passing
interface within hcid for these task. And guess what D-Bus is.

Also D-Bus provides bindings for almost every language and the license
for a Bluetooth client using D-Bus is no longer bound to the GPL.

Besides that are multiple technical reasons why D-Bus is the right
choice for a Bluetooth API.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
