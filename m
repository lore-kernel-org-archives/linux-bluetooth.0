Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Jul 2014 08:50:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Enable LE encryption events only when
 supported
Message-ID: <20140713055059.GB9869@t440s.P-661HNU-F1>
References: <1405200976-27292-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405200976-27292-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jul 12, 2014, Marcel Holtmann wrote:
> The support for LE encryption is optional. When encryption is not
> supported then also do not enable the encryption related events.
> 
> This moves the event mask setting to the third initialization
> stage to ensure that the LE features are available.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h |  1 +
>  net/bluetooth/hci_core.c    | 11 +++++++----
>  2 files changed, 8 insertions(+), 4 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
