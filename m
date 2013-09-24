Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 5/8] Bluetooth: Move mgmt response convenience functions to a better location
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380031363-1266-6-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Sep 2013 20:11:03 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EEA113CF-12FA-49E5-BC6E-5EF1DBFDB323@holtmann.org>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com> <1380031363-1266-6-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The settings_rsp and cmd_status_rsp functions can be useful for all mgmt
> command handlers when asynchronous request callbacks are used. They will
> e.g. be used by subsequent patches to change set_le to use an async
> request as well as a new set_advertising command. Therefore, move them
> higher up in the mgmt.c file to avoid unnecessary forward declarations
> or mixing this trivial change with other patches.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 60 ++++++++++++++++++++++++++--------------------------
> 1 file changed, 30 insertions(+), 30 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

