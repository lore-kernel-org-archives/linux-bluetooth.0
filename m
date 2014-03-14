Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Fix updating SMP remote key distribution information
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1394787230-26475-2-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 14 Mar 2014 09:06:07 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9649BAC9-3E96-469C-A3DC-D789F767C2A7@holtmann.org>
References: <1394787230-26475-1-git-send-email-johan.hedberg@gmail.com> <1394787230-26475-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When performing pairing using SMP the remote may clear any key
> distribution bits it wants in its pairing response. We must therefore
> update our local variable accordingly, otherwise we might get stuck
> waiting for keys that will never come.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

