Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Oct 2013 17:22:30 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix memory leak with L2CAP signal channels
Message-ID: <20131002202230.GC3130@joana>
References: <1380727701-44925-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380727701-44925-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2013-10-02 Marcel Holtmann <marcel@holtmann.org>:

> The wrong type of L2CAP signalling packets on the wrong type of
> either BR/EDR or LE links need to be dropped. When that happens
> the packet is dropped, but the memory not freed. So actually
> free the memory as well.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
