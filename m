Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Add support for SMP Invalid Parameters error code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1399547951-26259-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 8 May 2014 07:51:11 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BBE6C678-5106-429A-B4E2-89C98D52A584@holtmann.org>
References: <1399547951-26259-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The Invalid Parameters error code is used to indicate that the command
> length is invalid or that a parameter is outside of the specified range.
> This error code wasn't clearly specified in the Bluetooth 4.0
> specification but since 4.1 this has been fixed.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 20 ++++++++++----------
> net/bluetooth/smp.h |  1 +
> 2 files changed, 11 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

