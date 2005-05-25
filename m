Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] link_key pairing problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200505251447.42486.RJenster@web.de>
References: <200505211500.37962.ruben@hotheads.de>
	 <1116842913.30044.36.camel@pegasus>  <200505251447.42486.RJenster@web.de>
Content-Type: text/plain
Message-Id: <1117027586.30044.209.camel@pegasus>
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
Date: Wed, 25 May 2005 15:26:26 +0200

Hi Ruben,

> > use bluez-utils-2.17 and use a clean start. Don't modify hcid.conf and
> > remove the link_key file (new place and file format since 2.16). Run
> > "hcidump -X -V" to show what happens.
> >
> > Maybe your headset is broken.
> 
> I think that the headset is not broken rather than the dongle. 
> I tried to pair the headset multiple times with my new thinkpad that has a 
> builtin bluetooth device an it works without any problems. 
> After that I also tried it with the bluetooth dongle on the thinkpad and it 
> doesn't work. As they are both using the same module 'hci_usb'
> I assume that it must be the dongle that is causing problems.
> 
> Maybe this dongle does not work like other dongles and is not fully or proper 
> implemented in hci_usb driver. 
> The dongle is a "Allnet ALL1575" Poor product infos are available on 
> http://www.allnet.de/product_info_allnet.php?cPath=_&products_id=22844
> I'v attech the output of lsusb -vvv maybe that helps to track down the 
> problem.

what does "hciconfig -a" and "hcitool info" say?

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
