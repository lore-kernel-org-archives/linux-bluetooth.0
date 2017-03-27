Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] Bluetooth: fix assignments on error variable err
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170301151053.25779-1-colin.king@canonical.com>
Date: Mon, 27 Mar 2017 16:23:09 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <76DB816F-492D-468E-B7C0-AE83BAF0EA65@holtmann.org>
References: <20170301151053.25779-1-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Colin,

> Variable err is being initialized to zero and then later being
> set to the error return from the call to hci_req_run_skb; hence
> we can remove the redundant initialization to zero.
> 
> Also on two occassions err is not being set from the error return
> from the call to hci_req_run_skb, so add these missing assignments.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> net/bluetooth/amp.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

