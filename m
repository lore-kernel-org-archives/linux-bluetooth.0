Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2] Bluetooth: Fix tracking local SSP authentication requirement
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405081943-28785-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 11 Jul 2014 15:24:01 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0C97449C-9B0B-4881-B212-C83E0148666E@holtmann.org>
References: <1405081943-28785-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we need to make the decision whether to perform just-works or real
> user confirmation we need to know the exact local authentication
> requirement that was passed to the controller. So far conn->auth_type
> (the local requirement) wasn't in one case updated appropriately in fear
> of the user confirmation being rejected later.
> 
> The real problem however was not really that conn->auth_type couldn't
> represent the true value but that we were checking the local MITM
> requirement in an incorrect way. It's perfectly fine to let auth_type
> follow what we tell the controller since we're still tracking the target
> security level with conn->pending_sec_level.
> 
> This patch updates the check for local MITM requirement in the
> hci_user_confirm_request_evt function to use the locally requested
> security level and ensures that auth_type always represents what we tell
> the controller. All other code in hci_user_confirm_request_evt still
> uses the auth_type instead of pending_sec_level for determining whether
> to do just-works or not, since that's the only value that's in sync with
> what the remote device knows.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 17 ++++++++---------
> 1 file changed, 8 insertions(+), 9 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

