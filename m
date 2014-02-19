Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Feb 2014 06:10:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix wrong identity address during connection
 failures
Message-ID: <20140219041041.GB13827@x220.p-661hnu-f1>
References: <1392765223-21880-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392765223-21880-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 18, 2014, Marcel Holtmann wrote:
> When the connection attempt fails, the address information are not
> provided in the HCI_LE_Connection_Complete event. So use the original
> information from the connection to reconstruct the identity address.
> 
> This is important when a connection attempt has been made using the
> identity address, but the cached resolvable random address has changed
> in the meantime. The failure event needs to use the identity address
> and not the resolvable random address.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_conn.c  | 13 +++++++++++++
>  net/bluetooth/hci_event.c | 12 ++++++++++--
>  2 files changed, 23 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
