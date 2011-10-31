Return-Path: <cyrus@holtmann.org>
Date: Mon, 31 Oct 2011 17:38:07 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: ath3k: Use GFP_KERNEL instead of GFP_ATOMIC
Message-ID: <20111031193807.GH10164@joana>
References: <1319536194-4720-1-git-send-email-dh.herrmann@googlemail.com>
 <1319537392-4993-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319537392-4993-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@googlemail.com> [2011-10-25 12:09:52 +0200]:

> We are allowed to sleep here so no need to use GFP_ATOMIC. The caller
> (ath3k_probe) calls request_firmware() which definitely sleeps. Hence, we should
> avoid using GFP_ATOMIC.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
> V2: This fixes both occurences of GFP_ATOMIC in one patch.
> 
>  drivers/bluetooth/ath3k.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

	Gustavo
