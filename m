Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 7/8] Bluetooth: Add new mgmt setting for LE advertising
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380031363-1266-8-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Sep 2013 20:29:55 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B5745671-F199-4253-A0F3-3EDDDCA3F46D@holtmann.org>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com> <1380031363-1266-8-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds a new mgmt setting for LE advertising and hooks up the
> necessary places in the mgmt code to operate on the HCI_LE_PERIPHERAL
> flag (which corresponds to this setting). This patch does not yet add
> any new command for enabling the setting - that is left for a subsequent
> patch.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/mgmt.h |  1 +
> net/bluetooth/mgmt.c         | 24 +++++++++++++++++++++++-
> 2 files changed, 24 insertions(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

