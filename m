Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Fix BR/EDR-only address checks for remote OOB data
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1416250340-23675-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 18 Nov 2014 10:12:47 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2244D5AE-373B-4B13-AE42-7F04471B48A0@holtmann.org>
References: <1416250340-23675-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> For now the mgmt commands dealing with remote OOB data are strictly
> BR/EDR-only. This patch fixes missing checks for the passed address type
> so that any non-BR/EDR value triggers the appropriate error response.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

