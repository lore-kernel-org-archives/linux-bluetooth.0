Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 May 2008 17:56:24 +0300
From: Anssi Saari <anssi.saari@modeemi.fi>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20080514145623.GA7111@jolt.modeemi.cs.tut.fi>
References: <6238307d0803310503t724dedcfo9e9e587e87d41b8d@mail.gmail.com>
	<6238307d0803310509n15d73cb1wee14c9470e443d72@mail.gmail.com>
	<C5EBD7EB-6863-4B52-A4E2-15B772609FCA@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <C5EBD7EB-6863-4B52-A4E2-15B772609FCA@holtmann.org>
Subject: Re: [Bluez-users] Fwd: Socket CF Bluetooth Adapter with mpc5200
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

On Mon, Mar 31, 2008 at 06:51:58PM +0200, Marcel Holtmann wrote:
> Hi Kai,
> 
> > I want to use the CF-Bluetooth adapter from Socket in my TQM5200 board
> > with integrated CF slot. How can i activate the card in Kernel?
> 
> depends on the version of the card. Some use the dtl1_cs driver.  
> Others need to use hciattach to announce the serial port to the kernel.

Old thread, but did the dtl1_cs driver get fixed at some point? I still
have an old Socket CF card using that chipset somewhere, but the driver
wasn't very useful when I last used it back in 2005 or so. Basically I
got frequent hangs at EDGE speeds to my cell phone, with the blazing
speed of 5 kB/s or so. Ejecting and inserting the card was needed to
get it working again.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
