Return-Path: <cyrus@holtmann.org>
Message-Id: <75FB41F6-49E1-4CEE-8A7F-87DCF21645F5@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <3e9cdced0805170741i202cfe62kef18ca9a0c2e30c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Sat, 17 May 2008 16:47:02 +0200
References: <3e9cdced0805170741i202cfe62kef18ca9a0c2e30c@mail.gmail.com>
Subject: Re: [Bluez-users] using bluez dbus interface exposed from hcid with
	plain c code
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

> since I don't have resources for Glib or another abstraction layer  
> on my Embedded Linux I can only use plain C for communication with  
> bluez through dbus.
> But so far I've only find howto's with GLib or Qt etc.
> Are there any documents that describe my case (plain c  
> communication) ?
>
> For general understanding of the bluez architecture and tools, a  
> statement and a question:
>
> hcid is the daemon which exposes different Interfaces through dbus,  
> e.g. the Interface "Adapter".
> Another Application can access bluez functionalities through dbus by  
> using the Interfaces exposed from hcid. (hopefully also by using  
> plain C).
>
> E.g.: You want to develop an application "example-app" which should  
> list available local buetooth devices, remote devices and its  
> services.
> In this case it is enough to start hcid and use its Interface  
> "Adapter" from "example-app" ?
>
> The other tools like, hcitool, hciconfig etc. are not necessary,  
> they are own applications, right.
> In order to use bluez features from another application (through  
> dbus) the only tool/util needed is hcid?
> And this is configured by hcid.conf?

if you use bluez-utils-3.31 or any later release, the only thing you  
need is hcid. It will do everything for you. The only exception is if  
your adapter is connected via an UART and using hci_uart driver, then  
you also need hciattach, but that is it.

And of course you can write a client application using D-Bus low-level  
(libdbus) only. It is a little bit more work than using high level  
languages, but it is possible. I still have plans to provide a D-Bus  
only replacement for hciconfig, hcitool etc.

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
