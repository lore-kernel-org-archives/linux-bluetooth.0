Return-Path: <cyrus@holtmann.org>
Date: Sun, 8 Jun 2014 12:07:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Shrink size of struct l2cap_ctrl fields
Message-ID: <20140608090751.GB28683@t440s.P-661HNU-F1>
References: <1402216017-10419-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402216017-10419-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 08, 2014, Marcel Holtmann wrote:
> The struct l2cap_ctrl fields are wasting an unsigned int when all the
> bits can fit into an __u8 field.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/bluetooth.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
