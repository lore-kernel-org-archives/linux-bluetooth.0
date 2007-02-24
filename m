Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1172187093.10673.17.camel@cookie.hadess.net>
References: <1172187093.10673.17.camel@cookie.hadess.net>
Date: Sat, 24 Feb 2007 16:43:49 +0100
Message-Id: <1172331829.11537.14.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Another bluez-gnome patch
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

> Here's an updated patch for the bluez-gnome applet and properties:
> - Use HAL to determine the device class, if HAL is available

I added this part to the CVS now. However we need another GConf setting
that allows the user to control if HAL should be used or not.

The properties dialog needs a setting to control the HAL usage and show
or hide the class of device box according to it.

> - Fix translation of scanning mode changes (modes weren't translated at
> all, and the string used could only be used in English)

Fixed that and did a little rewording.

> - Don't show the notification bubble when switching the bluetooth device
> on/off, and we're only showing the icon if a device is present. The icon
> appearing/disappearing should be enough

We need to show when it goes back into connectable mode, because that
happens if you use the discoverable timeout.

> - Fix excessive markup in the properties labels

Done a little bit different, but with the same result.

> Once you've accepted this patch, my next step is to implement the
> software enable/disable for laptops in the applet (that would use HAL as
> well).

I really like to see that. We need that feature.

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
