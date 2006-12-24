Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1166912168.22566.11.camel@randel.hadess.net>
References: <1166912168.22566.11.camel@randel.hadess.net>
Date: Sun, 24 Dec 2006 14:55:57 +0100
Message-Id: <1166968557.15485.14.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Removing features
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

Hi Bastien,

> I was taking a look at the properties and applet in the bluez-gnome
> tree, and thought that some things could be changed to make it more
> GNOME-ish.
> 
> I've attached an obviously unfinished patch that would remove the
> "Adapter class" combobox from the properties capplet, and have the
> applet setup the class depending on the "system.formfactor" property
> given out by HAL[1].
> 
> If this sort of thing would accepted into the tree, I have some more
> patches lined up (including finishing up this one).

actually I am a little bit against a compile time option against HAL.
This should be a runtime check if HAL is available.

The other thing is that this doesn't really belong into bluetooth-applet
and should be moved directly into hcid. However this might give some
crazy dependency chain.

I am open for suggestions here.

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
