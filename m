Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH] Bluetooth: hci_h5: Use setup_timer Kernel API instead of
 init_timer
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20161018173018.GA27568@prasanna-ubuntu.itc.intrinsyc.com>
Date: Tue, 18 Oct 2016 19:55:38 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <C1199ADC-080C-4D27-9CD8-DCEC91747A7F@holtmann.org>
References: <20161018173018.GA27568@prasanna-ubuntu.itc.intrinsyc.com>
To: Prasanna Karthik <pkarthik@intrinsyc.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prasanna,

> Replace init_timer function with setup_timer reported by coccinelle
> 
> Signed-off-by: Prasanna Karthik <pkarthik@intrinsyc.com>
> ---
> drivers/bluetooth/hci_h5.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

