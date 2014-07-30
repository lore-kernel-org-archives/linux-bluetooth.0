Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 3/3] Bluetooth: Always use non-bonding requirement when not bondable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1406701344-23842-3-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 29 Jul 2014 23:28:54 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <544655CC-A430-401D-A4B9-479D9759F236@holtmann.org>
References: <1406701344-23842-1-git-send-email-johan.hedberg@gmail.com> <1406701344-23842-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we're not bondable we should never send any other SSP
> authentication requirement besides one of the non-bonding ones.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

