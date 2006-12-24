Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1166968557.15485.14.camel@violet>
References: <1166912168.22566.11.camel@randel.hadess.net>
	<1166968557.15485.14.camel@violet>
Date: Sun, 24 Dec 2006 14:12:16 +0000
Message-Id: <1166969536.3223.4.camel@randel.hadess.net>
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

On Sun, 2006-12-24 at 14:55 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > I was taking a look at the properties and applet in the bluez-gnome
> > tree, and thought that some things could be changed to make it more
> > GNOME-ish.
> > 
> > I've attached an obviously unfinished patch that would remove the
> > "Adapter class" combobox from the properties capplet, and have the
> > applet setup the class depending on the "system.formfactor" property
> > given out by HAL[1].
> > 
> > If this sort of thing would accepted into the tree, I have some more
> > patches lined up (including finishing up this one).
> 
> actually I am a little bit against a compile time option against HAL.
> This should be a runtime check if HAL is available.

I can certainly make it both a compile-time and run-time check. Ie. if
HAL is available at compile-time, but not at run-time, show the
combobox.

Did you want to make HAL a hard dependency, or should it be optional as
now?

I'll finish that up now.

> The other thing is that this doesn't really belong into bluetooth-applet
> and should be moved directly into hcid. However this might give some
> crazy dependency chain.

I don't think such a policy should be in hcid, but rather in the desktop
bits. (Currently, the bluetooth daemons are started a long time before
HAL is, at least in Fedora, and Matthew Garrett's HAL bits need the
bluetooth daemon running, so, yeah, crazy deps).

Cheers

-- 
Bastien Nocera <hadess@hadess.net>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
