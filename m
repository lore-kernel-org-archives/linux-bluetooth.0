Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH 0/2] Bluetooth: A couple of SMP fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1385974144-8836-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 2 Dec 2013 13:23:49 +0200
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <633E61D1-DBDF-4003-8CE2-98BFAC324FC1@holtmann.org>
References: <1385974144-8836-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here are a couple of small tweaks to the SMP code that I've found while
> browsing through and testing it (with the user space smp-tester).
> 
> Johan
> 
> Johan Hedberg (2):
>  Bluetooth: Remove useless smp_rand function
>  Bluetooth: Remove dead code from SMP encryption function
> 
> net/bluetooth/smp.c | 24 +++---------------------
> 1 file changed, 3 insertions(+), 21 deletions(-)

both patches have been applied to bluetooth-next.

Regards

Marcel

