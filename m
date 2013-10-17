Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Oct 2013 23:57:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Expose static address value for LE capable
 controllers
Message-ID: <20131017205710.GB17492@x220.p-661hnu-f1>
References: <1382035509-43957-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382035509-43957-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 17, 2013, Marcel Holtmann wrote:
> For LE capable controllers, the static address can be configured. For
> debugging purposes expose the value in debugfs.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
