Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Re-encrypt link after receiving an LTK
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393603803-19006-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 28 Feb 2014 08:19:21 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <31C1BB7E-9049-45D0-BA8F-1096F669B8FB@holtmann.org>
References: <1393603803-19006-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> It's not strictly speaking required to re-encrypt a link once we receive
> an LTK since the connection is already encrypted with the STK. However,
> re-encrypting with the LTK allows us to verify that we've received an
> LTK that actually works.
> 
> This patch updates the SMP code to request encrypting with the LTK in
> case we're in master role and waits until the key refresh complete event
> before notifying user space of the distributed keys.
> 
> A new flag is also added for the SMP context to ensure that we
> re-encryption only once in case of multiple calls to smp_distribute_keys.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 32 +++++++++++++++++++++++++++-----
> net/bluetooth/smp.h |  3 ++-
> 2 files changed, 29 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

