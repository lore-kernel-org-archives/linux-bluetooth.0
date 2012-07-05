Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Jul 2012 20:08:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: Override status if local user rejects
 pairing
Message-ID: <20120705170829.GA6606@x220.P-661HNU-F1>
References: <1341502277-13724-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341502277-13724-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Jul 05, 2012, Jaganath Kanakkassery wrote:
> In case if pairing is failed, user cannot differentiate from the status
> whether failure is caused by local rejection or remote rejection
> because authentication failure is coming in both the cases.
> 
> This patch overrides the status from controller with "Rejected"
> in case of local rejection.
> 
> This patch will be useful if user can take some action based on local
> or remote rejection
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> ---
>  include/net/bluetooth/hci_core.h |    4 +-
>  net/bluetooth/hci_event.c        |    4 +-
>  net/bluetooth/mgmt.c             |  173 +++++++++++++++++++-------------------
>  net/bluetooth/smp.c              |    2 +-
>  4 files changed, 94 insertions(+), 89 deletions(-)

Could you please split this to two separate patches:

1. Refactor PIN code rejection to use user_pairing_resp
2. Add the local rejection tracking

Johan
