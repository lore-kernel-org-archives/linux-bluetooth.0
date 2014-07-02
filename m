Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Jul 2014 16:41:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Default to internal use manufacturer
 identifier
Message-ID: <20140702134128.GB15249@t440s.P-661HNU-F1>
References: <1404293451-14505-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404293451-14505-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 02, 2014, Marcel Holtmann wrote:
> When allocating a new controller structure, then default to the internal
> use value 0xffff first. Default to 0x0000 is a bad idea since that is
> the manufacturer identifier of Ericsson Technology Licensing.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to bluetooth-next. Thanks.

Johan
