Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v2] Bluetooth: Fix missing hci_dev_lock/unlock in hci_event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418304495-15334-1-git-send-email-jaganath.k@samsung.com>
Date: Thu, 11 Dec 2014 15:10:13 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2CC901F3-1B75-48DB-B916-2DE3FA6C091A@holtmann.org>
References: <1418304495-15334-1-git-send-email-jaganath.k@samsung.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> mgmt_pending_remove() should be called with hci_dev_lock protection and
> all hci_event.c functions which calls mgmt_complete() (which eventually
> calls mgmt_pending_remove()) should hold the lock.
> So this patch fixes the same
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> ---
> net/bluetooth/hci_event.c |   20 ++++++++++++++++++++
> 1 file changed, 20 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

