Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH] Bluetooth: hci_qca: Use setup_timer Kernel API instead of
 init_timer
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20161018235323.GA19419@prasanna-ubuntu.itc.intrinsyc.com>
Date: Wed, 19 Oct 2016 06:07:00 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <44358BD6-511D-4EDF-B0DB-95A2CCA39D37@holtmann.org>
References: <20161018235323.GA19419@prasanna-ubuntu.itc.intrinsyc.com>
To: Prasanna Karthik <pkarthik@intrinsyc.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prasanna,

> Replace init_timer function with setup_timer reported by coccinelle
> 
> Signed-off-by: Prasanna Karthik <pkarthik@intrinsyc.com>
> ---
> drivers/bluetooth/hci_qca.c | 9 +++------
> 1 file changed, 3 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

