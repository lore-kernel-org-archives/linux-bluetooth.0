Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 15:35:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5] Bluetooth: Override status if local user rejects
 pairing
Message-ID: <20120724133520.GA19450@x220.ice.intel.com>
References: <1342449675-2842-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342449675-2842-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Mon, Jul 16, 2012, Jaganath Kanakkassery wrote:
> In case if pairing is failed, user cannot differentiate from the status
> whether failure is caused by local rejection or remote rejection
> because authentication failure is coming in both the cases.
> 
> This patch overrides the status from controller with "Cancelled"
> in case of local rejection.
> 
> This patch will be useful if user can take some action based on local
> or remote rejection
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> ---
> v5 -> 	Used STATUS_CANCELLED instead of STATUS_REJECTED
> 	Added a new flag in hci conn for auth cancel instead of
> 	a new member in struct	
> 	
>  include/net/bluetooth/hci_core.h |    3 ++-
>  net/bluetooth/hci_event.c        |   19 +++++++++++++++----
>  net/bluetooth/mgmt.c             |   18 ++++++++++++++++--
>  net/bluetooth/smp.c              |    3 ++-
>  4 files changed, 35 insertions(+), 8 deletions(-)

Technically the patch looks quite good now. Thanks for implementing the
fix proposals. I had a chat with Marcel and we'd like to have a more
detailed explanation of the exact use case where you need this (i.e.
describe what your agents, etc. are doing and why they can't do what you
want with the current behavior). Also a hcidump showing the local and
remote rejection error codes would be good.

Johan
