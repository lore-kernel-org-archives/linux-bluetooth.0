Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 2/3] Bluetooth: Rename pairable mgmt setting to bondable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1406701344-23842-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 29 Jul 2014 23:28:51 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <35A03E81-DEF3-49B3-B355-1BC658383257@holtmann.org>
References: <1406701344-23842-1-git-send-email-johan.hedberg@gmail.com> <1406701344-23842-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This setting maps to the HCI_BONDABLE flag which tracks whether we're
> bondable or not. Therefore, rename the mgmt setting and respective
> command accordingly.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/mgmt.h |  4 ++--
> net/bluetooth/mgmt.c         | 14 +++++++-------
> 2 files changed, 9 insertions(+), 9 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

