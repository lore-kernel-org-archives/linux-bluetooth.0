Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] Bluetooth: Fix BR/EDR Page Scan update with Add Device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1447230631-29973-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 11 Nov 2015 17:36:41 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CF0D3D1A-ED44-4607-A08D-5D7A6E71EF73@holtmann.org>
References: <1447230631-29973-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The recent changes to remove dependency on HCI in Add Device missed
> out relevant changes for BR/EDR. This patch removes the left-overs and
> ensures the right HCI command gets queued for BR/EDR.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 16 ++++------------
> 1 file changed, 4 insertions(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

