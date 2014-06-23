Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jun 2014 13:05:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Store current LE connection parameters in
 hci_conn struct
Message-ID: <20140623100529.GA12150@t440s>
References: <1403516405-2184-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403516405-2184-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jun 23, 2014, Marcel Holtmann wrote:
> The LE connection parameters are needed later on to be able to decide
> if it is required to trigger connection update procedures. So when the
> connection has been established successfully, store the current used
> parameters in hci_conn struct.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 3 +++
>  net/bluetooth/hci_event.c        | 4 ++++
>  2 files changed, 7 insertions(+)

Both patches have been applied to bluetooth-next. Thanks.

Johan
