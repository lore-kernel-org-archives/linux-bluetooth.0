Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 2/2] Bluetooth: Convert idle timer to use delayed work
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381936300-18629-2-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Oct 2013 18:13:27 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <26294ED4-C36A-420E-86BE-213DCCACE6A7@holtmann.org>
References: <1381936300-18629-1-git-send-email-johan.hedberg@gmail.com> <1381936300-18629-2-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There is no need to use a timer since the entire Bluetooth subsystem
> runs using workqueues these days.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  4 ++--
> net/bluetooth/hci_conn.c         | 22 +++++++---------------
> 2 files changed, 9 insertions(+), 17 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

