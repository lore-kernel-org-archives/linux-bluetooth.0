Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455B2942.1060506@kernelconcepts.de>
Date: Wed, 15 Nov 2006 15:50:42 +0100
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4410090A.3070706@kernelconcepts.de>	<1141912311.4605.9.camel@aeonflux.holtmann.net>	<44104DD5.80109@kernelconcepts.de>	<1141923373.4605.39.camel@aeonflux.holtmann.net>	<loom.20060412T215427-611@post.gmane.org>	<444CAE4F.70404@kernelconcepts.de>	<1145876694.21987.28.camel@localhost>	<4451F478.3070204@kernelconcepts.de>	<455B1164.5050607@kernelconcepts.de>
	<1163598433.4678.0.camel@localhost>
In-Reply-To: <1163598433.4678.0.camel@localhost>
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

Marcel Holtmann schrieb:
> Hi Nils,
Hi!

>> Then I created a small shell script which sets a "more correct" address
>> than the default 11:11:11:11:11:11. I assume in this script that an
>> ethernet device is present in the system as eth0 and use its MAC for the
>> Bluetooth dongle too.
>>
>> I did this for two reasons:
>> 1. On the same machine I always want to have the same BDADDR, so random
>> was no choice.
>> 2. The ethernet addresses also have to follow the same rules as
>> Bluetooth MAC addresses, i.e. they have to be unique. So the probability
>> of a collision is very low.
> 
> and now PAN will stop working, because the eth0 and bnep0 will have the
> same MAC address. Not a good idea.

Oh... I was not aware of this potential problem since I assumed that the
different network technologies do not share the same MAC space.
OK.

Proposals?
I could probably increment/decrement the MSB or LSB of the ethernet MAC?

> Regards
> Marcel
Cheers
  nils faerber

-- 
kernel concepts GbR      Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
--

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
