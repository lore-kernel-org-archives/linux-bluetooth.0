Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Kernel panic when unplugging USB dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Arthur Dent <tobili@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY18-F35upP0Xthjx700009162@hotmail.com>
References: <BAY18-F35upP0Xthjx700009162@hotmail.com>
Content-Type: text/plain
Message-Id: <1083686269.4666.33.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 04 May 2004 17:57:49 +0200

Hi Arthur,

> I have been using the Bluez architecture for quite some
> time now in combination with a bluetooth modem and
> everything has been working nicely. Now I decided to
> update my system: I have downloaded the 2.4.26 kernel
> from kernel.org, patched the kernel (2.4.26-mh1) and
> additionally installed: bluez-libs-2.6, bluez-utils-2.6
> and bluez-pan-1.1
> When I plugged in the USB dongle everything worked nicely
> and "hcitool dev" reports the address so bluetooth should be
> working. However, when I unplug the dongle the kernel freezes
> instantly and I am also not able to obtain any hint from
> /var/log/messages and stuff.
> 
> When I additionally install the outdated bluez-kernel-2.3
> package the kernel does not freeze...
> What did I do wrong, can anybody give me a hint? This is
> beyond my capabilities.
> I am using SuSE 9.0 on a Toshiba Satellite.

with the 2.4.26 this is a bad behaviour and I've never seen this problem
before. Please check if it matters if CONFIG_BLUEZ_HCIUSB_SCO is enabled
or not.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
