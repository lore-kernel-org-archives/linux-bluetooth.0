Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth 1.2 and HID Proxy
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200406052338.15162.cijoml@volny.cz>
References: <1086429803.16316.44.camel@pegasus>
	 <200406052338.15162.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1086476014.16316.129.camel@pegasus>
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
Date: Sun, 06 Jun 2004 00:53:34 +0200

Hi Michal,

> pls start new webpage on bluez which will collect all known doglech which we 
> know reflash with newer firmware and pls try describe step-by-step howto.

currently I am preparing a site with notes about firmware upgrade and
DFU. I will also summarize the public statements of the CSR signature
and so on. However don't expect a howto for getting firmware from one
device into another. I am not concerned in upgrading of any dongle,
because today an USB Bluetooth dongle is so cheap that you can buy
yourself a new one if the firmware is too old. I paid 14 EUR for my
D-Link dongle at eBay. The problem what I see is that the dongle
manufacturers are too lazy to get out the Bluetooth 1.2 capable dongles.
For the CSR based BlueCore02 based dongles they only have to change
their firmware and can sell it as a complete new product. If they
started with a 8 Mbit flash from the beginning they don't even have to
change their design.

The other point is the HID Proxy support. Actually people are asking me
where they can buy such dongles. I can't tell them, because I don't
know. And again, every BlueCore02 with 8 Mbit flash can use HID Proxy.
So where is the problem? I think Apple is doing this the right way. They
really support their hardware. The question is why D-Link can't provide
an update for the dongle ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
