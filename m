Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Nov 2014 10:28:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Consolidate whitelist debugfs entry into
 device_list
Message-ID: <20141103082823.GB32217@t440s.lan>
References: <1414961212-33611-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414961212-33611-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Nov 02, 2014, Marcel Holtmann wrote:
> The debufs entry for the BR/EDR whitelist is confusing since there is
> a controller debugfs entry with the name white_list and both are two
> different things.
> 
> With the BR/EDR whitelist, the actual interface in use is the device
> list and thus just include all values from the internal BR/EDR whitelist
> in the device_list debugfs entry.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 36 ++++++------------------------------
>  1 file changed, 6 insertions(+), 30 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
