Return-Path: <johan.hedberg@gmail.com>
Date: Fri, 9 Sep 2016 08:09:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Increase the subsystem minor version number
Message-ID: <20160909050924.GA15433@t440s>
References: <1473350827-64104-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473350827-64104-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Sep 08, 2016, Marcel Holtmann wrote:
> While the subsystem version information are purely informational,
> increase the minor number due to the addition of user channel and
> management control monitoring suppport. It is helpful for debugging
> purposes to see the version numbers change.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/bluetooth.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
