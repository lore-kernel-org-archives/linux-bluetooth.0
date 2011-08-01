Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Aug 2011 16:26:22 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: chen.ganir@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Chen Ganir <chen.ganir@ti.com>
Subject: Re: [PATCH] Bluetooth-next:Fixed wrong L2CAP Sock timer value
Message-ID: <20110801192621.GA18480@joana>
References: <1311856929-10464-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311856929-10464-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

* chen.ganir@gmail.com <chen.ganir@gmail.com> [2011-07-28 15:42:09 +0300]:

> From: Chen Ganir <chen.ganir@ti.com>
> 
> L2CAP connection timeout needs to be assigned as miliseconds
> and not as jiffies.
> 
> Signed-off-by: Chen Ganir <chen.ganir@ti.com>
> ---
>  net/bluetooth/l2cap_sock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Patch has been applied, thanks.

	Gustavo
