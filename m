Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20070927134257.GA32196@sus.mcgill.ca>
References: <1190675554.5133.151.camel@aeonflux.holtmann.net>
	<20070924232149.GA14346@sus.mcgill.ca>
	<2759cf860709250450yc36a945m846bd529d006b289@mail.gmail.com>
	<e1effdeb0709250524n16217623p194a891fa858810c@mail.gmail.com>
	<20070925123441.GA1032@sus.mcgill.ca> <20070926113035.GC8781@suse.de>
	<20070926140507.GA5913@sus.mcgill.ca>
	<1190844390.6484.30.camel@aeonflux.holtmann.net>
	<20070926221821.GA24681@sus.mcgill.ca>
	<1190878752.6484.48.camel@aeonflux.holtmann.net>
	<20070927134257.GA32196@sus.mcgill.ca>
Date: Fri, 28 Sep 2007 01:08:01 +0200
Message-Id: <1190934481.6484.79.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] help with Logitech Travel Mouse
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Martin,

> > > Thank you very much.  I didn't realize that hidd were supposed to still
> > > work.  I will look into writing a python tool that does what I want to
> > > do.  However, I still don't quite understand why the hidd behavior has
> > > changed and/or why it is incorrect to use them more then once.  In
> > > particular, in the case where a device (keyboard/mouse) was once paired
> > > with a computer, but then has been re-paired with another computer.  If
> > > I want to reconnect the keyboard/mouse to the first computer, wouldn't I
> > > have to re-issue a hidd --connect <MAC> ?  (or the equivalent D-Bus
> > > calls?)
> > 
> > the HID devices are not designed to work like this. Period. They only
> > support one binding with a host system. You try to make it work with a
> > scenario it is not designed for. If you need details, check the
> > Bluetooth HID specification.
> > 
> 
> I understand that HID devices only support one binding at a time.  But
> if I want to use the same keyboard with two systems, not at the same
> time but back and forth, then I should be able to re-authenticate it
> with the previous system.  This is a use case that totally makes sense
> and works fine.  It used to work fine between two Linux system, two
> Windows system and a Windows and Linux system.  I just had one keyboard
> and whenever I wanted to use it with another system, I'd reset the
> keyboard and re-pair it with the system at hand.  This is definitely
> possible and I am sure that the specifications allow for pairing with a
> system that was previously paired with in case the HID device lost its
> pairing.

the point here is to re-pair and for security reasons we reject attempts
from devices where the authentication fails. So it means you have to
actually remove the previous binding first before you can re-pair. From
a security point of view there is no other way to do that. All other
cases will make your system vulnerable for attacks.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
