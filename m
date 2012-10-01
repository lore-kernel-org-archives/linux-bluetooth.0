Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Oct 2012 13:10:11 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Rami Rosen <ramirose@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	johan.hedberg@gmail.com
Subject: Re: [PATCH v2] Bluetooth: remove unused member of hci_dev.
Message-ID: <20121001161011.GL15463@joana>
References: <1349113051-27803-1-git-send-email-ramirose@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349113051-27803-1-git-send-email-ramirose@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rami,

* Rami Rosen <ramirose@gmail.com> [2012-10-01 19:37:31 +0200]:

> This patch removes core_data member from hci_dev struct as it is unused.
> 
> Signed-off-by: Rami Rosen <ramirose@gmail.com>
> ---
>  include/net/bluetooth/hci_core.h | 2 --
>  1 file changed, 2 deletions(-)

Patch has been applied to bluetooth-next, thanks.

	Gustavo
