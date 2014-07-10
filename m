Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix advertising parameter update when toggling connectable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404978687-7723-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 10 Jul 2014 10:04:16 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8F9E9D1A-3C52-42A8-834A-ED8DECE7CF54@holtmann.org>
References: <1404978687-7723-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we change the connectable state and have advertising enabled we
> should update the advertising parameters no matter what. The code was
> incorrectly only updating them if advertising was not already active.
> This patch fixes the issue.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

