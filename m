Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bt3c_cs time out - no firmware loaded?
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Krisztian Mark Szentes <office@produktivit.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200305081542.17759.office@produktivit.com>
References: 
	<53B03DA73719D5119E6A0008C71E1D78030EA9A3@svr-mail1.corp.home.nl>
	<200305081542.17759.office@produktivit.com>
Content-Type: text/plain
Message-Id: <1052785027.1133.174.camel@pegasus.local>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 13 May 2003 02:17:01 +0200

Hi Krisztian,

> I have trouble with the 3COM Cardbus bluetooth card on a Powerbook Titanium (a 
> powerpc notebook). I patched the 2.4.20 kernel with the mh-6 patch (and the 
> benh patch which does not collide). I haven't found any hint on the list yet.
> 
> With a USB bluetooth adapter (hci_usb) everything works fine. I have a 
> wonderful RFCOMM communication to a Nokia 6310 and I can get on the internet 
> via GPRS.

is this a SMP enabled kernel? The driver have some problems if you run a
SMP kernel. Try to disable it.

Regards

Marcel




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
