Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Dongle firmware
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050104110418.M39860@bandos.homelinux.com>
References: <20050104110418.M39860@bandos.homelinux.com>
Content-Type: text/plain
Message-Id: <1104841297.8894.92.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 04 Jan 2005 13:21:37 +0100

Hi Jose,

> I've seen recently a few messages about new firmwares, is there a list of
> dongles and firmwares available?
> I have a Acer BT-500 and a MSI MS-6967, and I'd like to update these two.

you should actually ask the vendor of these dongles for updates. However
the ACER is a BlueCore01b and can't be updated with the GenericCSR.dfu
firmware file and for the MSI I don't know. The general rule at the
moment is if "hciconfig hci0 revision" don't show BlueCore02 and lsusb
don't show it as a "Cambridge Silicion Radio". You shouldn't even try to
update it.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
