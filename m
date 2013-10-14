Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Oct 2013 14:25:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Introduce L2CAP channel callback for resuming
Message-ID: <20131014112500.GC26222@x220.p-661hnu-f1>
References: <1381744434-35580-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381744434-35580-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 14, 2013, Marcel Holtmann wrote:
> Clearing the BT_SK_SUSPEND socket flag from the L2CAP core is causing
> a dependency on the socket. So intead of doing that, use a channel
> callback into the socket handling to resume.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h | 1 +
>  net/bluetooth/l2cap_core.c    | 6 +-----
>  net/bluetooth/l2cap_sock.c    | 9 +++++++++
>  3 files changed, 11 insertions(+), 5 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
