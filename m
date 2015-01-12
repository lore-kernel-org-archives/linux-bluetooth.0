Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Jan 2015 11:25:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: Add BUILD_BUG_ON for size of struct
 sockaddr_hci
Message-ID: <20150112092557.GB4548@t440s.lan>
References: <1421018300-14151-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421018300-14151-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jan 11, 2015, Marcel Holtmann wrote:
> This adds an extra check for ensuring that the size of sockaddr_hci
> does not grow larger than sockaddr.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 2 ++
>  1 file changed, 2 insertions(+)

All four patches (v2 of 2/4) have been applied to bluetooth-next.
Thanks.

Johan
