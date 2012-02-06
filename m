Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Feb 2012 17:27:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH trivial 0/3] Trivial patches set
Message-ID: <20120206152710.GA13323@x220>
References: <1328533441-29539-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328533441-29539-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Feb 06, 2012, Emeltchenko Andrei wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Those trivial patches are acked already and might be applied separetely
> from the main "locking" patch set.
> 
> Andrei Emeltchenko (3):
>   Bluetooth: Change chan_ready param from sk to chan
>   Bluetooth: Clean up l2cap_chan_add
>   Bluetooth: Remove unneeded sk variable
> 
>  net/bluetooth/l2cap_core.c |   32 +++++++++++++++++---------------
>  1 files changed, 17 insertions(+), 15 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
