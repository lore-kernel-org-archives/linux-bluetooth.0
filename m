Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 May 2013 18:34:38 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Fix mgmt handling of power on failures
Message-ID: <20130530213438.GA14083@joana>
References: <1369724867-31011-1-git-send-email-johan.hedberg@gmail.com>
 <1369810289-5090-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369810289-5090-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-05-29 09:51:29 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> If hci_dev_open fails we need to ensure that the corresponding
> mgmt_set_powered command gets an appropriate response. This patch fixes
> the missing response by adding a new mgmt_set_powered_failed function
> that's used to indicate a power on failure to mgmt. Since a sutuation
> with the device being rfkilled may require special handling in user
> space the patch uses a new dedicated mgmt status code for this.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Cc: stable@vger.kernel.org
> ---
> v2: Added dedicated mgmt error for the ERFKILL case
> 
>  include/net/bluetooth/hci_core.h |    1 +
>  include/net/bluetooth/mgmt.h     |    1 +
>  net/bluetooth/hci_core.c         |    6 +++++-
>  net/bluetooth/mgmt.c             |   21 +++++++++++++++++++++
>  4 files changed, 28 insertions(+), 1 deletion(-)

Patch has been applied, I fixed the typo too. Thanks.

	Gustavo
