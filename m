Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Oct 2013 15:14:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use helper function for re-enabling
 advertising
Message-ID: <20131006131408.GF32754@x220.p-661hnu-f1>
References: <1381057694-30810-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381057694-30810-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 06, 2013, Marcel Holtmann wrote:
> When the all LE connections have been disconneted, then it is up to
> the host to re-enable advertising at that point. To ensure that the
> correct advertising parameters are used, force the usage of the
> common helper to enable advertising.
> 
> The change just moves the manual enabling of advertising from the
> event handler into the management core so that the helper can
> be actually shared.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_event.c        | 36 +-----------------------------------
>  net/bluetooth/mgmt.c             | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 35 deletions(-)

Applied. Thanks.

Johan
