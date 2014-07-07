Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3 3/3] Bluetooth: Remove unnecessary return value from check_pending_le_conn
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404726355-7037-3-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 7 Jul 2014 12:05:51 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <334300EA-84A0-4FFD-AB5E-F2D87324D4A7@holtmann.org>
References: <1404726355-7037-1-git-send-email-johan.hedberg@gmail.com> <1404726355-7037-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Since only the caller of this function doesn't care about the return
> value anymore let's just remove it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 12 +++++-------
> 1 file changed, 5 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

