Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Oct 2013 10:09:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix switch statement order for L2CAP fixed
 channels
Message-ID: <20131003070958.GA26026@x220.p-661hnu-f1>
References: <1380782814-35670-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380782814-35670-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 02, 2013, Marcel Holtmann wrote:
> The switch statement for the various L2CAP fixed channel handlers
> is not really ordered.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
