Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <455B1164.5050607@kernelconcepts.de>
References: <4410090A.3070706@kernelconcepts.de>
	<1141912311.4605.9.camel@aeonflux.holtmann.net>
	<44104DD5.80109@kernelconcepts.de>
	<1141923373.4605.39.camel@aeonflux.holtmann.net>
	<loom.20060412T215427-611@post.gmane.org>
	<444CAE4F.70404@kernelconcepts.de>
	<1145876694.21987.28.camel@localhost>
	<4451F478.3070204@kernelconcepts.de>
	<455B1164.5050607@kernelconcepts.de>
Date: Wed, 15 Nov 2006 14:47:13 +0100
Message-Id: <1163598433.4678.0.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] New HCI-USB device, no MAC?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Nils,

> The issue was that some Bluetooth dongles do not contain a valid
> Bluetooth MAC address. Well, this is against the spec and so the dongles
> are bad but sometimes users cannot avoid to get such. So I still see the
> need that we do as good as we can to help those users and get those bad
> dongles working.
> 
> Long story short, Marcel's bdaddr application contained in the latest
> release of bluez-utils works, at least for the two dongles I have with
> ISS chipsets. So the BDADDR can be set now.
> 
> I wanted an automatic solution so that when I plug the dongle in it is
> automatically assigned "an" address. So first I created an udev rule
> that calls an application when the specific USB device with the
> vendorid:deviceid I know to be bad is inserted - in my case 1131:1001
> (plaease let me know more!).
> 
> Then I created a small shell script which sets a "more correct" address
> than the default 11:11:11:11:11:11. I assume in this script that an
> ethernet device is present in the system as eth0 and use its MAC for the
> Bluetooth dongle too.
> 
> I did this for two reasons:
> 1. On the same machine I always want to have the same BDADDR, so random
> was no choice.
> 2. The ethernet addresses also have to follow the same rules as
> Bluetooth MAC addresses, i.e. they have to be unique. So the probability
> of a collision is very low.

and now PAN will stop working, because the eth0 and bnep0 will have the
same MAC address. Not a good idea.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
