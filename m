Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Oct 2013 20:02:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Store address information in L2CAP channel
 structure
Message-ID: <20131013170245.GA29427@x220.p-661hnu-f1>
References: <1381677167-41315-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381677167-41315-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 13, 2013, Marcel Holtmann wrote:
> With the effort of abstracting the L2CAP socket from the underlying
> L2CAP channel it is important to store the source and destination
> address information directly in the L2CAP channel structure.
> 
> Direct access to the HCI connection address information is not
> possible since they might not be avaiable at L2CAP channel
> creation time. The address information will be updated when
> the underlying BR/EDR or LE connection status changes.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h |  2 ++
>  net/bluetooth/l2cap_core.c    | 61 +++++++++++++++++--------------------------
>  net/bluetooth/l2cap_sock.c    |  6 ++---
>  3 files changed, 29 insertions(+), 40 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
