Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Fix Pair Device response parameters for pairing failure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395241249-8235-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 19 Mar 2014 13:57:46 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <67918204-0E66-4384-8C6F-D202A4C52A1F@holtmann.org>
References: <1395241249-8235-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> It is possible that pairing fails after we've already received remote
> identity information. One example of such a situation is when
> re-encryption using the LTK fails. In this case the hci_conn object has
> already been updated with the identity address but user space does not
> yet know about it (since we didn't notify it of the new IRK yet).
> 
> To ensure user space doesn't get a Pair Device command response with an
> unknown address always use the same address in the response as was used
> for the original command.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 16 ++++++++++++++--
> 1 file changed, 14 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

