Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Jan 2015 22:08:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Introduce hci_dev_do_reset helper function
Message-ID: <20150128200810.GA2864@t440s.P-661HNU-F1>
References: <1422474785-17178-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422474785-17178-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 28, 2015, Marcel Holtmann wrote:
> Split the hci_dev_reset ioctl handling into using hci_dev_do_reset
> helper function. Similar to what has been done with hci_dev_do_open
> and hci_dev_do_close.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 57 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 34 insertions(+), 23 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
