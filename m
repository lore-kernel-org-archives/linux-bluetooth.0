Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Oct 2013 20:02:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Return the correct address type for L2CAP
 sockets
Message-ID: <20131013170259.GB29427@x220.p-661hnu-f1>
References: <1381679441-57025-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381679441-57025-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 13, 2013, Marcel Holtmann wrote:
> The L2CAP sockets can use BR/EDR public, LE public and LE random
> addresses for various combinations of source and destination
> devices. So make sure that getsockname(), getpeername() and
> accept() return the correct address type.
> 
> For this the address type of the source and destination is stored
> with the L2CAP channel information. The stored address type is
> not the one specific for the HCI protocol. It is the address
> type used for the L2CAP sockets and the management interface.
> 
> The underlying HCI connections store the HCI address type. If
> needed, it gets converted to the socket address type.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h |  5 +++--
>  net/bluetooth/l2cap_core.c    | 18 ++++++++++++++++++
>  net/bluetooth/l2cap_sock.c    |  3 +++
>  3 files changed, 24 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
