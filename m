Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Shell script during bluetooth connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Lalith Chakravarthi <lalithvc@yahoo.com>
Cc: bluez-users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040311045957.47445.qmail@web40703.mail.yahoo.com>
References: <20040311045957.47445.qmail@web40703.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1079087680.738.15.camel@merlin>
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
Date: Fri, 12 Mar 2004 11:34:41 +0100

Hi Lalith,

> When is the script /etc/hotplug/net.agent called? Is it when the USB
> Dongle is plugged in??? Or is it when another USB device comes within
> the range (I cant think of a way that this can happen without a
> connexion)... or is it when a bluetooth connection is established??

the net.agent is called when the new bnep0 (or any other network
interface) is created or released.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
