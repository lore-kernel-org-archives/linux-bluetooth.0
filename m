Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Sep 2011 15:14:56 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: chen.ganir@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Chen Ganir <chen.ganir@ti.com>
Subject: Re: [PATCH] Bluetooth-next: Fixed BT ST Channel reg order
Message-ID: <20110902181456.GF12684@joana>
References: <1314701908-15860-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314701908-15860-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

* chen.ganir@gmail.com <chen.ganir@gmail.com> [2011-08-30 13:58:28 +0300]:

> From: Chen Ganir <chen.ganir@ti.com>
> 
> Reordered the BT ST channel registration, to make sure that the
> event channel is registered before all others. This prevents a
> situation where incoming events may cause kernel panic in the ST
> driver if the event channel is not yet registered to handle
> incoming events.In addition, the deregistration of the channels
> was also modified, to be in the reversed order of the registration,
> to allow the event channel to be the last one unregistered.
> 
> Signed-off-by: Chen Ganir <chen.ganir@ti.com>
> ---
>  drivers/bluetooth/btwilink.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

I will push this patch only when kernel.org is back, the same is valid for
other patches I applied.

	Gustavo
