Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH 0/3] Bluetooth: Add kernel-side SMP self-tests
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414264539-19068-1-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 25 Oct 2014 12:39:25 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <110DC658-D034-422C-AAFA-C8DF691E8341@holtmann.org>
References: <1414264539-19068-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch set adds some simple self-tests for the SMP crypto functions.
> The tests are disabled by default and need to be enabled with a new
> config option in order to be compiled in.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (3):
>      Bluetooth: Pass only crypto context to SMP crypto functions
>      Bluetooth: Add skeleton for SMP self-tests
>      Bluetooth: Add self-tests for SMP crypto functions
> 
> net/bluetooth/Kconfig |   6 ++
> net/bluetooth/smp.c   | 150 ++++++++++++++++++++++++++++++++++++++++------
> 2 files changed, 138 insertions(+), 18 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

