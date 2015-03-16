Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: Don't send public key if OOB data verification fails
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426522377-31485-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 16 Mar 2015 09:23:25 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EDFC4854-14EA-4E43-8BC8-A1C72425B3AC@holtmann.org>
References: <1426522377-31485-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we receive the remote public key, if we have remote OOB data
> there's no point in sending our public key to the remote if the OOB data
> doesn't match. This patch moves the test for this higher up in the
> smp_cmd_public_key() function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 20 ++++++++++----------
> 1 file changed, 10 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

