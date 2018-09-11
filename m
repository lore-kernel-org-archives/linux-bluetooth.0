Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 0/2] Bluetooth: Two OOB related fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180911111013.2739-1-johan.hedberg@gmail.com>
Date: Tue, 11 Sep 2018 13:36:38 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A5BBCA63-CEBC-4AFB-8E60-5E6BAE4E0755@holtmann.org>
References: <20180911111013.2739-1-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here are two patches fixing handling of local OOB data.
> 
> Johan Hedberg (1):
>      Bluetooth: SMP: Fix trying to use non-existent local OOB data
> 
> Matias Karhumaa (1):
>      Bluetooth: Use correct tfm to generate OOB data
> 
> net/bluetooth/smp.c | 16 +++++++++++++---
> 1 file changed, 13 insertions(+), 3 deletions(-)

both patches have been applied to bluetooth-stable tree.

Regards

Marcel
