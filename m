Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20070405094324.GA9948@suse.de>
References: <20070405094324.GA9948@suse.de>
Date: Thu, 05 Apr 2007 11:45:33 +0200
Message-Id: <1175766333.5815.612.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Microsoft Bluetooth Keyboard, "missinig" keys
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

Hi Stefan,

> i got one of those:
> 
> http://www.microsoft.com/hardware/mouseandkeyboard/productdetails.aspx?pid=033
> 
> and it works pretty well with 2.6.21rc5, even most of the previously
> unhandled "silver" keys around the main keyboard and the wheel work fine.
> However, some of the silver keys do not work. They show up neither with
> showkey nor with evtest.
> 
> I can see they do transmit something with hcidump -X -V.
> 
> So the question is: what information do i need to supply (and to whom :-)
> to make all the keys work?

we might have to add another quirk to make this work. Mainly the same as
for the USB version of this one. Ask the HID maintainer, because I am
not really familiar with all these quirks.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
