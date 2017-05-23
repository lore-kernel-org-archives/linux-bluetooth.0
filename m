Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: btwilink: Fix unexpected skb free
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1495533060-12855-1-git-send-email-loic.poulain@intel.com>
Date: Tue, 23 May 2017 07:21:42 -0700
Cc: dan.carpenter@oracle.com, linux-bluetooth@vger.kernel.org
Message-Id: <2EC13B1F-5E7B-454D-BCB9-C8E15EE4EB99@holtmann.org>
References: <1495533060-12855-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> The caller (hci_core) still owns the skb in case of error, releasing
> it inside the send function can lead to use-after-free errors.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/btwilink.c | 1 -
> 1 file changed, 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

