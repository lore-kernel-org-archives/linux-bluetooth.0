Return-Path: <cyrus@holtmann.org>
Date: Sat, 22 Feb 2014 09:24:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix issue with missing management event opcode
Message-ID: <20140222072416.GA10358@x220.p-661hnu-f1>
References: <1393047330-34334-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393047330-34334-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Feb 21, 2014, Marcel Holtmann wrote:
> The event opcode for New Identity Resolving Key event is missing from
> supported event list. Just add it there.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to bluetooth-next. Thanks.

Johan
