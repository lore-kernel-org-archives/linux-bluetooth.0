Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 1/4] Bluetooth: Fix local OOB data handling for SMP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426499146-11959-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 16 Mar 2015 09:23:21 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9B99FBD1-5883-45B2-9F82-0C58504A6B57@holtmann.org>
References: <1426499146-11959-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We need to store the local ra/rb value in order to verify the Check
> value received from the remote. This patch adds a new 'lr' for the local
> ra/rb value and makes sure it gets used when verifying the DHKey Check
> PDU received from the remote.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

