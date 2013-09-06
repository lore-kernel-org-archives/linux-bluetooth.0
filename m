Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Sep 2013 12:06:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Disable upper layer connections when user
 channel is active
Message-ID: <20130906090621.GA1608@x220.p-661hnu-f1>
References: <1378256918-50836-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378256918-50836-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Sep 03, 2013, Marcel Holtmann wrote:
> When the device has the user channel flag set, it means it is driven by
> an user application. In that case do not allow any connections from
> L2CAP or SCO sockets.
> 
> This is the same situation as when the device has the raw flag set and
> it will then return EHOSTUNREACH.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_conn.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
