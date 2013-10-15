Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Oct 2013 18:48:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Simplify the code for re-arming discoverable
 timeout
Message-ID: <20131015154823.GA25463@x220.p-661hnu-f1>
References: <1381850931-34295-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381850931-34295-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 15, 2013, Marcel Holtmann wrote:
> When only the discoverable timeout gets updated, just cancel the current
> timeout, store the new timeout value. If the new timeout is valid, then
> arm the discoverable timeout again.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
