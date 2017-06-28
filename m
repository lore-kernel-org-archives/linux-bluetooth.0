Return-Path: <linux@dominikbrodowski.net>
Date: Wed, 28 Jun 2017 12:03:57 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Tejun Heo <tj@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: 4.12.0-rc6+: WQ_MEM_RECLAIM hci0:hci_power_off is flushing
 !WQ_MEM_RECLAIM events:btusb_work
Message-ID: <20170628100357.GA5675@light.dominikbrodowski.net>
References: <20170625182149.GA18000@light.dominikbrodowski.net>
 <20170627152032.GA2289@htj.duckdns.org>
 <83EA7A09-DDFB-4CEB-8F45-52BFDCE3C6DF@holtmann.org>
 <20170627173946.GE2289@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170627173946.GE2289@htj.duckdns.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hej Tejun and Marcel,

On Tue, Jun 27, 2017 at 01:39:46PM -0400, Tejun Heo wrote:
> Hello, Marcel.
> 
> On Tue, Jun 27, 2017 at 07:28:40PM +0200, Marcel Holtmann wrote:
> > >> On my Dell XPS 13 9343 (x86_64), the following warning was logged right
> > >> after a resume from suspend-to-mem (not on *every* resume, though, so it
> > >> might be hard to reproduce). The kernel is v4.12.0-rc6+ as of 94a6df251dd0,
> > >> and I don't really use bluetooth, though the drivers are loaded:
> > >> 
> > >> PM: Finishing wakeup.
> > >> OOM killer enabled.
> > >> Restarting tasks ... done.
> > >> Bluetooth: hci0: read Intel version: 370710018002030d00
> > >> Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> > >> Bluetooth: hci0: Intel Bluetooth firmware patch completed and activated
> > >> ... <more, unrelated messages>
> > >> workqueue: WQ_MEM_RECLAIM hci0:hci_power_off is flushing !WQ_MEM_RECLAIM events:btusb_work
> > > 
> > > So, WQ_MEM_RECLAIM has to be transitive; otherwise, it doesn't mean
> > > anything.  I have a hard time believing that bluetooth actually needs
> > > WQ_MEM_RECLAIM unless people mount nfs through a bluetooth tethered
> > > phone.  Would it be possible to remove WQ_MEM_RECLAIM from these
> > > workqueues?
> > 
> > frankly I do not remember. We used what was recommended to use. I
> > know that the only requirement in one case is that it is a truly
> > single workqueue.
> 
> Heh, I don't remember either.  I wonder whether there is an existing
> dependency chain from network side which triggers the warning.
> Dominik, can you please see whether the following patch makes the
> warning go away while not triggering new ones?

Alas, the warning was not reproducible beforehand -- with the patch applied,
no warning was emitted during a few suspend-and-resume cycles. Whether
bluetooth still works as expected, I cannot tell, as I do not use it.

Thanks,

	Dominik
