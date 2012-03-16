Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Mar 2012 12:36:53 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix broken usage of get_unaligned_le16
Message-ID: <20120316153653.GC21335@x220>
References: <1331609468-22906-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331609468-22906-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Mar 12, 2012, Marcel Holtmann wrote:
> In case the struct is already __packed, there is no need to use unaligned
> access to the data. So just use __le16_to_cpu in these cases.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)

Applied. Thanks.

Johan
