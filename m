Return-Path: <cyrus@holtmann.org>
Date: Sat, 12 Oct 2013 17:36:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: Limit security mode 4 level 0 to
 connection oriented channels
Message-ID: <20131012143620.GB8354@x220.p-661hnu-f1>
References: <1381587572-63593-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381587572-63593-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Oct 12, 2013, Marcel Holtmann wrote:
> The exception for certain PSM channels when it comes to security
> mode 4 level 0 should only be checked when actually a connection
> oriented channel is established.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 24 +++++++++++++++---------
>  net/bluetooth/l2cap_sock.c | 10 +++++++---
>  2 files changed, 22 insertions(+), 12 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
