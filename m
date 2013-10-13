Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Oct 2013 17:59:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Update source address and type for incoming
 LE connections
Message-ID: <20131013145925.GF23382@x220.p-661hnu-f1>
References: <1381674318-6590-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381674318-6590-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 13, 2013, Marcel Holtmann wrote:
> The incoming LE connections do not have a proper source address and
> address type set. The connection needs to be set with the same values
> as used for advertising parameters.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
