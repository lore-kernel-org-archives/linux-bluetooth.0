Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Avoid hard-coded IO capability values in SMP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1410397134-31492-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 10 Sep 2014 18:03:24 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E4C95DA0-2B3E-4521-A24E-16983CF907BE@holtmann.org>
References: <1410397134-31492-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This is a trivial change to use a proper define for the NoInputNoOutput
> IO capability instead of hard-coded values.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

