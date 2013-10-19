Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 Oct 2013 16:52:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add LE features to debugfs if available
Message-ID: <20131019135200.GA25024@x220.p-661hnu-f1>
References: <1382174733-25708-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382174733-25708-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Oct 19, 2013, Marcel Holtmann wrote:
> For LE capable controllers at the special LE features page to the
> debugfs list with all the other features pages.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
