Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Jul 2014 13:57:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Move HCI request internals to
 net/bluetooth/hci_core.c
Message-ID: <20140711105746.GD14378@t440s.P-661HNU-F1>
References: <1405050718-51197-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405050718-51197-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 11, 2014, Marcel Holtmann wrote:
> The internals of the HCI request framework should not be leaking to
> its users. Move them all into net/bluetooth/hci_core.c and provide
> a simple hci_req_pending helper function for the one user outside
> the framework.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  9 +--------
>  net/bluetooth/hci_core.c         | 14 ++++++++++++++
>  net/bluetooth/hci_event.c        |  2 +-
>  3 files changed, 16 insertions(+), 9 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
