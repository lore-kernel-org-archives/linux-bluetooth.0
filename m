Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 27 Jun 2017 11:20:32 -0400
From: Tejun Heo <tj@kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: 4.12.0-rc6+: WQ_MEM_RECLAIM hci0:hci_power_off is flushing
 !WQ_MEM_RECLAIM events:btusb_work
Message-ID: <20170627152032.GA2289@htj.duckdns.org>
References: <20170625182149.GA18000@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170625182149.GA18000@light.dominikbrodowski.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

On Sun, Jun 25, 2017 at 08:21:49PM +0200, Dominik Brodowski wrote:
> On my Dell XPS 13 9343 (x86_64), the following warning was logged right
> after a resume from suspend-to-mem (not on *every* resume, though, so it
> might be hard to reproduce). The kernel is v4.12.0-rc6+ as of 94a6df251dd0,
> and I don't really use bluetooth, though the drivers are loaded:
> 
> PM: Finishing wakeup.
> OOM killer enabled.
> Restarting tasks ... done.
> Bluetooth: hci0: read Intel version: 370710018002030d00
> Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> Bluetooth: hci0: Intel Bluetooth firmware patch completed and activated
> ... <more, unrelated messages>
> workqueue: WQ_MEM_RECLAIM hci0:hci_power_off is flushing !WQ_MEM_RECLAIM events:btusb_work

So, WQ_MEM_RECLAIM has to be transitive; otherwise, it doesn't mean
anything.  I have a hard time believing that bluetooth actually needs
WQ_MEM_RECLAIM unless people mount nfs through a bluetooth tethered
phone.  Would it be possible to remove WQ_MEM_RECLAIM from these
workqueues?

Thanks.

-- 
tejun
