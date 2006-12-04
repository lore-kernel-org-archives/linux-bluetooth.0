Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 4 Dec 2006 16:55:12 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200612041031.06996.akohlsmith-bluez@benshaw.com>
Message-ID: <Pine.LNX.4.63.0612041647550.20046@redbean.intranet.gw-instruments.de>
References: <200612011448.32667.akohlsmith-bluez@benshaw.com>
	<200612040855.29496.akohlsmith-bluez@benshaw.com>
	<1165241266.12640.30.camel@localhost>
	<200612041031.06996.akohlsmith-bluez@benshaw.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] "promiscuous mode" for hci devices?
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


Hi Andrew, 

> That's what I was getting at; the device *does* see all communications, but 
> unless there is a method to flip on the equivalent of ethernet's promiscuous 
> mode, you'll never see anything not intended for you.  Your message suggests 
> that there is no HCI call to do this, which puts me out of luck.
> 
> Have you seen or heard of anyone using two BT devices in a Linux box to 
> achieve a "man-in-the-middle" type of monitoring system?

What you're looking for is a Bluetooth Sniffer. Such devices are 
commercial available and you special low level firmware (never disclosed). 

However, your assumption is wrong that the device sees all traffic and 
simply throw away everthing it is not interested in. 

To sniff a Bluetooth connection you need the hopping sequence of the 
master. Unless you don't have this it is impossible to know which channel 
is used by any two devices to communicate in a given time slot. Not to 
mention encryption.... 

So even with a bluetooth sniffer you first need to synchronize to the 
master of a bluetooth connection before you can extract anything useful. 
Normaly this is done by connecting from the master to the sniffer as a 
slave. 

Ciao, 

Peter  


|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
