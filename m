Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1172485729.4742.1.camel@bnocera.surrey.redhat.com>
References: <1172187093.10673.17.camel@cookie.hadess.net>
	<1172331829.11537.14.camel@violet>
	<1172337118.31852.10.camel@cookie.hadess.net>
	<1172337927.11537.19.camel@violet>
	<1172451821.31852.28.camel@cookie.hadess.net>
	<1172481882.27370.4.camel@violet>
	<1172485729.4742.1.camel@bnocera.surrey.redhat.com>
Date: Mon, 26 Feb 2007 11:32:35 +0100
Message-Id: <1172485955.27370.14.camel@violet>
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

> > > > > > > Here's an updated patch for the bluez-gnome applet and properties:
> > > > > > > - Use HAL to determine the device class, if HAL is available
> > > > > > 
> > > > > > I added this part to the CVS now. However we need another GConf setting
> > > > > > that allows the user to control if HAL should be used or not.
> > > > > > 
> > > > > > The properties dialog needs a setting to control the HAL usage and show
> > > > > > or hide the class of device box according to it.
> > > > > 
> > > > > That sounds like over-engineering to me. What is the use case of the
> > > > > applet? If it's only going to be used on desktops, what's the matter
> > > > > with leaving the HAL support on? If the applet is to be used in embedded
> > > > > systems, surely those systems would make mofidications to the applet to
> > > > > fit their usage, and could turn off HAL support.
> > > > 
> > > > it is not over-engineered for people that don't have the HAL formfactor
> > > > setting to be used as base for the Bluetooth class of device. It also
> > > > makes the properties application simpler since it doesn't have to check
> > > > for HAL at all. It simply only sets a GConf value and applet acts
> > > > depending on this value.
> > > 
> > > I still don't understand why you would want to give the user the choice
> > > of using HAL or not. If it's there, use it! The information is always
> > > available (it's given out by the BIOS/firmware), and if it's not
> > > accurate, it can be overridden using an .fdi file.
> > > 
> > > What does the user gain from being able to enable/disable HAL support
> > > themselves?
> > 
> > for example if they wanna modify the class of device with a specific
> > value (as access point or something else) and still log into the system.
> > It is a special case, but there are still some systems that use the
> > class of device value for filtering the inquiry list. In general this
> > value is only good for choosing the correct icon in the UI. By default
> > however HAL will be used.
> 
> OK. Do you mind me changing the "use HAL" checkbox with something like:
> Class of device
> [ ]  automatic
> [X] [drop-down menu]
> 
> Then?

actually use, because the HAL usage is a user wide setting while the
class of device is per adapter. Remember that Linux supports for than
one adapter. When HAL usage is on, I need to make the class of device
setting disappear, but I haven't had time for that so far.

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
