Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 May 2013 12:23:37 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix mgmt handling of power on failures
Message-ID: <20130528152337.GA3697@joana>
References: <1369724867-31011-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369724867-31011-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-05-28 10:07:47 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> If hci_dev_open fails we need to ensure that the corresponding
> mgmt_set_powered command gets an appropriate response. This patch fixes
> the missing response by adding a new mgmt_set_powered_failed function
> that's used to indicate a power on failure to mgmt.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |    6 +++++-
>  net/bluetooth/mgmt.c             |   16 ++++++++++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
