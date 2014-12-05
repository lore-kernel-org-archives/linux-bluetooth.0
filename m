Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Dec 2014 13:37:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Add helper function for clearing the
 discovery filter
Message-ID: <20141205113725.GB6745@t440s.lan>
References: <1417776323-131063-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417776323-131063-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Dec 05, 2014, Marcel Holtmann wrote:
> The discovery filter allocates memory for its UUID list. So use
> a helper function to free it and reset it to default states.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 8 ++++++++
>  net/bluetooth/hci_core.c         | 5 +----
>  2 files changed, 9 insertions(+), 4 deletions(-)

All patches in this set have been applied to bluetooth-next. Thanks.

Johan
