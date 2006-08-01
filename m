Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 1 Aug 2006 15:39:29 +0200
From: Andreas Gaufer <Andreas.Gaufer@bluecellnetworks.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060801153929.27b21990@localhost.localdomain>
In-Reply-To: <1154369980.4982.14.camel@aeonflux.holtmann.net>
References: <E65CD2CAB74C80498703D6EF7624BB4C023974A7@zmaex.zma.zoran.com>
	<1154051769.7650.20.camel@localhost>
	<20060728123724.47e76a7f@localhost.localdomain>
	<20060728133933.034e4e13@localhost.localdomain>
	<20060731182135.488b017c@localhost.localdomain>
	<1154369980.4982.14.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Hci Reset Problem - Caused by USB Hub
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Mon, 31 Jul 2006 20:19:40 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Andreas,
Hi Marcel,

> 
> > further tests proofed that the problem described here are caused by
> > the USB-hub used. It seems to be unable to handle the load and just
> > breaks down. The same operations are working on other (higher quality) hubs.
> > 
> > Watch out for lines like
> > 
> >     usb 1-1: USB disconnect, address 29
> > 
> > in syslog and/or dmesg to check if your problem is similar. Make sure
> > not to mess with real physical disconnects which produce the same log
> > output.
> 
> does this also happens if you load the hci_usb driver with "isoc=0" to
> disable all ISOC transfers.
> 

Confuses me a bit... my kernel (2.6.8.1) says:  kernel: hci_usb: Unknown parameter `isoc'
my modinfo -p hci_usb says: "nothing".

> > I guess the HCI_RESET is issued by bluez after the device comes back on.
> 
> This could be the case.
> 
> Regards
> 
> Marcel
> 
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
