Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Oct 2013 23:57:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Expose current voice setting in debugfs
Message-ID: <20131017205728.GC17492@x220.p-661hnu-f1>
References: <1382036551-54592-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382036551-54592-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 17, 2013, Marcel Holtmann wrote:
> For easier debugging of the current voice setting, expose the value
> in debugfs if the controller is BR/EDR capable.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
