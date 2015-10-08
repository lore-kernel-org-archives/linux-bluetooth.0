Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Oct 2015 10:05:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: bpa10x: Use h4_recv_buf helper for frame
 reassembly
Message-ID: <20151008070539.GI25309@t440s.lan>
References: <1444266413-77165-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444266413-77165-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 08, 2015, Marcel Holtmann wrote:
> The manually coded frame reassembly is actually broken. The h4_recv_buf
> helper from the UART driver is a perfect fit for frame reassembly for
> this driver. So just export that function and use it here as well.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/Kconfig  |   1 +
>  drivers/bluetooth/bpa10x.c | 136 +++++++++------------------------------------
>  drivers/bluetooth/hci_h4.c |   1 +
>  3 files changed, 29 insertions(+), 109 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
