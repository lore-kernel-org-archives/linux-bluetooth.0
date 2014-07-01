Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Fix redundant encryption when receiving Security Request
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404229220-11760-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 1 Jul 2014 17:53:27 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D845610B-B8D4-4773-A1E1-C0178F760C7A@holtmann.org>
References: <1404229220-11760-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If we're already encrypted with a good enough LTK we should just ignore
> an incoming SMP Security Request. The code was already taking care of
> this in the smp_conn_security function before calling smp_ltk_encrypt
> but failed to do the same in smp_cmd_security_req. This patch fixes the
> issue by moving up the smp_sufficient_security function and using it in
> the Security Request handler before trying to request encryption.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 25 ++++++++++++++-----------
> 1 file changed, 14 insertions(+), 11 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

