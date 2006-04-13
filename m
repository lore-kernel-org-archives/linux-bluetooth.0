Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] How to process fragmentation synchronously when
	two l2cap connections over one acl connection?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <ef9938ec0604130949q67168579m85a3eb9521cdae91@mail.gmail.com>
References: <9FBCE015AF479F46B3B410499F3AE05B011F0BCB@pdsmsx405>
	 <OF01649481.41C9F474-ON4825714F.003F0EC5-4825714F.004171CE@zte.com.cn>
	 <ef9938ec0604130949q67168579m85a3eb9521cdae91@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1144948700.11159.53.camel@localhost>
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
Date: Thu, 13 Apr 2006 19:18:20 +0200

Hi Albert,

> l2cap packets are always identified by a channel ID, which is
> negotiated when each l2cap connection (channel) is established.
> Continuation fragments always have the channel ID in the packet
> header, so there is no ambiguity over which continuation fragment
> belongs to which connection.  You should take another look at the
> L2CAP section in the core spec.

you are not allowed to mix L2CAP fragments. As simple as that.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
