Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Jun 2014 19:48:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Store latency and supervision timeout in
 connection params
Message-ID: <20140629164848.GA15792@t440s.P-661HNU-F1>
References: <1404053007-35603-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404053007-35603-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 29, 2014, Marcel Holtmann wrote:
> When the slave updates the connection parameters, store also the
> connection latency and supervision timeout information in the
> internal list of connection parameters for known devices.
> 
> Having these values available allowes the auto-connection
> procedure to use the correct values from the beginning without
> having to request an update on every connection establishment.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  2 ++
>  net/bluetooth/hci_conn.c         | 16 ++++++++++++++--
>  net/bluetooth/hci_core.c         |  2 ++
>  3 files changed, 18 insertions(+), 2 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
