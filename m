Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Report of working dongle: IOGear GBU311 and,
	question
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <42250989.1040908@cloutier-vilhuber.net>
References: <20050301154820.930E6C5364@sc8-sf-spam1.sourceforge.net>
	 <42250989.1040908@cloutier-vilhuber.net>
Content-Type: text/plain
Message-Id: <1109775358.8284.22.camel@pegasus>
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
Date: Wed, 02 Mar 2005 15:55:58 +0100

Hi Lars,

> >>However, I am curious: when plugging it in, the logs show a USB *HUB*, 
> >>and registers keyboard and mouse drivers. Is this something SuSE 
> >>specific, something driver-specific? Is SuSE misconfigured? or what does 
> >>it mean when the USB dongle registers as a keyboard/mouse?
> > 
> > the registration as mouse and keyboard is fine, 
> 
> But I am still curious: what is the purpose of a keyboard-and-mouse free 
> Bluetooth dongle reporting those capabilities? Just in case there was a 
> BT keyboard and mouse around, neither of which I own?

read something about the HID Proxy thing created by CSR in the first
place.

> > but actually this device
> > should only start working with a recent 2.6.11-rc5 kernel. 
> 
> This might be another one of those SuSE-backports - my latest SuSE 
> kernel is "2.6.8-24.11-default #1 Fri Jan 14 13:01:26"

Not that I know of, but you may wanna check the latest KOTD and see if
it is still working.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
