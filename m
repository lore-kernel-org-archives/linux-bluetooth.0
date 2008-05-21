Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <3e9cdced0805190343l56fe321aye9a1e257165f2ee@mail.gmail.com>
References: <3e9cdced0805190343l56fe321aye9a1e257165f2ee@mail.gmail.com>
Date: Wed, 21 May 2008 16:38:57 +0200
Message-Id: <1211380737.13248.72.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-users] specifiy path to socket file (hcid)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Fritz,

> how can I specify a path where hcid should look for the socket which
> is created by dbus?
> Didn't find anything in "man hcid.conf" or other docs
> At the moment the path seems to be just set to PREFIX ( which was set
> at compile time) with the string added var/run/dbus.
> Since Im crosscompiling PREFIX is the path to my toolchain and not my
> favorite place of the socket file in my target system.

there must be some D-Bus environment variable set before you run hcid.
It think it is something like DBUS_SYSTEM_PATH or so. Check the D-Bus
documentation or source code.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
