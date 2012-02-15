Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Feb 2012 15:25:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Fix discovery state machine
Message-ID: <20120215132533.GA30023@x220.ger.corp.intel.com>
References: <1329158462-28914-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329158462-28914-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Mon, Feb 13, 2012, Andre Guedes wrote:
> In case of Start Discovery command failure, we should set the
> discovery state to DISCOVERY_STOPPED. Otherwise, we stuck at
> DISCOVERY_STARTING state and subsequent Start Discovery commands
> will simply fail.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Both patches have been applied to my bluetooth-next tree. I also fixed
the summary line of the second patch to be a bit more descriptive.
Thanks.

Johan
