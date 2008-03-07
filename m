Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47D03C82.9060009@suse.de>
References: <47D03C82.9060009@suse.de>
Date: Fri, 07 Mar 2008 15:16:09 +0100
Message-Id: <1204899369.28006.2.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [patch]  make apitest more useful
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

Hi Stefan,

> This trivial 2-character patch makes apitest much more useful by allowing
> stuff like "apitest -l DiscoverDevices" to work like i'd expect it to:
> 
> --- /usr/bin/apitest	2008-03-02 19:22:20.000000000 +0100
> +++ /home/seife/bin/apitest.seife	2008-03-06 19:44:52.000000000 +0100
> @@ -415,7 +415,7 @@ class Tester:
>              self.dbus_dev_sig_setup()
>              print 'Listening for events...'
> 
> -        elif self.cmd in mgr_cmds:
> +        if self.cmd in mgr_cmds:
>              try:
>                  self.dbus_mgr_setup()
>              except dbus.DBusException, e:
> 
> 
> Now we can alias "hcitool scan" to "apitest -l DiscoverDevices" ;-)

the apitest is really only a test program, but I applied the patch
neverless.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
