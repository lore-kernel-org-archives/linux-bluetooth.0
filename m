Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Sep 2013 16:47:45 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Disable upper layer connections when user
 channel is active
Message-ID: <20130910154745.GC1916@joana>
References: <1378256918-50836-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378256918-50836-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2013-09-03 Marcel Holtmann <marcel@holtmann.org>:

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

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
