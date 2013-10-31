Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Oct 2013 15:56:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Remove debug statement for features
 complete event
Message-ID: <20131031135624.GA26127@x220.p-661hnu-f1>
References: <1383220473-33584-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383220473-33584-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 31, 2013, Marcel Holtmann wrote:
> The complete list of local features are available through debugfs and
> so there is no need to add a debug print here.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c | 6 ------
>  1 file changed, 6 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
