Return-Path: <cyrus@holtmann.org>
Date: Sun, 1 Feb 2015 11:53:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix OOB data present for BR/EDR Secure
 Connections Only mode
Message-ID: <20150201095329.GA23132@t440s.P-661HNU-F1>
References: <1422739227-15093-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422739227-15093-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jan 31, 2015, Marcel Holtmann wrote:
> When using Secure Connections Only mode, then only P-256 OOB data is
> valid and should be provided. In case userspace provides P-192 and P-256
> OOB data, then the P-192 values will be set to zero. However the present
> value of the IO capability exchange still mentioned that both values
> would be available. Fix this by telling the controller clearly that only
> the P-256 OOB data is present.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
