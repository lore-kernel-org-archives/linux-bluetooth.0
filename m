Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2 3/3] Bluetooth: Fix SMP user passkey notification mgmt event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395231293-26581-3-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 19 Mar 2014 14:00:19 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4217CDF4-6CBC-49B9-8766-B46E35393F87@holtmann.org>
References: <1395231293-26581-1-git-send-email-johan.hedberg@gmail.com> <1395231293-26581-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When performing SMP pairing with MITM protection one side needs to
> enter the passkey while the other side displays to the user what needs
> to be entered. Nowhere in the SMP specification does it say that the
> displaying side needs to any kind of confirmation of the passkey, even
> though a code comment in smp.c implies this.
> 
> This patch removes the misleading comment and converts the code to use
> the passkey notification mgmt event instead of the passkey confirmation
> mgmt event.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

