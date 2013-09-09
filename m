Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Sep 2013 11:23:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Only schedule raw queue when user channel
 is active
Message-ID: <20130909082339.GA29399@x220.p-661hnu-f1>
References: <1378256918-50836-2-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378256918-50836-2-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Sep 03, 2013, Marcel Holtmann wrote:
> When the user channel is set and an user application has full control
> over the device, do not bother trying to schedule any queues except
> the raw queue.
> 
> This is an optimization since with user channel, only the raw queue
> is in use.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
