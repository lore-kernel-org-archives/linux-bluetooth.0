Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: "P. Durante" <shackan@gmail.com>
In-Reply-To: <9307f5f20606100551p523fc123tcad46e29032c5ecc@mail.gmail.com>
References: <9307f5f20606100551p523fc123tcad46e29032c5ecc@mail.gmail.com>
Date: Sun, 11 Jun 2006 01:16:52 +0200
Message-Id: <1149981412.5358.23.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [D-Bus] api naming convention
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

> what about renaming interfaces and object paths to something more
> generic, like 'org.bluetooth' and '/org/bluetooth' ?
> since the api is supposed to be crossplatform I think it's a good idea
> to get rid of any 'bluez' references before people start writing
> programs depending on the current api.

I wanted to do that initially, but a lot of people complained that I
can't use the bluetooth.org domain name since I don't own it. In the end
it is only a name.

At some point we might move all its current features over to HAL so this
name will go away.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
