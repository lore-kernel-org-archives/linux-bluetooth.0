Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Multiple user/device model?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1127025473.14893.51.camel@yeti>
References: <1127025473.14893.51.camel@yeti>
Content-Type: text/plain
Message-Id: <1127216957.5168.30.camel@localhost.localdomain>
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
Date: Tue, 20 Sep 2005 13:49:16 +0200

Hi Fredrik,

> Can multiple users have different sets of Bluetooth devices? I.e.
> something like this:
> 
>     /home/peter/.bluetooth/devices/00:11:22:33:44:55/linkkeys
>     /home/maria/.bluetooth/devices/99:88:77:66:55:44/linkkeys
> 
> With the following properties:
> 
>     1. User pairing and device management don't require
>        administrative (root) privileges.
>     2. Peter cannot remove/modify Maria's devices and vice versa.
>     3. Would be excellent if Peter and Maria could use Bluetooth
>        simultaneously, but good enough if only one at the time.

the idea is not bad, but it will never work this way. This is because
how the Bluetooth security architecture is designed. We need a central
root service that deals with the kernel side of HCI. However the control
of pairing etc. for users will be handled over D-Bus.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
