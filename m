Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Shopping for new ultralight notebook with
	built-in bluetooth and good Linux support
From: Marcel Holtmann <marcel@holtmann.org>
To: David Wuertele <dave-gnus@bfnet.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <m3zn85sfea.fsf@bfnet.com>
References: <m3zn85sfea.fsf@bfnet.com>
Content-Type: text/plain
Message-Id: <1084916330.4327.10.camel@pegasus>
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
Date: Tue, 18 May 2004 23:38:50 +0200

Hi David,

> I looked in the hardware list, and found lots of Sony notebooks, but I
> could not find ANY of these models (eg SR31K SR9G SR9K SRX7 SRX7E
> SRX7P SRK41P SRX41P SRX51P SRX51P/A) on the Sony website.  Are any of
> them still made?

I don't think so, because these days the notebook manufacturers change
their models a way too often ;)

> I did not see the "Sony VAIO USB Bluetooth Adapter PCGA-BA1/A"
> mentioned on the hardware compatibility list.  Anyone using it?

It is CSR based as I know and it should also work fine, but nobody sent
me the output of "hciconfig -a" and so it is not on the list.

> Can anyone recommend a notebook on the bluez hardware compatibility
> list that is ultralight, well supported, and still being manufactured?

Acutally every Bluetooth enabled notebook should be supported, because
the Bluetooth chip is connected via USB in every case I have seen so
far. The only problem is maybe to activate these devices, because the
manufacturers like to have software switches to attach/detach their
Bluetooth hardware from the USB bus.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
