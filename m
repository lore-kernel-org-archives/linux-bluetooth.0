Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Prefer sizeof(*ptr) when allocating memory
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405929006-21537-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 21 Jul 2014 13:01:37 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E04B1162-F78C-4312-9AA8-A00A4CED13EC@holtmann.org>
References: <1405929006-21537-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> It's safer practice to use sizeof(*ptr) instead of sizeof(ptr_type) when
> allocating memory in case the type changes. This also fixes the
> following style of warnings from static analyzers:
> 
> CHECK: Prefer kzalloc(sizeof(*ie)...) over kzalloc(sizeof(struct inquiry_entry)...)
> +	ie = kzalloc(sizeof(struct inquiry_entry), GFP_KERNEL);
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_conn.c   | 4 ++--
> net/bluetooth/hci_core.c   | 6 +++---
> net/bluetooth/l2cap_core.c | 2 +-
> 3 files changed, 6 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

