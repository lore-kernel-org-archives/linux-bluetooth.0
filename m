Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46DEE2D5.3080804@free.fr>
References: <f58d13790709050943x4d8a7491qfc5131b76934cce6@mail.gmail.com>
	<46DEE2D5.3080804@free.fr>
Date: Mon, 10 Sep 2007 21:15:58 +0200
Message-Id: <1189451758.687.70.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [bluetooth-alsa] SCO-FLOWCONTROL patch in
	the	newest kernels
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Fabien,

> > I've applied the 
> > http://bluetooth-alsa.cvs.sourceforge.net/bluetooth-alsa/plugz/patches/sco-flowcontrol-v4.2.diff 
> > <http://bluetooth-alsa.cvs.sourceforge.net/bluetooth-alsa/plugz/patches/sco-flowcontrol-v4.2.diff> 
> > patch on my 2.6.22 kernel to let the SCO protocol works with my 
> > bluetooth headset and it works well.
> > 
> > Anyway I had some problem during the patching as the kernel wasn't the 
> > correct one.
> > 
> Indeed they should be updated to apply cleanly on latest 2.6.22 kernel.
> If you can provide an updated version of the patch i would happily push 
> it in CVS.

the new audio service support for mono headset doesn't really need this
patch. Eventually we have to have it, but right now the Bluetooth Core
inside the kernel is in a major re-write to remove all the old cruft and
keeping this patch in sync is totally impossible. Once I have the eSCO
support merged upstream then we can talk about it again.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
