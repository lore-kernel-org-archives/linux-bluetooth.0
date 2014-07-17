Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Don't bother user space without IO capabilities
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405512553-15781-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 17 Jul 2014 11:45:45 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4DC5ABE4-3358-468F-A678-BFAA4D11A8F8@holtmann.org>
References: <1405512553-15781-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If user space has a NoInputNoOutput IO capability it makes no sense to
> bother it with confirmation requests. This patch updates both SSP and
> SMP to check for the local IO capability before sending a user
> confirmation request to user space.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 4 +++-
> net/bluetooth/smp.c       | 4 ++++
> 2 files changed, 7 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

