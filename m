Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <b5dccebe0611200031v64a8d2d0xfdd92edf29a44d0@mail.gmail.com>
References: <b5dccebe0611190350p4801a631m3cca5cc0b5c9abb3@mail.gmail.com>
	<1163940471.11790.2.camel@localhost>
	<b5dccebe0611200031v64a8d2d0xfdd92edf29a44d0@mail.gmail.com>
Date: Mon, 20 Nov 2006 09:43:24 +0100
Message-Id: <1164012204.28397.22.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] permissions to set local name
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Mikael,

> How does hcid know what mode that is "best" for my application? I want
> to make sure that it is 1 (result with rssi), is there a way I can
> tell hcid to always choose that mode then?

if inquiry with RSSI is supported by the chip, it will be activated for
any bluez-utils-3.x you use. In case you already have a chip that
supports extended inquiry from the Bluetooth 2.1 specification, it will
also enable that by default.

The events that indicate that a new device has been found are send out
over D-Bus and they are unified between all versions of the Bluetooth
specification. That is internal to hcid and you applications don't have
to worry about this stuff anymore. Same goes for the name resolving
after the inquiry process. It is all taken care of.

> Also, I would like to have as few external dependencies, so if
> possible I would prefer to not use d-bus. Is there a way to set the
> local name without d-bus and without root privileges? 

With the bluez-utils-3.x series, the D-Bus support is required. We don't
support any non D-Bus version anymore. You will see the long term
advantage of D-Bus once you start using it. Trust me. I wasn't a believe
for a long time, but nowadays, D-Bus is the way to go.

Anyway, there is a security filter inside the kernel that can be
modified to allows certain commands for non-root users. However you are
on you own with doing that.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
