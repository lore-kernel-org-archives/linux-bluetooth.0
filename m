Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Dec 2012 20:26:03 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Rami Rosen <ramirose@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	johan.hedberg@gmail.com
Subject: Re: [PATCH ] Bluetooth: Remove unnecessary include l2cap.h.
Message-ID: <20121211222603.GD7912@joana>
References: <1354943305-7069-1-git-send-email-ramirose@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354943305-7069-1-git-send-email-ramirose@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rami,

* Rami Rosen <ramirose@gmail.com> [2012-12-08 07:08:25 +0200]:

> This patch removes unnecessary include of <net/bluetooth/l2cap.h>
> in bluetooth/bnep/core.c.
> 
> Signed-off-by: Rami Rosen <ramirose@gmail.com>
> ---
>  net/bluetooth/bnep/core.c | 1 -
>  1 file changed, 1 deletion(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
