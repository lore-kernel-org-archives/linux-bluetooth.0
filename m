Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 1/4] Bluetooth: Don't send device found events during passive scanning
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395736249-11450-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 25 Mar 2014 01:43:28 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <204B2271-6976-44F0-B272-96997F40218F@holtmann.org>
References: <1395736249-11450-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Passive LE scanning is only used by the kernel-internal connection
> establishment procedure. It makes therefore little sense to send device
> found events to user space.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

