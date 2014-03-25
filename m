Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 0/2] Bluetooth: Improve device found events in busy environments
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395750900-10755-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 25 Mar 2014 10:25:08 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5DEF8D0B-A049-47FC-895D-768DAB42EAC2@holtmann.org>
References: <1395750900-10755-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here are two patches which I saw necessary for having decent behavior
> with CSR adapters in crowded environments (3 or more advertisers).
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (2):
>      Bluetooth: Don't send device found events for duplicate reports
>      Bluetooth: Store also RSSI for pending advertising reports
> 
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_event.c        | 26 ++++++++++++++++----------
> 2 files changed, 17 insertions(+), 10 deletions(-)

both patches (v2) have been applied to bluetooth-next tree.

Regards

Marcel

