Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] How to configure a 723kbps connection?
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthew Reimer <mreimer@vpop.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40329F44.5070603@vpop.net>
References: <lists.bluez.users.1077037423.2665.72.camel@pegasus.SOMEWHERE>
	 <lists.bluez.users.403291AD.7080601@csr.com>  <40329F44.5070603@vpop.net>
Content-Type: text/plain
Message-Id: <1077061006.2665.141.camel@pegasus>
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
Date: Wed, 18 Feb 2004 00:36:46 +0100

Hi Matt,

> Can I change the L2CAP MTU? Is that different than the ACL MTU that can 
> be set via hciconfig? Can I get "an HCI trace" with hcidump, or is that 
> what a protocol analyzer would be needed for?

you can change L2CAP MTU, but in case of RFCOMM or BNEP the correct one
will be choosen for you.

Run "hcidump -w <file>" (as root).

> I'm using the NAP profile (sorry for not mentioning that).

The old 3870 and 3970 series only supports LAN access using PPP, but we
will see in your dump file what you are using.

Regards

marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
