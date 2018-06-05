Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] Bluetooth: btusb: Avoid race condition during controller
 recovery
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1527760213-8877-1-git-send-email-amit.k.bag@intel.com>
Date: Tue, 5 Jun 2018 16:07:02 +0200
Cc: linux-bluetooth@vger.kernel.org, sukumar.ghorai@intel.com,
        chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com
Message-Id: <0364575D-8925-40AF-ACFF-8D97DF0BB666@holtmann.org>
References: <1527760213-8877-1-git-send-email-amit.k.bag@intel.com>
To: Amit K Bag <amit.k.bag@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amit,

> Observed race condition during controller recovery mechanism
> resulting the controller not responding to the reset command.
> 
> To avoid such race condition need a delay of 2ms soon after the
> USB re-enumeration and before sending the Reset command which shall
> allow controller to completely recover and process the Reset command.
> 
> Change-Id: Ifbc387d4377bc79081244d444d45ba6effc95f23
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>

oh, and no Change-Id please and you also need to add your Signed-off-by here.

Regards

Marcel

