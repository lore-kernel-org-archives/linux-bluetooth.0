Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Oct 2013 14:44:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Use hcon directly instead of conn->hcon
 where possible
Message-ID: <20131018114432.GA18182@x220.p-661hnu-f1>
References: <1382092981-48006-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382092981-48006-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 18, 2013, Marcel Holtmann wrote:
> When the HCI connection hcon is already dereferenced, then use hcon
> directly instead of conn->hcon.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 7 +++----
>  net/bluetooth/smp.c        | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
