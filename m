Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Sep 2013 13:41:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use GFP_KERNEL when cloning SKB in a workqueue
Message-ID: <20130906104139.GB4139@x220.p-661hnu-f1>
References: <1378257067-52933-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378257067-52933-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Sep 03, 2013, Marcel Holtmann wrote:
> There is no need to use GFP_ATOMIC with skb_clone() when the code is
> executed in a workqueue.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
