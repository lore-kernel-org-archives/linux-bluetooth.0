Return-Path: <cyrus@holtmann.org>
Date: Sun, 1 Feb 2015 09:16:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: Expose Secure Simple Pairing debug
 mode setting in debugfs
Message-ID: <20150201071630.GA13640@t440s.P-661HNU-F1>
References: <1422745672-27516-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422745672-27516-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jan 31, 2015, Marcel Holtmann wrote:
> The value of the ssp_debug_mode should be accessible via debugfs to be
> able to determine if a BR/EDR controller generates debugs keys or not.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_debugfs.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
