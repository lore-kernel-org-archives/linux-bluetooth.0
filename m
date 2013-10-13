Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Oct 2013 17:59:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Update L2CAP socket source address from HCI
 connection
Message-ID: <20131013145913.GE23382@x220.p-661hnu-f1>
References: <1381668997-1240-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381668997-1240-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 13, 2013, Marcel Holtmann wrote:
> When having LE connections, the source address is not always the
> public address of the controller. So update the socket address
> based on the actual used source address of the HCI connection.
> 
> This also remove the pointless source address pointer and adds
> a proper lock around the socket structure.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
