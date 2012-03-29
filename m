Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Mar 2012 21:25:24 -0400 (EDT)
Message-Id: <20120328.212524.1423286973836820167.davem@davemloft.net>
To: keithp@keithp.com
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        marcel@holtmann.org, johan.hedberg@intel.com
Subject: Re: [PATCH] Revert "Bluetooth: Always enable management interface"
From: David Miller <davem@davemloft.net>
In-Reply-To: <1332983958-2734-1-git-send-email-keithp@keithp.com>
References: <1332983958-2734-1-git-send-email-keithp@keithp.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

From: Keith Packard <keithp@keithp.com>
Date: Wed, 28 Mar 2012 18:19:18 -0700

> This reverts commit 4b95a24ce12c4545fd7d2e3075841dc3119d1d71.
> 
> My USB bluetooth device does not show up with this patch in place.
> 
> Signed-off-by: Keith Packard <keithp@keithp.com>

Bluetooth folks please look over this, thanks.
