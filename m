Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Multiple Headsets
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41E3FE69.5030903@xmission.com>
References: <41E25ECD.2000505@fcse.co.uk> <41E267C4.5030906@dark-reality.de>
	 <1105362147.8652.10.camel@pegasus> <41E2A9FC.2010405@dark-reality.de>
	 <41E39BC8.2020105@xmission.com> <1105438532.8056.12.camel@pegasus>
	 <41E3AAD8.9090303@dark-reality.de>  <41E3FE69.5030903@xmission.com>
Content-Type: text/plain
Message-Id: <1105461428.8056.46.camel@pegasus>
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
Date: Tue, 11 Jan 2005 17:37:08 +0100

Hi Brad,

> > What has to be documented is:
> > 
> > how to calculate the bitrate for the proper "alternate setting" of usb_hci?
> > 
> > We could put the table from the BT docs online
> 
> Where do I look to find this table? (The phrase "alternate setting" does 
> not seem to be the way to find it)

it is part of the HCI USB transport specification or look at the old
Bluetooth 1.1 specification under H:2.

> What if it's set too high? Will it fail to work or will it waste space 
> in the transmission?

Setting it to 0 makes the driver not to select the ISOC endpoint. When
you choose a too high value this should fail. However I haven't tested
this so far.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
