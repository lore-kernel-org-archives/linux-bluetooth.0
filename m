Return-Path: <cyrus@holtmann.org>
Date: Sat, 12 Oct 2013 09:47:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add MGMT_OP_SET_SCAN_PARAMS to supported
 commands list
Message-ID: <20131012064711.GA30228@x220.p-661hnu-f1>
References: <1381527898-10784-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381527898-10784-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 11, 2013, Marcel Holtmann wrote:
> When adding support for MGMT_OP_SET_SCAN_PARAMS command the addition
> to the supported commands list has been forgotten. This is needed
> for userspace to detect if the command is supported or not.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to bluetooth-next. Thanke.

Johan
