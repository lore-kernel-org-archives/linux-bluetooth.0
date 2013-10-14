Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Oct 2013 14:24:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Introduce L2CAP channel flag for defer setup
Message-ID: <20131014112445.GB26222@x220.p-661hnu-f1>
References: <1381743934-29348-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381743934-29348-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 14, 2013, Marcel Holtmann wrote:
> The L2CAP core should not look into the socket flags to figure out the
> setting of defer setup. So introduce a L2CAP channel flag that mirrors
> the socket flag.
> 
> Since the defer setup option is only set in one place this becomes a
> really easy thing to do.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 15 +++++++--------
>  net/bluetooth/l2cap_sock.c    |  7 +++++--
>  3 files changed, 13 insertions(+), 10 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
