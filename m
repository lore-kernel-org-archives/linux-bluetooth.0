Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Sep 2013 21:16:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Use only 2 bits for controller type
 information
Message-ID: <20130930181632.GB26405@x220.p-661hnu-f1>
References: <1380514261-21742-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380514261-21742-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 29, 2013, Marcel Holtmann wrote:
> The controller type is limited to BR/EDR/LE and AMP controllers. This
> can be easily encoded with just 2 bits and still leave enough room
> for future controller types.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
