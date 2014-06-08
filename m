Return-Path: <cyrus@holtmann.org>
Date: Sun, 8 Jun 2014 12:07:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use const for struct l2cap_ops field
Message-ID: <20140608090737.GA28683@t440s.P-661HNU-F1>
References: <1402214731-4445-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402214731-4445-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 08, 2014, Marcel Holtmann wrote:
> The struct l2cap_ops field should not allow any modifications and thus
> it is better declared as const.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h | 2 +-
>  net/bluetooth/a2mp.c          | 2 +-
>  net/bluetooth/l2cap_sock.c    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
