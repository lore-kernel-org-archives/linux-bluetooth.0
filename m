Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Oct 2015 10:01:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix interaction of HCI_QUIRK_RESET_ON_CLOSE
 and HCI_AUTO_OFF
Message-ID: <20151008070122.GF25309@t440s.lan>
References: <1444262035-69957-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444262035-69957-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 08, 2015, Marcel Holtmann wrote:
> When the controller requires the HCI Reset command to be send when
> closing the transport, the HCI_AUTO_OFF needs to be accounted for. The
> current code tries to actually do that, but the flag gets cleared to
> early. So store its value and use it that stored value instead of
> checking for a flag that is always cleared.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
