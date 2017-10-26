Return-Path: <ronald@innovation.ch>
Date: Thu, 26 Oct 2017 02:47:49 -0700
From: "Life is hard, and then you die" <ronald@innovation.ch>
To: Lukas Wunner <lukas@wunner.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Dean Jenkins <Dean_Jenkins@mentor.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: hci_ldisc: Allow sleeping while proto
 locks are held.
Message-ID: <20171026094749.GA15996@innovation.ch>
References: <20171026051453.GA15910@innovation.ch>
 <20171026065828.GB6487@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171026065828.GB6487@wunner.de>
List-ID: <linux-bluetooth.vger.kernel.org>


On Thu, Oct 26, 2017 at 08:58:28AM +0200, Lukas Wunner wrote:
> On Wed, Oct 25, 2017 at 10:14:53PM -0700, =?UTF-8?q?Ronald=20Tschal=C3=A4r?= wrote:
> > Commit dec2c92880cc5435381d50e3045ef018a762a917 ("Bluetooth: hci_ldisc:
> > Use rwlocking to avoid closing proto races") introduced locks in
> > hci_ldisc that are held while calling the proto functions. These locks
> > are rwlock's, and hence do not allow sleeping while they are held.
> > However, the proto functions that hci_bcm registers use mutexes and
> > hence need to be able to sleep.
> [...]
> > We can't replace the mutex in hci_bcm, because there are other calls
> > there that might sleep. Therefore this replaces the rwlock's in
> > hci_ldisc with rw_semaphore's (which allow sleeping). This is a safer
> > approach anyway as it reduces the restrictions on the proto callbacks.
> > Also, because acquiring write-lock is very rare compared to acquiring
> > the read-lock, the percpu variant of rw_semaphore is used.
> 
> The percpu_rw_semaphore is unusual (if fine I guess), it's only used
> by cgroups, uprobes and ext4 so far and I was unaware of its existence.

I mainly took my cue from the documentation, which indicated this was
better in scenarios where writes are rare. But if there are concerns
about it's use, or there is some use-case where tty's are opened and
close a lot without doing much in between, then it can be trivially
replaced with the non-percpu variant.

> I don't have the hardware to test this but the rationale and patch itself
> LGTM, so:
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks!


  Cheers,

  Ronald
