Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Use min_t for calculating chan->imtu
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1386306533-32239-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 6 Dec 2013 07:51:03 +0200
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <D5F80CD8-DDF0-4B8F-858C-4CCB1292FDFF@holtmann.org>
References: <1386306533-32239-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Since there's a nice convenient helper for calculating the minimum of
> two values, let's use that one.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 6 +-----
> 1 file changed, 1 insertion(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

