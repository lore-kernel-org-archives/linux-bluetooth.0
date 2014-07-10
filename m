Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluteooth: Reject SMP bonding if HCI_PAIRABLE is not set
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404979327-9384-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 10 Jul 2014 10:25:25 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <110B4C45-4AA1-45D0-BC38-862BE3032D55@holtmann.org>
References: <1404979327-9384-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If the remote device tries to initiate bonding with us and we don't have
> HCI_PAIRABLE set we should just flat out reject the request. This brings
> SMP in line with how the flag is used for BR/EDR SSP.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 9 +++++++++
> 1 file changed, 9 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

