Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem with BlueLogic WingKey Keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <42406D46.10804@rz-zw.fh-kl.de>
References: <200503202301.49376.tv@rz-zw.fh-kl.de>
	 <1111408373.22872.54.camel@pegasus> <423F5B7F.9060200@rz-zw.fh-kl.de>
	 <423F5E1C.8030301@rz-zw.fh-kl.de> <1111453185.22872.84.camel@pegasus>
	 <42406D46.10804@rz-zw.fh-kl.de>
Content-Type: text/plain
Message-Id: <1111530389.22872.132.camel@pegasus>
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
Date: Tue, 22 Mar 2005 23:26:29 +0100

Hi Timo,

> I applied your patch and it works now. Thanks a lot! :)
> 
> Will your patch be integrated into the offical kernel and if yes when?

what you applied with that patch is a proof of concept for the report
protocol mode. The current mainline kernel only supports the boot mode
and this should also work in most cases. I don't know why it does not
work for your keyboard and until someone donates such keyboard to me, we
will may never know.

The work for the generic HID parser is on going and when this is merged
back into mainline then Bluetooth will get full HID report mode protocol
support.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
