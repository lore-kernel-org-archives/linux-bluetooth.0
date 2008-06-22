Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <3e9cdced0806210213i412a870dnfdde87de30e3ea63@mail.gmail.com>
References: <3e9cdced0806210213i412a870dnfdde87de30e3ea63@mail.gmail.com>
Date: Sun, 22 Jun 2008 03:44:13 +0200
Message-Id: <1214099053.7046.1.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] problemes using passkeyagent d-bus interface
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

>  did everything to implement a passkey-agent. ( using bluez 3.31)
> The problem is, althouth I've implemented everything the same way, and
> it definitely should be right, only the method "Reqest" gets
> called, but the other ones, Keypress. Cancel, Confirm, Complete not?
> Using dbus-monitor I can only see Signals but no method-calls, so I
> dont know if the method calls get executed.

the other ones are for Simple Pairing support and where never
implemented properly. Starting with bluez-utils-3.33 we do have Simple
Pairing support, but we it will we only supported on the the 4.x D-Bus
API with the new interfaces. You can call hcid -x to switch it on and
all documentation is inside the doc/ directory.

Regards

Marcel



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
