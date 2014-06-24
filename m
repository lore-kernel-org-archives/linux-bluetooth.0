Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 6/6] Bluetooth: Convert hcon->flush_key to a proper flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403604953-19539-6-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Jun 2014 12:38:45 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <ED2C4AD6-F4FA-492B-AE85-B7B8398D297A@holtmann.org>
References: <1403604953-19539-1-git-send-email-johan.hedberg@gmail.com> <1403604953-19539-6-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There's no point in having boolean variables in the hci_conn struct
> since it already has a flags member. This patch converts the flush_key
> member into a proper flag.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 2 +-
> net/bluetooth/hci_event.c        | 8 ++++++--
> 2 files changed, 7 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

