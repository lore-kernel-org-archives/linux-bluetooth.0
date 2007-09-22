Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <a654bb710709210254x416bab8atcabebcadf8a6523@mail.gmail.com>
References: <a654bb710709191343o3472b21auddee76f608ff710@mail.gmail.com>
	<1190272091.5525.149.camel@aeonflux.holtmann.net>
	<a654bb710709210254x416bab8atcabebcadf8a6523@mail.gmail.com>
Date: Sat, 22 Sep 2007 09:52:36 +0200
Message-Id: <1190447556.5133.57.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] PS3 remote working?
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

Hi Lari,

> > > Has anyone gotten the playstation 3 BD remote working as a remote
> > > controller? There has been some discussion about it earlier, anyone
> > > gotten further in getting it working smoothly?
> >
> > the PS3 remote control is basically working. However we are still
> > missing a nice integration into the input service.
> 
> I've noticed this now that I got my bluetooth dongle. The remote
> connects well and registers as /dev/input/eventX but nothing comes
> out...
> 
> Are there any plans to make the input service thing work better or how
>  this is done? Would the code need only the mapping of the codes sent
> by the remote to right uinput codes?
> 
> There are some python scripts that convert the PS3 keypresses with
> uinput to /dev/input/eventX. But this is not very convenient
> solution...

as I said, it needs to be integrated into the input service. And it has
to become a fake input. Using the kernel HID parser makes no sense since
the mapping is totally off.

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
