Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Convert Set SC to use HCI Request
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422020566-30680-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 23 Jan 2015 10:10:03 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <08C54AED-CD9E-4DCC-AB77-F14858CA6015@holtmann.org>
References: <1422020566-30680-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch converts the Set Secure Connection HCI handling to use a HCI
> request instead of using a hard-coded callback in hci_event.c. This e.g.
> ensures that we don't clear the flags incorrectly if something goes
> wrong with the power up process (not related to a mgmt Set SC command).
> 
> The code can also be simplified a bit since only one pending Set SC
> command is allowed, i.e. mgmt_pending_foreach usage is not needed.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  1 -
> net/bluetooth/hci_event.c        |  4 +-
> net/bluetooth/mgmt.c             | 92 +++++++++++++++++++++-------------------
> 3 files changed, 50 insertions(+), 47 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

