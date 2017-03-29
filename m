Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/2] Bluetooth: fix hci-uart crashes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170329161528.17843-1-johan@kernel.org>
Date: Wed, 29 Mar 2017 20:57:45 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <FF455D51-6F43-4218-A09A-065E2026DFC8@holtmann.org>
References: <20170329161528.17843-1-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Not every tty has a class device and this could be used to trigger
> NULL-pointer dereferences in two hci-uart drivers that lacked the
> required sanity checks.
> 
> Johan
> 
> 
> Johan Hovold (2):
>  Bluetooth: hci_bcm: add missing tty-device sanity check
>  Bluetooth: hci_intel: add missing tty-device sanity check
> 
> drivers/bluetooth/hci_bcm.c   |  5 ++++-
> drivers/bluetooth/hci_intel.c | 13 ++++++++++++-
> 2 files changed, 16 insertions(+), 2 deletions(-)

bot patches have been applied to bluetooth-next tree.

Regards

Marcel
