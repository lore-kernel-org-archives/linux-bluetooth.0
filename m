Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH] Bluetooth: Revert SMP self-test patches
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414506132-21330-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 28 Oct 2014 07:36:10 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F4B069E6-AD50-4D2A-AB80-4928CC0D8F17@holtmann.org>
References: <1414506132-21330-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This reverts commits c6992e9ef2a17e9738b7bb8a03a7fe581a8f9977 and
> 4cd3362da899a59955146851dd860198b0aaaa75.
> 
> The reason for the revert is that we cannot have more than one module
> initialization function and the SMP one breaks the build with modular
> kernels. As the proper fix for this is right now looking non-trivial
> it's better to simply revert the problematic patches in order to keep
> the upstream tree compilable.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/Kconfig |   6 ---
> net/bluetooth/smp.c   | 120 --------------------------------------------------
> 2 files changed, 126 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

