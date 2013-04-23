Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Apr 2013 20:22:33 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Fix sending write_le_host_supporte for
 LE-only controllers
Message-ID: <20130423232233.GA1697@joana>
References: <1366385721-4558-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366385721-4558-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-04-19 18:35:21 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The Bluetooth Core Specification (4.0) defines the Write LE Host
> Supported HCI command as only available for controllers supporting
> BR/EDR. This is further reflected in the Read Local Extended Features
> HCI command also not being available for LE-only controllers. In other
> words, host-side LE support is implicit for single-mode LE controllers
> and doesn't have explicit HCI-level enablement.
> 
> This patch ensures that the LE setting is always exposed as enabled
> through mgmt and returns a "rejected" response if user space tries to
> toggle the setting. The patch also ensures that Write LE Host Supported
> is never sent for LE-only controllers.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Instead of requiring user space to explicitly enable the setting it
> is now always enabled and trying to toggle it through mgmt will cause a
> rejected error. One missing check for bredr_supported in the HCI init
> sequence was also added.
> 
>  net/bluetooth/hci_core.c |   10 ++++++++++
>  net/bluetooth/mgmt.c     |    8 +++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
