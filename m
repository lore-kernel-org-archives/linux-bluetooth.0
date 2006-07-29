Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200607291426.26109.fexpop@onlinehome.de>
References: <200607271240.49400.fexpop@onlinehome.de>
	<200607271258.45178.fexpop@onlinehome.de>
	<1153998247.9543.8.camel@localhost>
	<200607291426.26109.fexpop@onlinehome.de>
Date: Sat, 29 Jul 2006 14:42:05 +0200
Message-Id: <1154176925.25939.5.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Several problems with bluez-utils 3.1,
	kbluetoothd and a Belkin dongle in Debian
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Felix,

> > with bluez-utils-3.x we try to activate Inquiry with RSSI by default and
> > in your case it doesn't seem to work.
> 
> Thanks, for clarifying.
> 
> > What does "hciconfig hci0 features version" tell you about your dongle.
> 
> Please, take a look into the attached features-version.log.
> 
> > Please also include the output of "hcidump -X -V" while starting an
> > inquiry. With inqmode 0 and inqmode 1.
> 
> I've attached some files containing the ouptut of 'hcidump -X -V'. Those with 
> hcitool in their name have been produced while doing a 'hcitool scan', those 
> with kdebluetooth while scanning for devices with kdebluetoothd. The 
> corresponding inqmode should be obvious from the file names.

the dumps are fine. With inquiry mode 0 you see only Inquiry Result
events and with inquiry mode 1 (in your case the default that hcid will
set on adapter init) you see only Inquiry Result with RSSI events. The
Linux kernel and hcid+hcitool are capable of handling all for possible
events that are out there:

	inqmode 0: Inquiry Result
	inqmode 1: Inquiry Result with RSSI
	inqmode 1: Inquiry Result with RSSI and Page Scan
	inqmode 2: Extended Inquiry Result

The Inquiry Result with RSSI and Page Scan shows only up on a couple of
broken Silicon Wave based adapters where these guys where to stupid to
read the final Bluetooth 1.2 specification. However BlueZ works around
their mistake.

It seems that kdebluetoothd needs to updated and the best would be if
they start using the new D-Bus interface, because this takes care of all
this adapter specific things.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
