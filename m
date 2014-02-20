Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Feb 2014 08:32:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add comment explainging store hint for long
 term keys
Message-ID: <20140220063204.GB3739@x220.p-661hnu-f1>
References: <1392858718-40052-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392858718-40052-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 19, 2014, Marcel Holtmann wrote:
> The code itself is not descriptive on what store hint is used for
> long term keys and why. So add some extensive comment here. Similar
> to what has already been done for identity resolving key store hint.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
