Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Russell Neches <russell@ccs.neu.edu>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] crash on remove
Message-ID: <20040311003852.GA5348@omocha.vort.org>
References: <20040310182158.GA9279@naginata.ccs.neu.edu> <200403102346.11707.simone.gotti@email.it> <20040310234112.GA4871@omocha.vort.org> <200403110111.31218.simone.gotti@email.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200403110111.31218.simone.gotti@email.it>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 10 Mar 2004 19:38:53 -0500

On Thu, Mar 11, 2004 at 01:11:31AM +0100, Simone Gotti wrote:
> On Thursday 11 March 2004 00:41, Russell Neches wrote:
> > > Hi!, I think it's a SCO support problem .
> >
> > Those bastards! Death to SCO!
> >
> > Oh. SCO. Synchronous Connection Oriented.
> >
> > > I think that Marcel Holtmann spoked about this a lot of times on the
> > > mailinglists. You have to disable the SCO support in the hci_usb
> > > module to avoid this problem. I've read that probably it's a usb uchi
> > > isochronous problem.
> >
> > Hmm... Do you have a link?
> 
> I've found this, but there are many others.
> http://www.ussg.iu.edu/hypermail/linux/kernel/0311.0/0135.html

Are you sure it's related to SCO? Then shouldn't my laptop exhibit the
same behavior? It's interesting to note that he is also using an Abit
motherboard, though his board uses the Intel 875P chipset, not the Via
chipset (like mine). Maybe it's related to USB 2.0? 

Russell


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
