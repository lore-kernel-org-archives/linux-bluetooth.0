Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 0/3] Bluetooth: Add SMP self-tests (try number 4)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1419925841-27185-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 29 Dec 2014 23:56:26 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1DA7D83D-433F-4513-AA47-9B29D7469DC4@holtmann.org>
References: <1419925841-27185-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Now that we went with Marcel's RFC approach, here's an updated set of
> the SMP tests reworked to match the new design.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (3):
>      Bluetooth: Add skeleton for SMP self-tests
>      Bluetooth: Add legacy SMP tests
>      Bluetooth: Add LE Secure Connections tests for SMP
> 
> net/bluetooth/Kconfig    |   7 +
> net/bluetooth/selftest.c |   7 +
> net/bluetooth/smp.c      | 320 +++++++++++++++++++++++++++++++++++++++++++++
> net/bluetooth/smp.h      |  13 ++
> 4 files changed, 347 insertions(+)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

