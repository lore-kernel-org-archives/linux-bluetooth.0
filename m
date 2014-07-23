Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Jul 2014 20:35:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Get MWS transport configuration of the
 controller
Message-ID: <20140723173537.GA31752@t440s.P-661HNU-F1>
References: <1406136297-31644-2-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406136297-31644-2-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 23, 2014, Marcel Holtmann wrote:
> If the Bluetooth controller supports Get MWS Transport Layer
> Configuration command, then issue it during initialization.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 2 ++
>  net/bluetooth/hci_core.c    | 4 ++++
>  2 files changed, 6 insertions(+)

Both patches have been applied to bluetooth-next. (I fixed the commit
message of the first one with a push --force).

Johan
