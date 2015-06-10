Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: Fix exposing full value of shortened LTKs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433923880-16430-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 10 Jun 2015 10:50:52 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <97ED2E82-694E-4B2C-9382-87DF4A4F1C3A@holtmann.org>
References: <1433923880-16430-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we notify user space of a new LTK or distribute an LTK to the
> remote peer the value passed should be the shortened version so that
> it's easy to compare values in various traces. The core spec also sets
> the requirements for the shortening/masking as:
> 
> "The masking shall be done after generation and before being
> distributed, used or stored."
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 7 ++++++-
> net/bluetooth/smp.c  | 9 ++++++++-
> 2 files changed, 14 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

