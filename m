Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2 2/2] Bluetooth: Fix workqueue synchronization in hci_dev_open
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380656690-22246-3-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 2 Oct 2013 06:52:55 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C9EF05DB-42CA-4660-8DA8-E06EACF0FB7A@holtmann.org>
References: <1380656690-22246-1-git-send-email-johan.hedberg@gmail.com> <1380656690-22246-3-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When hci_sock.c calls hci_dev_open it needs to ensure that there isn't
> pending work in progress, such as that which is scheduled for the
> initial setup procedure or the one for automatically powering off after
> the setup procedure. This adds the necessary calls to ensure that any
> previously scheduled work is completed before attempting to call
> hci_dev_do_open.
> 
> This patch fixes a race with old user space versions where we might
> receive a HCIDEVUP ioctl before the setup procedure has been completed.
> When that happens the setup procedures callback may fail early and leave
> the device in an inconsistent state, causing e.g. the setup callback to
> be (incorrectly) called more than once.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

