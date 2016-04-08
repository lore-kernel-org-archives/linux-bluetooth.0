Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: Ignore unknown advertising packet types
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1460052087-29894-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 8 Apr 2016 09:53:00 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <37347F9A-F74D-4FC7-B6E6-5F38DE530817@holtmann.org>
References: <1460052087-29894-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> In case of buggy controllers send advertising packet types that we
> don't know of we should simply ignore them instead of trying to react
> to them in some (potentially wrong) way.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

